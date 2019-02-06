Received: from eggs.gnu.org ([209.51.188.92]:37862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grPkr-0006xS-0x
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grPkn-0006aP-AF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:08:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grPkl-0006Uo-6Q
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:08:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id q21so3372612wmc.5
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 08:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20190129062801.15799-1-pagupta@redhat.com>
In-Reply-To: <20190129062801.15799-1-pagupta@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Feb 2019 17:08:25 +0100
Message-ID: <CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, xiaohli@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi

On Tue, Jan 29, 2019 at 7:36 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> Hotplugging existing char chardev with qmp, dereferences(removes)
> existing chardev. This patch avoids adding a chardev if a chardev
> with same id exists.

As you pointed out, if you attempt to add a chardev with an existing
ID, you get an error:

{"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type"=
:"socket","data":{"addr":{"type":"unix",
"data": {"path": "/tmp/helloworld1"}}}}}}
{"return": {}}
{"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type"=
:"socket","data":{"addr":{"type":"unix",
"data": {"path": "/tmp/helloworld1"}}}}}}
{"error": {"class": "GenericError", "desc": "attempt to add duplicate
property 'charchannel1' to object (type 'container')"}}


But the existing chardev is left untouched.

However, since unix socket chardev will delete existing file and
rebind (this is not always a good idea, but people seem to prefer
that)
the rebound socket is removed on error cleanup.


I am not sure this is a bug tbh.

Your solution to check for duplicate ID upfront is ok. But any other
later error path could have the same "bug" effect of removing existing
chardev because of the overwrite socket creation.

Daniel, you may want to comment (we had a similar discussion about
Spice server unix sockets recently)

thanks

>
> RH BZ 1660831:
>
> # (host) ls -lt /tmp/helloworld*
> srwxr-xr-x.  /tmp/helloworld1
> srwxr-xr-x.  /tmp/helloworld2
>
> Before this patch:
>
> hotplug existed chardev(channel1) in qmp:
> {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"typ=
e":"socket",
> "data":{"addr":{"type":"unix", "data": {"path": "/tmp/helloworld1"}}}}}}
>
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate
> property 'charchannel1' to object (type 'container')"}}
>
> # ls -lt /tmp/helloworld*
> srwxr-xr-x. 1 root root 0 Dec 19 16:39 /tmp/helloworld2
>
> After this patch:
>
> {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"typ=
e":"socket",
> "data":{"addr":{"type":"unix", "data": {"path": "/tmp/helloworld1"}}}}}}
> {"error": {"class": "GenericError", "desc": "Chardev 'charchannel1' alrea=
dy exists"}}
>
> # ls -lt /tmp/helloworld*
> srwxr-xr-x. 1 /tmp/helloworld1
> srwxr-xr-x. 1 /tmp/helloworld2
>
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>
> v1->v2
>  Correct error message - Eric
>
>  chardev/char.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index ccba36bafb..cab0d3df16 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -985,6 +985,12 @@ ChardevReturn *qmp_chardev_add(const char *id, Chard=
evBackend *backend,
>      ChardevReturn *ret;
>      Chardev *chr;
>
> +    chr =3D qemu_chr_find(id);
> +    if (chr) {
> +        error_setg(errp, "Chardev '%s' already exists", id);
> +        return NULL;
> +    }
> +
>      cc =3D char_get_class(ChardevBackendKind_str(backend->type), errp);
>      if (!cc) {
>          return NULL;
> --
> 2.14.3
>
>


--=20
Marc-Andr=C3=A9 Lureau
