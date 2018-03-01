Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQnn-0002Qr-Pt
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQnm-00038f-Fv
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:11:27 -0500
Date: Thu, 1 Mar 2018 16:11:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301161118.GW14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
	<20180301135856.22698-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301135856.22698-2-rjones@redhat.com>
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
Cc: jcody@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Thu, Mar 01, 2018 at 01:58:55PM +0000, Richard W.M. Jones wrote:
> Allow arbitrary HTTP request headers to be set, like this:
>=20
>   qemu-img create -f qcow2 \
>       -b 'json:{ "file.driver":"http",
>                  "file.url":"http://192.168.0.249/scratch/test.img",
>                  "file.header": ["Authorization: letmein"] }' \
>       test.qcow2
>=20
> which adds the =E2=80=98Authorization: letmein=E2=80=99 header to the o=
utgoing request
> for the backing file.  Multiple headers can be set, and curl built-in
> headers can be removed (using "Header:").
>=20
> Note this uses the same format as curl's CURLOPT_HTTPHEADER, thus
> pulling in curl API guarantees into qemu, but curl has had very strong
> API backward compatibility since the start of the project.

It doesn't appear like there's anything really curl specific about
this - isn't   'Key: value' just the standard HTTP format (minus the
\r\n line ending of course.  IOW, I don't see any problem with using
this format.

>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  block/curl.c         | 21 ++++++++++++++++++++-
>  qapi/block-core.json | 10 ++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)
>=20


> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5c5921bfb7..ca1ebdbef1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3047,12 +3047,15 @@
>  # @cookie-secret: ID of a QCryptoSecret object providing the cookie da=
ta in a
>  #                 secure way. See @cookie for the format. (since 2.10)
>  #
> +# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3=
).

Put  a '(since 2.12)' anntation on end of the docs for this new field

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurlHttp',
>    'base': 'BlockdevOptionsCurlBase',
>    'data': { '*cookie': 'str',
> -            '*cookie-secret': 'str'} }
> +            '*cookie-secret': 'str',
> +            '*header': [ 'str' ] } }
> =20
>  ##
>  # @BlockdevOptionsCurlHttps:
> @@ -3070,13 +3073,16 @@
>  # @cookie-secret: ID of a QCryptoSecret object providing the cookie da=
ta in a
>  #                 secure way. See @cookie for the format. (since 2.10)
>  #
> +# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3=
).

Same here about version annotation.

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

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
