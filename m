Received: from eggs.gnu.org ([2001:4830:134:3::10]:50749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etfmZ-0006h9-R2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etfmS-0008Uf-RB
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:35:27 -0500
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com
	([104.47.32.62]:64064
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etfmS-0008U7-7U
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:35:20 -0500
References: <152044348322.1455.3969737570225820649@bdbb90650ae5>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4d92bde9-85ce-e6b6-8bc6-30d80a9c4e3c@amd.com>
Date: Wed, 7 Mar 2018 14:35:07 -0600
MIME-Version: 1.0
In-Reply-To: <152044348322.1455.3969737570225820649@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v11 00/28] x86: Secure Encrypted
 Virtualization (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, famz@redhat.com, peter.maydell@linaro.org, kvm@vger.kernel.org, mst@redhat.com, stefanha@gmail.com, agraf@suse.de, edgar.iglesias@xilinx.com, armbru@redhat.com, brogers@suse.com, borntraeger@de.ibm.com, marcel@redhat.com, bp@suse.de, Thomas.Lendacky@amd.com, ehabkost@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com, alistair.francis@xilinx.com, cornelia.huck@de.ibm.com, crosthwaite.peter@gmail.com, pbonzini@redhat.com

Hi,

I have root caused and fixed the build issue seen with mingw32 compiler,
the patch is very trivial (see below).

I am looking for direction on how to submit the fix, should I resubmit
the whole series or just send the updated=C2=A0 patch marked as "Patch v1=
1.1
=2E.." ? The "patch v11 11/28" included these headers in sev_i386.h, we
need to move them in sev.c to fix this issue.

thanks

-------

diff --git a/target/i386/sev.c b/target/i386/sev.c
index f838cf7e3720..826bdff7bf2e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -11,6 +11,11 @@
=C2=A0 *
=C2=A0 */
=C2=A0
+#include <linux/psp-sev.h>
+#include <linux/kvm.h>
+
+#include <sys/ioctl.h>
+
=C2=A0#include "qemu/osdep.h"
=C2=A0#include "qapi/error.h"
=C2=A0#include "qom/object_interfaces.h"
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index cd802e4b4178..b8622dfb1e49 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -14,11 +14,6 @@
=C2=A0#ifndef QEMU_SEV_I386_H
=C2=A0#define QEMU_SEV_I386_H
=C2=A0
-#include <linux/kvm.h>
-#include <linux/psp-sev.h>
-
-#include <sys/ioctl.h>
-
=C2=A0#include "qom/object.h"
=C2=A0#include "qapi/error.h"
=C2=A0#include "sysemu/kvm.h"



On 3/7/18 11:24 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed docker-mingw@fedora build test. Please find the test=
ing commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>
> Type: series
> Message-id: 20180307165038.88640-1-brijesh.singh@amd.com
> Subject: [Qemu-devel] [PATCH v11 00/28] x86: Secure Encrypted Virtualiz=
ation (AMD)
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D8
> time make docker-test-mingw@fedora
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 4fbea75df6 tests/qmp-test: blacklist sev specific qmp commands
> dee06afe23 sev/i386: add sev_get_capabilities()
> 4bc4467cbd qmp: add query-sev-capabilities command
> b96190fd71 cpu/i386: populate CPUID 0x8000_001F when SEV is active
> 3c60cdc4ec sev/i386: add migration blocker
> a9ab0a27b2 qmp: add query-sev-launch-measure command
> 7a9005e7b3 target/i386: clear C-bit when walking SEV guest page table
> 1758f0ec5d sev/i386: add debug encrypt and decrypt commands
> 31a61f5fe9 hw/i386: set ram_debug_ops when memory encryption is enabled=

> 346e90b176 sev/i386: finalize the SEV guest launch flow
> 38cf6ff868 sev/i386: add support to LAUNCH_MEASURE command
> a9df6d98ec target/i386: encrypt bios rom
> baa46b9faf sev/i386: add command to encrypt guest memory region
> 41354b73a4 sev/i386: add command to create launch memory encryption con=
text
> 4d35f32583 hmp: add 'info sev' command
> 16598f2cc1 kvm: introduce memory encryption APIs
> 36b000c77c sev/i386: register the guest memory range which may contain =
encrypted data
> 435a482830 sev/i386: add command to initialize the memory encryption co=
ntext
> 1c37bac2fa include: add psp-sev.h header file
> ea9d68aad5 qmp: add query-sev command
> e85ff63940 target/i386: add Secure Encrypted Virtulization (SEV) object=

> 9605c92f32 docs: add AMD Secure Encrypted Virtualization (SEV)
> 52514277fb kvm: update kvm.h to include memory encryption ioctls
> 2398a21fbd machine: add -memory-encryption property
> 40ba67a92d monitor/i386: use debug APIs when accessing guest memory
> 7a060f2310 exec: add debug version of physical memory read and write AP=
I
> 6533e78730 exec: add ram_debug_ops support
> 94ffe21118 memattrs: add debug attribute
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-99e1alq5/src/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
>   BUILD   fedora
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-99e1alq5/src'
>   GEN     /var/tmp/patchew-tester-tmp-99e1alq5/src/docker-src.2018-03-0=
7-12.18.40.16945/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-99e1alq5/src/docker-src.2018-=
03-07-12.18.40.16945/qemu.tar.vroot'...
> done.
> Checking out files:  45% (2690/5948)  =20
> Checking out files:  46% (2737/5948)  =20
> Checking out files:  47% (2796/5948)  =20
> Checking out files:  48% (2856/5948)  =20
> Checking out files:  49% (2915/5948)  =20
> Checking out files:  50% (2974/5948)  =20
> Checking out files:  51% (3034/5948)  =20
> Checking out files:  52% (3093/5948)  =20
> Checking out files:  53% (3153/5948)  =20
> Checking out files:  54% (3212/5948)  =20
> Checking out files:  55% (3272/5948)  =20
> Checking out files:  56% (3331/5948)  =20
> Checking out files:  57% (3391/5948)  =20
> Checking out files:  58% (3450/5948)  =20
> Checking out files:  59% (3510/5948)  =20
> Checking out files:  60% (3569/5948)  =20
> Checking out files:  61% (3629/5948)  =20
> Checking out files:  62% (3688/5948)  =20
> Checking out files:  63% (3748/5948)  =20
> Checking out files:  64% (3807/5948)  =20
> Checking out files:  65% (3867/5948)  =20
> Checking out files:  66% (3926/5948)  =20
> Checking out files:  67% (3986/5948)  =20
> Checking out files:  68% (4045/5948)  =20
> Checking out files:  69% (4105/5948)  =20
> Checking out files:  70% (4164/5948)  =20
> Checking out files:  71% (4224/5948)  =20
> Checking out files:  72% (4283/5948)  =20
> Checking out files:  73% (4343/5948)  =20
> Checking out files:  74% (4402/5948)  =20
> Checking out files:  75% (4461/5948)  =20
> Checking out files:  76% (4521/5948)  =20
> Checking out files:  77% (4580/5948)  =20
> Checking out files:  78% (4640/5948)  =20
> Checking out files:  79% (4699/5948)  =20
> Checking out files:  80% (4759/5948)  =20
> Checking out files:  81% (4818/5948)  =20
> Checking out files:  82% (4878/5948)  =20
> Checking out files:  83% (4937/5948)  =20
> Checking out files:  84% (4997/5948)  =20
> Checking out files:  85% (5056/5948)  =20
> Checking out files:  86% (5116/5948)  =20
> Checking out files:  87% (5175/5948)  =20
> Checking out files:  88% (5235/5948)  =20
> Checking out files:  89% (5294/5948)  =20
> Checking out files:  90% (5354/5948)  =20
> Checking out files:  91% (5413/5948)  =20
> Checking out files:  92% (5473/5948)  =20
> Checking out files:  93% (5532/5948)  =20
> Checking out files:  94% (5592/5948)  =20
> Checking out files:  95% (5651/5948)  =20
> Checking out files:  96% (5711/5948)  =20
> Checking out files:  97% (5770/5948)  =20
> Checking out files:  98% (5830/5948)  =20
> Checking out files:  99% (5889/5948)  =20
> Checking out files: 100% (5948/5948)  =20
> Checking out files: 100% (5948/5948), done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-99e1alq5/src/docker-src.2018-=
03-07-12.18.40.16945/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) regis=
tered for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-99e1alq5/src/docker-src.2018-=
03-07-12.18.40.16945/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d322=
0552280ef3d832ce'
>   COPY    RUNNER
>     RUN test-mingw in qemu:fedora=20
> Packages installed:
> PyYAML-3.12-5.fc27.x86_64
> SDL-devel-1.2.15-29.fc27.x86_64
> bc-1.07.1-3.fc27.x86_64
> bison-3.0.4-8.fc27.x86_64
> bzip2-1.0.6-24.fc27.x86_64
> ccache-3.3.5-1.fc27.x86_64
> clang-5.0.1-1.fc27.x86_64
> findutils-4.6.0-14.fc27.x86_64
> flex-2.6.1-5.fc27.x86_64
> gcc-7.3.1-2.fc27.x86_64
> gcc-c++-7.3.1-2.fc27.x86_64
> gettext-0.19.8.1-12.fc27.x86_64
> git-2.14.3-2.fc27.x86_64
> glib2-devel-2.54.3-2.fc27.x86_64
> hostname-3.18-4.fc27.x86_64
> libaio-devel-0.3.110-9.fc27.x86_64
> libasan-7.3.1-2.fc27.x86_64
> libfdt-devel-1.4.6-1.fc27.x86_64
> libubsan-7.3.1-2.fc27.x86_64
> make-4.2.1-4.fc27.x86_64
> mingw32-SDL-1.2.15-9.fc27.noarch
> mingw32-bzip2-1.0.6-9.fc27.noarch
> mingw32-curl-7.54.1-2.fc27.noarch
> mingw32-glib2-2.54.1-1.fc27.noarch
> mingw32-gmp-6.1.2-2.fc27.noarch
> mingw32-gnutls-3.5.13-2.fc27.noarch
> mingw32-gtk2-2.24.31-4.fc27.noarch
> mingw32-gtk3-3.22.16-1.fc27.noarch
> mingw32-libjpeg-turbo-1.5.1-3.fc27.noarch
> mingw32-libpng-1.6.29-2.fc27.noarch
> mingw32-libssh2-1.8.0-3.fc27.noarch
> mingw32-libtasn1-4.13-1.fc27.noarch
> mingw32-nettle-3.3-3.fc27.noarch
> mingw32-pixman-0.34.0-3.fc27.noarch
> mingw32-pkg-config-0.28-9.fc27.x86_64
> mingw64-SDL-1.2.15-9.fc27.noarch
> mingw64-bzip2-1.0.6-9.fc27.noarch
> mingw64-curl-7.54.1-2.fc27.noarch
> mingw64-glib2-2.54.1-1.fc27.noarch
> mingw64-gmp-6.1.2-2.fc27.noarch
> mingw64-gnutls-3.5.13-2.fc27.noarch
> mingw64-gtk2-2.24.31-4.fc27.noarch
> mingw64-gtk3-3.22.16-1.fc27.noarch
> mingw64-libjpeg-turbo-1.5.1-3.fc27.noarch
> mingw64-libpng-1.6.29-2.fc27.noarch
> mingw64-libssh2-1.8.0-3.fc27.noarch
> mingw64-libtasn1-4.13-1.fc27.noarch
> mingw64-nettle-3.3-3.fc27.noarch
> mingw64-pixman-0.34.0-3.fc27.noarch
> mingw64-pkg-config-0.28-9.fc27.x86_64
> nettle-devel-3.4-1.fc27.x86_64
> perl-5.26.1-402.fc27.x86_64
> pixman-devel-0.34.0-4.fc27.x86_64
> python3-3.6.2-13.fc27.x86_64
> sparse-0.5.1-2.fc27.x86_64
> tar-1.29-7.fc27.x86_64
> which-2.21-4.fc27.x86_64
> zlib-devel-1.2.11-4.fc27.x86_64
>
> Environment variables:
> TARGET_LIST=3D
> PACKAGES=3Dccache gettext git tar PyYAML sparse flex bison python3 bzip=
2 hostname     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel=
     gcc gcc-c++ clang make perl which bc findutils libaio-devel     nett=
le-devel libasan libubsan     mingw32-pixman mingw32-glib2 mingw32-gmp mi=
ngw32-SDL mingw32-pkg-config     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls=
 mingw32-nettle mingw32-libtasn1     mingw32-libjpeg-turbo mingw32-libpng=
 mingw32-curl mingw32-libssh2     mingw32-bzip2     mingw64-pixman mingw6=
4-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config     mingw64-gtk2 mingw=
64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1     mingw64-libjpe=
g-turbo mingw64-libpng mingw64-curl mingw64-libssh2     mingw64-bzip2
> J=3D8
> V=3D
> HOSTNAME=3D939c73c338e1
> DEBUG=3D
> SHOW_ENV=3D1
> PWD=3D/
> HOME=3D/root
> CCACHE_DIR=3D/var/tmp/ccache
> DISTTAG=3Df27container
> QEMU_CONFIGURE_OPTS=3D--python=3D/usr/bin/python3
> FGC=3Df27
> TEST_DIR=3D/tmp/qemu-test
> SHLVL=3D1
> FEATURES=3Dmingw clang pyyaml asan dtc
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin=
:/usr/sbin:/usr/bin:/sbin:/bin
> MAKEFLAGS=3D -j8
> EXTRA_CONFIGURE_OPTS=3D
> _=3D/usr/bin/env
>
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/tmp/qemu-test/install --python=3D/usr/bin/python3 --cross-prefix=3Dx8=
6_64-w64-mingw32- --enable-trace-backends=3Dsimple --enable-gnutls --enab=
le-nettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent =
--with-sdlabi=3D1.2 --with-gtkabi=3D2.0
> Install prefix    /tmp/qemu-test/install
> BIOS directory    /tmp/qemu-test/install
> firmware path     /tmp/qemu-test/install/share/qemu-firmware
> binary directory  /tmp/qemu-test/install
> library directory /tmp/qemu-test/install/lib
> module directory  /tmp/qemu-test/install/lib
> libexec directory /tmp/qemu-test/install/libexec
> include directory /tmp/qemu-test/install/include
> config directory  /tmp/qemu-test/install
> local state directory   queried at runtime
> Windows SDK       no
> Source path       /tmp/qemu-test/src
> GIT binary        git
> GIT submodules   =20
> C compiler        x86_64-w64-mingw32-gcc
> Host C compiler   cc
> C++ compiler      x86_64-w64-mingw32-g++
> Objective-C compiler clang
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixm=
an-1  -I$(SRC_PATH)/dtc/libfdt -Werror -DHAS_LIBSSH2_SFTP_FSYNC -mms-bitf=
ields -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/usr/x8=
6_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w64-mi=
ngw32/sys-root/mingw/include  -m64 -mcx16 -mthreads -D__USE_MINGW_ANSI_ST=
DIO=3D1 -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -W=
all -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fn=
o-common -fwrapv  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negati=
ve-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat=
-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-decla=
ration -Wold-style-definition -Wtype-limits -fstack-protector-strong -I/u=
sr/x86_64-w64-mingw32/sys-root/mingw/include -I/usr/x86_64-w64-mingw32/sy=
s-root/mingw/include/p11-kit-1 -I/usr/x86_64-w64-mingw32/sys-root/mingw/i=
nclude  -I/usr/x86_64-w64-mingw32/sys-root/mingw/include   -I/usr/x86_64-=
w64-mingw32/sys-root/mingw/include/libpng16=20
> LDFLAGS           -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--w=
arn-common -m64 -g=20
> make              make
> install           install
> python            /usr/bin/python3 -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       x86_64-softmmu aarch64-softmmu
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> SDL support       yes (1.2.15)
> GTK support       yes (2.24.31)
> GTK GL support    no
> VTE support       no=20
> TLS priority      NORMAL
> GNUTLS support    yes
> GNUTLS rnd        yes
> libgcrypt         no
> libgcrypt kdf     no
> nettle            yes (3.3)
> nettle kdf        yes
> libtasn1          yes
> curses support    no
> virgl support     no
> curl support      yes
> mingw32 support   yes
> Audio drivers     dsound
> Block whitelist (rw)=20
> Block whitelist (ro)=20
> VirtFS support    no
> Multipath support no
> VNC support       yes
> VNC SASL support  no
> VNC JPEG support  yes
> VNC PNG support   yes
> xen support       no
> brlapi support    no
> bluez  support    no
> Documentation     no
> PIE               no
> vde support       no
> netmap support    no
> Linux AIO support no
> ATTR/XATTR support no
> Install blobs     yes
> KVM support       no
> HAX support       yes
> HVF support       no
> WHPX support      no
> TCG support       yes
> TCG debug enabled no
> TCG interpreter   no
> malloc trim support no
> RDMA support      no
> fdt support       yes
> preadv support    no
> fdatasync         no
> madvise           no
> posix_madvise     no
> posix_memalign    no
> libcap-ng support no
> vhost-net support no
> vhost-crypto support no
> vhost-scsi support no
> vhost-vsock support no
> vhost-user support no
> Trace backends    simple
> Trace output file trace-<pid>
> spice support     no=20
> rbd support       no
> xfsctl support    no
> smartcard support no
> libusb            no
> usb net redir     no
> OpenGL support    no
> OpenGL dmabufs    no
> libiscsi support  no
> libnfs support    no
> build guest agent yes
> QGA VSS support   no
> QGA w32 disk info yes
> QGA MSI support   no
> seccomp support   no
> coroutine backend win32
> coroutine pool    yes
> debug stack usage no
> crypto afalg      no
> GlusterFS support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   no
> TPM emulator      no
> QOM debugging     yes
> Live block migration yes
> lzo support       no
> snappy support    no
> bzip2 support     yes
> NUMA host support no
> libxml2           no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization yes
> replication support yes
> VxHS block device no
> capstone          no
>
> WARNING: Use of GTK 2.0 is deprecated and will be removed in
> WARNING: future releases. Please switch to using GTK 3.0
>
> WARNING: Use of SDL 1.2 is deprecated and will be removed in
> WARNING: future releases. Please switch to using SDL 2.0
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     qapi-gen
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
>   GEN     ui/input-keymap-atset1-to-qcode.c
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-atset1.c
>   GEN     ui/input-keymap-qcode-to-atset2.c
>   GEN     ui/input-keymap-qcode-to-atset3.c
>   GEN     ui/input-keymap-qcode-to-linux.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   GEN     ui/input-keymap-qcode-to-sun.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
>   GEN     ui/input-keymap-usb-to-qcode.c
>   GEN     ui/input-keymap-win32-to-qcode.c
>   GEN     ui/input-keymap-x11-to-qcode.c
>   GEN     ui/input-keymap-xorgevdev-to-qcode.c
>   GEN     ui/input-keymap-xorgkbd-to-qcode.c
>   GEN     ui/input-keymap-xorgxquartz-to-qcode.c
>   GEN     ui/input-keymap-xorgxwin-to-qcode.c
>   GEN     tests/test-qapi-gen
>   GEN     trace-root.h
>   GEN     util/trace.h
>   GEN     crypto/trace.h
>   GEN     io/trace.h
>   GEN     migration/trace.h
>   GEN     block/trace.h
>   GEN     chardev/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/rdma/trace.h
>   GEN     hw/rdma/vmw/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/misc/macio/trace.h
>   GEN     hw/usb/trace.h
>   GEN     hw/scsi/trace.h
>   GEN     hw/nvram/trace.h
>   GEN     hw/display/trace.h
>   GEN     hw/input/trace.h
>   GEN     hw/timer/trace.h
>   GEN     hw/dma/trace.h
>   GEN     hw/sparc/trace.h
>   GEN     hw/sparc64/trace.h
>   GEN     hw/sd/trace.h
>   GEN     hw/isa/trace.h
>   GEN     hw/mem/trace.h
>   GEN     hw/i386/trace.h
>   GEN     hw/i386/xen/trace.h
>   GEN     hw/9pfs/trace.h
>   GEN     hw/ppc/trace.h
>   GEN     hw/pci/trace.h
>   GEN     hw/pci-host/trace.h
>   GEN     hw/s390x/trace.h
>   GEN     hw/vfio/trace.h
>   GEN     hw/acpi/trace.h
>   GEN     hw/arm/trace.h
>   GEN     hw/alpha/trace.h
>   GEN     hw/hppa/trace.h
>   GEN     hw/xen/trace.h
>   GEN     hw/ide/trace.h
>   GEN     ui/trace.h
>   GEN     audio/trace.h
>   GEN     net/trace.h
>   GEN     target/arm/trace.h
>   GEN     target/i386/trace.h
>   GEN     target/mips/trace.h
>   GEN     target/sparc/trace.h
>   GEN     target/s390x/trace.h
>   GEN     target/ppc/trace.h
>   GEN     qom/trace.h
>   GEN     linux-user/trace.h
>   GEN     qapi/trace.h
>   GEN     accel/tcg/trace.h
>   GEN     accel/kvm/trace.h
>   GEN     nbd/trace.h
>   GEN     scsi/trace.h
>   GEN     trace-root.c
>   GEN     util/trace.c
>   GEN     crypto/trace.c
>   GEN     io/trace.c
>   GEN     migration/trace.c
>   GEN     block/trace.c
>   GEN     chardev/trace.c
>   GEN     hw/block/trace.c
>   GEN     hw/block/dataplane/trace.c
>   GEN     hw/char/trace.c
>   GEN     hw/intc/trace.c
>   GEN     hw/net/trace.c
>   GEN     hw/rdma/trace.c
>   GEN     hw/rdma/vmw/trace.c
>   GEN     hw/virtio/trace.c
>   GEN     hw/audio/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/misc/macio/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/scsi/trace.c
>   GEN     hw/nvram/trace.c
>   GEN     hw/display/trace.c
>   GEN     hw/input/trace.c
>   GEN     hw/timer/trace.c
>   GEN     hw/dma/trace.c
>   GEN     hw/sparc/trace.c
>   GEN     hw/sparc64/trace.c
>   GEN     hw/sd/trace.c
>   GEN     hw/isa/trace.c
>   GEN     hw/mem/trace.c
>   GEN     hw/i386/trace.c
>   GEN     hw/i386/xen/trace.c
>   GEN     hw/9pfs/trace.c
>   GEN     hw/ppc/trace.c
>   GEN     hw/pci/trace.c
>   GEN     hw/pci-host/trace.c
>   GEN     hw/s390x/trace.c
>   GEN     hw/vfio/trace.c
>   GEN     hw/acpi/trace.c
>   GEN     hw/arm/trace.c
>   GEN     hw/alpha/trace.c
>   GEN     hw/hppa/trace.c
>   GEN     hw/xen/trace.c
>   GEN     hw/ide/trace.c
>   GEN     ui/trace.c
>   GEN     audio/trace.c
>   GEN     net/trace.c
>   GEN     target/arm/trace.c
>   GEN     target/i386/trace.c
>   GEN     target/mips/trace.c
>   GEN     target/sparc/trace.c
>   GEN     target/s390x/trace.c
>   GEN     target/ppc/trace.c
>   GEN     qom/trace.c
>   GEN     linux-user/trace.c
>   GEN     qapi/trace.c
>   GEN     accel/tcg/trace.c
>   GEN     accel/kvm/trace.c
>   GEN     nbd/trace.c
>   GEN     scsi/trace.c
>   GEN     config-all-devices.mak
> 	 DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/trees.S
> 	 DEP /tmp/qemu-test/src/dtc/tests/testutils.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/check_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/overlay.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/incbin.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path-references.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/references.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/del_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/setprop.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/del_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/set_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/notfound.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/getprop.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/root_node.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/find_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtoverlay.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtput.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtget.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/srcpos.c
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/treesource.c
> 	 DEP /tmp/qemu-test/src/dtc/livetree.c
> 	 DEP /tmp/qemu-test/src/dtc/fstree.c
> 	 DEP /tmp/qemu-test/src/dtc/flattree.c
> 	 DEP /tmp/qemu-test/src/dtc/dtc.c
> 	 DEP /tmp/qemu-test/src/dtc/data.c
> 	 DEP /tmp/qemu-test/src/dtc/checks.c
> 	 DEP convert-dtsv0-lexer.lex.c
> 	 DEP dtc-lexer.lex.c
> 	 DEP dtc-parser.tab.c
> 	CHK version_gen.h
> 	UPD version_gen.h
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 CC libfdt/fdt.o
> 	 CC libfdt/fdt_ro.o
> 	 CC libfdt/fdt_wip.o
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_empty_tree.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_strerror.o
> 	 CC libfdt/fdt_addresses.o
> 	 CC libfdt/fdt_overlay.o
> 	 AR libfdt/libfdt.a
> x86_64-w64-mingw32-ar: creating libfdt/libfdt.a
> a - libfdt/fdt.o
> a - libfdt/fdt_ro.o
> a - libfdt/fdt_wip.o
> a - libfdt/fdt_sw.o
> a - libfdt/fdt_rw.o
> a - libfdt/fdt_strerror.o
> a - libfdt/fdt_empty_tree.o
> a - libfdt/fdt_addresses.o
> a - libfdt/fdt_overlay.o
>   RC      version.o
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     qga/qapi-generated/qapi-gen
>   CC      qapi/qapi-types.o
>   CC      qapi/qapi-types-block-core.o
>   CC      qapi/qapi-builtin-types.o
>   CC      qapi/qapi-types-char.o
>   CC      qapi/qapi-types-block.o
>   CC      qapi/qapi-types-common.o
>   CC      qapi/qapi-types-crypto.o
>   CC      qapi/qapi-types-introspect.o
>   CC      qapi/qapi-types-misc.o
>   CC      qapi/qapi-types-migration.o
>   CC      qapi/qapi-types-net.o
>   CC      qapi/qapi-types-rocker.o
>   CC      qapi/qapi-types-run-state.o
>   CC      qapi/qapi-types-sockets.o
>   CC      qapi/qapi-types-tpm.o
>   CC      qapi/qapi-types-trace.o
>   CC      qapi/qapi-types-transaction.o
>   CC      qapi/qapi-types-ui.o
>   CC      qapi/qapi-builtin-visit.o
>   CC      qapi/qapi-visit.o
>   CC      qapi/qapi-visit-block-core.o
>   CC      qapi/qapi-visit-char.o
>   CC      qapi/qapi-visit-block.o
>   CC      qapi/qapi-visit-common.o
>   CC      qapi/qapi-visit-crypto.o
>   CC      qapi/qapi-visit-introspect.o
>   CC      qapi/qapi-visit-migration.o
>   CC      qapi/qapi-visit-misc.o
>   CC      qapi/qapi-visit-net.o
>   CC      qapi/qapi-visit-rocker.o
>   CC      qapi/qapi-visit-run-state.o
>   CC      qapi/qapi-visit-sockets.o
>   CC      qapi/qapi-visit-tpm.o
>   CC      qapi/qapi-visit-transaction.o
>   CC      qapi/qapi-visit-trace.o
>   CC      qapi/qapi-visit-ui.o
>   CC      qapi/qapi-events.o
>   CC      qapi/qapi-events-block-core.o
>   CC      qapi/qapi-events-block.o
>   CC      qapi/qapi-events-char.o
>   CC      qapi/qapi-events-common.o
>   CC      qapi/qapi-events-crypto.o
>   CC      qapi/qapi-events-introspect.o
>   CC      qapi/qapi-events-migration.o
>   CC      qapi/qapi-events-misc.o
>   CC      qapi/qapi-events-net.o
>   CC      qapi/qapi-events-rocker.o
>   CC      qapi/qapi-events-run-state.o
>   CC      qapi/qapi-events-sockets.o
>   CC      qapi/qapi-events-tpm.o
>   CC      qapi/qapi-events-trace.o
>   CC      qapi/qapi-events-transaction.o
>   CC      qapi/qapi-events-ui.o
>   CC      qapi/qapi-introspect.o
>   CC      qapi/qapi-visit-core.o
>   CC      qapi/qapi-dealloc-visitor.o
>   CC      qapi/qobject-input-visitor.o
>   CC      qapi/qobject-output-visitor.o
>   CC      qapi/qmp-registry.o
>   CC      qapi/qmp-dispatch.o
>   CC      qapi/string-input-visitor.o
>   CC      qapi/string-output-visitor.o
>   CC      qapi/opts-visitor.o
>   CC      qapi/qapi-clone-visitor.o
>   CC      qapi/qmp-event.o
>   CC      qapi/qapi-util.o
>   CC      qobject/qnull.o
>   CC      qobject/qnum.o
>   CC      qobject/qstring.o
>   CC      qobject/qdict.o
>   CC      qobject/qbool.o
>   CC      qobject/qlist.o
>   CC      qobject/qlit.o
>   CC      qobject/qjson.o
>   CC      qobject/qobject.o
>   CC      qobject/json-lexer.o
>   CC      qobject/json-streamer.o
>   CC      qobject/json-parser.o
>   CC      trace/simple.o
>   CC      trace/control.o
>   CC      trace/qmp.o
>   CC      util/osdep.o
>   CC      util/cutils.o
>   CC      util/unicode.o
>   CC      util/qemu-timer-common.o
>   CC      util/bufferiszero.o
>   CC      util/lockcnt.o
>   CC      util/aiocb.o
>   CC      util/async.o
>   CC      util/aio-wait.o
>   CC      util/thread-pool.o
>   CC      util/qemu-timer.o
>   CC      util/main-loop.o
>   CC      util/iohandler.o
>   CC      util/aio-win32.o
>   CC      util/event_notifier-win32.o
>   CC      util/oslib-win32.o
>   CC      util/qemu-thread-win32.o
>   CC      util/envlist.o
>   CC      util/path.o
>   CC      util/module.o
>   CC      util/host-utils.o
>   CC      util/bitmap.o
>   CC      util/bitops.o
>   CC      util/hbitmap.o
>   CC      util/fifo8.o
>   CC      util/acl.o
>   CC      util/cacheinfo.o
>   CC      util/error.o
>   CC      util/qemu-error.o
>   CC      util/id.o
>   CC      util/iov.o
>   CC      util/qemu-config.o
>   CC      util/qemu-sockets.o
>   CC      util/uri.o
>   CC      util/notify.o
>   CC      util/qemu-option.o
>   CC      util/qemu-progress.o
>   CC      util/keyval.o
>   CC      util/hexdump.o
>   CC      util/crc32c.o
>   CC      util/throttle.o
>   CC      util/uuid.o
>   CC      util/getauxval.o
>   CC      util/readline.o
>   CC      util/rcu.o
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-win32.o
>   CC      util/buffer.o
>   CC      util/timed-average.o
>   CC      util/base64.o
>   CC      util/log.o
>   CC      util/pagesize.o
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      util/stats64.o
>   CC      util/systemd.o
>   CC      trace-root.o
>   CC      util/trace.o
>   CC      crypto/trace.o
>   CC      io/trace.o
>   CC      migration/trace.o
>   CC      block/trace.o
>   CC      chardev/trace.o
>   CC      hw/block/trace.o
>   CC      hw/block/dataplane/trace.o
>   CC      hw/char/trace.o
>   CC      hw/intc/trace.o
>   CC      hw/net/trace.o
>   CC      hw/rdma/trace.o
>   CC      hw/rdma/vmw/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/audio/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/misc/macio/trace.o
>   CC      hw/usb/trace.o
>   CC      hw/scsi/trace.o
>   CC      hw/nvram/trace.o
>   CC      hw/display/trace.o
>   CC      hw/input/trace.o
>   CC      hw/timer/trace.o
>   CC      hw/dma/trace.o
>   CC      hw/sparc/trace.o
>   CC      hw/sparc64/trace.o
>   CC      hw/sd/trace.o
>   CC      hw/isa/trace.o
>   CC      hw/mem/trace.o
>   CC      hw/i386/trace.o
>   CC      hw/i386/xen/trace.o
>   CC      hw/9pfs/trace.o
>   CC      hw/ppc/trace.o
>   CC      hw/pci/trace.o
>   CC      hw/pci-host/trace.o
>   CC      hw/s390x/trace.o
>   CC      hw/vfio/trace.o
>   CC      hw/acpi/trace.o
>   CC      hw/arm/trace.o
>   CC      hw/alpha/trace.o
>   CC      hw/hppa/trace.o
>   CC      hw/xen/trace.o
>   CC      hw/ide/trace.o
>   CC      ui/trace.o
>   CC      audio/trace.o
>   CC      net/trace.o
>   CC      target/arm/trace.o
>   CC      target/i386/trace.o
>   CC      target/mips/trace.o
>   CC      target/sparc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/ppc/trace.o
>   CC      qom/trace.o
>   CC      linux-user/trace.o
>   CC      qapi/trace.o
>   CC      accel/tcg/trace.o
>   CC      accel/kvm/trace.o
>   CC      nbd/trace.o
>   CC      scsi/trace.o
>   CC      crypto/pbkdf-stub.o
>   CC      stubs/arch-query-cpu-def.o
>   CC      stubs/arch-query-cpu-model-expansion.o
>   CC      stubs/arch-query-cpu-model-comparison.o
>   CC      stubs/arch-query-cpu-model-baseline.o
>   CC      stubs/bdrv-next-monitor-owned.o
>   CC      stubs/blk-commit-all.o
>   CC      stubs/blockdev-close-all-bdrv-states.o
>   CC      stubs/clock-warp.o
>   CC      stubs/cpu-get-clock.o
>   CC      stubs/cpu-get-icount.o
>   CC      stubs/dump.o
>   CC      stubs/error-printf.o
>   CC      stubs/fdset.o
>   CC      stubs/gdbstub.o
>   CC      stubs/get-vm-name.o
>   CC      stubs/iothread.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/change-state-handler.o
>   CC      stubs/monitor.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/runstate-check.o
>   CC      stubs/set-fd-handler.o
>   CC      stubs/slirp.o
>   CC      stubs/sysbus.o
>   CC      stubs/tpm.o
>   CC      stubs/trace-control.o
>   CC      stubs/uuid.o
>   CC      stubs/vm-stop.o
>   CC      stubs/vmstate.o
>   CC      stubs/fd-register.o
>   CC      stubs/qmp_pc_dimm.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      stubs/vmgenid.o
>   CC      stubs/xen-common.o
>   CC      stubs/xen-hvm.o
>   CC      stubs/pci-host-piix.o
>   CC      stubs/ram-block.o
>   CC      stubs/sev.o
>   GEN     qemu-img-cmds.h
>   CC      block.o
>   CC      blockjob.o
>   CC      qemu-io-cmds.o
>   CC      replication.o
>   CC      block/raw-format.o
>   CC      block/qcow.o
>   CC      block/vdi.o
>   CC      block/vmdk.o
>   CC      block/cloop.o
>   CC      block/bochs.o
>   CC      block/vpc.o
>   CC      block/vvfat.o
>   CC      block/dmg.o
>   CC      block/qcow2.o
>   CC      block/qcow2-refcount.o
>   CC      block/qcow2-cluster.o
>   CC      block/qcow2-snapshot.o
>   CC      block/qcow2-cache.o
>   CC      block/qcow2-bitmap.o
>   CC      block/qed.o
>   CC      block/qed-l2-cache.o
>   CC      block/qed-table.o
>   CC      block/qed-cluster.o
>   CC      block/qed-check.o
>   CC      block/vhdx.o
>   CC      block/vhdx-endian.o
>   CC      block/vhdx-log.o
>   CC      block/quorum.o
>   CC      block/parallels.o
>   CC      block/blkdebug.o
>   CC      block/blkverify.o
>   CC      block/blkreplay.o
>   CC      block/block-backend.o
>   CC      block/snapshot.o
>   CC      block/qapi.o
>   CC      block/file-win32.o
>   CC      block/win32-aio.o
>   CC      block/null.o
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/throttle.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      scsi/utils.o
>   CC      block/curl.o
>   CC      block/ssh.o
>   CC      block/dmg-bz2.o
>   CC      crypto/init.o
>   CC      crypto/hash.o
>   CC      crypto/hash-nettle.o
>   CC      crypto/hmac.o
>   CC      crypto/hmac-nettle.o
>   CC      crypto/aes.o
>   CC      crypto/desrfb.o
>   CC      crypto/cipher.o
>   CC      crypto/tlscreds.o
>   CC      crypto/tlscredsanon.o
>   CC      crypto/tlscredsx509.o
>   CC      crypto/tlssession.o
>   CC      crypto/secret.o
>   CC      crypto/random-gnutls.o
>   CC      crypto/pbkdf.o
>   CC      crypto/pbkdf-nettle.o
>   CC      crypto/ivgen.o
>   CC      crypto/ivgen-essiv.o
>   CC      crypto/ivgen-plain.o
>   CC      crypto/ivgen-plain64.o
>   CC      crypto/afsplit.o
>   CC      crypto/xts.o
>   CC      crypto/block.o
>   CC      crypto/block-qcow.o
>   CC      crypto/block-luks.o
>   CC      io/channel.o
>   CC      io/channel-buffer.o
>   CC      io/channel-command.o
>   CC      io/channel-file.o
>   CC      io/channel-socket.o
>   CC      io/channel-tls.o
>   CC      io/channel-watch.o
>   CC      io/channel-websock.o
>   CC      io/channel-util.o
>   CC      io/dns-resolver.o
>   CC      io/net-listener.o
>   CC      io/task.o
>   CC      qom/object.o
>   CC      qom/container.o
>   CC      qom/qom-qobject.o
>   CC      qom/object_interfaces.o
>   CC      qemu-io.o
>   CC      blockdev.o
>   CC      blockdev-nbd.o
>   CC      bootdevice.o
>   CC      iothread.o
>   CC      qdev-monitor.o
>   CC      device-hotplug.o
>   CC      os-win32.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      device_tree.o
>   CC      qapi/qapi-commands.o
>   CC      qapi/qapi-commands-block-core.o
>   CC      qapi/qapi-commands-block.o
>   CC      qapi/qapi-commands-char.o
>   CC      qapi/qapi-commands-common.o
>   CC      qapi/qapi-commands-crypto.o
>   CC      qapi/qapi-commands-introspect.o
>   CC      qapi/qapi-commands-migration.o
>   CC      qapi/qapi-commands-misc.o
>   CC      qapi/qapi-commands-net.o
>   CC      qapi/qapi-commands-rocker.o
>   CC      qapi/qapi-commands-run-state.o
>   CC      qapi/qapi-commands-sockets.o
>   CC      qapi/qapi-commands-tpm.o
>   CC      qapi/qapi-commands-trace.o
>   CC      qapi/qapi-commands-transaction.o
>   CC      qapi/qapi-commands-ui.o
>   CC      qmp.o
>   CC      hmp.o
>   CC      cpus-common.o
>   CC      audio/audio.o
>   CC      audio/noaudio.o
>   CC      audio/wavaudio.o
>   CC      audio/mixeng.o
>   CC      audio/dsoundaudio.o
>   CC      audio/audio_win_int.o
>   CC      audio/wavcapture.o
>   CC      backends/rng.o
>   CC      backends/rng-egd.o
>   CC      backends/tpm.o
>   CC      backends/hostmem.o
>   CC      backends/hostmem-ram.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      backends/cryptodev-vhost.o
>   CC      block/stream.o
>   CC      chardev/msmouse.o
>   CC      chardev/wctablet.o
>   CC      chardev/testdev.o
>   CC      disas/arm.o
>   CXX     disas/arm-a64.o
>   CC      disas/i386.o
>   CXX     disas/libvixl/vixl/utils.o
>   CXX     disas/libvixl/vixl/compiler-intrinsics.o
>   CXX     disas/libvixl/vixl/a64/instructions-a64.o
>   CXX     disas/libvixl/vixl/a64/decoder-a64.o
>   CXX     disas/libvixl/vixl/a64/disasm-a64.o
>   CC      hw/acpi/core.o
>   CC      hw/acpi/piix4.o
>   CC      hw/acpi/pcihp.o
>   CC      hw/acpi/ich9.o
>   CC      hw/acpi/tco.o
>   CC      hw/acpi/cpu_hotplug.o
>   CC      hw/acpi/memory_hotplug.o
>   CC      hw/acpi/cpu.o
>   CC      hw/acpi/nvdimm.o
>   CC      hw/acpi/vmgenid.o
>   CC      hw/acpi/acpi_interface.o
>   CC      hw/acpi/bios-linker-loader.o
>   CC      hw/acpi/aml-build.o
>   CC      hw/acpi/ipmi.o
>   CC      hw/acpi/acpi-stub.o
>   CC      hw/acpi/ipmi-stub.o
>   CC      hw/audio/sb16.o
>   CC      hw/audio/es1370.o
>   CC      hw/audio/ac97.o
>   CC      hw/audio/fmopl.o
>   CC      hw/audio/adlib.o
>   CC      hw/audio/gus.o
>   CC      hw/audio/gusemu_hal.o
>   CC      hw/audio/gusemu_mixer.o
>   CC      hw/audio/cs4231a.o
>   CC      hw/audio/intel-hda.o
>   CC      hw/audio/hda-codec.o
>   CC      hw/audio/pcspk.o
>   CC      hw/audio/wm8750.o
>   CC      hw/audio/pl041.o
>   CC      hw/audio/lm4549.o
>   CC      hw/audio/marvell_88w8618.o
>   CC      hw/audio/soundhw.o
>   CC      hw/block/block.o
>   CC      hw/block/cdrom.o
>   CC      hw/block/hd-geometry.o
>   CC      hw/block/fdc.o
>   CC      hw/block/m25p80.o
>   CC      hw/block/nand.o
>   CC      hw/block/pflash_cfi01.o
>   CC      hw/block/pflash_cfi02.o
>   CC      hw/block/ecc.o
>   CC      hw/block/onenand.o
>   CC      hw/block/nvme.o
>   CC      hw/bt/core.o
>   CC      hw/bt/l2cap.o
>   CC      hw/bt/sdp.o
>   CC      hw/bt/hci.o
>   CC      hw/bt/hid.o
>   CC      hw/bt/hci-csr.o
>   CC      hw/char/ipoctal232.o
>   CC      hw/char/parallel.o
>   CC      hw/char/pl011.o
>   CC      hw/char/serial.o
>   CC      hw/char/serial-isa.o
>   CC      hw/char/serial-pci.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/cadence_uart.o
>   CC      hw/char/cmsdk-apb-uart.o
>   CC      hw/char/debugcon.o
>   CC      hw/char/imx_serial.o
>   CC      hw/core/qdev.o
>   CC      hw/core/qdev-properties.o
>   CC      hw/core/bus.o
>   CC      hw/core/reset.o
>   CC      hw/core/qdev-fw.o
>   CC      hw/core/fw-path-provider.o
>   CC      hw/core/irq.o
>   CC      hw/core/hotplug.o
>   CC      hw/core/nmi.o
>   CC      hw/core/stream.o
>   CC      hw/core/ptimer.o
>   CC      hw/core/sysbus.o
>   CC      hw/core/machine.o
>   CC      hw/core/loader.o
>   CC      hw/core/qdev-properties-system.o
>   CC      hw/core/register.o
>   CC      hw/core/or-irq.o
>   CC      hw/core/split-irq.o
>   CC      hw/core/platform-bus.o
>   CC      hw/cpu/core.o
>   CC      hw/display/ads7846.o
>   CC      hw/display/cirrus_vga.o
>   CC      hw/display/pl110.o
>   CC      hw/display/sii9022.o
>   CC      hw/display/ssd0303.o
>   CC      hw/display/ssd0323.o
>   CC      hw/display/vga-pci.o
>   CC      hw/display/vga-isa.o
>   CC      hw/display/vmware_vga.o
>   CC      hw/display/blizzard.o
>   CC      hw/display/exynos4210_fimd.o
>   CC      hw/display/framebuffer.o
>   CC      hw/display/tc6393xb.o
>   CC      hw/dma/pl080.o
>   CC      hw/dma/pl330.o
>   CC      hw/dma/i8257.o
>   CC      hw/dma/xilinx_axidma.o
>   CC      hw/dma/xlnx-zynq-devcfg.o
>   CC      hw/gpio/max7310.o
>   CC      hw/gpio/pl061.o
>   CC      hw/gpio/zaurus.o
>   CC      hw/gpio/gpio_key.o
>   CC      hw/i2c/core.o
>   CC      hw/i2c/smbus.o
>   CC      hw/i2c/smbus_eeprom.o
>   CC      hw/i2c/i2c-ddc.o
>   CC      hw/i2c/versatile_i2c.o
>   CC      hw/i2c/smbus_ich9.o
>   CC      hw/i2c/pm_smbus.o
>   CC      hw/i2c/bitbang_i2c.o
>   CC      hw/i2c/exynos4210_i2c.o
>   CC      hw/i2c/imx_i2c.o
>   CC      hw/i2c/aspeed_i2c.o
>   CC      hw/ide/core.o
>   CC      hw/ide/atapi.o
>   CC      hw/ide/qdev.o
>   CC      hw/ide/pci.o
>   CC      hw/ide/isa.o
>   CC      hw/ide/piix.o
>   CC      hw/ide/microdrive.o
>   CC      hw/ide/ahci.o
>   CC      hw/ide/ich.o
>   CC      hw/ide/ahci-allwinner.o
>   CC      hw/input/hid.o
>   CC      hw/input/lm832x.o
>   CC      hw/input/pckbd.o
>   CC      hw/input/pl050.o
>   CC      hw/input/ps2.o
>   CC      hw/input/stellaris_input.o
>   CC      hw/input/tsc2005.o
>   CC      hw/input/virtio-input.o
>   CC      hw/input/virtio-input-hid.o
>   CC      hw/intc/i8259_common.o
>   CC      hw/intc/i8259.o
>   CC      hw/intc/pl190.o
>   CC      hw/intc/xlnx-pmu-iomod-intc.o
>   CC      hw/intc/xlnx-zynqmp-ipi.o
>   CC      hw/intc/imx_avic.o
>   CC      hw/intc/imx_gpcv2.o
>   CC      hw/intc/realview_gic.o
>   CC      hw/intc/ioapic_common.o
>   CC      hw/intc/arm_gic_common.o
>   CC      hw/intc/arm_gic.o
>   CC      hw/intc/arm_gicv2m.o
>   CC      hw/intc/arm_gicv3_common.o
>   CC      hw/intc/arm_gicv3.o
>   CC      hw/intc/arm_gicv3_dist.o
>   CC      hw/intc/arm_gicv3_redist.o
>   CC      hw/intc/arm_gicv3_its_common.o
>   CC      hw/intc/intc.o
>   CC      hw/ipack/ipack.o
>   CC      hw/ipack/tpci200.o
>   CC      hw/ipmi/ipmi.o
>   CC      hw/ipmi/ipmi_bmc_sim.o
>   CC      hw/ipmi/ipmi_bmc_extern.o
>   CC      hw/ipmi/isa_ipmi_kcs.o
>   CC      hw/ipmi/isa_ipmi_bt.o
>   CC      hw/isa/isa-bus.o
>   CC      hw/isa/apm.o
>   CC      hw/mem/pc-dimm.o
>   CC      hw/mem/nvdimm.o
>   CC      hw/misc/applesmc.o
>   CC      hw/misc/max111x.o
>   CC      hw/misc/tmp105.o
>   CC      hw/misc/tmp421.o
>   CC      hw/misc/debugexit.o
>   CC      hw/misc/sga.o
>   CC      hw/misc/pc-testdev.o
>   CC      hw/misc/pci-testdev.o
>   CC      hw/misc/edu.o
>   CC      hw/misc/unimp.o
>   CC      hw/misc/vmcoreinfo.o
>   CC      hw/misc/arm_l2x0.o
>   CC      hw/misc/arm_integrator_debug.o
>   CC      hw/misc/a9scu.o
>   CC      hw/misc/arm11scu.o
>   CC      hw/net/ne2000.o
>   CC      hw/net/eepro100.o
>   CC      hw/net/pcnet-pci.o
>   CC      hw/net/pcnet.o
>   CC      hw/net/e1000.o
>   CC      hw/net/e1000x_common.o
>   CC      hw/net/net_tx_pkt.o
>   CC      hw/net/net_rx_pkt.o
>   CC      hw/net/e1000e.o
>   CC      hw/net/e1000e_core.o
>   CC      hw/net/rtl8139.o
>   CC      hw/net/vmxnet3.o
>   CC      hw/net/smc91c111.o
>   CC      hw/net/lan9118.o
>   CC      hw/net/ne2000-isa.o
>   CC      hw/net/xgmac.o
>   CC      hw/net/xilinx_axienet.o
>   CC      hw/net/allwinner_emac.o
>   CC      hw/net/imx_fec.o
>   CC      hw/net/cadence_gem.o
>   CC      hw/net/stellaris_enet.o
>   CC      hw/net/ftgmac100.o
>   CC      hw/net/rocker/rocker.o
>   CC      hw/net/rocker/rocker_fp.o
>   CC      hw/net/rocker/rocker_desc.o
>   CC      hw/net/rocker/rocker_world.o
>   CC      hw/net/rocker/rocker_of_dpa.o
>   CC      hw/net/can/can_sja1000.o
>   CC      hw/net/can/can_kvaser_pci.o
>   CC      hw/net/can/can_pcm3680_pci.o
>   CC      hw/net/can/can_mioe3680_pci.o
>   CC      hw/nvram/eeprom93xx.o
>   CC      hw/nvram/eeprom_at24c.o
>   CC      hw/nvram/fw_cfg.o
>   CC      hw/nvram/chrp_nvram.o
>   CC      hw/pci-bridge/pci_bridge_dev.o
>   CC      hw/pci-bridge/pcie_root_port.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/pcie_pci_bridge.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/ioh3420.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-host/pam.o
>   CC      hw/pci-host/versatile.o
>   CC      hw/pci-host/piix.o
>   CC      hw/pci-host/q35.o
>   CC      hw/pci-host/gpex.o
>   CC      hw/pci/pci.o
>   CC      hw/pci/pci_bridge.o
>   CC      hw/pci/msix.o
>   CC      hw/pci/msi.o
>   CC      hw/pci/shpc.o
>   CC      hw/pci/slotid_cap.o
>   CC      hw/pci/pci_host.o
>   CC      hw/pci/pcie_host.o
>   CC      hw/pci/pcie.o
>   CC      hw/pci/pcie_aer.o
>   CC      hw/pci/pcie_port.o
>   CC      hw/pci/pci-stub.o
>   CC      hw/pcmcia/pcmcia.o
>   CC      hw/scsi/scsi-disk.o
>   CC      hw/scsi/scsi-generic.o
>   CC      hw/scsi/scsi-bus.o
>   CC      hw/scsi/lsi53c895a.o
>   CC      hw/scsi/mptsas.o
>   CC      hw/scsi/mptconfig.o
>   CC      hw/scsi/mptendian.o
>   CC      hw/scsi/megasas.o
>   CC      hw/scsi/vmw_pvscsi.o
>   CC      hw/scsi/esp.o
>   CC      hw/scsi/esp-pci.o
>   CC      hw/sd/pl181.o
>   CC      hw/sd/ssi-sd.o
>   CC      hw/sd/sd.o
>   CC      hw/sd/core.o
>   CC      hw/sd/sdhci.o
>   CC      hw/smbios/smbios.o
>   CC      hw/smbios/smbios_type_38.o
>   CC      hw/smbios/smbios-stub.o
>   CC      hw/smbios/smbios_type_38-stub.o
>   CC      hw/ssi/pl022.o
>   CC      hw/ssi/ssi.o
>   CC      hw/ssi/xilinx_spips.o
>   CC      hw/ssi/aspeed_smc.o
>   CC      hw/ssi/stm32f2xx_spi.o
>   CC      hw/ssi/mss-spi.o
>   CC      hw/timer/arm_timer.o
>   CC      hw/timer/arm_mptimer.o
>   CC      hw/timer/armv7m_systick.o
>   CC      hw/timer/a9gtimer.o
>   CC      hw/timer/cadence_ttc.o
>   CC      hw/timer/ds1338.o
>   CC      hw/timer/hpet.o
>   CC      hw/timer/i8254_common.o
>   CC      hw/timer/i8254.o
>   CC      hw/timer/pl031.o
>   CC      hw/timer/twl92230.o
>   CC      hw/timer/imx_epit.o
>   CC      hw/timer/imx_gpt.o
>   CC      hw/timer/xlnx-zynqmp-rtc.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/timer/cmsdk-apb-timer.o
>   CC      hw/timer/mss-timer.o
>   CC      hw/tpm/tpm_util.o
>   CC      hw/tpm/tpm_tis.o
>   CC      hw/tpm/tpm_crb.o
>   CC      hw/usb/core.o
>   CC      hw/usb/combined-packet.o
>   CC      hw/usb/bus.o
>   CC      hw/usb/libhw.o
>   CC      hw/usb/desc.o
>   CC      hw/usb/desc-msos.o
>   CC      hw/usb/hcd-uhci.o
>   CC      hw/usb/hcd-ohci.o
>   CC      hw/usb/hcd-ehci.o
>   CC      hw/usb/hcd-ehci-pci.o
>   CC      hw/usb/hcd-ehci-sysbus.o
>   CC      hw/usb/hcd-xhci.o
>   CC      hw/usb/hcd-xhci-nec.o
>   CC      hw/usb/hcd-musb.o
>   CC      hw/usb/dev-hub.o
>   CC      hw/usb/dev-hid.o
>   CC      hw/usb/dev-wacom.o
>   CC      hw/usb/dev-storage.o
>   CC      hw/usb/dev-uas.o
>   CC      hw/usb/dev-audio.o
>   CC      hw/usb/dev-serial.o
>   CC      hw/usb/dev-network.o
>   CC      hw/usb/dev-bluetooth.o
>   CC      hw/usb/dev-smartcard-reader.o
>   CC      hw/usb/host-stub.o
>   CC      hw/virtio/virtio-rng.o
>   CC      hw/virtio/virtio-pci.o
>   CC      hw/virtio/virtio-bus.o
>   CC      hw/virtio/virtio-mmio.o
>   CC      hw/virtio/vhost-stub.o
>   CC      hw/watchdog/watchdog.o
>   CC      hw/watchdog/wdt_i6300esb.o
>   CC      hw/watchdog/wdt_ib700.o
>   CC      hw/watchdog/wdt_aspeed.o
>   CC      migration/migration.o
>   CC      migration/socket.o
>   CC      migration/fd.o
>   CC      migration/exec.o
>   CC      migration/tls.o
>   CC      migration/channel.o
>   CC      migration/savevm.o
>   CC      migration/colo-comm.o
>   CC      migration/colo.o
>   CC      migration/colo-failover.o
>   CC      migration/vmstate.o
>   CC      migration/vmstate-types.o
>   CC      migration/page_cache.o
>   CC      migration/qemu-file.o
>   CC      migration/global_state.o
>   CC      migration/qemu-file-channel.o
>   CC      migration/xbzrle.o
>   CC      migration/postcopy-ram.o
>   CC      migration/qjson.o
>   CC      migration/block.o
>   CC      net/net.o
>   CC      net/queue.o
>   CC      net/checksum.o
>   CC      net/util.o
>   CC      net/hub.o
>   CC      net/socket.o
>   CC      net/dump.o
>   CC      net/eth.o
>   CC      net/slirp.o
>   CC      net/filter.o
>   CC      net/filter-buffer.o
>   CC      net/filter-mirror.o
>   CC      net/colo-compare.o
>   CC      net/colo.o
>   CC      net/filter-rewriter.o
>   CC      net/filter-replay.o
>   CC      net/tap-win32.o
>   CC      net/can/can_core.o
>   CC      net/can/can_host.o
>   CC      qom/cpu.o
>   CC      replay/replay.o
>   CC      replay/replay-internal.o
>   CC      replay/replay-events.o
>   CC      replay/replay-time.o
>   CC      replay/replay-input.o
>   CC      replay/replay-char.o
>   CC      replay/replay-snapshot.o
>   CC      replay/replay-net.o
>   CC      replay/replay-audio.o
>   CC      slirp/cksum.o
>   CC      slirp/if.o
>   CC      slirp/ip_icmp.o
>   CC      slirp/ip6_icmp.o
>   CC      slirp/ip6_input.o
>   CC      slirp/ip6_output.o
>   CC      slirp/ip_input.o
>   CC      slirp/ip_output.o
>   CC      slirp/dnssearch.o
>   CC      slirp/dhcpv6.o
>   CC      slirp/slirp.o
>   CC      slirp/mbuf.o
>   CC      slirp/misc.o
>   CC      slirp/sbuf.o
>   CC      slirp/socket.o
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_output.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/tcp_timer.o
>   CC      slirp/udp.o
>   CC      slirp/udp6.o
>   CC      slirp/bootp.o
>   CC      slirp/tftp.o
>   CC      slirp/arp_table.o
>   CC      slirp/ndp_table.o
>   CC      slirp/ncsi.o
>   CC      ui/keymaps.o
>   CC      ui/console.o
>   CC      ui/cursor.o
>   CC      ui/qemu-pixman.o
>   CC      ui/input.o
>   CC      ui/input-keymap.o
>   CC      ui/input-legacy.o
>   CC      ui/vnc.o
>   CC      ui/vnc-enc-zlib.o
>   CC      ui/vnc-enc-hextile.o
>   CC      ui/vnc-enc-tight.o
>   CC      ui/vnc-enc-zrle.o
>   CC      ui/vnc-palette.o
>   CC      ui/vnc-auth-vencrypt.o
>   CC      ui/vnc-ws.o
>   CC      ui/vnc-jobs.o
>   CC      ui/sdl.o
>   CC      ui/sdl_zoom.o
>   CC      ui/gtk.o
>   CC      chardev/char.o
>   CC      chardev/char-console.o
>   CC      chardev/char-fe.o
>   CC      chardev/char-file.o
>   CC      chardev/char-io.o
>   CC      chardev/char-mux.o
>   CC      chardev/char-null.o
>   CC      chardev/char-pipe.o
>   CC      chardev/char-ringbuf.o
>   CC      chardev/char-serial.o
>   CC      chardev/char-socket.o
>   CC      chardev/char-stdio.o
>   CC      chardev/char-udp.o
>   CC      chardev/char-win.o
>   CC      chardev/char-win-stdio.o
>   CC      qga/commands.o
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   AS      optionrom/multiboot.o
>   AS      optionrom/linuxboot.o
>   CC      qga/commands-win32.o
>   CC      optionrom/linuxboot_dma.o
>   AS      optionrom/kvmvapic.o
>   BUILD   optionrom/multiboot.img
>   BUILD   optionrom/linuxboot.img
>   BUILD   optionrom/linuxboot_dma.img
>   CC      qga/channel-win32.o
>   BUILD   optionrom/kvmvapic.img
>   BUILD   optionrom/multiboot.raw
>   CC      qga/service-win32.o
>   BUILD   optionrom/linuxboot.raw
>   BUILD   optionrom/linuxboot_dma.raw
>   CC      qga/vss-win32.o
>   BUILD   optionrom/kvmvapic.raw
>   SIGN    optionrom/multiboot.bin
>   SIGN    optionrom/linuxboot.bin
>   SIGN    optionrom/linuxboot_dma.bin
>   SIGN    optionrom/kvmvapic.bin
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   CC      qga/qapi-generated/qga-qapi-commands.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   AR      libqemuutil.a
>   CC      qemu-img.o
>   LINK    qemu-ga.exe
>   LINK    qemu-io.exe
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/config-target.h
>   GEN     aarch64-softmmu/config-target.h
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   CC      x86_64-softmmu/exec.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      x86_64-softmmu/tcg/tcg-op-vec.o
>   CC      x86_64-softmmu/tcg/tcg-op-gvec.o
>   CC      x86_64-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/exec.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/optimize.o
>   LINK    qemu-img.exe
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/tcg/tcg-op-vec.o
>   CC      x86_64-softmmu/disas.o
>   GEN     x86_64-softmmu/gdbstub-xml.c
>   CC      x86_64-softmmu/arch_init.o
>   CC      x86_64-softmmu/cpus.o
>   CC      x86_64-softmmu/monitor.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      aarch64-softmmu/tcg/tcg-op-gvec.o
>   CC      x86_64-softmmu/balloon.o
>   CC      x86_64-softmmu/ioport.o
>   CC      x86_64-softmmu/numa.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      x86_64-softmmu/qtest.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      x86_64-softmmu/memory.o
>   CC      x86_64-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/dump.o
>   CC      x86_64-softmmu/migration/ram.o
>   CC      x86_64-softmmu/accel/accel.o
>   CC      x86_64-softmmu/accel/stubs/hvf-stub.o
>   CC      x86_64-softmmu/accel/stubs/whpx-stub.o
>   CC      aarch64-softmmu/disas.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      x86_64-softmmu/accel/stubs/kvm-stub.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/arch_init.o
>   CC      aarch64-softmmu/cpus.o
>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>   CC      aarch64-softmmu/monitor.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>   CC      x86_64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>   CC      x86_64-softmmu/accel/tcg/translator.o
>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>   CC      x86_64-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/hw/core/null-machine.o
>   CC      x86_64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>   CC      x86_64-softmmu/hw/intc/apic.o
>   CC      x86_64-softmmu/hw/intc/apic_common.o
>   CC      x86_64-softmmu/hw/intc/ioapic.o
>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>   CC      aarch64-softmmu/ioport.o
>   CC      aarch64-softmmu/balloon.o
>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>   CC      aarch64-softmmu/numa.o
>   CC      aarch64-softmmu/qtest.o
>   CC      aarch64-softmmu/memory.o
>   CC      x86_64-softmmu/hw/net/virtio-net.o
>   CC      x86_64-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/dump.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      aarch64-softmmu/accel/accel.o
>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/accel/stubs/hax-stub.o
>   CC      x86_64-softmmu/hw/virtio/virtio.o
>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      x86_64-softmmu/hw/i386/multiboot.o
>   CC      aarch64-softmmu/accel/stubs/whpx-stub.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      aarch64-softmmu/accel/stubs/hvf-stub.o
>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>   CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>   CC      aarch64-softmmu/accel/tcg/tcg-all.o
>   CC      aarch64-softmmu/accel/tcg/cputlb.o
>   CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>   CC      aarch64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>   CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>   CC      aarch64-softmmu/accel/tcg/translate-all.o
>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>   CC      aarch64-softmmu/accel/tcg/translator.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      x86_64-softmmu/hw/i386/vmport.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      x86_64-softmmu/hw/i386/vmmouse.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      x86_64-softmmu/target/i386/helper.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/target/i386/cpu.o
> In file included from /tmp/qemu-test/src/target/i386/helper.c:24:0:
> /tmp/qemu-test/src/target/i386/sev_i386.h:17:10: fatal error: linux/kvm=
=2Eh: No such file or directory
>  #include <linux/kvm.h>
>           ^~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [/tmp/qemu-test/src/rules.mak:66: target/i386/helper.o] Er=
ror 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
> In file included from /tmp/qemu-test/src/target/i386/cpu.c:29:0:
> /tmp/qemu-test/src/target/i386/sev_i386.h:17:10: fatal error: linux/kvm=
=2Eh: No such file or directory
>  #include <linux/kvm.h>
>           ^~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [/tmp/qemu-test/src/rules.mak:66: target/i386/cpu.o] Error=
 1
> make: *** [Makefile:472: subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      aarch64-softmmu/hw/misc/imx7_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx2_wdt.o
>   CC      aarch64-softmmu/hw/misc/imx7_snvs.o
>   CC      aarch64-softmmu/hw/misc/imx7_gpr.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      aarch64-softmmu/hw/misc/mps2-fpgaio.o
>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>   CC      aarch64-softmmu/hw/misc/tz-ppc.o
>   CC      aarch64-softmmu/hw/misc/iotkit-secctl.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      aarch64-softmmu/hw/usb/chipidea.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/arm/boot.o
>   CC      aarch64-softmmu/hw/arm/collie.o
>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      aarch64-softmmu/hw/arm/highbank.o
>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>   CC      aarch64-softmmu/hw/arm/mainstone.o
>   CC      aarch64-softmmu/hw/arm/musicpal.o
>   CC      aarch64-softmmu/hw/arm/nseries.o
>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>   CC      aarch64-softmmu/hw/arm/palm.o
>   CC      aarch64-softmmu/hw/arm/realview.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
>   CC      aarch64-softmmu/hw/arm/stellaris.o
>   CC      aarch64-softmmu/hw/arm/tosa.o
>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>   CC      aarch64-softmmu/hw/arm/vexpress.o
>   CC      aarch64-softmmu/hw/arm/virt.o
>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>   CC      aarch64-softmmu/hw/arm/z2.o
>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>   CC      aarch64-softmmu/hw/arm/netduino2.o
>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>   CC      aarch64-softmmu/hw/arm/armv7m.o
>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      aarch64-softmmu/hw/arm/digic.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>   CC      aarch64-softmmu/hw/arm/raspi.o
>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>   CC      aarch64-softmmu/hw/arm/kzm.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>   CC      aarch64-softmmu/hw/arm/aspeed.o
>   CC      aarch64-softmmu/hw/arm/mps2.o
>   CC      aarch64-softmmu/hw/arm/mps2-tz.o
>   CC      aarch64-softmmu/hw/arm/msf2-soc.o
>   CC      aarch64-softmmu/hw/arm/msf2-som.o
>   CC      aarch64-softmmu/hw/arm/iotkit.o
>   CC      aarch64-softmmu/target/arm/arm-semi.o
>   CC      aarch64-softmmu/target/arm/machine.o
>   CC      aarch64-softmmu/target/arm/psci.o
>   CC      aarch64-softmmu/target/arm/arch_dump.o
>   CC      aarch64-softmmu/target/arm/monitor.o
>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>   CC      aarch64-softmmu/target/arm/translate.o
>   CC      aarch64-softmmu/target/arm/op_helper.o
>   CC      aarch64-softmmu/target/arm/helper.o
>   CC      aarch64-softmmu/target/arm/cpu.o
>   CC      aarch64-softmmu/target/arm/neon_helper.o
>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>   CC      aarch64-softmmu/target/arm/vec_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub.o
>   CC      aarch64-softmmu/target/arm/cpu64.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   LINK    aarch64-softmmu/qemu-system-aarch64w.exe
>   GEN     aarch64-softmmu/qemu-system-aarch64.exe
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 407, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 404, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 261, in run
>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>   File "./tests/docker/docker.py", line 229, in run
>     quiet=3Dquiet)
>   File "./tests/docker/docker.py", line 147, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'c=
om.qemu.instance.uuid=3D9bef6af0222b11e8bca752540069c830', '-u', '0', '--=
security-opt', 'seccomp=3Dunconfined', '--rm', '--net=3Dnone', '-e', 'TAR=
GET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D8=
', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/c=
cache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', =
'/var/tmp/patchew-tester-tmp-99e1alq5/src/docker-src.2018-03-07-12.18.40.=
16945:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-ming=
w']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-99e1alq5/src'
> make: *** [tests/docker/Makefile.include:163: docker-run-test-mingw@fed=
ora] Error 2
>
> real	5m52.411s
> user	0m4.700s
> sys	0m4.017s
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
