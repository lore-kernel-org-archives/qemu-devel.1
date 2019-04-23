Received: from eggs.gnu.org ([209.51.188.92]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIsJs-0004cC-4q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIsF6-0008TE-D0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIsF6-0008Sl-3V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:01:36 -0400
Date: Tue, 23 Apr 2019 11:01:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423100101.GD6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190417053225.27505-1-richard.henderson@linaro.org>
	<20190417053225.27505-2-richard.henderson@linaro.org>
	<fb4917eb-4ff3-7a93-cbcd-39d1800827e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb4917eb-4ff3-7a93-cbcd-39d1800827e8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] util/path: Do not cache all filenames
 at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Apr 23, 2019 at 11:54:53AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Richard, Daniel,
>=20
> On 4/17/19 7:32 AM, Richard Henderson wrote:
> > If one uses -L $PATH to point to a full chroot, the startup time
> > is significant.  In addition, the existing probing algorithm fails
> > to handle symlink loops.
> >=20
> > Instead, probe individual paths on demand.  Cache both positive
> > and negative results within $PATH, so that any one filename is
> > probed only once.
> >=20
> > Use glib filename functions for clarity.
> >=20
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  util/path.c | 211 ++++++++++++++------------------------------------=
--
> >  1 file changed, 57 insertions(+), 154 deletions(-)


> > +#if GLIB_CHECK_VERSION(2, 58, 0)
>=20
> Should we raise GLIB_VERSION_MAX_ALLOWED in "glib-compat.h"?
>=20
> Currently it is:
>=20
>   /* Ask for warnings if code tries to use function that did not
>    * exist in the defined version. These risk breaking builds
>    */
>   #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40

Use of 2.40 is set in accordance with our targetted platform support
policy. If Peter has stopped using the Ubuntu 14.04 build host, we
could bump it to 2.42. Once our dev tree opens up we could in fact
drop Jessie since we'll be supporting Buster by the time next QEMU
is released. That would still only take us upto perhaps Glib 2.48

Glib 2.58 is waaaay to new to rely on.

commit e7b3af81597db1a6b55f2c15d030d703c6b2c6ac
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Fri May 4 15:34:46 2018 +0100

    glib: bump min required glib library version to 2.40
   =20
    Per supported platforms doc[1], the various min glib on relevant dist=
ros is:
   =20
      RHEL-7: 2.50.3
      Debian (Stretch): 2.50.3
      Debian (Jessie): 2.42.1
      OpenBSD (Ports): 2.54.3
      FreeBSD (Ports): 2.50.3
      OpenSUSE Leap 15: 2.54.3
      SLE12-SP2: 2.48.2
      Ubuntu (Xenial): 2.48.0
      macOS (Homebrew): 2.56.0
   =20
    This suggests that a minimum glib of 2.42 is a reasonable target.
   =20
    The GLibC compile farm, however, uses Ubuntu 14.04 (Trusty) which onl=
y
    has glib 2.40.0, and this is needed for testing during merge. Thus an
    exception is made to the documented platform support policy to allow =
for
    all three current LTS releases to be supported.
   =20
    Docker jobs that not longer satisfy this new min version are removed.
   =20
    [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platfo=
rms
   =20
    Reviewed-by: Thomas Huth <thuth@redhat.com>
    Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> From commit e71e8cc035558eabd6b3e19f6d3254c754c027ef:
>=20
>  glib: enforce the minimum required version and warn about old APIs
>=20
>  There are two useful macros that can be defined before including
>  glib.h that are related to the min required glib version
>=20
>   - GLIB_VERSION_MIN_REQUIRED
>=20
>     When this is defined, if code uses an API that was deprecated
>     in this version, or older, a compiler warning will be emitted.
>     This alerts maintainers to update their code to whatever new
>     replacement API is now recommended best practice.
>=20
>   - GLIB_VERSION_MAX_ALLOWED
>=20
>     When this is defined, if code uses an API that was introduced
>     in a version that is newer than the declared version, a compiler
>     warning will be emitted. This alerts maintainers if new code
>     accidentally uses functionality that won't be available on some
>     supported platforms.
>=20
>  The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
>  in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
>  To workaround this Pragmas can be used to temporarily turn off the
>  -Wdeprecated-declarations compiler warning, while a static inline
>  compat function is implemented. This workaround is illustrated with th=
e
>  implementation of the g_strv_contains method to satisfy the test suite=
.
>=20
> > +    base =3D g_canonicalize_filename(prefix, NULL);
> > +#else
> > +    if (prefix[0] !=3D '/') {
> > +        char *cwd =3D g_get_current_dir();
> > +        base =3D g_build_filename(cwd, prefix, NULL);
> > +        g_free(cwd);
> > +    } else {
> > +        base =3D g_strdup(prefix);
> > +    }
> > +#endif

To use functionality from newer glib releases we can't put the #ifdef
conditionals inline in the main source files.

They have to be put into glib-compat.h instead. There's a detailed
comment in that file illustrating how todo this without triggering
the compile warnings about deprecations.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
