Received: from eggs.gnu.org ([2001:4830:134:3::10]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fBNGX-0005qq-OB
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fBNGU-0001RZ-IZ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:27:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fBNGU-0001Qx-CV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:27:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PGPcGt131901
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 12:27:28 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hjvu596fa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 12:27:27 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 25 Apr 2018 12:27:27 -0400
Reply-To: muriloo@linux.ibm.com
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Wed, 25 Apr 2018 13:27:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <bb44b0dc-d0c2-2ff3-1815-00b80f199848@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/46] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Benn=C3=A9e wrote:
> This allows us to specify cross compilers for our guests. This is
> useful for building test images/programs. Currently we re-run the
> compile test for each target. I couldn't think of a way to cache the
> value for a given arch without getting messier configure code.
>=20
> The cross compiler for the guest is visible to each target as
> CROSS_CC_GUEST in config-target.mak.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v3
>   - --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit...
>   - --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D=
*}
>   - add remaining target_compiler definitions
> ---
>  configure | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/configure b/configure
> index b0ae632ee4..caa838a0d0 100755
> --- a/configure
> +++ b/configure
> @@ -453,6 +453,13 @@ vxhs=3D""
>  libxml2=3D""
>  docker=3D"no"
> =20
> +# cross compilers defaults, can be overridden with --cross-cc-ARCH
> +cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
> +cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
> +cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"

Do we need to have default values for all targets?

> +
> +enabled_cross_compilers=3D""
> +
>  supported_cpu=3D"no"
>  supported_os=3D"no"
>  bogus_os=3D"no"
> @@ -483,6 +490,11 @@ for opt do
>    ;;
>    --disable-debug-info) debug_info=3D"no"
>    ;;
> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-F=
OO option"
> +  ;;
> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D=
*}
> +                eval "cross_cc_${cc_arch}=3D\$optarg"
> +  ;;

Do we need to verify if a valid --cross-cc-FOO was passed, in case of a
typo?

>    esac
>  done
>  # OS specific
> @@ -675,10 +687,12 @@ case "$cpu" in
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu=3D"i386"
>      supported_cpu=3D"yes"
> +    cross_cc_i386=3Dgcc
>    ;;
>    x86_64|amd64)
>      cpu=3D"x86_64"
>      supported_cpu=3D"yes"
> +    cross_cc_x86_64=3Dgcc
>    ;;
>    armv*b|armv*l|arm)
>      cpu=3D"arm"
> @@ -912,6 +926,8 @@ for opt do
>    ;;
>    --disable-debug-info)
>    ;;
> +  --cross-cc-*)
> +  ;;
>    --enable-modules)
>        modules=3D"yes"
>    ;;
> @@ -6777,6 +6793,8 @@ case "$target" in
>      ;;
>  esac
> =20
> +target_compiler=3D""
> +
>  mkdir -p $target_dir
>  echo "# Automatically generated by configure - do not modify" > $confi=
g_target_mak
> =20
> @@ -6792,19 +6810,23 @@ TARGET_ABI_DIR=3D""
>  case "$target_name" in
>    i386)
>      gdb_xml_files=3D"i386-32bit.xml i386-32bit-core.xml i386-32bit-sse=
.xml"
> +    target_compiler=3D$cross_cc_i386
>    ;;
>    x86_64)
>      TARGET_BASE_ARCH=3Di386
>      gdb_xml_files=3D"i386-64bit.xml i386-64bit-core.xml i386-64bit-sse=
.xml"
> +    target_compiler=3D$cross_cc_x86_64
>    ;;
>    alpha)
>      mttcg=3D"yes"
> +    target_compiler=3D$cross_cc_alpha
>    ;;
>    arm|armeb)
>      TARGET_ARCH=3Darm
>      bflt=3D"yes"
>      mttcg=3D"yes"
>      gdb_xml_files=3D"arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xm=
l"
> +    target_compiler=3D$cross_cc_arm
>    ;;
>    aarch64|aarch64_be)
>      TARGET_ARCH=3Daarch64
> @@ -6812,58 +6834,73 @@ case "$target_name" in
>      bflt=3D"yes"
>      mttcg=3D"yes"
>      gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml arm=
-vfp.xml arm-vfp3.xml arm-neon.xml"
> +    target_compiler=3D$cross_cc_aarch64
>    ;;
>    cris)
> +    target_compiler=3D$cross_cc_cris
>    ;;
>    hppa)
>      mttcg=3D"yes"
> +    target_compiler=3D$cross_cc_hppa
>    ;;
>    lm32)
> +    target_compiler=3D$cross_cc_lm32
>    ;;
>    m68k)
>      bflt=3D"yes"
>      gdb_xml_files=3D"cf-core.xml cf-fp.xml m68k-fp.xml"
> +    target_compiler=3D$cross_cc_m68k
>    ;;
>    microblaze|microblazeel)
>      TARGET_ARCH=3Dmicroblaze
>      bflt=3D"yes"
> +    target_compiler=3D$cross_cc_microblaze
>    ;;
>    mips|mipsel)
>      TARGET_ARCH=3Dmips
> +    target_compiler=3D$cross_cc_mips
>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>    ;;
>    mipsn32|mipsn32el)
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
> +    target_compiler=3D$cross_cc_mipsn32
>      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips64|mips64el)
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
> +    target_compiler=3D$cross_cc_mips64
>      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
>    ;;
>    moxie)
> +    target_compiler=3D$cross_cc_moxie
>    ;;
>    nios2)
> +    target_compiler=3D$cross_cc_nios2
>    ;;
>    or1k)
> +    target_compiler=3D$cross_cc_or1k
>      TARGET_ARCH=3Dopenrisc
>      TARGET_BASE_ARCH=3Dopenrisc
>    ;;
>    ppc)
>      gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml"
> +    target_compiler=3D$cross_cc_powerpc
>    ;;
>    ppcemb)
>      TARGET_BASE_ARCH=3Dppc
>      TARGET_ABI_DIR=3Dppc
>      gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml"
> +    target_compiler=3D$cross_cc_ppcemb
>    ;;
>    ppc64)
>      TARGET_BASE_ARCH=3Dppc
>      TARGET_ABI_DIR=3Dppc
>      mttcg=3Dyes
>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml =
power-spe.xml power-vsx.xml"
> +    target_compiler=3D$cross_cc_ppc64
>    ;;
>    ppc64le)
>      TARGET_ARCH=3Dppc64
> @@ -6871,6 +6908,7 @@ case "$target_name" in
>      TARGET_ABI_DIR=3Dppc
>      mttcg=3Dyes
>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml =
power-spe.xml power-vsx.xml"
> +    target_compiler=3D$cross_cc_ppc64le
>    ;;
>    ppc64abi32)
>      TARGET_ARCH=3Dppc64
> @@ -6878,45 +6916,57 @@ case "$target_name" in
>      TARGET_ABI_DIR=3Dppc
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml =
power-spe.xml power-vsx.xml"
> +    target_compiler=3D$cross_cc_ppc64abi32
>    ;;
>    riscv32)
>      TARGET_BASE_ARCH=3Driscv
>      TARGET_ABI_DIR=3Driscv
>      mttcg=3Dyes
> +    target_compiler=3D$cross_cc_riscv32
>    ;;
>    riscv64)
>      TARGET_BASE_ARCH=3Driscv
>      TARGET_ABI_DIR=3Driscv
>      mttcg=3Dyes
> +    target_compiler=3D$cross_cc_riscv64
>    ;;
>    sh4|sh4eb)
>      TARGET_ARCH=3Dsh4
>      bflt=3D"yes"
> +    target_compiler=3D$cross_cc_sh4
>    ;;
>    sparc)
> +    target_compiler=3D$cross_cc_sparc
>    ;;
>    sparc64)
>      TARGET_BASE_ARCH=3Dsparc
> +    target_compiler=3D$cross_cc_sparc64
>    ;;
>    sparc32plus)
>      TARGET_ARCH=3Dsparc64
>      TARGET_BASE_ARCH=3Dsparc
>      TARGET_ABI_DIR=3Dsparc
> +    target_compiler=3D$cross_cc_sparc32plus
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    s390x)
>      mttcg=3Dyes
>      gdb_xml_files=3D"s390x-core64.xml s390-acr.xml s390-fpr.xml s390-v=
x.xml s390-cr.xml s390-virt.xml s390-gs.xml"
> +    target_compiler=3D$cross_cc_s390x
>    ;;
>    tilegx)
> +    target_compiler=3D$cross_cc_tilegx
>    ;;
>    tricore)
> +    target_compiler=3D$cross_cc_tricore
>    ;;
>    unicore32)
> +    target_compiler=3D$cross_cc_unicore32
>    ;;
>    xtensa|xtensaeb)
>      TARGET_ARCH=3Dxtensa
>      mttcg=3D"yes"
> +    target_compiler=3D$cross_cc_xtensa
>    ;;
>    *)
>      error_exit "Unsupported target CPU"
> @@ -6927,6 +6977,25 @@ if [ "$TARGET_BASE_ARCH" =3D "" ]; then
>    TARGET_BASE_ARCH=3D$TARGET_ARCH
>  fi
> =20
> +# Do we have a cross compiler for this target?
> +if has $target_compiler; then
> +
> +    cat > $TMPC << EOF
> +#include <stdio.h>
> +int main(void) {
> +    printf("Hello World!\n");
> +}
> +EOF

Can this be replaced by write_c_skeleton?

> +
> +    if ! do_compiler $target_compiler -o $TMPE $TMPC -static ; then
> +        target_compiler=3D""
> +    else
> +        enabled_cross_compilers=3D"${enabled_cross_compilers} ${target=
_compiler}"
> +    fi
> +else
> +    target_compiler=3D""
> +fi
> +
>  symlink "$source_path/Makefile.target" "$target_dir/Makefile"
> =20
>  upper() {
> @@ -7000,6 +7069,10 @@ if test "$target_bsd_user" =3D "yes" ; then
>    echo "CONFIG_BSD_USER=3Dy" >> $config_target_mak
>  fi
> =20
> +if test -n "$target_compiler"; then
> +  echo "CROSS_CC_GUEST=3D$target_compiler" >> $config_target_mak
> +fi
> +
>  # generate QEMU_CFLAGS/LDFLAGS for targets
> =20
>  cflags=3D""
> @@ -7122,6 +7195,12 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_=
mak
> =20
>  done # for target in $targets
> =20
> +if test -n "$enabled_cross_compilers"; then
> +    echo
> +    echo "NOTE: cross-compilers enabled:"
> +    printf '%s\n' $enabled_cross_compilers | sort -u
> +fi
> +
>  if [ "$dtc_internal" =3D "yes" ]; then
>    echo "config-host.h: subdir-dtc" >> $config_host_mak
>  fi
>=20
