Received: from eggs.gnu.org ([2001:4830:134:3::10]:60224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eygBm-0005Wu-Mz
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eygBg-0005iN-D6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:02:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eygBg-0005i0-8D
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:02:04 -0400
Date: Wed, 21 Mar 2018 18:02:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180321174022-mutt-send-email-mst@kernel.org>
References: <1521645545-247351-1-git-send-email-mst@redhat.com>
	<1521645545-247351-2-git-send-email-mst@redhat.com>
	<20180321153651.GS8551@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180321153651.GS8551@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] make: switch from -I to
 -iquote
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>

On Wed, Mar 21, 2018 at 03:36:51PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Mar 21, 2018 at 05:22:07PM +0200, Michael S. Tsirkin wrote:
> > Our rule right now is to use <> for external headers,
> > "" for internal ones. The idea was to avoid conflicts
> > between e.g. a system file named <trace.h> and an
> > internal one by the same name.
> >=20
> > Unfortunately we use -I compiler flag so it does not
> > help: a system file doing #include <trace.h> will
> > still pick up ours first.
>=20
> Has that actually hit you practice ?  I'm wondering if this
> is just theoretical in which case it could wait till 2.13
> since this scenario has existed in QEMU along time, or
> a real problem right now requiring fix in 2.12.

It's borderline.

In particular there is at least one instance where we already have a
conflict (yes, there are probably other ways to address this, but
I consider them less robust):

util/getauxval.c:#include <sys/auxv.h>
/usr/include/sys/auxv.h:#include <elf.h>

So it really does build by luck.


> > To fix, switch to -iquote which is supported by both
> > gcc and clang and only affects #include "" directives.
>=20
> Fine since we don't support anything other than
> gcc and clang. I'm assuming -iquote has been supported
> by these two compilers for a long time though ? The GCC
> docs annoyingly don't ever mention what release features
> appear in :-(

Judging by git log output:

For clang it appears to be there since 2007 that's pretty
close to day 1.

gcc's log is better documented, it's been there since 2004-05-03

> >=20
> > As a side effect, this catches any future uses of
> >  #include <> for internal headers.
> >=20
> > Suggested-by: Stefan Weil <sw@weilnetz.de>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>


Thanks!

>=20
> >=20
> > I still think we want to switch to a more formal rule such as qemu/
> > prefix for all includes down the road, but this will at least catch a=
ny
> > scheme violations from creeping in meanwhile.
> >=20
> >=20
> >  configure       | 16 ++++++++--------
> >  rules.mak       |  2 +-
> >  Makefile.target |  4 ++--
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/configure b/configure
> > index af72fc8..23a4f3b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -534,7 +534,7 @@ QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -=
fwrapv $QEMU_CFLAGS"
> >  QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $Q=
EMU_CFLAGS"
> >  QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
> >  QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_S=
OURCE $QEMU_CFLAGS"
> > -QEMU_INCLUDES=3D"-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/accel/tcg -I\$(SR=
C_PATH)/include"
> > +QEMU_INCLUDES=3D"-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)=
/accel/tcg -iquote \$(SRC_PATH)/include"
> >  if test "$debug_info" =3D "yes"; then
> >      CFLAGS=3D"-g $CFLAGS"
> >      LDFLAGS=3D"-g $LDFLAGS"
> > @@ -6560,19 +6560,19 @@ if test "$vxhs" =3D "yes" ; then
> >  fi
> > =20
> >  if test "$tcg_interpreter" =3D "yes"; then
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
> >  elif test "$ARCH" =3D "sparc64" ; then
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
> >  elif test "$ARCH" =3D "s390x" ; then
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
> >  elif test "$ARCH" =3D "x86_64" -o "$ARCH" =3D "x32" ; then
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
> >  elif test "$ARCH" =3D "ppc64" ; then
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
> >  else
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
> >  fi
> > -QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg $QEMU_INCLUDES"
> > +QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
> > =20
> >  echo "TOOLS=3D$tools" >> $config_host_mak
> >  echo "ROMS=3D$roms" >> $config_host_mak
> > diff --git a/rules.mak b/rules.mak
> > index 6e94333..93a0702 100644
> > --- a/rules.mak
> > +++ b/rules.mak
> > @@ -29,7 +29,7 @@ QEMU_DGFLAGS +=3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> >  # dir, one absolute and the other relative to the compiler working
> >  # directory. These are the same for target-independent files, but
> >  # different for target-dependent ones.
> > -QEMU_LOCAL_INCLUDES =3D -I$(BUILD_DIR)/$(@D) -I$(@D)
> > +QEMU_LOCAL_INCLUDES =3D -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
> > =20
> >  WL_U :=3D -Wl,-u,
> >  find-symbols =3D $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
> > diff --git a/Makefile.target b/Makefile.target
> > index 6549481..d0ec77a 100644
> > --- a/Makefile.target
> > +++ b/Makefile.target
> > @@ -11,9 +11,9 @@ $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
> >  ifdef CONFIG_LINUX
> >  QEMU_CFLAGS +=3D -I../linux-headers
> >  endif
> > -QEMU_CFLAGS +=3D -I.. -I$(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEE=
D_CPU_H
> > +QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE=
_ARCH) -DNEED_CPU_H
> > =20
> > -QEMU_CFLAGS+=3D-I$(SRC_PATH)/include
> > +QEMU_CFLAGS+=3D-iquote $(SRC_PATH)/include
> > =20
> >  ifdef CONFIG_USER_ONLY
> >  # user emulator name
> > --=20
> > MST
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
