Received: from eggs.gnu.org ([2001:4830:134:3::10]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLpVk-0001Wb-QK
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLpVe-0003td-I2
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:06:10 -0500
Received: from indium.canonical.com ([91.189.90.7]:40194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eLpVe-0003tT-Ce
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:06:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eLpVc-0006IV-8v
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 12:06:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1765C2E80CC
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 12:06:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Dec 2017 11:53:20 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1735384 <1735384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<87fu8qsuwu.fsf@linaro.org>
Message-Id: <1f60c7d8-a7c8-d8ac-21cd-64c5062f3859@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12/04/2017 10:29 AM, Alex Benn=C3=A9e wrote:
> It's hard to imagine a scenario where taking the tb_lock() for resolving
> something that will fail is going to be an improvement. However maybe
> there is a subtle difference with sh4's javavm implementation.

So, OpenJDK doesn't have a SH-specific implementation of the JVM, it just
uses the Zero variant, which is a pure C++ implementation of the JVM.

The same implementation is used on any other architecture like older ARM
(< ARMv7). I just tested it on ARMv4T and it doesn't crash there on
qemu-user.

However, SH4 is special due to its implementation of atomics in user
space called gUSA for which support to qemu-user has been recently
added by Richard Hendersson. Maybe the problem lies there.

> A backtrace QEMU after the segv would be useful here.

I forgot what the proper procedure is for running qemu-user inside
GDB. Could you help me with that?

The strace looks like this in any case:

28856 access("/etc/ld.so.nohwcap",F_OK) =3D -1 errno=3D2 (No such file or d=
irectory)
28856 open("/lib/sh4-linux-gnu/libgcc_s.so.1",O_RDONLY|O_CLOEXEC) =3D 3
28856 read(3,0x7fffacd4,512) =3D 512
28856 fstat64(3,0x7fffabe8) =3D 0
28856 mmap(NULL,189084,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) =
=3D 0x7ee27000
28856 mprotect(0x7ee45000,61440,PROT_NONE) =3D 0
28856 mmap(0x7ee54000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|M=
AP_FIXED,3,0x1d000) =3D 0x7ee54000
28856 close(3) =3D 0
28856 mprotect(0x7ee54000,4096,PROT_READ) =3D 0
28856 mprotect(0x7eee8000,4096,PROT_READ) =3D 0
28856 mprotect(0x7f05c000,20480,PROT_READ) =3D 0
28856 mprotect(0x7f5c8000,53248,PROT_READ) =3D 0
28856 getpid() =3D 28856
28856 munmap(0x7f065000,50134) =3D 0
28856 getpid() =3D 28856
28856 mmap(NULL,1572864,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x20=
000,-1,0) =3D 0x7eca7000
28856 mprotect(0x7eca7000,4096,PROT_NONE) =3D 0
28856 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_=
SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x7ee26048,parent_tidptr=3D0x7ee26528,tls=3D0x7ee26930,child_tidptr=3D0x=
7ee26528) =3D 28860
28856 futex(0x7ee26528,FUTEX_WAIT,28860,NULL,0x7f77c6e8,2138556136)28856 se=
t_robust_list(2128766256,12,-1,2128766652,-1,2128764832) =3D -1 errno=3D38 =
(Function not implemented)
--- SIGSEGV {si_signo=3DSIGSEGV, si_code=3D1, si_addr=3D0x289da000} ---
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
(sid-sh4-sbuild)root@nofan:/local_scratch/sid-sh4-sbuild#

Adrian

-- =

  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735384

Title:
  OpenJDK JVM segfaults on qemu-sh4 (regression)

Status in QEMU:
  New

Bug description:
  Some of the recent changes introduced a regression which makes the
  OpenJDK JVM crash on qemu-sh4:

  (sid-sh4-sbuild)root@nofan:/# java -version
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  (sid-sh4-sbuild)root@nofan:/#

  An older version works fine:

  (sid-sh4-sbuild)root@nofan:/# java -version
  openjdk version "9.0.1"
  OpenJDK Runtime Environment (build 9.0.1+11-Debian-1)
  OpenJDK Zero VM (build 9.0.1+11-Debian-1, interpreted mode)
  (sid-sh4-sbuild)root@nofan:/#

  Haven't had time for bisecting this yet.

  Adrian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735384/+subscriptions
