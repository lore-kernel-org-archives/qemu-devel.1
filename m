Received: from eggs.gnu.org ([2001:4830:134:3::10]:55063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMDgV-00063J-5d
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMDgR-0001V5-8o
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:54:55 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMDgQ-0001Ut-Um
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:54:51 -0500
Received: by mail-wm0-x242.google.com with SMTP id t8so1431787wmc.3
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 05:54:50 -0800 (PST)
Date: Tue, 5 Dec 2017 13:54:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171205135447.GA29422@stefanha-x1.localdomain>
References: <alpine.BSF.2.21.1712041954200.69360@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1712041954200.69360@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Debugging io deadlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 08:22:48PM +0100, BALATON Zoltan wrote:
> I'm seeing a possible deadlock that I don't know how to debug. Any hint on
> how to find the cause or what should be checked further to identify the
> reason why this is happening and how to fix it is greatly appreciated.
>=20
> Here are the state of threads:
>=20
> (gdb) info thr
>   Id   Target Id         Frame
> * 4    Thread 0x7fffba76c700 (LWP 3445) "qemu-system-ppc" 0x0000555555cbe=
c04 in worker_thread (opaque=3D0x7fffe40c9000) at util/thread-pool.c:92
>   3    Thread 0x7fffe8829700 (LWP 3443) "qemu-system-ppc" 0x00007ffff78d2=
67f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
>   2    Thread 0x7ffff111b700 (LWP 3442) "qemu-system-ppc" 0x00007ffff42ca=
d29 in syscall () from /lib64/libc.so.6
>   1    Thread 0x7ffff7fc7b00 (LWP 3441) "qemu-system-ppc" 0x00007ffff42c4=
e31 in ppoll () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff78d4830 in sem_timedwait () from /lib64/libpthread.so.0
> #1  0x0000555555cc572e in qemu_sem_timedwait (sem=3D0x7fffe40c9078, ms=3D=
10000) at util/qemu-thread-posix.c:289
> #2  0x0000555555cbec04 in worker_thread (opaque=3D0x7fffe40c9000) at util=
/thread-pool.c:92
> #3  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
> #4  0x00007ffff42d062d in clone () from /lib64/libc.so.6
> (gdb) thr 3
> [Switching to thread 3 (Thread 0x7fffe8829700 (LWP 3443))]
> #0  0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/l=
ibpthread.so.0
> (gdb) bt
> #0  0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/l=
ibpthread.so.0
> #1  0x0000555555cc5458 in qemu_cond_wait (cond=3D0x555556b47b90, mutex=3D=
0x5555565b5220 <qemu_global_mutex>) at util/qemu-thread-posix.c:161
> #2  0x00005555557e6690 in qemu_tcg_wait_io_event (cpu=3D0x7ffff7e20010) a=
t cpus.c:1084
> #3  0x00005555557e6f00 in qemu_tcg_rr_cpu_thread_fn (arg=3D0x7ffff7e20010=
) at cpus.c:1396
> #4  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
> #5  0x00007ffff42d062d in clone () from /lib64/libc.so.6
> (gdb) thr 2
> [Switching to thread 2 (Thread 0x7ffff111b700 (LWP 3442))]
> #0  0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
> #1  0x0000555555cc58a7 in qemu_futex_wait (f=3D0x555556a01134 <rcu_call_r=
eady_event>, val=3D4294967295) at include/qemu/futex.h:29
> #2  0x0000555555cc5a74 in qemu_event_wait (ev=3D0x555556a01134 <rcu_call_=
ready_event>) at util/qemu-thread-posix.c:442
> #3  0x0000555555cdd92c in call_rcu_thread (opaque=3D0x0) at util/rcu.c:249
> #4  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
> #5  0x00007ffff42d062d in clone () from /lib64/libc.so.6
> (gdb) thr 1
> [Switching to thread 1 (Thread 0x7ffff7fc7b00 (LWP 3441))]
> #0  0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
> #1  0x0000555555cbfe86 in qemu_poll_ns (fds=3D0x555557c17620, nfds=3D5, t=
imeout=3D29806320) at util/qemu-timer.c:334
> #2  0x0000555555cc0eab in os_host_main_loop_wait (timeout=3D29806320) at =
util/main-loop.c:255
> #3  0x0000555555cc0f7d in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:515
> #4  0x000055555599e2b3 in main_loop () at vl.c:1995
> #5  0x00005555559a6353 in main (argc=3D21, argv=3D0x7fffffffdef8, envp=3D=
0x7fffffffdfa8) at vl.c:4911
>=20
> Then if I wait a little, thread 4 exits due to sem_timedwait returning -1
> with errno=3DETIMEDOUT leaving other threads waiting for something to hap=
pen
> but this is apparently a deadlock as it will be stuck here (thread 1-3 are
> still as above). Any idea why this could happen and how to debug it furht=
er?

Are you using the latest qemu.git/master?

Commit ef6dada8b44e1e7c4bec5c1115903af9af415b50 ("util/async: use
atomic_mb_set in qemu_bh_cancel") fixes hangs that occur with the thread
pool (Thread 4 in your example).  I'm not sure if this applies to your
hang though...

It looks like Thread 3 isn't running guest code because the cpu wants to
sleep (is it halted?).

Stefan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJqUnAAoJEJykq7OBq3PIjVMH/0ADAhbZuMZhvDXRbGdYK0VP
hCxGMolW/ZyeIo9LRpiGc5A3lhogPk96qVAatWobo6EbbkhjmJTh0Zs40Ofi++KV
ms1zEF1NttWPsKzdv7gr8SZtzm/kUH1JgK7sskrViC4iUb45xfyLGoUmMz+chrHv
gKZvA86vW395o/NPDbMk3wUI98Nq4knc39bp6mMuiwx14FZusOr5FqTu6Gxoj4T6
fPuh/e2DUoT04NhSQtSXHeAZcASskGyxKy2txgLR28HAbOLK0J7AyvWF4n2w4nSA
PNtwmQ8YpcXe7M79g0IzC/PMCw8gGOOfWyH/ngCDEsmdDo4hs+rtpBAHL6jkbrM=
=gS/W
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
