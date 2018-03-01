Received: from eggs.gnu.org ([2001:4830:134:3::10]:48525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1erQ5A-000367-39
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1erQ53-00082u-1c
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:25:20 -0500
MIME-Version: 1.0
References: <20180301135856.22698-1-rjones@redhat.com>
	<20180301135856.22698-2-rjones@redhat.com>
In-Reply-To: <20180301135856.22698-2-rjones@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 01 Mar 2018 15:24:48 +0000
Message-ID: <CAMr-obsJtVe9h5CjQ1PkjBdrQhKBRP0RUAA2f3cQ7p_-2MG-EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] block: curl: Allow arbitrary HTTP
 request headers to be set.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jcody@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, armbru@redhat.com, mreitz@redhat.com, "derez@redhat.com" <derez@redhat.com>

On Thu, Mar 1, 2018 at 4:00 PM Richard W.M. Jones <rjones@redhat.com> wrote=
:

> Allow arbitrary HTTP request headers to be set, like this:
>
>   qemu-img create -f qcow2 \
>       -b 'json:{ "file.driver":"http",
>                  "file.url":"http://192.168.0.249/scratch/test.img",
>                  "file.header": ["Authorization: letmein"] }' \
>

Since oVirt 4.2, you don't need the Authorization header.

In any version, the Authorization header was used only
in by the proxy (running on engine host). You really want
to access the host directly and not the proxy, unless you
cannot access the host.

Authorization in ovirt works like this now:

1. User start a transfer operation using engine API/UI
2. Engine creates a ticket authorizing the operation on a some host and
    in ovirt-imageio-proxy
3. Engine returns random transfter url and proxy url to the user.
4. User can access the the image via the transfer or proxy url
5. User finish the operation via engine API/UI
6. Engine remove the tickets, invalidating the transfer/proxy urls

So the only thing qemu-img needs is a url.

Other issue that you need to consider is that you cannot
create images via the http. Images are created only via
engine API/UI. What ovirt-imageio give you is a way to
read and write data to existing image. The url you get is
mostly like an open file descriptor you can use with read()
and write().

Note that you cannot access yet a chain of image via a url, since
ovirt generate a random url per image in a chain. For example,
if you have this chain:

base-img <- top-image (top)

oVirt will provide these urls to access a single image of the chain:
https://host.address:54322/images/random-id1 (top-image)
https://host.address:54322/images/random-id
<https://host.address:54322/images/random-id1>2 (base-image)

So qemu will not be able to consume the chain, as the base image
is not available at https://host.address:54322/images/
<https://host.address:54322/images/random-id1>base-imge

We plan to support this use case in 4.3, by using a ticket-per-chain
instead of ticker-per-image.

In this case oVirt will generate this url:

https://host.address:54322/images/random-id1/top-image

And the base image will be accessible at:
https://host.address:54322/images/random-id1/base-image

Nir


>       test.qcow2
>
> which adds the =E2=80=98Authorization: letmein=E2=80=99 header to the out=
going request
> for the backing file.  Multiple headers can be set, and curl built-in
> headers can be removed (using "Header:").
>
> Note this uses the same format as curl's CURLOPT_HTTPHEADER, thus
> pulling in curl API guarantees into qemu, but curl has had very strong
> API backward compatibility since the start of the project.
>

But otherwise, supporting custom headers may be useful for other
use cases.


>
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  block/curl.c         | 21 ++++++++++++++++++++-
>  qapi/block-core.json | 10 ++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/block/curl.c b/block/curl.c
> index aa42535783..972673ba5c 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -83,6 +83,7 @@ static CURLMcode __curl_multi_socket_action(CURLM
> *multi_handle,
>  #define CURL_BLOCK_OPT_TIMEOUT "timeout"
>  #define CURL_BLOCK_OPT_COOKIE    "cookie"
>  #define CURL_BLOCK_OPT_COOKIE_SECRET "cookie-secret"
> +#define CURL_BLOCK_OPT_HEADER_PATTERN "header."
>  #define CURL_BLOCK_OPT_USERNAME "username"
>  #define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
>  #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
> @@ -134,6 +135,7 @@ typedef struct BDRVCURLState {
>      bool sslverify;
>      uint64_t timeout;
>      char *cookie;
> +    struct curl_slist *headers;
>      bool accept_range;
>      AioContext *aio_context;
>      QemuMutex mutex;
> @@ -486,6 +488,9 @@ static int curl_init_state(BDRVCURLState *s, CURLStat=
e
> *state)
>          if (s->cookie) {
>              curl_easy_setopt(state->curl, CURLOPT_COOKIE, s->cookie);
>          }
> +        if (s->headers) {
> +            curl_easy_setopt(state->curl, CURLOPT_HTTPHEADER, s->headers=
);
> +        }
>          curl_easy_setopt(state->curl, CURLOPT_TIMEOUT, (long)s->timeout)=
;
>          curl_easy_setopt(state->curl, CURLOPT_WRITEFUNCTION,
>                           (void *)curl_read_cb);
> @@ -680,7 +685,7 @@ static int curl_open(BlockDriverState *bs, QDict
> *options, int flags,
>      double d;
>      const char *secretid;
>      const char *protocol_delimiter;
> -    int ret;
> +    int i, nr, ret;
>
>
>      if (flags & BDRV_O_RDWR) {
> @@ -740,6 +745,18 @@ static int curl_open(BlockDriverState *bs, QDict
> *options, int flags,
>          s->cookie =3D g_strdup(cookie);
>      }
>
> +    s->headers =3D NULL;
> +    nr =3D qdict_array_entries(options, CURL_BLOCK_OPT_HEADER_PATTERN);
> +    for (i =3D 0; i < nr; ++i) {
> +        char key[32];
> +        const char *header;
> +
> +        snprintf(key, sizeof key, CURL_BLOCK_OPT_HEADER_PATTERN "%d", i)=
;
> +        header =3D qdict_get_str(options, key);
> +        s->headers =3D curl_slist_append(s->headers, header);
> +        qdict_del(options, key);
> +    }
> +
>      file =3D qemu_opt_get(opts, CURL_BLOCK_OPT_URL);
>      if (file =3D=3D NULL) {
>          error_setg(errp, "curl block driver requires an 'url' option");
> @@ -847,6 +864,7 @@ out:
>      state->curl =3D NULL;
>  out_noclean:
>      qemu_mutex_destroy(&s->mutex);
> +    curl_slist_free_all(s->headers);
>      g_free(s->cookie);
>      g_free(s->url);
>      g_free(s->username);
> @@ -945,6 +963,7 @@ static void curl_close(BlockDriverState *bs)
>      curl_detach_aio_context(bs);
>      qemu_mutex_destroy(&s->mutex);
>
> +    curl_slist_free_all(s->headers);
>      g_free(s->cookie);
>      g_free(s->url);
>      g_free(s->username);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5c5921bfb7..ca1ebdbef1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3047,12 +3047,15 @@
>  # @cookie-secret: ID of a QCryptoSecret object providing the cookie data
> in a
>  #                 secure way. See @cookie for the format. (since 2.10)
>  #
> +# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3).
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurlHttp',
>    'base': 'BlockdevOptionsCurlBase',
>    'data': { '*cookie': 'str',
> -            '*cookie-secret': 'str'} }
> +            '*cookie-secret': 'str',
> +            '*header': [ 'str' ] } }
>
>  ##
>  # @BlockdevOptionsCurlHttps:
> @@ -3070,13 +3073,16 @@
>  # @cookie-secret: ID of a QCryptoSecret object providing the cookie data
> in a
>  #                 secure way. See @cookie for the format. (since 2.10)
>  #
> +# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3).
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurlHttps',
>    'base': 'BlockdevOptionsCurlBase',
>    'data': { '*cookie': 'str',
>              '*sslverify': 'bool',
> -            '*cookie-secret': 'str'} }
> +            '*cookie-secret': 'str',
> +            '*header': [ 'str' ] } }
>
>  ##
>  # @BlockdevOptionsCurlFtp:
> --
> 2.13.2
>
>
>
