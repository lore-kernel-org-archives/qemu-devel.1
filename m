Received: from eggs.gnu.org ([2001:4830:134:3::10]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctbLt-0004CJ-RW
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctbLq-0003L6-Ot
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:47:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ctbLq-0003Ke-GA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:47:02 -0400
Date: Thu, 30 Mar 2017 16:46:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170330164657.50c75e8c@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-2.9 crashes in tcg_handle_interrupt() during
 winx64 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, KONRAD Frederic <fred.konrad@greensocs.com>, "Emilio G. Cota" <cota@braap.org>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

(PS: resend due to wrong qemu-devel mail list address in original email)


Regression bisects to:

commit 8d04fb55dec381bc5105cb47f29d918e579e8cbd
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Thu Feb 23 18:29:11 2017 +0000
    tcg: drop global lock during TCG code execution

with following stack trace:
#2  0x00007fffee48f0c5 in g_assertion_message (domain=domain@entry=0x0, file=file@entry=0x555555c8aa80 "qemu/translate-common.c", line=line@entry=0x22, func=func@entry=0x555555c8aae0 <__FUNCTION__.22084> "tcg_handle_interrupt", message=message@entry=0x7fff781371d0 "assertion failed: (qemu_mutex_iothread_locked())")
    at gtestutils.c:2432
#3  0x00007fffee48f15a in g_assertion_message_expr (domain=0x0, file=0x555555c8aa80 "qemu/translate-common.c", line=0x22, func=0x555555c8aae0 <__FUNCTION__.22084> "tcg_handle_interrupt", expr=<optimized out>)
    at gtestutils.c:2455
#4  0x000055555577808b in tcg_handle_interrupt (cpu=0x55555683a400, mask=0x2)
    at qemu/translate-common.c:34
#5  0x00005555557fe900 in cpu_interrupt (cpu=0x55555683a400, mask=0x2)
    at qemu/include/qom/cpu.h:795
#6  0x00005555557ffb6a in apic_update_irq (s=0x5555568587a0) at qemu/hw/intc/apic.c:372
#7  0x00005555557ff9d4 in apic_set_tpr (s=0x5555568587a0, val=0x0) at qemu/hw/intc/apic.c:304
#8  0x000055555580168d in cpu_set_apic_tpr (dev=0x5555568587a0, val=0x0)
    at qemu/hw/intc/apic_common.c:77
#9  0x00005555558c5edb in helper_write_crN (env=0x555556842690, reg=0x8, t0=0x0)
    at qemu/target/i386/misc_helper.c:159
#10 0x00007fffd66e1020 in code_gen_buffer ()
#11 0x0000555555776f9f in cpu_tb_exec (cpu=0x55555683a400, itb=0x7fffd0fcbf50)
    at qemu/cpu-exec.c:165
#12 0x0000555555777ca4 in cpu_loop_exec_tb (cpu=0x55555683a400, tb=0x7fffd0fcbf50, last_tb=0x7fffd002a968, tb_exit=0x7fffd002a964, sc=0x7fffd002a980) at qemu/cpu-exec.c:566
#13 0x0000555555777fbe in cpu_exec (cpu=0x55555683a400) at qemu/cpu-exec.c:674
#14 0x00005555557a9af0 in tcg_cpu_exec (cpu=0x55555683a400) at qemu/cpus.c:1247
#15 0x00005555557a9d62 in qemu_tcg_cpu_thread_fn (arg=0x55555683a400) at qemu/cpus.c:1340
#16 0x00007fffeffb5dc5 in start_thread (arg=0x7fffd002b700) at pthread_create.c:308
#17 0x00007fffed10a34d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:113

to reproduce build qemu with following options:

./configure --enable-debug --target-list=x86_64-softmmu

and run qemu in tcg mode with install image from msdn as following:

  qemu-system-x86_64 -m 1G  \
    -cdrom en_windows_10_enterprise_n_version_1607_updated_jan_2017_x64_dvd_9718069.iso

It seems to be affecting Windows x64 variants only.
Assert also happens with WinEnt 8.1/WinServer 2003 Ent x64
