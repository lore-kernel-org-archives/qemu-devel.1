Received: from eggs.gnu.org ([209.51.188.92]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyw6L-00089S-Hq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyw6J-0002vq-Vn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:06:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:36962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gyw6J-0002uS-Ob
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:06:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gyw6G-0001KB-RS
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 10:06:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 81C6E2E80D6
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 10:06:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Feb 2019 09:56:20 -0000
From: Vic <llyzs.vic@gmail.com>
Reply-To: Bug 1817865 <1817865@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155125923743.16914.13241911895735421382.malonedeb@soybean.canonical.com>
Message-Id: <155126138022.18130.7745057664020979038.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1817865] Re: deadlock in prepare_mmio_access
 reading mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In order to fix the issue I think we need a call like
"qemu_mutex_trylock_iothread()" in order to combine
qemu_mutex_iothread_locked() and qemu_mutex_lock_iothread() into a
single atomic operation. Any comments?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817865

Title:
  deadlock in prepare_mmio_access reading mmio

Status in QEMU:
  New

Bug description:
  QEMU release 3.1.0; Guest running win10.

  The deadlock happens in prepare_mmio_access call when the guest is
  trying to read MMIO address 0xFEBC00C0. This address belongs to
  "Intel(R) PRO/1000 MT Network Connection" as shown in Windows 10
  device manager. A quick analysis has shown that in prepare_mmio_access
  call:

  static bool prepare_mmio_access(MemoryRegion *mr)
  {
      bool unlocked =3D !qemu_mutex_iothread_locked();
      bool release_lock =3D false;

      if (unlocked && mr->global_locking) {
          qemu_mutex_lock_iothread();
  ...

  "qemu_mutex_iothread_locked()" and "qemu_mutex_lock_iothread()" are
  not atomic operation, so the global mutex could become locked by "util
  /main-loop.c" (line =3D 236) after "qemu_mutex_iothread_locked()" is
  called.

  GDB backtrace analysis as following:

  (gdb) thread 9
  [Switching to thread 9 (Thread 0x7fffe6b7c700 (LWP 14405))]
  #0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.=
S:103
  103	../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or dir=
ectory.
  (gdb) bt
  #0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.=
S:103
  #1  0x00007ffff748c714 in __GI___pthread_mutex_lock (mutex=3D0x5555565183=
40 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:80
  #2  0x0000555555d8ae7b in qemu_mutex_lock_impl (mutex=3D0x555556518340 <q=
emu_global_mutex>, =

      file=3D0x555555e7a298 "/home/vic/Projects/tc-qemu/exec.c", line=3D319=
7) at util/qemu-thread-posix.c:66
  #3  0x000055555584cf66 in qemu_mutex_lock_iothread_impl (file=3D0x555555e=
7a298 "/home/vic/Projects/tc-qemu/exec.c", line=3D3197)
      at /home/vic/Projects/tc-qemu/cpus.c:1849
  #4  0x0000555555804ccc in prepare_mmio_access (mr=3D0x5555575b9000) at /h=
ome/vic/Projects/tc-qemu/exec.c:3197
  #5  0x0000555555804f90 in flatview_read_continue (fv=3D0x7fffd86f2390, ad=
dr=3D4273733824, attrs=3D..., buf=3D0x7ffff7fcc028 "=DB=9C/o", len=3D4, =

      addr1=3D192, l=3D4, mr=3D0x5555575b9000) at /home/vic/Projects/tc-qem=
u/exec.c:3292
  #6  0x0000555555805136 in flatview_read (fv=3D0x7fffd86f2390, addr=3D4273=
733824, attrs=3D..., buf=3D0x7ffff7fcc028 "=DB=9C/o", len=3D4)
      at /home/vic/Projects/tc-qemu/exec.c:3332
  #7  0x00005555558051aa in address_space_read_full (as=3D0x555556517bc0 <a=
ddress_space_memory>, addr=3D4273733824, attrs=3D..., =

      buf=3D0x7ffff7fcc028 "=DB=9C/o", len=3D4) at /home/vic/Projects/tc-qe=
mu/exec.c:3345
  #8  0x0000555555805281 in address_space_rw (as=3D0x555556517bc0 <address_=
space_memory>, addr=3D4273733824, attrs=3D..., =

      buf=3D0x7ffff7fcc028 "=DB=9C/o", len=3D4, is_write=3Dfalse) at /home/=
vic/Projects/tc-qemu/exec.c:3375
  #9  0x0000555555886199 in kvm_cpu_exec (cpu=3D0x5555566d1800) at /home/vi=
c/Projects/tc-qemu/accel/kvm/kvm-all.c:2031
  #10 0x000055555584c001 in qemu_kvm_cpu_thread_fn (arg=3D0x5555566d1800) a=
t /home/vic/Projects/tc-qemu/cpus.c:1281
  #11 0x0000555555d8b9f7 in qemu_thread_start (args=3D0x5555566f3c00) at ut=
il/qemu-thread-posix.c:498
  #12 0x00007ffff7489fa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
  #13 0x00007ffff73ba80f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95
  (gdb) f 2
  #2  0x0000555555d8ae7b in qemu_mutex_lock_impl (mutex=3D0x555556518340 <q=
emu_global_mutex>, =

      file=3D0x555555e7a298 "/home/vic/Projects/tc-qemu/exec.c", line=3D319=
7) at util/qemu-thread-posix.c:66
  66	    err =3D pthread_mutex_lock(&mutex->lock);
  (gdb) p mutex
  $1 =3D (QemuMutex *) 0x555556518340 <qemu_global_mutex>
  (gdb) p *mutex
  $2 =3D {lock =3D pthread_mutex_t =3D {Type =3D Normal, Status =3D Acquire=
d, possibly with waiters, Owner ID =3D 14393, Robust =3D No, Shared =3D No, =

      Protocol =3D None}, file =3D 0x555555fc2a64 "util/main-loop.c", line =
=3D 236, initialized =3D true}
  (gdb) thread 1
  [Switching to thread 1 (Thread 0x7ffff495cc00 (LWP 14393))]
  #0  0x00007ffff7493832 in __libc_recvfrom (fd=3D147, buf=3D0x7fffd81ce0cc=
, len=3D1500, flags=3D0, addr=3D..., addrlen=3D0x7fffffffd9a8)
      at ../sysdeps/unix/sysv/linux/recvfrom.c:27
  27	../sysdeps/unix/sysv/linux/recvfrom.c: No such file or directory.
  (gdb) bt
  #0  0x00007ffff7493832 in __libc_recvfrom (fd=3D147, buf=3D0x7fffd81ce0cc=
, len=3D1500, flags=3D0, addr=3D..., addrlen=3D0x7fffffffd9a8)
      at ../sysdeps/unix/sysv/linux/recvfrom.c:27
  #1  0x0000555555c18bf3 in sorecvfrom (so=3D0x7fffd818fe60) at slirp/socke=
t.c:584
  #2  0x0000555555c146f9 in slirp_pollfds_poll (pollfds=3D0x555556655470, s=
elect_error=3D0) at slirp/slirp.c:753
  #3  0x0000555555d8675b in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:498
  #4  0x00005555559d2194 in main_loop () at vl.c:1893
  #5  0x00005555559d9d93 in main (argc=3D16, argv=3D0x7fffffffdff8, envp=3D=
0x7fffffffe080) at vl.c:4692

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817865/+subscriptions
