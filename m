Received: from eggs.gnu.org ([2001:4830:134:3::10]:58435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cgxEC-0006ui-Cu
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cgxE8-0005j9-7I
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:30:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:54880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cgxE7-0005iu-Pi
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:30:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cgxE5-0005oO-Rz
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 17:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B85282E80D3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 17:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Feb 2017 17:15:49 -0000
From: William Barsse <1667401@bugs.launchpad.net>
Reply-To: Bug 1667401 <1667401@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170223171549.3964.19524.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1667401] [NEW] qemu-ppc segfaults(SIGSEGV) on
 pthread_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

qemu-ppc running on x86-64 hardware leads to a segfault when running the
attached program (test.c). It simply creates a pthread, joins it and exits.

It was compiled as follows on a Debian testing system:
> powerpc-linux-gnuspe-gcc-6 -static -Wall -g -o test -pthread test.c

Sample execution (expected output is "Hello - World!"):
> qemu-ppc -cpu e500 ./test
[...output...]
Hello - qemu-ppc: /build/qemu-_M2UL5/qemu-2.8+dfsg/translate-all.c:175: tb_=
lock: Assertion `!have_tb_lock' failed.
qemu-ppc: /build/qemu-_M2UL5/qemu-2.8+dfsg/translate-all.c:175: tb_lock: As=
sertion `!have_tb_lock' failed.
[1]    25747 segmentation fault  qemu-ppc -cpu e500 test
[...end output...]

The same behavior is observed when running on a PPC 604:

> powerpc-linux-gnu-gcc -Wall -g -o test -pthread test.c
> qemu-ppc ./test
[... as above ...]

Version information:
powerpc-linux-gnu-gcc -v =3D> gcc version 6.3.0 20170124 (Debian 6.3.0-5)
qemu-ppc -version =3D> qemu-ppc version 2.8.0(Debian 1:2.8+dfsg-2)

The same experiment was conducted again using qemu from the git repository =
(commit: 796b288f7be875045670f963ce99991b3c8e96ac):
~/tools/qemu/build/ppc-linux-user/qemu-ppc -version =3D> qemu-ppc version 2=
.8.50 (v2.8.0-1417-g796b288f7b-dirty)
[...output...]
Hello - qemu-ppc: [...redacted...]/tools/qemu/translate-all.c:175: tb_lock:=
 Assertion `!have_tb_lock' failed.
qemu-ppc: [...redacted...]/tools/qemu/translate-all.c:175: tb_lock: Asserti=
on `!have_tb_lock' failed.
[1]    25996 segmentation fault  ~/tools/qemu/build/ppc-linux-user/qemu-ppc=
 -cpu e500 test
[...end output...]


Executing with -strace option yields a surprising entry (see second clone()=
 syscall below):
[...]
26007 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_=
SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0xf67fde60,parent_tidptr=3D0xf67fe368,tls=3D0xf68057d0,child_tidptr=3D0x=
f67fe368) =3D 26009
26007 clone(0,child_stack=3D0xf67fde60,parent_tidptr=3D0xf67fe368,tls=3D0xf=
68057d0,child_tidptr=3D0xf67fe368) =3D -1 errno=3D22 (Invalid argument)


test.c works just fine if the pthread_create & pthread_join calls are remov=
ed
(i.e. when compiled with -DNO_PTHREAD_CREATE).

At first glance, the issue seems specific to PPC because compiling and runn=
ing
for x86_64 using qemu-x86_64 works fine.


Additional info:
> lddtree =3Dqemu-ppc
qemu-ppc =3D> /usr/bin/qemu-ppc (interpreter =3D> /lib64/ld-linux-x86-64.so=
.2)
    libgmodule-2.0.so.0 =3D> /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0
        libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
            ld-linux-x86-64.so.2 =3D> /lib64/ld-linux-x86-64.so.2
    libglib-2.0.so.0 =3D> /lib/x86_64-linux-gnu/libglib-2.0.so.0
        libpcre.so.3 =3D> /lib/x86_64-linux-gnu/libpcre.so.3
    librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
    libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6
    libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1
    libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
    libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6

> /lib/x86_64-linux-gnu/libc.so.6
GNU C Library (Debian GLIBC 2.24-9) stable release version 2.24, by Roland =
McGrath et al.

> uname -a
Linux [...redacted...] 4.9.0-1-amd64 #1 SMP Debian 4.9.6-3 (2017-01-28) x86=
_64 GNU/Linux

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "test.c"
   https://bugs.launchpad.net/bugs/1667401/+attachment/4825336/+files/test.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1667401

Title:
  qemu-ppc segfaults(SIGSEGV) on pthread_create

Status in QEMU:
  New

Bug description:
  qemu-ppc running on x86-64 hardware leads to a segfault when running the
  attached program (test.c). It simply creates a pthread, joins it and exit=
s.

  It was compiled as follows on a Debian testing system:
  > powerpc-linux-gnuspe-gcc-6 -static -Wall -g -o test -pthread test.c

  Sample execution (expected output is "Hello - World!"):
  > qemu-ppc -cpu e500 ./test
  [...output...]
  Hello - qemu-ppc: /build/qemu-_M2UL5/qemu-2.8+dfsg/translate-all.c:175: t=
b_lock: Assertion `!have_tb_lock' failed.
  qemu-ppc: /build/qemu-_M2UL5/qemu-2.8+dfsg/translate-all.c:175: tb_lock: =
Assertion `!have_tb_lock' failed.
  [1]    25747 segmentation fault  qemu-ppc -cpu e500 test
  [...end output...]

  The same behavior is observed when running on a PPC 604:

  > powerpc-linux-gnu-gcc -Wall -g -o test -pthread test.c
  > qemu-ppc ./test
  [... as above ...]

  Version information:
  powerpc-linux-gnu-gcc -v =3D> gcc version 6.3.0 20170124 (Debian 6.3.0-5)
  qemu-ppc -version =3D> qemu-ppc version 2.8.0(Debian 1:2.8+dfsg-2)

  The same experiment was conducted again using qemu from the git repositor=
y (commit: 796b288f7be875045670f963ce99991b3c8e96ac):
  ~/tools/qemu/build/ppc-linux-user/qemu-ppc -version =3D> qemu-ppc version=
 2.8.50 (v2.8.0-1417-g796b288f7b-dirty)
  [...output...]
  Hello - qemu-ppc: [...redacted...]/tools/qemu/translate-all.c:175: tb_loc=
k: Assertion `!have_tb_lock' failed.
  qemu-ppc: [...redacted...]/tools/qemu/translate-all.c:175: tb_lock: Asser=
tion `!have_tb_lock' failed.
  [1]    25996 segmentation fault  ~/tools/qemu/build/ppc-linux-user/qemu-p=
pc -cpu e500 test
  [...end output...]

  =

  Executing with -strace option yields a surprising entry (see second clone=
() syscall below):
  [...]
  26007 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLON=
E_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0xf67fde60,parent_tidptr=3D0xf67fe368,tls=3D0xf68057d0,child_tidptr=3D0x=
f67fe368) =3D 26009
  26007 clone(0,child_stack=3D0xf67fde60,parent_tidptr=3D0xf67fe368,tls=3D0=
xf68057d0,child_tidptr=3D0xf67fe368) =3D -1 errno=3D22 (Invalid argument)

  =

  test.c works just fine if the pthread_create & pthread_join calls are rem=
oved
  (i.e. when compiled with -DNO_PTHREAD_CREATE).

  At first glance, the issue seems specific to PPC because compiling and ru=
nning
  for x86_64 using qemu-x86_64 works fine.

  =

  Additional info:
  > lddtree =3Dqemu-ppc
  qemu-ppc =3D> /usr/bin/qemu-ppc (interpreter =3D> /lib64/ld-linux-x86-64.=
so.2)
      libgmodule-2.0.so.0 =3D> /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0
          libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
              ld-linux-x86-64.so.2 =3D> /lib64/ld-linux-x86-64.so.2
      libglib-2.0.so.0 =3D> /lib/x86_64-linux-gnu/libglib-2.0.so.0
          libpcre.so.3 =3D> /lib/x86_64-linux-gnu/libpcre.so.3
      librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
      libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6
      libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1
      libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
      libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6

  > /lib/x86_64-linux-gnu/libc.so.6
  GNU C Library (Debian GLIBC 2.24-9) stable release version 2.24, by Rolan=
d McGrath et al.

  > uname -a
  Linux [...redacted...] 4.9.0-1-amd64 #1 SMP Debian 4.9.6-3 (2017-01-28) x=
86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1667401/+subscriptions
