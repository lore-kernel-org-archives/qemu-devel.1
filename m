Received: from eggs.gnu.org ([2001:4830:134:3::10]:55069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzkmb-0008Kr-3e
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzkmX-0005XQ-T9
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:40600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fzkmX-0005XB-N1
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:40:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fzkmW-0003u0-In
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 15:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 881AE2E806B
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 15:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Sep 2018 15:34:27 -0000
From: Sandra Loosemore <1791796@bugs.launchpad.net>
Reply-To: Bug 1791796 <1791796@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153660698641.24944.17107147595708483311.malonedeb@gac.canonical.com>
Message-Id: <153668006744.31966.11333457437734513810.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1791796] Re: unimplemented thread syscalls in
 nios2 user-mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If you need a Nios II GNU/Linux toolchain, I think the most recent
CodeBench Lite release will work:

https://sourcery.mentor.com/GNUToolchain/subscription42545

We're planning on adding user-mode QEMU to the upcoming 2018.11
release....  that's actually what I've been testing it for.  Results on
the GCC testsuite actually don't look too bad, but I have a patch I
haven't submitted yet that's required to make the GDB stub work, and
there are a lot of GDB test failures I haven't triaged yet.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1791796

Title:
  unimplemented thread syscalls in nios2 user-mode emulation

Status in QEMU:
  New

Bug description:
  This bug is reported against the 3.0 release.

  I noticed that the GCC test gcc.dg/torture/tls/tls-test.c is failing
  when run in user-mode qemu for nios2 target.  The problem appears to
  be that the thread-related syscalls are unimplemented in qemu.  Here
  is output from running with -strace:

  22484 brk(NULL) =3D 0x00005000
  22484 uname(0x7fffef5a) =3D 0
  22484 faccessat(AT_FDCWD,"/etc/ld.so.preload",R_OK,0x5) =3D -1 errno=3D2 =
(No such file or directory)
  22484 openat(AT_FDCWD,"/scratch/sandra/nios2-linux-trunk3/obj/test-2018.1=
1-999999-nios2-linux-gnu/host-x86_64-linux-gnu/sourceryg++-2018.11/nios2-li=
nux-gnu/libc/./lib/./tls/libm.so.6",O_RDONLY|O_LARGEFILE|O_CLOEXEC) =3D -1 =
errno=3D2 (No such file or directory)
  22484 fstatat64(AT_FDCWD,"/scratch/sandra/nios2-linux-trunk3/obj/test-201=
8.11-999999-nios2-linux-gnu/host-x86_64-linux-gnu/sourceryg++-2018.11/nios2=
-linux-gnu/libc/./lib/./tls",0x7fffe870,0) =3D -1 errno=3D2 (No such file o=
r directory)
  22484 openat(AT_FDCWD,"/scratch/sandra/nios2-linux-trunk3/obj/test-2018.1=
1-999999-nios2-linux-gnu/host-x86_64-linux-gnu/sourceryg++-2018.11/nios2-li=
nux-gnu/libc/./lib/./libm.so.6",O_RDONLY|O_LARGEFILE|O_CLOEXEC) =3D 3
  22484 read(3,0x7fffe954,512) =3D 512
  22484 fstat64(3,0x7fffe870) =3D 0
  22484 mmap2(NULL,803596,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0=
) =3D 0x7f716000
  22484 mmap2(0x7f7d8000,12288,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRI=
TE|MAP_FIXED,3,0xc1) =3D 0x7f7d8000
  22484 close(3) =3D 0
  22484 openat(AT_FDCWD,"/scratch/sandra/nios2-linux-trunk3/obj/test-2018.1=
1-999999-nios2-linux-gnu/host-x86_64-linux-gnu/sourceryg++-2018.11/nios2-li=
nux-gnu/libc/./lib/./libpthread.so.0",O_RDONLY|O_LARGEFILE|O_CLOEXEC) =3D 3
  22484 read(3,0x7fffe948,512) =3D 512
  22484 mmap2(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0=
) =3D 0x7f714000
  22484 fstat64(3,0x7fffe864) =3D 0
  22484 mmap2(NULL,120700,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0=
) =3D 0x7f6f6000
  22484 mprotect(0x7f70e000,4096,PROT_NONE) =3D 0
  22484 mmap2(0x7f70f000,12288,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRI=
TE|MAP_FIXED,3,0x18) =3D 0x7f70f000
  22484 mmap2(0x7f712000,6012,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOU=
S|MAP_FIXED,-1,0) =3D 0x7f712000
  22484 close(3) =3D 0
  22484 openat(AT_FDCWD,"/scratch/sandra/nios2-linux-trunk3/obj/test-2018.1=
1-999999-nios2-linux-gnu/host-x86_64-linux-gnu/sourceryg++-2018.11/nios2-li=
nux-gnu/libc/./lib/./libc.so.6",O_RDONLY|O_LARGEFILE|O_CLOEXEC) =3D 3
  22484 read(3,0x7fffe93c,512) =3D 512
  22484 fstat64(3,0x7fffe858) =3D 0
  22484 mmap2(NULL,1491048,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,=
0) =3D 0x7f589000
  22484 mmap2(0x7f6de000,86016,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRI=
TE|MAP_FIXED,3,0x154) =3D 0x7f6de000
  22484 mmap2(0x7f6f3000,8296,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOU=
S|MAP_FIXED,-1,0) =3D 0x7f6f3000
  22484 close(3) =3D 0
  22484 mprotect(0x7f6de000,65536,PROT_READ) =3D 0
  22484 mprotect(0x7f70f000,8192,PROT_READ) =3D 0
  22484 mprotect(0x7f7d8000,4096,PROT_READ) =3D 0
  22484 mprotect(0x00003000,4096,PROT_READ) =3D 0
  22484 mprotect(0x7f7fc000,4096,PROT_READ) =3D 0
  22484 set_tid_address(2138131700,2147480980,2147480988,2147480988,87148,4=
7) =3D 22484
  22484 set_robust_list(2138131708,12,2147480988,0,87148,47) =3D -1 errno=
=3D38 (Function not implemented)
  22484 rt_sigaction(32,0x7ffff36c,NULL) =3D 0
  22484 rt_sigaction(33,0x7ffff36c,NULL) =3D -1 errno=3D22 (Invalid argumen=
t)
  22484 rt_sigprocmask(SIG_UNBLOCK,0x7ffff4a8,NULL) =3D 0
  22484 getrlimit(3,2147480732,3,0,62512,47) =3D 0
  22484 mmap2(NULL,8392704,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0=
) =3D 0x7ed88000
  22484 mprotect(0x7ed89000,8388608,PROT_READ|PROT_WRITE) =3D 0
  22484 brk(NULL) =3D 0x00005000
  22484 brk(0x00026000) =3D 0x00026000
  22484 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLON=
E_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x7f588018,parent_tidptr=3D0x7f5884fc,tls=3D0x7f58f928,child_tidptr=3D0x=
7f5884fc) =3D 22503
  22484 io_setup(4001536,2136506392,2136507644,2136507644,2136537384,4100) =
=3D -1 errno=3D38 (Function not implemented)
  22484 futex(0x7f5884fc,FUTEX_WAIT,22503,NULL,NULL,0)22484 set_robust_list=
(2136507652,12,0,4100,2136508076,4100) =3D -1 errno=3D38 (Function not impl=
emented)
  22484 madvise(2128117760,8372224,4,2136507672,528660,4100) =3D 0
  22484 exit(0)
   =3D 0
  22484 fstat64(1,0x7fffef48) =3D 0
  22484 write(1,0x51e8,42)FAIL: a=3D 10, thr_a =3D 10 Addr =3D 0x7f715120
   =3D 42
  22484 exit_group(1)
  sandra@build2-trusty-cs:/scratch/sandra/nios2-linux-trunk3$ =

  22484 mmap2(NULL,1491048,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,=
0) =3D 0x7f589000
  22484 mmap2(0x7f6de000,86016,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRI=
TE|MAP_FIXED,3,0x154) =3D 0x7f6de000
  22484 mmap2(0x7f6f3000,8296,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOU=
S|MAP_FIXED,-1,0) =3D 0x7f6f3000
  22484 close(3) =3D 0
  22484 mprotect(0x7f6de000,65536,PROT_READ) =3D 0
  22484 mprotect(0x7f70f000,8192,PROT_READ) =3D 0
  22484 mprotect(0x7f7d8000,4096,PROT_READ) =3D 0
  22484 mprotect(0x00003000,4096,PROT_READ) =3D 0
  22484 mprotect(0x7f7fc000,4096,PROT_READ) =3D 0
  22484 set_tid_address(2138131700,2147480980,2147480988,2147480988,87148,4=
7) =3D 22484
  22484 set_robust_list(2138131708,12,2147480988,0,87148,47) =3D -1 errno=
=3D38 (Function not implemented)
  22484 rt_sigaction(32,0x7ffff36c,NULL) =3D 0
  22484 rt_sigaction(33,0x7ffff36c,NULL) =3D -1 errno=3D22 (Invalid argumen=
t)
  22484 rt_sigprocmask(SIG_UNBLOCK,0x7ffff4a8,NULL) =3D 0
  22484 getrlimit(3,2147480732,3,0,62512,47) =3D 0
  22484 mmap2(NULL,8392704,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0=
) =3D 0x7ed88000
  22484 mprotect(0x7ed89000,8388608,PROT_READ|PROT_WRITE) =3D 0
  22484 brk(NULL) =3D 0x00005000
  22484 brk(0x00026000) =3D 0x00026000
  22484 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLON=
E_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x7f588018,parent_tidptr=3D0x7f5884fc,tls=3D0x7f58f928,child_tidptr=3D0x=
7f5884fc) =3D 22503
  22484 io_setup(4001536,2136506392,2136507644,2136507644,2136537384,4100) =
=3D -1 errno=3D38 (Function not implemented)
  22484 futex(0x7f5884fc,FUTEX_WAIT,22503,NULL,NULL,0)22484 set_robust_list=
(2136507652,12,0,4100,2136508076,4100) =3D -1 errno=3D38 (Function not impl=
emented)
  22484 madvise(2128117760,8372224,4,2136507672,528660,4100) =3D 0
  22484 exit(0)
   =3D 0
  22484 fstat64(1,0x7fffef48) =3D 0
  22484 write(1,0x51e8,42)FAIL: a=3D 10, thr_a =3D 10 Addr =3D 0x7f715120
   =3D 42
  22484 exit_group(1)
  sandra@build2-trusty-cs:/scratch/sandra/nios2-linux-trunk3$ =

  22484 mmap2(NULL,1491048,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,=
0) =3D 0x7f589000
  22484 mmap2(0x7f6de000,86016,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRI=
TE|MAP_FIXED,3,0x154) =3D 0x7f6de000
  22484 mmap2(0x7f6f3000,8296,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOU=
S|MAP_FIXED,-1,0) =3D 0x7f6f3000
  22484 close(3) =3D 0
  22484 mprotect(0x7f6de000,65536,PROT_READ) =3D 0
  22484 mprotect(0x7f70f000,8192,PROT_READ) =3D 0
  22484 mprotect(0x7f7d8000,4096,PROT_READ) =3D 0
  22484 mprotect(0x00003000,4096,PROT_READ) =3D 0
  22484 mprotect(0x7f7fc000,4096,PROT_READ) =3D 0
  22484 set_tid_address(2138131700,2147480980,2147480988,2147480988,87148,4=
7) =3D 22484
  22484 set_robust_list(2138131708,12,2147480988,0,87148,47) =3D -1 errno=
=3D38 (Function not implemented)
  22484 rt_sigaction(32,0x7ffff36c,NULL) =3D 0
  22484 rt_sigaction(33,0x7ffff36c,NULL) =3D -1 errno=3D22 (Invalid argumen=
t)
  22484 rt_sigprocmask(SIG_UNBLOCK,0x7ffff4a8,NULL) =3D 0
  22484 getrlimit(3,2147480732,3,0,62512,47) =3D 0
  22484 mmap2(NULL,8392704,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0=
) =3D 0x7ed88000
  22484 mprotect(0x7ed89000,8388608,PROT_READ|PROT_WRITE) =3D 0
  22484 brk(NULL) =3D 0x00005000
  22484 brk(0x00026000) =3D 0x00026000
  22484 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLON=
E_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x7f588018,parent_tidptr=3D0x7f5884fc,tls=3D0x7f58f928,child_tidptr=3D0x=
7f5884fc) =3D 22503
  22484 io_setup(4001536,2136506392,2136507644,2136507644,2136537384,4100) =
=3D -1 errno=3D38 (Function not implemented)
  22484 futex(0x7f5884fc,FUTEX_WAIT,22503,NULL,NULL,0)22484 set_robust_list=
(2136507652,12,0,4100,2136508076,4100) =3D -1 errno=3D38 (Function not impl=
emented)
  22484 madvise(2128117760,8372224,4,2136507672,528660,4100) =3D 0
  22484 exit(0)
   =3D 0
  22484 fstat64(1,0x7fffef48) =3D 0
  22484 write(1,0x51e8,42)FAIL: a=3D 10, thr_a =3D 10 Addr =3D 0x7f715120
   =3D 42
  22484 exit_group(1)

  Note that set_robust_list and clone are reported as unimplemented.

  I've reported the problems with the signal syscalls separately here.
  https://bugs.launchpad.net/qemu/+bug/1791763

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1791796/+subscriptions
