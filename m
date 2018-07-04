Received: from eggs.gnu.org ([2001:4830:134:3::10]:43119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ludo@gnu.org>) id 1fagz4-0003md-1s
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ludo@gnu.org>) id 1fagz2-0001kf-TA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:34:10 -0400
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:36997)
	by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <ludo@gnu.org>)
	id 1fagz2-0001kZ-PD
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:34:08 -0400
Received: from [2a01:e0a:1d:7270:af76:b9b:ca24:c465] (port=34682 helo=ribbon)
	by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.82) (envelope-from <ludo@gnu.org>) id 1fagz2-0001U5-CA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:34:08 -0400
From: ludo@gnu.org (Ludovic =?utf-8?Q?Court=C3=A8s?=)
Date: Wed, 04 Jul 2018 14:34:07 +0200
Message-ID: <87tvpfch8g.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?32-bit_=E2=80=9Cqemu-system-i386_-enable-k?=
 =?utf-8?q?vm=E2=80=9D__segfaults_on_x86=5F64?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

(I=E2=80=99m reporting the issue here because for some reason the launchpad=
.net
login page redirects me to an =E2=80=9Coops=E2=80=9D page and fails to log =
me in.)

On a Linux 4.17 x86_64 host, =E2=80=9Cqemu-system-i386 -enable-kvm=E2=80=9D=
, where
qemu-system-i386 is a 32-bit binary, crashes (it works fine without
=E2=80=98-enable-kvm=E2=80=99):

--8<---------------cut here---------------start------------->8---
$ uname -rm
4.17.3-gnu x86_64
$ file /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/bin/=
qemu-system-i386=20
/gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/bin/qemu-sy=
stem-i386: ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dyn=
amically linked, interpreter /gnu/store/4aka3nwppxf3z072l6vr8cxvwj3x5h9s-gl=
ibc-2.27/lib/ld-linux.so.2, for GNU/Linux 2.6.32, stripped
$ /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/bin/qemu-=
system-i386 -enable-kvm /dev/null
WARNING: Image format was not specified for '/dev/null' and probing guessed=
 raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
VNC server running on 127.0.0.1:5900
Adres-eraro(nekropsio el=C5=9Dutita)
--8<---------------cut here---------------start------------->8---

I=E2=80=99d need debugging symbols to provide a useful backtrace, but perha=
ps
the strace gives useful hints:

--8<---------------cut here---------------start------------->8---
$ strace -o ,,s /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.=
12.0/bin/qemu-system-i386 -enable-kvm /dev/null
WARNING: Image format was not specified for '/dev/null' and probing guessed=
 raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
VNC server running on 127.0.0.1:5900
Adres-eraro
$ tail ,,s
ioctl(10, KVM_CHECK_EXTENSION, 0x4c)    =3D 1
ioctl(11, KVM_SET_CLOCK, 0xff9f32bc)    =3D 0
ioctl(16, KVM_KVMCLOCK_CTRL, 0)         =3D -1 EINVAL (Invalid argument)
write(15, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x57ee400c, FUTEX_WAKE_PRIVATE, 2147483647) =3D 1
getpid()                                =3D 3064
tgkill(3064, 3068, SIGUSR1)             =3D 0
futex(0x57193bd8, FUTEX_WAKE_PRIVATE, 1) =3D 1
ppoll([{fd=3D4, events=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=3D17, events=3DPOLLIN}], 5, {tv=
_sec=3D0, tv_nsec=3D0}, NULL, 8 <unfinished ...>
+++ killed by SIGSEGV (core dumped) +++
--8<---------------cut here---------------end--------------->8---

Before investigating further, does it ring a bell?  It used to work, and
I think the main difference is the kernel version.

Thanks,
Ludo=E2=80=99.
