Received: from eggs.gnu.org ([209.51.188.92]:49484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gyOiu-0007ff-6z
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gyOis-0004tF-P7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:27:44 -0500
Received: from chuckie.co.uk ([82.165.15.123]:42926
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gyOis-0004CR-C9
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:27:42 -0500
References: <20190215143115.28777-1-alex.bennee@linaro.org>
	<87d0nn6eoi.fsf@zen.linaroharston> <20190219182528.GA19925@flamenco>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <01acc60d-5f00-20ed-4631-6da98ae4da7e@ilande.co.uk>
Date: Mon, 25 Feb 2019 22:27:19 +0000
MIME-Version: 1.0
In-Reply-To: <20190219182528.GA19925@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 19/02/2019 18:25, Emilio G. Cota wrote:

> On Tue, Feb 19, 2019 at 14:22:37 +0000, Alex Bennée wrote:
>> Emilio,
>>
>> Any chance you could run it through your benchmark suite?
> 
> Something isn't quite right. For instance, gcc in SPEC doesn't
> complete; it fails after 2s with some errors about the syntax of
> the source being compiled. Before the patches the error isn't
> there (the test completes in ~7s, as usual), so I suspect
> some guest memory accesses aren't going to the right place.
> 
> I am too busy right now to try to debug this, but if you have
> patches to test, I can run them. The patches I tested are in
> your v3 branch on github, i.e. with 430f28154b5 at the head.

I spent a few hours yesterday and today testing this patchset against my OpenBIOS
test images and found that all of them were able to boot, except for one MacOS image
which started exhibiting flashing blocks on a progress bar during boot. Tracing this
back, I found the problem was still present when just the first patch "accel/tcg:
demacro cputlb" was applied.

First of all there were a couple of typos I found in load_helper() and store_helper()
which can be fixed up with the following diff:


diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 351f579fed..f3cc2dd0d9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1251,7 +1251,7 @@ static tcg_target_ulong load_helper(CPUArchState *env,
target_ulong addr,
         }

         tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
-                       addr & tlb_addr & TLB_RECHECK,
+                       tlb_addr & TLB_RECHECK,
                        code_read ? MMU_INST_FETCH : MMU_DATA_LOAD, size);
         return handle_bswap(tmp, size, big_endian);
     }
@@ -1405,14 +1405,14 @@ tcg_target_ulong
 helper_le_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
-    return (int32_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
+    return (int32_t)helper_le_ldul_mmu(env, addr, oi, retaddr);
 }

 tcg_target_ulong
 helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
-    return (int32_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+    return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
 }
+    return (int32_t)helper_le_ldul_mmu(env, addr, oi, retaddr);
 }

 tcg_target_ulong
 helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
-    return (int32_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+    return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
 }

 /*
@@ -1427,6 +1427,7 @@ static void store_helper(CPUArchState *env, target_ulong addr,
uint64_t val,
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlb_addr_write(entry);
+    const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;

@@ -1438,7 +1439,8 @@ static void store_helper(CPUArchState *env, target_ulong addr,
uint64_t val,

     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
+        if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
+            addr & TARGET_PAGE_MASK)) {
             tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
@@ -1466,7 +1468,6 @@ static void store_helper(CPUArchState *env, target_ulong addr,
uint64_t val,
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                      >= TARGET_PAGE_SIZE)) {
         int i;
-        uintptr_t index2;
         CPUTLBEntry *entry2;
         target_ulong page2, tlb_addr2;
     do_unaligned_access:
@@ -1476,15 +1477,13 @@ static void store_helper(CPUArchState *env, target_ulong
addr, uint64_t val,
          * cannot evict the first.
          */
         page2 = (addr + size) & TARGET_PAGE_MASK;
-        index2 = tlb_index(env, mmu_idx, page2);
-        entry2 = tlb_entry(env, mmu_idx, index2);
+        entry2 = tlb_entry(env, mmu_idx, page2);
         tlb_addr2 = tlb_addr_write(entry2);
         if (!tlb_hit_page(tlb_addr2, page2)
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
+            && !victim_tlb_hit(env, mmu_idx, index, tlb_off,
+                               page2 & TARGET_PAGE_MASK)) {
             tlb_fill(ENV_GET_CPU(env), page2, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
-            index2 = tlb_index(env, mmu_idx, page2);
-            entry2 = tlb_entry(env, mmu_idx, index2);
         }

         /*


Even with this patch applied I was still seeing issues with the progress bar, so I
ended up manually unrolling softmmu_template.h myself until I could see at what point
things were breaking.

The culprit turned out to be the change in type of res in load_helper() from the size
-related type of uint8_t/uint16_t/uint32_t/uint64_t to tcg_target_ulong in the slow
path as seen from my locally unrolled version:


WORKING:

tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
{
    ....

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (4 > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
                    >= TARGET_PAGE_SIZE)) {
        target_ulong addr1, addr2;
        uint32_t res1, res2;
        ^^^^^^^^
        unsigned shift;
    do_unaligned_access:
        addr1 = addr & ~(4 - 1);
        addr2 = addr1 + 4;
        res1 = helper_le_ldul_mmu(env, addr1, oi, retaddr);
        res2 = helper_le_ldul_mmu(env, addr2, oi, retaddr);
        shift = (addr & (4 - 1)) * 8;

        /* Little-endian combine.  */
        res = (res1 >> shift) | (res2 << ((4 * 8) - shift));
        return res;
    }

}

tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
{
    ....

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (4 > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
                    >= TARGET_PAGE_SIZE)) {
        target_ulong addr1, addr2;
        uint32_t res1, res2;
        ^^^^^^^^
        unsigned shift;
    do_unaligned_access:
        addr1 = addr & ~(4 - 1);
        addr2 = addr1 + 4;
        res1 = helper_be_ldul_mmu(env, addr1, oi, retaddr);
        res2 = helper_be_ldul_mmu(env, addr2, oi, retaddr);
        shift = (addr & (4 - 1)) * 8;

        /* Big-endian combine.  */
        res = (res1 << shift) | (res2 >> ((4 * 8) - shift));
        return res;
    }
}


CORRUPTED:

tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
{
    ....

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (4 > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
                    >= TARGET_PAGE_SIZE)) {
        target_ulong addr1, addr2;
        tcg_target_ulong res1, res2;
        ^^^^^^^^^^^^^^^^
        unsigned shift;
    do_unaligned_access:
        addr1 = addr & ~(4 - 1);
        addr2 = addr1 + 4;
        res1 = helper_le_ldul_mmu(env, addr1, oi, retaddr);
        res2 = helper_le_ldul_mmu(env, addr2, oi, retaddr);
        shift = (addr & (4 - 1)) * 8;

        /* Little-endian combine.  */
        res = (res1 >> shift) | (res2 << ((4 * 8) - shift));
        return res;
    }

}

tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
{
    ....

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (4 > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
                    >= TARGET_PAGE_SIZE)) {
        target_ulong addr1, addr2;
        tcg_target_ulong res1, res2;
        ^^^^^^^^^^^^^^^^
        unsigned shift;
    do_unaligned_access:
        addr1 = addr & ~(4 - 1);
        addr2 = addr1 + 4;
        res1 = helper_be_ldul_mmu(env, addr1, oi, retaddr);
        res2 = helper_be_ldul_mmu(env, addr2, oi, retaddr);
        shift = (addr & (4 - 1)) * 8;

        /* Big-endian combine.  */
        res = (res1 << shift) | (res2 >> ((4 * 8) - shift));
        return res;
    }
}


Presumably the issue here is somehow related to the compiler incorrectly
extending/reducing the shift when the larger type is involved? Also during my tests
the visual corruption was only present for 32-bit accesses, but presumably all the
access sizes will need a similar fix.


ATB,

Mark.
