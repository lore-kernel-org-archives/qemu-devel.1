Received: from eggs.gnu.org ([209.51.188.92]:60632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIkLR-0006bO-N8
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 21:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIkLO-0007Sk-QU
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 21:35:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:58502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIkLK-0007PY-2E
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 21:35:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIkLG-000596-BF
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 01:35:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 382872E807D
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 01:35:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 01:29:40 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1805256@bugs.launchpad.net>
Reply-To: Bug 1805256 <1805256@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <155598298071.13263.10695875240846950986.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on high core count
 ARM system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I can reproduce this problem with qemu.git/matser. It still exists in qemu.=
git/matser. I found that when an IO return in worker threads and want to ca=
ll aio_notify to wake up main_loop, but it found that ctx->notify_me is cle=
ared to 0 by main_loop in aio_ctx_check by calling atomic_and(&ctx->notify_=
me, ~1) . So worker thread won't write enventfd to notify main_loop.If such=
 a scene happens, the main_loop will hang:
    main loop                        worker thread1                  worker=
 thread2
---------------------------------------------------------------------------=
--------------------
    qemu_poll_ns                    aio_worker
                            qemu_bh_schedule(pool->completion_bh)
    glib_pollfds_poll
    g_main_context_check
    aio_ctx_check
    atomic_and(&ctx->notify_me, ~1)                                aio_work=
er
                                                      qemu_bh_schedule(pool=
->completion_bh)
    /* do something for event */
    qemu_poll_ns
    /* hangs !!!*/

As we known, ctx->notify_me will be visited by worker thread and main
loop. I thank we should add a lock protection for ctx->notify_me to
avoid this happend.what do you thank so?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on high core count ARM system

Status in QEMU:
  Confirmed

Bug description:
  On the HiSilicon D06 system - a 96 core NUMA arm64 box - qemu-img
  frequently hangs (~50% of the time) with this command:

  qemu-img convert -f qcow2 -O qcow2 /tmp/cloudimg /tmp/cloudimg2

  Where "cloudimg" is a standard qcow2 Ubuntu cloud image. This
  qcow2->qcow2 conversion happens to be something uvtool does every time
  it fetches images.

  Once hung, attaching gdb gives the following backtrace:

  (gdb) bt
  #0  0x0000ffffae4f8154 in __GI_ppoll (fds=3D0xaaaae8a67dc0, nfds=3D187650=
274213760, =

      timeout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3D0xffffc123b=
950)
      at ../sysdeps/unix/sysv/linux/ppoll.c:39
  #1  0x0000aaaabbefaf00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, =

      __fds=3D<optimized out>) at /usr/include/aarch64-linux-gnu/bits/poll2=
.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, =

      timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:322
  #3  0x0000aaaabbefbf80 in os_host_main_loop_wait (timeout=3D-1)
      at util/main-loop.c:233
  #4  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:497
  #5  0x0000aaaabbe2aa30 in convert_do_copy (s=3D0xffffc123bb58) at qemu-im=
g.c:1980
  #6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at qemu-=
img.c:2456
  #7  0x0000aaaabbe2333c in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:4975

  Reproduced w/ latest QEMU git (@ 53744e0a182)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805256/+subscriptions
