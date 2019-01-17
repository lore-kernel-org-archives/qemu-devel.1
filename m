Received: from eggs.gnu.org ([209.51.188.92]:53327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gk4Km-0001IN-Rm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gk4Kj-0006pQ-BJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gk4Kb-0006eu-Ks
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:51:27 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
Date: Thu, 17 Jan 2019 17:46:13 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>


On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>
>
> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert=20
> <dgilbert@redhat.com <mailto:dgilbert@redhat.com>> wrote:
>
>     * Peter Maydell (peter.maydell@linaro.org
>     <mailto:peter.maydell@linaro.org>) wrote:
>     > Recently I've noticed that test-filter-mirror has been hanging
>     > intermittently, typically when run on some other TCG architecture=
.
>     > In the instance I've just looked at, this was with s390x guest on
>     > x86-64 host, though I've also seen it on other host archs and
>     > perhaps with other guests.
>
>     Watch out to see if you really do see it for other guests;
>     it carefully avoids using virtio-net to avoid vhost; but on s390x i=
t
>     uses virtio-net-ccw - could that hit the vhost it was trying to avo=
id?
>
>     > Below is a backtrace, though it seems to be pretty unhelpful.
>     > Anybody got any theories ? Does the mirror test rely on dirty
>     > memory bitmaps like the migration test (which also hangs
>     > occasionally with TCG due to some bug I'm sure we've investigated
>     > in the past) ?
>
>     I don't think it relies on the CPU at all.
>
>     Dave
>
>
> =C2=A0I have no idea about this currently, but Jason and I designed the=
=20
> test case.
> Add Jason: Have any comments about this ?


I can't reproduce this locally with s390x-softmmu. It looks to me the=20
test should be independent to any kinds of emulation. It should pass=20
when mainloop work.

Thanks


>
> Thanks
> Zhang Chen
>
>     > Processes:
>     > petmay01 10533=C2=A0 0.0=C2=A0 0.0=C2=A0 15624=C2=A0 1400 pts/16=C2=
=A0 =C2=A0S+ =C2=A014:22=C2=A0 =C2=A00:00
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \_ tests/test-filter-mirror --quiet
>     > --keep-going -m=3Dquick --GTestLogFD=3D6
>     > petmay01 10534=C2=A0 0.0=C2=A0 0.2 979892 36492 pts/16=C2=A0 =C2=A0=
Sl+ 14:22=C2=A0 =C2=A00:00
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \_ s390x-softmmu/qemu-syste=
m-s390x
>     > -qtest unix:/tmp/qtest-10533.sock,nowait -qtest-log /dev/null
>     -chardev
>     > socket,path=3D/tmp/qtest-10533.qmp,nowait,id=3Dchar0 -mon
>     > chardev=3Dchar0,mode=3Dcontrol -machine accel=3Dqtest -display no=
ne
>     -netdev
>     > socket,id=3Dqtest-bn0,fd=3D4 -device
>     > virtio-net-ccw,netdev=3Dqtest-bn0,id=3Dqtest-e0 -chardev
>     > socket,id=3Dmirror0,path=3Dfilter-mirror.Ongzms,server,nowait -ob=
ject
>     > filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queue=3Dtx,outdev=3D=
mirror0
>     >
>     > Backtrace of all threads in the QEMU process:
>     > Thread 4 (Thread 0x7f59b67ff700 (LWP 10539)):
>     > #0=C2=A0 0x00007f59cf908156 in __sigwait (sig=3D0x7f59b67fc510,
>     set=3D<optimised out>)
>     >=C2=A0 =C2=A0 =C2=A0at ../sysdeps/unix/sysv/linux/sigwait.c:64
>     > #1=C2=A0 0x00007f59cf908156 in __sigwait (set=3D<optimised out>,
>     sig=3D0x7f59b67fc510)
>     >=C2=A0 =C2=A0 =C2=A0at ../sysdeps/unix/sysv/linux/sigwait.c:96
>     > #2=C2=A0 0x00005639a87c4c8e in qemu_dummy_cpu_thread_fn
>     (arg=3D0x5639aa544250)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/cpus.=
c:1326
>     > #3=C2=A0 0x00005639a8b8b911 in qemu_thread_start (args=3D0x5639aa=
569010)
>     >=C2=A0 =C2=A0 =C2=A0at
>     /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
>     > #4=C2=A0 0x00007f59cf8fe6ba in start_thread (arg=3D0x7f59b67ff700=
) at
>     > pthread_create.c:333
>     > #5=C2=A0 0x00007f59cf63441d in clone () at
>     > ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>     >
>     > Thread 3 (Thread 0x7f59bf1f0700 (LWP 10538)):
>     > #0=C2=A0 0x00007f59cf62874d in poll () at
>     ../sysdeps/unix/syscall-template.S:84
>     > #1=C2=A0 0x00007f59e64e638c in g_main_context_iterate
>     (priority=3D2147483647,
>     > n_fds=3D3, fds=3D0x7f59b0001300, timeout=3D<optimised out>,
>     > context=3D0x7f59b00008c0)
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gmain.c:4135
>     > #2=C2=A0 0x00007f59e64e638c in g_main_context_iterate
>     > (context=3D0x7f59b00008c0, block=3Dblock@entry=3D1,
>     > dispatch=3Ddispatch@entry=3D1, self=3D<optimised out>)
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gmain.c:3835
>     > #3=C2=A0 0x00007f59e64e6712 in g_main_loop_run (loop=3D0x7f59b000=
12e0)
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gmain.c:4034
>     > #4=C2=A0 0x00005639a88d187a in iothread_run (opaque=3D0x5639aa512=
710)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/iothr=
ead.c:74
>     > #5=C2=A0 0x00005639a8b8b911 in qemu_thread_start (args=3D0x5639aa=
49d6a0)
>     >=C2=A0 =C2=A0 =C2=A0at
>     /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
>     > #6=C2=A0 0x00007f59cf8fe6ba in start_thread (arg=3D0x7f59bf1f0700=
) at
>     > pthread_create.c:333
>     > #7=C2=A0 0x00007f59cf63441d in clone () at
>     > ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>     >
>     > Thread 2 (Thread 0x7f59bf9f1700 (LWP 10537)):
>     > #0=C2=A0 0x00007f59cf62e4d9 in syscall () at
>     > ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
>     > #1=C2=A0 0x00005639a8b8b58f in qemu_futex_wait (f=3D0x5639a930a41=
8
>     > <rcu_call_ready_event>, val=3D4294967295)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/inclu=
de/qemu/futex.h:29
>     > #2=C2=A0 0x00005639a8b8b75e in qemu_event_wait (ev=3D0x5639a930a4=
18
>     > <rcu_call_ready_event>)
>     >=C2=A0 =C2=A0 =C2=A0at
>     /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:442
>     > #3=C2=A0 0x00005639a8ba41d3 in call_rcu_thread (opaque=3D0x0)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/util/=
rcu.c:261
>     > #4=C2=A0 0x00005639a8b8b911 in qemu_thread_start (args=3D0x5639aa=
449ac0)
>     >=C2=A0 =C2=A0 =C2=A0at
>     /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
>     > #5=C2=A0 0x00007f59cf8fe6ba in start_thread (arg=3D0x7f59bf9f1700=
) at
>     > pthread_create.c:333
>     > #6=C2=A0 0x00007f59cf63441d in clone () at
>     > ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>     >
>     > Thread 1 (Thread 0x7f59e9017fc0 (LWP 10534)):
>     > #0=C2=A0 0x00007f59cf628811 in __GI_ppoll (fds=3D0x5639aa5a1b90, =
nfds=3D6,
>     > timeout=3D<optimised out>, sigmask=3D0x0) at
>     > ../sysdeps/unix/sysv/linux/ppoll.c:50
>     > #1=C2=A0 0x00005639a8b8534b in qemu_poll_ns (fds=3D0x5639aa5a1b90=
,
>     nfds=3D6, timeout=3D-1)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/util/=
qemu-timer.c:322
>     > ---Type <return> to continue, or q <return> to quit---
>     > #2=C2=A0 0x00005639a8b86527 in os_host_main_loop_wait (timeout=3D=
-1)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/util/=
main-loop.c:233
>     > #3=C2=A0 0x00005639a8b865fe in main_loop_wait (nonblocking=3D0)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/util/=
main-loop.c:497
>     > #4=C2=A0 0x00005639a88dab83 in main_loop () at
>     > /home/petmay01/linaro/qemu-for-merges/vl.c:1925
>     > #5=C2=A0 0x00005639a88e25b9 in main (argc=3D21, argv=3D0x7ffd344d=
6138,
>     > envp=3D0x7ffd344d61e8)
>     >=C2=A0 =C2=A0 =C2=A0at /home/petmay01/linaro/qemu-for-merges/vl.c:=
4669
>     >
>     > Backtrace in test-filter-mirror:
>     > Thread 1 (Thread 0x7fd24ab03740 (LWP 10533)):
>     > #0=C2=A0 0x00007fd24a0eb81d in __libc_recv (fd=3D8, buf=3D0x7ffce=
f3a8c58,
>     n=3D4, flags=3D0)
>     >=C2=A0 =C2=A0 =C2=A0at ../sysdeps/unix/sysv/linux/x86_64/recv.c:28
>     > #1=C2=A0 0x000055e065d2d26a in test_mirror ()
>     >=C2=A0 =C2=A0 =C2=A0at
>     /home/petmay01/linaro/qemu-for-merges/tests/test-filter-mirror.c:70
>     > #2=C2=A0 0x00007fd24a67087b in test_case_run (tc=3D0x55e0676b6a00=
)
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gtestutils.c:2158
>     > #3=C2=A0 g_test_run_suite_internal (suite=3Dsuite@entry=3D0x55e06=
76b6060,
>     > path=3Dpath@entry=3D0x0)
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gtestutils.c:2241
>     > #4=C2=A0 0x00007fd24a670a43 in g_test_run_suite_internal
>     > (suite=3Dsuite@entry=3D0x55e0676b6040,
>     >=C2=A0 =C2=A0 =C2=A0path=3Dpath@entry=3D0x0) at
>     > /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2253
>     > #5=C2=A0 0x00007fd24a670a43 in g_test_run_suite_internal
>     > (suite=3Dsuite@entry=3D0x55e0676b6020,
>     >=C2=A0 =C2=A0 =C2=A0path=3Dpath@entry=3D0x0) at
>     > /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2253
>     > #6=C2=A0 0x00007fd24a670c4e in g_test_run_suite (suite=3D0x55e067=
6b6020)
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gtestutils.c:2328
>     > #7=C2=A0 0x00007fd24a670c71 in g_test_run ()
>     >=C2=A0 =C2=A0 =C2=A0at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib=
/gtestutils.c:1596
>     > #8=C2=A0 0x000055e065d2d4af in main (argc=3D1, argv=3D0x7ffcef3a9=
128)
>     >=C2=A0 =C2=A0 =C2=A0at
>     /home/petmay01/linaro/qemu-for-merges/tests/test-filter-mirror.c:92
>     >
>     >
>     > thanks
>     > -- PMM
>     --
>     Dr. David Alan Gilbert / dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com> / Manchester, UK
>
