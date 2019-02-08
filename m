Received: from eggs.gnu.org ([209.51.188.92]:34868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsFYq-00044k-3O
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 18:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsFYo-0002Vh-Vm
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 18:27:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gsFYo-0002FD-Ib
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 18:27:54 -0500
Date: Fri, 8 Feb 2019 18:27:37 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190208232737.GA5156@flamenco>
References: <CAMo8BfJ63PaA=0jJs4B03EK7idg8om7cyjud1hMUCRsBwBHrbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJ63PaA=0jJs4B03EK7idg8om7cyjud1hMUCRsBwBHrbA@mail.gmail.com>
Subject: Re: [Qemu-devel] segfault on the mainline qemu-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On Fri, Feb 08, 2019 at 13:00:44 -0800, Max Filippov wrote:
> after updating to the latest qemu mainline I get segfault with the following
> backtrace when I run qemu-system-xtensa:
> 
> Thread 3 "qemu-system-xte" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffde9d3700 (LWP 13583)]
> 0x0000555555794252 in tlb_addr_write (entry=0x7fffdd0d7010) at
> /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/include/exec/cpu_ldst.h:134
> 134         return atomic_read(&entry->addr_write);
> (gdb) bt
> #0  0x0000555555794252 in tlb_addr_write (entry=0x7fffdd0d7010) at
> /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/include/exec/cpu_ldst.h:134
> #1  0x00005555557987e7 in helper_le_stl_mmu (env=0x5555563cf6b8,
> addr=2680160256, val=4853560, oi=32, retaddr=140736928419195) at
> /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/softmmu_template.h:298
(snip)
> Bisection points to the following commit:
> 54eaf40b8f8b ("tcg/i386: enable dynamic TLB sizing").
> 
> It can be reproduced with the following command line
> (not very deterministic, you may need to log in/out, run
> couple commands. root without password):
> 
> qemu-system-xtensa -cpu dc233c -monitor null -nographic -M lx60
> -serial stdio -kernel Image.elf
> 
> The kernel is available here:
> http://jcmvbkbc.spb.ru/~dumb/tmp/201902081257/Image.elf
> 
> Any idea what it can be?

Thanks for the report and repro.

The problem is that tlb_fill can end up triggering a resize of
the TLB, and therefore after tlb_fill() we might end up with a
stale entry pointer and index.

Can you please test the appended?

Thanks,

		Emilio

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f580e4dd7e..1ef1ebce2e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1045,6 +1045,9 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     if (unlikely(!tlb_hit(entry->addr_code, addr))) {
         if (!VICTIM_TLB_HIT(addr_code, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
+            /* tlb_fill might have resized the TLB; re-do the entry lookup */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         assert(tlb_hit(entry->addr_code, addr));
     }
@@ -1125,6 +1128,9 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            /* tlb_fill might have resized the TLB; re-do the entry lookup */
+            index = tlb_index(env, mmu_idx, addr);
+            tlbe = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index 1fdd262ea4..88ec7b9b02 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -129,6 +129,9 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
+            /* tlb_fill might have resized the TLB; re-do the entry lookup */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = entry->ADDR_READ;
     }
@@ -198,6 +201,9 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
+            /* tlb_fill might have resized the TLB; re-do the entry lookup */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = entry->ADDR_READ;
     }
@@ -294,6 +300,9 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            /* tlb_fill might have resized the TLB; re-do the entry lookup */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
@@ -372,6 +381,9 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            /* tlb_fill might have resized the TLB; re-do the entry lookup */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
