Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebosN-0000Pn-5k
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebosJ-00050A-Qa
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:39:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebosJ-0004zS-I9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:39:35 -0500
Date: Wed, 17 Jan 2018 14:39:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180117143911.GQ19227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180117131821.18700-1-f4bug@amsat.org>
	<20180117131821.18700-2-f4bug@amsat.org>
	<20180117133201.GN19227@redhat.com>
	<a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
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

On Wed, Jan 17, 2018 at 11:33:34AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 01/17/2018 10:32 AM, Daniel P. Berrange wrote:
> > On Wed, Jan 17, 2018 at 10:18:19AM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  include/qemu/compiler.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> >> index 340e5fdc09..d9b2489391 100644
> >> --- a/include/qemu/compiler.h
> >> +++ b/include/qemu/compiler.h
> >> @@ -26,6 +26,8 @@
> >> =20
> >>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
> >> =20
> >> +#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args=
)))
> >=20
> > If we take this, it should come with a warning attached to it, becaus=
e
> > it has really nasty behaviour with GCC. Consider code like:
> >=20
> >   void foo(void *bar) __attribute__((nonnull(1)));
> >=20
> >   ...
> >=20
> >   void foo(void *bar) { if (!bar) return; }
> >=20
> > GCC may or may not warn you about passing NULL for the 'bar'
> > parameter, but it will none the less assume nothing passes
> > NULL, and thus remove the 'if (!bar)' conditional during
> > optimization. IOW, adding nonnull annotations can actually
> > make your code less robust :-(
>=20
> TIL!
>=20
> > After having a number of crashes in libvirt caused by gcc
> > optimizing out checks for NULL, we now only define nonnull
> > when running under static analysis (coverity) and not when
> > compiling normally.
> >=20
> > https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/internal.h;=
h=3D5895030415968d72200599e8a59bbf01ffc2d5a3;hb=3DHEAD#l162
>=20
> Why do you use __attribute__(()) ? Isn't this enough:

No idea offhand - Eric wrote this so perhaps he had a reason for that
else branch style.

>=20
> #if defined __clang_analyzer__ || defined __COVERITY__
> #define QEMU_STATIC_ANALYSIS 1
> +#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args)))
> +#else
> +#define QEMU_WARN_NONNULL_ARGS(args...)
> #endif
>=20
> > The 2 functions you've added nonnull attrs to look safe enough,
> > but people might unwittingly use this elsewhere in QEMU in future
> > not realizing the side-effect it has.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
