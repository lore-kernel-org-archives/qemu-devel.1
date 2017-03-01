Received: from eggs.gnu.org ([2001:4830:134:3::10]:36663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cj9CI-0004m6-CH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cj9CF-0007tK-5F
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:41:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cj9CE-0007sY-Uy
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:41:55 -0500
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d3a039e7-77cc-f0de-2b9a-1779009bb7bb@redhat.com>
Date: Wed, 1 Mar 2017 19:41:51 +0100
MIME-Version: 1.0
In-Reply-To: <877f492ppx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] xtensa failure: "tcg_handle_interrupt: assertion
 failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

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
[...]
> What will be useful for all these reports is the backtrace. Then it's
> fairly simple to identify the thing triggering the interrupt and
> identify the correct place for the locking.

xtensa-softmmu crashes, too:

#0  0x00007ffff18ef1d7 in raise () at /lib64/libc.so.6
#1  0x00007ffff18f08c8 in abort () at /lib64/libc.so.6
#2  0x00007ffff2f642a5 in g_assertion_message () at /lib64/libglib-2.0.so=
.0
#3  0x00007ffff2f6433a in g_assertion_message_expr () at /lib64/libglib-2=
.0.so.0
#4  0x00005555555e5411 in tcg_handle_interrupt (cpu=3D0x555555fec400, mas=
k=3D2) at /home/thuth/devel/qemu/translate-common.c:34
#5  0x000055555563d2e7 in check_interrupts (mask=3D2, cpu=3D0x555555fec40=
0) at /home/thuth/devel/qemu/include/qom/cpu.h:801
#6  0x000055555563d2e7 in check_interrupts (env=3D0x555555ff4690) at /hom=
e/thuth/devel/qemu/hw/xtensa/pic_cpu.c:44
#7  0x00007fffe5ab66da in code_gen_buffer ()
#8  0x00005555555e4a51 in cpu_exec (itb=3D<optimized out>, itb=3D<optimiz=
ed out>, cpu=3D0x7fffe51bf3c0)
    at /home/thuth/devel/qemu/cpu-exec.c:165
#9  0x00005555555e4a51 in cpu_exec (sc=3D0x7fffe51bc9b0, tb_exit=3D<synth=
etic pointer>, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D=
0x7fffe51bf3c0) at /home/thuth/devel/qemu/cpu-exec.c:584
#10 0x00005555555e4a51 in cpu_exec (cpu=3Dcpu@entry=3D0x555555fec400) at =
/home/thuth/devel/qemu/cpu-exec.c:686
#11 0x000055555560e89a in tcg_cpu_exec (cpu=3D0x555555fec400) at /home/th=
uth/devel/qemu/cpus.c:1251
#12 0x000055555560ebd4 in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>) at /home/thuth/devel/qemu/cpus.c:1347
#13 0x00007ffff53b3dc5 in start_thread () at /lib64/libpthread.so.0
#14 0x00007ffff19b173d in clone () at /lib64/libc.so.6

IIRC I once downloaded that image from http://wiki.qemu-project.org/Testi=
ng/System_Images

 Thomas
