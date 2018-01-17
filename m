Received: from eggs.gnu.org ([2001:4830:134:3::10]:48121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebnpL-0004H7-K7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebnpH-0004Ca-H1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebnpH-0004Br-AA
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:32:23 -0500
Date: Wed, 17 Jan 2018 13:32:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180117133201.GN19227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180117131821.18700-1-f4bug@amsat.org>
	<20180117131821.18700-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180117131821.18700-2-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] compiler: add
 QEMU_WARN_NONNULL_ARGS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Jan 17, 2018 at 10:18:19AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu/compiler.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 340e5fdc09..d9b2489391 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -26,6 +26,8 @@
> =20
>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
> =20
> +#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args)))

If we take this, it should come with a warning attached to it, because
it has really nasty behaviour with GCC. Consider code like:

  void foo(void *bar) __attribute__((nonnull(1)));

  ...

  void foo(void *bar) { if (!bar) return; }

GCC may or may not warn you about passing NULL for the 'bar'
parameter, but it will none the less assume nothing passes
NULL, and thus remove the 'if (!bar)' conditional during
optimization. IOW, adding nonnull annotations can actually
make your code less robust :-(

After having a number of crashes in libvirt caused by gcc
optimizing out checks for NULL, we now only define nonnull
when running under static analysis (coverity) and not when
compiling normally.

https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/internal.h;h=3D=
5895030415968d72200599e8a59bbf01ffc2d5a3;hb=3DHEAD#l162

The 2 functions you've added nonnull attrs to look safe enough,
but people might unwittingly use this elsewhere in QEMU in future
not realizing the side-effect it has.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
