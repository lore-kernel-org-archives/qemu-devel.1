Received: from eggs.gnu.org ([2001:4830:134:3::10]:59741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTD3t-0005nl-Bs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTD3o-0003FC-Sa
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:35:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTD3o-0003F2-KC
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:35:20 -0500
Date: Mon, 16 Jan 2017 17:35:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170116193517.GC3491@thinpad.lan.raisama.net>
References: <20161224040042.12654-1-rth@twiddle.net>
	<20161224040042.12654-50-rth@twiddle.net>
	<20170116191939.GA6657@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170116191939.GA6657@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH 49/65] tcg/i386: Rely on
 undefined/undocumented behaviour of BSF/BSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Mon, Jan 16, 2017 at 05:19:39PM -0200, Eduardo Habkost wrote:
> On Fri, Dec 23, 2016 at 08:00:26PM -0800, Richard Henderson wrote:
> > The ISA manual documents the output is undefined if the input was zero.
> > 
> > However, we document in target-i386 that the behavior of real silicon
> > is to preserve the contents of the output register.  We also mention
> > that there are real applications that depend on this.  That this is
> > baked into silicon is mentioned as a potential cause for some false
> > sharing behaviour wrt lzcnt/tzcnt.
> > 
> > Taking advantage of this allows us to save 2 insns in the normal case,
> > and 4 insns for i686 emulating a 64-bit clz.
> > 
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> 
> I am unable to boot a Fedora image[1] with TCG using latest master,
> and I have bisected the problem to this patch.
> 
> [1] http://download.fedoraproject.org/pub/fedora/linux/releases/25/CloudImages/x86_64/images/Fedora-Cloud-Base-25-1.3.x86_64.qcow2
> 
> $ qemu-system-x86_64 -machine accel=tcg -drive file=~/system/vmachines/Fedora-Cloud-Base-25-1.3.x86_64.qcow2,format=qcow2 -nographic
> [    0.000000] BUG: unable to handle kernel NULL pointer dereference at           (null)
[...]

With TCG debug enabled:

$ qemu-system-x86_64 -machine accel=tcg -drive file=~/system/vmachines/Fedora-Cloud-Base-25-1.3.x86_64.qcow2,format=qcow2 -nographic
qemu-system-x86_64: /home/ehabkost/rh/proj/virt/qemu/tcg/i386/tcg-target.inc.c:1153: tcg_out_ctz: Assertion `dest == arg2' failed.
Aborted (core dumped)

(gdb) bt
#0  0x00007f3332c50765 in raise () at /lib64/libc.so.6
#1  0x00007f3332c5236a in abort () at /lib64/libc.so.6
#2  0x00007f3332c48f97 in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007f3332c49042 in  () at /lib64/libc.so.6
#4  0x000055dbccbd04e8 in tcg_gen_code (const_a2=false, arg2=3, arg1=TCG_REG_EBP, dest=TCG_REG_R12, rexw=<optimized out>, s=0x55dbcd5792c0 <tcg_ctx>) at /home/ehabkost/rh/proj/virt/qemu/tcg/i386/tcg-target.inc.c:1153
#5  0x000055dbccbd04e8 in tcg_gen_code (const_args=0x7f3327ecd6d0, args=0x7f3327ecd710, opc=<optimized out>, s=0x55dbcd5792c0 <tcg_ctx>) at /home/ehabkost/rh/proj/virt/qemu/tcg/i386/tcg-target.inc.c:2081
#6  0x000055dbccbd04e8 in tcg_gen_code (arg_life=<optimized out>, args=<optimized out>, opc=<optimized out>, def=<optimized out>, s=0x55dbcd5792c0 <tcg_ctx>) at /home/ehabkost/rh/proj/virt/qemu/tcg/tcg.c:2335
#7  0x000055dbccbd04e8 in tcg_gen_code (s=s@entry=0x55dbcd5792c0 <tcg_ctx>, tb=tb@entry=0x7f3328ee3748) at /home/ehabkost/rh/proj/virt/qemu/tcg/tcg.c:2654
#8  0x000055dbccbc6836 in tb_gen_code (cpu=cpu@entry=0x55dbcf482dc0, pc=pc@entry=18446744072199146483, cs_base=cs_base@entry=0, flags=flags@entry=4244144, cflags=<optimized out>, cflags@entry=0)
    at /home/ehabkost/rh/proj/virt/qemu/translate-all.c:1339
#9  0x000055dbccbc8b2c in cpu_exec (tb_exit=0, last_tb=<optimized out>, cpu=0x0) at /home/ehabkost/rh/proj/virt/qemu/cpu-exec.c:346
#10 0x000055dbccbc8b2c in cpu_exec (cpu=cpu@entry=0x55dbcf482dc0) at /home/ehabkost/rh/proj/virt/qemu/cpu-exec.c:637
#11 0x000055dbccbed8a1 in qemu_tcg_cpu_thread_fn (cpu=0x55dbcf482dc0) at /home/ehabkost/rh/proj/virt/qemu/cpus.c:1117
#12 0x000055dbccbed8a1 in qemu_tcg_cpu_thread_fn (arg=<optimized out>) at /home/ehabkost/rh/proj/virt/qemu/cpus.c:1197
#13 0x00007f33364ae5ca in start_thread () at /lib64/libpthread.so.0
#14 0x00007f3332d1f0ed in clone () at /lib64/libc.so.6
(gdb) up
#1  0x00007f3332c5236a in abort () from /lib64/libc.so.6
(gdb) 
#2  0x00007f3332c48f97 in __assert_fail_base () from /lib64/libc.so.6
(gdb) 
#3  0x00007f3332c49042 in __assert_fail () from /lib64/libc.so.6
(gdb) 
#4  0x000055dbccbd04e8 in tcg_out_ctz (const_a2=false, arg2=3, arg1=TCG_REG_EBP, dest=TCG_REG_R12, rexw=<optimized out>, s=0x55dbcd5792c0 <tcg_ctx>) at /home/ehabkost/rh/proj/virt/qemu/tcg/i386/tcg-target.inc.c:1153
1153            tcg_debug_assert(dest == arg2);
(gdb) 
#5  tcg_out_op (const_args=0x7f3327ecd6d0, args=0x7f3327ecd710, opc=<optimized out>, s=0x55dbcd5792c0 <tcg_ctx>) at /home/ehabkost/rh/proj/virt/qemu/tcg/i386/tcg-target.inc.c:2081
2081            tcg_out_ctz(s, rexw, args[0], args[1], args[2], const_args[2]);
(gdb) 
#6  tcg_reg_alloc_op (arg_life=<optimized out>, args=<optimized out>, opc=<optimized out>, def=<optimized out>, s=0x55dbcd5792c0 <tcg_ctx>) at /home/ehabkost/rh/proj/virt/qemu/tcg/tcg.c:2335
2335        tcg_out_op(s, opc, new_args, const_args);
(gdb) 
#7  tcg_gen_code (s=s@entry=0x55dbcd5792c0 <tcg_ctx>, tb=tb@entry=0x7f3328ee3748) at /home/ehabkost/rh/proj/virt/qemu/tcg/tcg.c:2654
2654                tcg_reg_alloc_op(s, def, opc, args, arg_life);
(gdb) 
#8  0x000055dbccbc6836 in tb_gen_code (cpu=cpu@entry=0x55dbcf482dc0, pc=pc@entry=18446744072199146483, cs_base=cs_base@entry=0, flags=flags@entry=4244144, cflags=<optimized out>, cflags@entry=0)
    at /home/ehabkost/rh/proj/virt/qemu/translate-all.c:1339
1339        gen_code_size = tcg_gen_code(&tcg_ctx, tb);
(gdb) 
#9  0x000055dbccbc8b2c in tb_find (tb_exit=0, last_tb=<optimized out>, cpu=0x0) at /home/ehabkost/rh/proj/virt/qemu/cpu-exec.c:346
346                     tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
(gdb) 
#10 cpu_exec (cpu=cpu@entry=0x55dbcf482dc0) at /home/ehabkost/rh/proj/virt/qemu/cpu-exec.c:637
637                     tb = tb_find(cpu, last_tb, tb_exit);

-- 
Eduardo
