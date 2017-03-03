Received: from eggs.gnu.org ([2001:4830:134:3::10]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjtDX-0007gs-EJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjtDU-0003CJ-Dn
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:19 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjtDU-0003C7-8N
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:16 -0500
Received: by mail-pf0-x242.google.com with SMTP id j5so10716343pfb.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:50:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-6-alex.bennee@linaro.org>
	<4054a3ea-c278-11c3-9c0a-5ec952ef8598@twiddle.net>
	<87r32e1xus.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <83f5e36e-75ca-677f-be5e-cb016b16bb18@twiddle.net>
Date: Sat, 4 Mar 2017 06:50:07 +1100
MIME-Version: 1.0
In-Reply-To: <87r32e1xus.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 03/03/2017 09:03 PM, Alex Bennée wrote:
>> We *should* have retaddr == 0 for this case, which indicates that we
>> should not attempt to restore state.  Are you seeing a non-zero value?
>
> Actually looking at xtensa I see:
>
>   Attempt to resolve CPU state @ 0x0 while translating
>
> So maybe I should check just that - but I don't see where we ensure we
> always pass zero.

cpu_ld*_cmmu, in include/exec/cpu_ldst_template.h, has

     return glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(env, ptr, 0);

so there's your zero.

> #0  0x00005555555e3712 in cpu_restore_state (cpu=cpu@entry=0x555556032600, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:338
> #1  0x000055555564cb38 in tlb_fill (cs=cs@entry=0x555556032600, vaddr=vaddr@entry=537034752, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=mmu_idx@entry=1, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/op_helper.c:73
> #2  0x000055555562d604 in helper_ret_ldb_cmmu (env=env@entry=0x55555603a890, addr=537034752, oi=<optimised out>, retaddr=retaddr@entry=0) at /home/alex/lsrc/qemu/qemu.git/softmmu_template.h:127

Confirmed.  This is a simple bug in xtensa -- failure to check retaddr == 0 
before calling cpu_restore_state.

That said, I do wonder if it wouldn't be better to move that check inside 
cpu_restore_state instead.  Put the check there now, but leave the follow-on 
cleanup for the next devel cycle.

It would also save auditing the other usages of cpu_restore_state in the tree.

>> Is this in fact linux-user, not softmmu, as you imply from tlb_fill?
>> Because handle_cpu_signal will in fact pass a genuine non-zero retaddr
>> for the SIGSEGV resulting from a cpu_ld*_code from a non-mapped
>> address.
>
> I think that is another call chain that might trip us up. Peter
> mentioned he'd hit it. This one is definitely softmmu.

This is really easy to reproduce on any guest with a call to a null function 
pointer.


r~
