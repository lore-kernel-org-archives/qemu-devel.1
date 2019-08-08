Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D213C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 15:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C5D208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 15:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C5D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvkU5-0007mX-69
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 11:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvkTd-0007IL-Pq
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvkTb-0003VJ-Ne
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvkTb-0003Um-GD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:37:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D32533067289
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 15:37:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 229591001948
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 15:37:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8AB43113864E; Thu,  8 Aug 2019 17:37:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 08 Aug 2019 17:37:10 +0200
Message-ID: <87r25vd5y1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 08 Aug 2019 15:37:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Does i386-linux-user build on an i686 host?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fails for me, but perhaps I'm doing it wrong:

$ uname -a
Linux gcc45 3.16.0-7-686-pae #1 SMP Debian 3.16.59-1 (2018-10-03) i686 GNU/=
Linux
$ ../configure --target-list=3Di386-linux-user
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
firmware path     /usr/local/share/qemu-firmware
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
libexec directory /usr/local/libexec
include directory /usr/local/include
config directory  /usr/local/etc
local state directory   /usr/local/var
Manual directory  /usr/local/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       /home/armbru/qemu
GIT binary        git
GIT submodules    ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/be=
rkeley-softfloat-3 dtc capstone slirp
C compiler        cc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler clang
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
QEMU_CFLAGS       -I/usr/include/pixman-1  -I$(SRC_PATH)/dtc/libfdt -Werror=
  -pthread -I/usr/include/glib-2.0 -I/usr/lib/i386-linux-gnu/glib-2.0/inclu=
de  -fPIE -DPIE -m32 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99  -=
Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wfor=
mat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-decl=
aration -Wold-style-definition -Wtype-limits -fstack-protector-strong -Wno-=
missing-braces -I/usr/include/p11-kit-1    -I/usr/include/libpng12  -I$(SRC=
_PATH)/capstone/include
LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m32 -g=20
QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt=20
make              make
install           install
python            python3 -B (3.4.2)
slirp support     git=20
smbd              /usr/sbin/smbd
module support    no
host CPU          i386
host big endian   no
target list       i386-linux-user
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
SDL support       no=20
SDL image support no
GTK support       no=20
GTK GL support    no
VTE support       no=20
TLS priority      NORMAL
GNUTLS support    yes
libgcrypt         no
nettle            yes (2.7.1)
libtasn1          yes
PAM               no
iconv support     yes
curses support    no
virgl support     no=20
curl support      yes
mingw32 support   no
Audio drivers     pa oss
Block whitelist (rw)=20
Block whitelist (ro)=20
VirtFS support=20=20=20=20
Multipath support=20
VNC support       yes
VNC SASL support  no
VNC JPEG support  yes
VNC PNG support   yes
xen support       no
brlapi support    no
bluez  support    no
Documentation     no
PIE               yes
vde support       no
netmap support    no
Linux AIO support yes
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
HAX support       no
HVF support       no
WHPX support      no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
malloc trim support yes
RDMA support      no
PVRDMA support    no
fdt support       git
membarrier        no
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
posix_memalign    yes
libcap-ng support no
vhost-net support yes
vhost-crypto support yes
vhost-scsi support yes
vhost-vsock support yes
vhost-user support yes
Trace backends    log
spice support     no=20
rbd support       no
xfsctl support    no
smartcard support no
libusb            yes
usb net redir     no
OpenGL support    no
OpenGL dmabufs    no
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
mutex debugging   no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh support    no
QOM debugging     yes
Live block migration yes
lzo support       no
snappy support    no
bzip2 support     yes
lzfse support     no
NUMA host support yes
libxml2           yes
tcmalloc support  no
jemalloc support  no
avx2 optimization yes
replication support yes
VxHS block device no
bochs support     yes
cloop support     yes
dmg support       yes
qcow v1 support   yes
vdi support       yes
vvfat support     yes
qed support       yes
parallels support yes
sheepdog support  yes
capstone          git
docker            no
libpmem support   no
libudev           yes
default devices   yes

NOTE: cross-compilers enabled:  'cc'
$ make
  CC      i386-linux-user/linux-user/syscall.o
/home/armbru/qemu/linux-user/ioctls.h:306:9: error: =E2=80=98SNDCTL_DSP_MAP=
INBUF=E2=80=99 undeclared here (not in a function)
   IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
         ^
/home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of macr=
o =E2=80=98IOCTL=E2=80=99
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
                       ^
/home/armbru/qemu/linux-user/ioctls.h:307:9: error: =E2=80=98SNDCTL_DSP_MAP=
OUTBUF=E2=80=99 undeclared here (not in a function)
   IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)=
))
         ^
/home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of macr=
o =E2=80=98IOCTL=E2=80=99
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
                       ^
/home/armbru/qemu/linux-user/ioctls.h:362:9: error: =E2=80=98SOUND_MIXER_AC=
CESS=E2=80=99 undeclared here (not in a function)
   IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
         ^
/home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of macr=
o =E2=80=98IOCTL=E2=80=99
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
                       ^
/home/armbru/qemu/rules.mak:69: recipe for target 'linux-user/syscall.o' fa=
iled
make[1]: *** [linux-user/syscall.o] Error 1
Makefile:472: recipe for target 'i386-linux-user/all' failed
make: *** [i386-linux-user/all] Error 2

