Received: from eggs.gnu.org ([2001:4830:134:3::10]:34157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjk3L-0002jd-N8
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjk3H-0003rQ-0t
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:03:11 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjk3G-0003pt-P6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:03:06 -0500
Received: by mail-wm0-x22a.google.com with SMTP id n11so11286608wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 02:03:06 -0800 (PST)
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-6-alex.bennee@linaro.org>
	<4054a3ea-c278-11c3-9c0a-5ec952ef8598@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <4054a3ea-c278-11c3-9c0a-5ec952ef8598@twiddle.net>
Date: Fri, 03 Mar 2017 10:03:07 +0000
Message-ID: <87r32e1xus.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/11] translate-all: exit
 cpu_restore_state early if translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Richard Henderson <rth@twiddle.net> writes:

> On 03/03/2017 06:53 AM, Alex Bennée wrote:
>> The translation code uses cpu_ld*_code which can trigger a tlb_fill
>> which if it fails will attempt a fault resolution. This never works
>> during translation as the TB being generated hasn't been added yet.
>> However with the new locking regime we end up double locking the
>> tb_lock(). As the tcg_ctx.cpu is only set during translation we use
>> this to short circuit the restore code and return with a fail.
>
> We *should* have retaddr == 0 for this case, which indicates that we
> should not attempt to restore state.  Are you seeing a non-zero value?

Actually looking at xtensa I see:

  Attempt to resolve CPU state @ 0x0 while translating

So maybe I should check just that - but I don't see where we ensure we
always pass zero.

>
> Hmm.. Or rather we should not have called cpu_restore_state in the
> first place. What is the call chain leading to this point?


Thread 3 "qemu-system-xte" hit Breakpoint 2, cpu_restore_state (cpu=cpu@entry=0x555556032600, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:338
338	        qemu_log_mask(LOG_UNIMP, "Attempt to resolve CPU state @ 0x%" PRIxPTR
#0  0x00005555555e3712 in cpu_restore_state (cpu=cpu@entry=0x555556032600, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:338
#1  0x000055555564cb38 in tlb_fill (cs=cs@entry=0x555556032600, vaddr=vaddr@entry=537034752, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=mmu_idx@entry=1, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/op_helper.c:73
#2  0x000055555562d604 in helper_ret_ldb_cmmu (env=env@entry=0x55555603a890, addr=537034752, oi=<optimised out>, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/softmmu_template.h:127
#3  0x00005555556448df in gen_intermediate_code (retaddr=0, ptr=<optimised out>, env=0x55555603a890) at /home/alex/lsrc/qemu/qemu.git/include/exec/cpu_ldst_template.h:102
#4  0x00005555556448df in gen_intermediate_code (ptr=<optimised out>, env=0x55555603a890) at /home/alex/lsrc/qemu/qemu.git/include/exec/cpu_ldst_template.h:114
#5  0x00005555556448df in gen_intermediate_code (dc=0x7fffcca0f4d0, env=0x55555603a890) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/translate.c:1052
#6  0x00005555556448df in gen_intermediate_code (env=0x55555603a890, tb=0x7fffccc7de00) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/translate.c:3214
#7  0x00005555555e383b in tb_gen_code (cpu=cpu@entry=0x555556032600, pc=pc@entry=537034751, cs_base=cs_base@entry=0, flags=flags@entry=229393, cflags=<optimised out>, cflags@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:1288
#8  0x00005555555e5e41 in cpu_exec (tb_exit=0, last_tb=<optimised out>, cpu=0x38011) at /home/alex/lsrc/qemu/qemu.git/cpu-exec.c:370
#9  0x00005555555e5e41 in cpu_exec (cpu=cpu@entry=0x555556032600) at /home/alex/lsrc/qemu/qemu.git/cpu-exec.c:685
#10 0x0000555555611898 in tcg_cpu_exec (cpu=0x555556032600) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1254
#11 0x0000555555611bd4 in qemu_tcg_rr_cpu_thread_fn (arg=<optimised out>) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1350
#12 0x00007fffdf6606ba in start_thread (arg=0x7fffcca12700) at pthread_create.c:333
#13 0x00007fffdf39682d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
Continuing.

Thread 3 "qemu-system-xte" hit Breakpoint 2, cpu_restore_state (cpu=cpu@entry=0x555556032600, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:338
338	        qemu_log_mask(LOG_UNIMP, "Attempt to resolve CPU state @ 0x%" PRIxPTR
#0  0x00005555555e3712 in cpu_restore_state (cpu=cpu@entry=0x555556032600, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:338
#1  0x000055555564cb38 in tlb_fill (cs=cs@entry=0x555556032600, vaddr=vaddr@entry=4308992, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=mmu_idx@entry=1, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/op_helper.c:73
#2  0x000055555562d604 in helper_ret_ldb_cmmu (env=env@entry=0x55555603a890, addr=4308992, oi=<optimised out>, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/softmmu_template.h:127
#3  0x00005555556448df in gen_intermediate_code (retaddr=0, ptr=<optimised out>, env=0x55555603a890) at /home/alex/lsrc/qemu/qemu.git/include/exec/cpu_ldst_template.h:102
#4  0x00005555556448df in gen_intermediate_code (ptr=<optimised out>, env=0x55555603a890) at /home/alex/lsrc/qemu/qemu.git/include/exec/cpu_ldst_template.h:114
#5  0x00005555556448df in gen_intermediate_code (dc=0x7fffcca0f4d0, env=0x55555603a890) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/translate.c:1052
#6  0x00005555556448df in gen_intermediate_code (env=0x55555603a890, tb=0x7fffccd0b1b0) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/translate.c:3214
#7  0x00005555555e383b in tb_gen_code (cpu=cpu@entry=0x555556032600, pc=pc@entry=4308991, cs_base=cs_base@entry=0, flags=flags@entry=229393, cflags=<optimised out>, cflags@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:1288
#8  0x00005555555e5e41 in cpu_exec (tb_exit=0, last_tb=<optimised out>, cpu=0x38011) at /home/alex/lsrc/qemu/qemu.git/cpu-exec.c:370
#9  0x00005555555e5e41 in cpu_exec (cpu=cpu@entry=0x555556032600) at /home/alex/lsrc/qemu/qemu.git/cpu-exec.c:685
#10 0x0000555555611898 in tcg_cpu_exec (cpu=0x555556032600) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1254
#11 0x0000555555611bd4 in qemu_tcg_rr_cpu_thread_fn (arg=<optimised out>) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1350
#12 0x00007fffdf6606ba in start_thread (arg=0x7fffcca12700) at pthread_create.c:333
#13 0x00007fffdf39682d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109


> Is this in fact linux-user, not softmmu, as you imply from tlb_fill?
> Because handle_cpu_signal will in fact pass a genuine non-zero retaddr
> for the SIGSEGV resulting from a cpu_ld*_code from a non-mapped
> address.

I think that is another call chain that might trip us up. Peter
mentioned he'd hit it. This one is definitely softmmu.

> So... for linux-user I think the qemu_log is unnecessary -- that's
> just the way things are.  For softmmu, I don't know what to think
> except that we shouldn't have gotten here.

I kinda agree but all SoftMMU targets have this potential path. Having
saif that I haven't seen it hit ARM, maybe because we take care not to
cross a page boundary?

I agree it would be better to handle fetching code bytes without this
potential for breakage but that would be a much bigger change and need
more testing this close to rc0.

>
>
> r~


--
Alex Bennée
