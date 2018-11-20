Received: from eggs.gnu.org ([2001:4830:134:3::10]:56794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gOyr0-00052I-7k
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 00:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gOyqz-0008PX-CV
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 00:45:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gOyqy-0008N4-Fq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 00:45:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id w7-v6so870942wmc.1
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 21:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20181119135903.11729-1-berrange@redhat.com>
In-Reply-To: <20181119135903.11729-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Nov 2018 09:45:23 +0400
Message-ID: <CAJ+F1CKnNftoqOfQBX6mMtpX+Jq2K21VyP8s-w7-wq3hAgYd7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom: avoid reporting errors for NULL error
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Hi

On Mon, Nov 19, 2018 at 5:59 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> When debugging QEMU it is often useful to put a breakpoint on the
> error_setg_internal method impl.
>
> Unfortunately the object_property_add / object_class_property_add
> methods call object_property_find / object_class_property_find methods
> to check if a property exists already before adding the new property.
>
> As a result there are a huge number of calls to error_setg_internal
> on startup of most QEMU commands, making it very painful to set a
> breakpoint on this method.
>
> This puts a minor optimization on the code so that we avoid calling
> error_setg() when errp is NULL. Functionally there's no difference
> since error_setg() is a no-op when errp is NULL, but this lets us
> use breakpoints in GDB in a practical way.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Or maybe change the error_setg* macros? After all, if errp is NULL,
it's an error qemu can handle.

> ---
>  qom/object.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 547dcf97c3..ddd5e7a30e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1087,7 +1087,12 @@ ObjectProperty *object_property_find(Object *obj, =
const char *name,
>          return prop;
>      }
>
> -    error_setg(errp, "Property '.%s' not found", name);
> +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> +     * otherwise every property add call hits error_setg
> +     * making it impratical to set breakpoints in GDB */
> +    if (errp) {
> +        error_setg(errp, "Property '.%s' not found", name);
> +    }
>      return NULL;
>  }
>
> @@ -1133,7 +1138,10 @@ ObjectProperty *object_class_property_find(ObjectC=
lass *klass, const char *name,
>      }
>
>      prop =3D g_hash_table_lookup(klass->properties, name);
> -    if (!prop) {
> +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> +     * otherwise every property add call hits error_setg
> +     * making it impratical to set breakpoints in GDB */
> +    if (!prop && errp) {
>          error_setg(errp, "Property '.%s' not found", name);
>      }
>      return prop;
> --
> 2.19.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
