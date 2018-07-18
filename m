Received: from eggs.gnu.org ([2001:4830:134:3::10]:42176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffpsS-0002xp-5Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 13:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffpsO-0007rC-V9
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 13:04:36 -0400
Date: Wed, 18 Jul 2018 18:04:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180718170428.GT9812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180712192603.11599-1-sw@weilnetz.de>
	<20180718162111.GR9812@redhat.com>
	<255cc07f-8eb7-0839-2001-e6ead4f3d969@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <255cc07f-8eb7-0839-2001-e6ead4f3d969@weilnetz.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Support pkg-config for zlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Wed, Jul 18, 2018 at 06:59:25PM +0200, Stefan Weil wrote:
> Am 18.07.2018 um 18:21 schrieb Daniel P. Berrang=C3=A9:
> > On Thu, Jul 12, 2018 at 09:26:03PM +0200, Stefan Weil wrote:
> >> This is needed for builds with the mingw64-* packages from Cygwin,
> >> but also works for Linux.
> >>
> >> Move the zlib test also more to the end because users should
> >> get information on the really important missing packages
> >> (which also require zlib) first.
> >=20
> > According to the zlib Changelog file pkgconfig support was added
> > in 2006 !
> >=20
> > [quote]
> > Changes in 1.2.3.1 (16 August 2006)
> >=20
> >   - Add pkgconfig support [Weigelt]
> > [/quote]
> >=20
> > Given our target build platforms support guidelines
> >=20
> >   https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platform=
s
> >=20
> > we can safely say that all supported platforms will have a zlib
> > that contains pkgconfig support, so......
> >=20
> >>
> >> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> >> ---
> >>  configure | 40 +++++++++++++++++++++++-----------------
> >>  1 file changed, 23 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/configure b/configure
> >> index 2a7796ea80..dcaab01729 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -2140,23 +2140,6 @@ EOF
> >>    fi
> >>  fi
> >> =20
> >> -#########################################
> >> -# zlib check
> >> -
> >> -if test "$zlib" !=3D "no" ; then
> >> -    cat > $TMPC << EOF
> >> -#include <zlib.h>
> >> -int main(void) { zlibVersion(); return 0; }
> >> -EOF
> >> -    if compile_prog "" "-lz" ; then
> >> -        :
> >> -    else
> >> -        error_exit "zlib check failed" \
> >> -            "Make sure to have the zlib libs and headers installed.=
"
> >> -    fi
> >> -fi
> >> -LIBS=3D"$LIBS -lz"
> >> -
> >>  ##########################################
> >>  # lzo check
> >> =20
> >> @@ -3525,6 +3508,29 @@ if ! compile_prog "$glib_cflags -Werror" "$gl=
ib_libs" ; then
> >>      fi
> >>  fi
> >> =20
> >> +#########################################
> >> +# zlib check
> >> +
> >> +if test "$zlib" !=3D "no" ; then
> >> +    if $pkg_config --exists zlib; then
> >> +        zlib_cflags=3D$($pkg_config --cflags zlib)
> >> +        zlib_libs=3D$($pkg_config --libs zlib)
> >> +        QEMU_CFLAGS=3D"$zlib_cflags $QEMU_CFLAGS"
> >> +        LIBS=3D"$zlib_libs $LIBS"
> >> +    else
> >> +        cat > $TMPC << EOF
> >> +#include <zlib.h>
> >> +int main(void) { zlibVersion(); return 0; }
> >> +EOF
> >> +        if compile_prog "" "-lz" ; then
> >> +            LIBS=3D"$LIBS -lz"
> >> +        else
> >> +            error_exit "zlib check failed" \
> >> +                "Make sure to have the zlib libs and headers instal=
led."
> >> +        fi
> >> +    fi
> >=20
> > .... this fallback support for non-pkgconfig scenarios can be entirel=
y
> > deleted, just leaving the error_exit message.=20
>=20
> I have no objection. Thank you for the investigation of the zlib
> history. Removing old unneeded code is always good, but maybe that's
> something which could be done after release 3.0.
>=20
> Or would you suggest to do it now? Then I can either send an updated
> patch (v2), or whoever pulls that patch can make that trivial modificat=
ion.

If we're ok with adding support for pkg-config in 3.0, I think it is
reasonable to drop the fallback check at the same time.  I think it
this stills qualify as a bug fix patch in terms of our freeze rules,
since we're specificially aiming to fix build problems on one of our
supported platforms.

So personally I'd suggest sending a v2 with the fallback dropped.
for 3.0

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
