Received: from eggs.gnu.org ([2001:4830:134:3::10]:53520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVwUi-0003ZZ-8c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVwUe-0005h3-7J
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVwUd-0005fq-VF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:02:36 -0400
Date: Fri, 14 Jul 2017 05:02:32 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1724026964.16491421.1500022952979.JavaMail.zimbra@redhat.com>
In-Reply-To: <d42dd796-70c1-55c9-ff6c-9318b7d2a33a@amsat.org>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-25-git-send-email-pbonzini@redhat.com>
	<d42dd796-70c1-55c9-ff6c-9318b7d2a33a@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 24/42] configure: add --disable-tcg
 configure option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@us.ibm.com>



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, qemu-devel@nongnu.org
> Cc: "Anthony Liguori" <aliguori@us.ibm.com>
> Sent: Friday, July 14, 2017 7:24:29 AM
> Subject: Re: [Qemu-devel] [PULL 24/42] configure: add --disable-tcg confi=
gure option
>=20
> Hi Paolo,
>=20
> trying "./configure --disable-docs --disable-tcg" I get:
>=20
>    CC      x86_64-softmmu/exec.o
> qemu/exec.c: In function =E2=80=98breakpoint_invalidate=E2=80=99:
> qemu/exec.c:797:9: error: implicit declaration of function
> =E2=80=98tb_invalidate_phys_addr=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
>           tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
>           ^~~~~~~~~~~~~~~~~~~~~~~
> qemu/exec.c:797:9: error: nested extern declaration of
> =E2=80=98tb_invalidate_phys_addr=E2=80=99 [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
> qemu/rules.mak:66: recipe for target 'exec.o' failed
> make[1]: *** [exec.o] Error 1
> Makefile:328: recipe for target 'subdir-x86_64-softmmu' failed
> make: *** [subdir-x86_64-softmmu] Error 2
>=20
> due to include/exec/exec-all.h:
>=20
> #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
> void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
> #else

This is introduced by Pranith's patch.  I will respin my pull request.

Paolo

>=20
> On 07/05/2017 04:14 AM, Paolo Bonzini wrote:
> > This lets you build without TCG (hardware accelerationor qtest only).  =
When
> > this flag is passed to configure, it will automatically filter out the
> > target
> > list to only those that support KVM or Xen or HAX.
> >=20
> > Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   configure | 26 +++++++++++++++++++++-----
> >   1 file changed, 21 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/configure b/configure
> > index ae69e96..806658c 100755
> > --- a/configure
> > +++ b/configure
> > @@ -232,7 +232,12 @@ supported_target() {
> >               return 1
> >               ;;
> >       esac
> > -    return 0
> > +    test "$tcg" =3D "yes" && return 0
> > +    supported_kvm_target "$1" && return 0
> > +    supported_xen_target "$1" && return 0
> > +    supported_hax_target "$1" && return 0
> > +    print_error "TCG disabled, but hardware accelerator not available =
for
> > '$target'"
> > +    return 1
> >   }
> >  =20
> >   # default parameters
> > @@ -296,6 +301,7 @@ cap_ng=3D""
> >   attr=3D""
> >   libattr=3D""
> >   xfs=3D""
> > +tcg=3D"yes"
> >  =20
> >   vhost_net=3D"no"
> >   vhost_scsi=3D"no"
> > @@ -1033,6 +1039,10 @@ for opt do
> >     ;;
> >     --enable-cap-ng) cap_ng=3D"yes"
> >     ;;
> > +  --disable-tcg) tcg=3D"no"
> > +  ;;
> > +  --enable-tcg) tcg=3D"yes"
> > +  ;;
> >     --disable-spice) spice=3D"no"
> >     ;;
> >     --enable-spice) spice=3D"yes"
> > @@ -5195,7 +5205,6 @@ echo "module support    $modules"
> >   echo "host CPU          $cpu"
> >   echo "host big endian   $bigendian"
> >   echo "target list       $target_list"
> > -echo "tcg debug enabled $debug_tcg"
> >   echo "gprof enabled     $gprof"
> >   echo "sparse enabled    $sparse"
> >   echo "strip binaries    $strip_opt"
> > @@ -5250,8 +5259,12 @@ echo "ATTR/XATTR support $attr"
> >   echo "Install blobs     $blobs"
> >   echo "KVM support       $kvm"
> >   echo "HAX support       $hax"
> > +echo "TCG support       $tcg"
> > +if test "$tcg" =3D "yes" ; then
> > +    echo "TCG debug enabled $debug_tcg"
> > +    echo "TCG interpreter   $tcg_interpreter"
> > +fi
> >   echo "RDMA support      $rdma"
> > -echo "TCG interpreter   $tcg_interpreter"
> >   echo "fdt support       $fdt"
> >   echo "preadv support    $preadv"
> >   echo "fdatasync         $fdatasync"
> > @@ -5694,8 +5707,11 @@ fi
> >   if test "$signalfd" =3D "yes" ; then
> >     echo "CONFIG_SIGNALFD=3Dy" >> $config_host_mak
> >   fi
> > -if test "$tcg_interpreter" =3D "yes" ; then
> > -  echo "CONFIG_TCG_INTERPRETER=3Dy" >> $config_host_mak
> > +if test "$tcg" =3D "yes"; then
> > +  echo "CONFIG_TCG=3Dy" >> $config_host_mak
> > +  if test "$tcg_interpreter" =3D "yes" ; then
> > +    echo "CONFIG_TCG_INTERPRETER=3Dy" >> $config_host_mak
> > +  fi
> >   fi
> >   if test "$fdatasync" =3D "yes" ; then
> >     echo "CONFIG_FDATASYNC=3Dy" >> $config_host_mak
> >=20
>=20
