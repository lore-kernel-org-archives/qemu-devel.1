Received: from eggs.gnu.org ([2001:4830:134:3::10]:57887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cj8yQ-0005f4-TC
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cj8yM-0007Pu-SW
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:27:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cj8yM-0007PP-Jk
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:27:34 -0500
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c65c1da3-a7bb-c800-e0a6-e7a121f13f2d@redhat.com>
Date: Wed, 1 Mar 2017 19:27:31 +0100
MIME-Version: 1.0
In-Reply-To: <877f492ppx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] s390x failure: "tcg_handle_interrupt: assertion
 failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01.03.2017 12:36, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> I got a make check failure on aarch64 host running a sparc64 test:
>>
>>
>> TEST: tests/prom-env-test... (pid=3D13573)
>>   /sparc64/prom-env/sun4u:                                            =
 **
>> ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
>> assertion failed: (qemu_mutex_iothread_locked())
>=20
> So the assertions where added with MTTCG. The design specifies which
> bits should be protected by the BQL and cpu->interrupt_request is one o=
f
> them. This is because cpu->interrupt_request is often a cross-vCPU
> action (one vCPU triggering an interrupt on another) so there is a
> chance of racing if not protected.
>=20
> It's odd this is showing up on a aarch64 host though when it didn't hit
> on my x86_64 host while testing.
>=20
> As most of this stuff is triggered by hardware emulation the BQL should
> be in effect when handling MMIO for device emulation. There where other
> entry points in ARM which could trigger stuff which is why we add
> locking for things like ARM_CP_IO which are co-processor register
> accesses which trigger other things in the system.
>=20
> What will be useful for all these reports is the backtrace. Then it's
> fairly simple to identify the thing triggering the interrupt and
> identify the correct place for the locking.

Here are the backtraces from the s390x moon buggy image:

Thread 3 (Thread 0x7fffdc608700 (LWP 14468)):
#0  0x00007ffff18ef1d7 in raise () at /lib64/libc.so.6
#1  0x00007ffff18f08c8 in abort () at /lib64/libc.so.6
#2  0x00007ffff2f642a5 in g_assertion_message () at /lib64/libglib-2.0.so=
.0
#3  0x00007ffff2f6433a in g_assertion_message_expr () at /lib64/libglib-2=
.0.so.0
#4  0x000055555560bd31 in tcg_handle_interrupt (cpu=3D0x55555612fc40, mas=
k=3D2) at /home/thuth/devel/qemu/translate-common.c:34
#5  0x000055555568fe03 in css_do_ssch (sch=3Dsch@entry=3D0x5555561740d0, =
orb=3Dorb@entry=3D0x7fffdc607400)
    at /home/thuth/devel/qemu/hw/s390x/css.c:945
#6  0x00005555556b99ad in ioinst_handle_ssch (cpu=3D0x55555612fc40, reg1=3D=
<optimized out>, ipb=3D<optimized out>)
    at /home/thuth/devel/qemu/target/s390x/ioinst.c:238
#7  0x00007fffe60957be in code_gen_buffer ()
#8  0x000055555560b49d in cpu_exec (itb=3D<optimized out>, itb=3D<optimiz=
ed out>, cpu=3D0x7fffe52dc790)
    at /home/thuth/devel/qemu/cpu-exec.c:165
#9  0x000055555560b49d in cpu_exec (sc=3D0x7fffdc6079b0, tb_exit=3D<synth=
etic pointer>, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D=
0x7fffe52dc790) at /home/thuth/devel/qemu/cpu-exec.c:584
#10 0x000055555560b49d in cpu_exec (cpu=3Dcpu@entry=3D0x55555612fc40) at =
/home/thuth/devel/qemu/cpu-exec.c:686
#11 0x000055555563677a in tcg_cpu_exec (cpu=3D0x55555612fc40) at /home/th=
uth/devel/qemu/cpus.c:1251
#12 0x0000555555636ab4 in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>) at /home/thuth/devel/qemu/cpus.c:1347
#13 0x00007ffff53b3dc5 in start_thread () at /lib64/libpthread.so.0
#14 0x00007ffff19b173d in clone () at /lib64/libc.so.6

Thread 2 (Thread 0x7fffe82b5700 (LWP 14467)):
#0  0x00007ffff19abbf9 in syscall () at /lib64/libc.so.6
#1  0x0000555555853896 in qemu_event_wait (val=3D<optimized out>, f=3D<op=
timized out>)
    at /home/thuth/devel/qemu/include/qemu/futex.h:26
#2  0x0000555555853896 in qemu_event_wait (ev=3Dev@entry=3D0x555556082284=
 <rcu_call_ready_event>)
    at /home/thuth/devel/qemu/util/qemu-thread-posix.c:399
#3  0x000055555586243e in call_rcu_thread (opaque=3D<optimized out>) at /=
home/thuth/devel/qemu/util/rcu.c:249
#4  0x00007ffff53b3dc5 in start_thread () at /lib64/libpthread.so.0
#5  0x00007ffff19b173d in clone () at /lib64/libc.so.6

Thread 1 (Thread 0x7ffff7f91c00 (LWP 14463)):
#0  0x00007ffff19a6ebf in ppoll () at /lib64/libc.so.6
#1  0x000055555584f819 in qemu_poll_ns (__ss=3D0x0, __timeout=3D0x7ffffff=
fda20, __nfds=3D<optimized out>, __fds=3D<optimized out>)
    at /usr/include/bits/poll2.h:77
#2  0x000055555584f819 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<op=
timized out>, timeout=3Dtimeout@entry=3D9897590)
    at /home/thuth/devel/qemu/util/qemu-timer.c:333
#3  0x00005555558505e8 in main_loop_wait (timeout=3D9897590) at /home/thu=
th/devel/qemu/util/main-loop.c:254
#4  0x00005555558505e8 in main_loop_wait (nonblocking=3D<optimized out>) =
at /home/thuth/devel/qemu/util/main-loop.c:508
#5  0x00005555555f83b9 in main () at /home/thuth/devel/qemu/vl.c:1897
#6  0x00005555555f83b9 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>)
    at /home/thuth/devel/qemu/vl.c:4675

 HTH2,
  Thomas
