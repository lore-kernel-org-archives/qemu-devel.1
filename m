Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E544DC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D4A206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D4A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0bV-0007cF-Pg
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PU-0000E4-2J
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PR-0003lU-KX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0PR-0003kQ-BQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F546745A1;
 Fri, 11 Oct 2019 19:17:04 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF555D6C8;
 Fri, 11 Oct 2019 19:17:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 06/21] rcu: Use automatic rc_read unlock in core memory/exec
 code
Date: Fri, 11 Oct 2019 20:16:31 +0100
Message-Id: <20191011191646.226814-7-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 11 Oct 2019 19:17:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20191007143642.301445-6-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                  | 116 ++++++++++++++-------------------
 include/exec/ram_addr.h | 138 +++++++++++++++++++---------------------
 memory.c                |  15 ++---
 3 files changed, 118 insertions(+), 151 deletions(-)

diff --git a/exec.c b/exec.c
index bdcfcdff3f..fb0943cfed 100644
--- a/exec.c
+++ b/exec.c
@@ -1037,16 +1037,14 @@ void tb_invalidate_phys_addr(AddressSpace *as, hw=
addr addr, MemTxAttrs attrs)
         return;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     mr =3D address_space_translate(as, addr, &addr, &l, false, attrs);
     if (!(memory_region_is_ram(mr)
           || memory_region_is_romd(mr))) {
-        rcu_read_unlock();
         return;
     }
     ram_addr =3D memory_region_get_ram_addr(mr) + addr;
     tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
-    rcu_read_unlock();
 }
=20
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
@@ -1332,14 +1330,13 @@ static void tlb_reset_dirty_range_all(ram_addr_t =
start, ram_addr_t length)
     end =3D TARGET_PAGE_ALIGN(start + length);
     start &=3D TARGET_PAGE_MASK;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     block =3D qemu_get_ram_block(start);
     assert(block =3D=3D qemu_get_ram_block(end - 1));
     start1 =3D (uintptr_t)ramblock_ptr(block, start - block->offset);
     CPU_FOREACH(cpu) {
         tlb_reset_dirty(cpu, start1, length);
     }
-    rcu_read_unlock();
 }
=20
 /* Note: start and end must be within the same ram block.  */
@@ -1360,30 +1357,29 @@ bool cpu_physical_memory_test_and_clear_dirty(ram=
_addr_t start,
     end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
     page =3D start >> TARGET_PAGE_BITS;
=20
-    rcu_read_lock();
+    WITH_RCU_READ_LOCK_GUARD() {
+        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+        ramblock =3D qemu_get_ram_block(start);
+        /* Range sanity check on the ramblock */
+        assert(start >=3D ramblock->offset &&
+               start + length <=3D ramblock->offset + ramblock->used_len=
gth);
=20
-    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
-    ramblock =3D qemu_get_ram_block(start);
-    /* Range sanity check on the ramblock */
-    assert(start >=3D ramblock->offset &&
-           start + length <=3D ramblock->offset + ramblock->used_length)=
;
+        while (page < end) {
+            unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+            unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+            unsigned long num =3D MIN(end - page,
+                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
=20
-    while (page < end) {
-        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long num =3D MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - =
offset);
+            dirty |=3D bitmap_test_and_clear_atomic(blocks->blocks[idx],
+                                                  offset, num);
+            page +=3D num;
+        }
=20
-        dirty |=3D bitmap_test_and_clear_atomic(blocks->blocks[idx],
-                                              offset, num);
-        page +=3D num;
+        mr_offset =3D (ram_addr_t)(page << TARGET_PAGE_BITS) - ramblock-=
>offset;
+        mr_size =3D (end - page) << TARGET_PAGE_BITS;
+        memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_siz=
e);
     }
=20
-    mr_offset =3D (ram_addr_t)(page << TARGET_PAGE_BITS) - ramblock->off=
set;
-    mr_size =3D (end - page) << TARGET_PAGE_BITS;
-    memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
-
-    rcu_read_unlock();
-
     if (dirty && tcg_enabled()) {
         tlb_reset_dirty_range_all(start, length);
     }
@@ -1411,28 +1407,27 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot=
_and_clear_dirty
     end  =3D last  >> TARGET_PAGE_BITS;
     dest =3D 0;
=20
-    rcu_read_lock();
+    WITH_RCU_READ_LOCK_GUARD() {
+        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
=20
-    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+        while (page < end) {
+            unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+            unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+            unsigned long num =3D MIN(end - page,
+                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
=20
-    while (page < end) {
-        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long num =3D MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - =
offset);
-
-        assert(QEMU_IS_ALIGNED(offset, (1 << BITS_PER_LEVEL)));
-        assert(QEMU_IS_ALIGNED(num,    (1 << BITS_PER_LEVEL)));
-        offset >>=3D BITS_PER_LEVEL;
+            assert(QEMU_IS_ALIGNED(offset, (1 << BITS_PER_LEVEL)));
+            assert(QEMU_IS_ALIGNED(num,    (1 << BITS_PER_LEVEL)));
+            offset >>=3D BITS_PER_LEVEL;
=20
-        bitmap_copy_and_clear_atomic(snap->dirty + dest,
-                                     blocks->blocks[idx] + offset,
-                                     num);
-        page +=3D num;
-        dest +=3D num >> BITS_PER_LEVEL;
+            bitmap_copy_and_clear_atomic(snap->dirty + dest,
+                                         blocks->blocks[idx] + offset,
+                                         num);
+            page +=3D num;
+            dest +=3D num >> BITS_PER_LEVEL;
+        }
     }
=20
-    rcu_read_unlock();
-
     if (tcg_enabled()) {
         tlb_reset_dirty_range_all(start, length);
     }
@@ -1643,7 +1638,7 @@ void ram_block_dump(Monitor *mon)
     RAMBlock *block;
     char *psize;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     monitor_printf(mon, "%24s %8s  %18s %18s %18s\n",
                    "Block Name", "PSize", "Offset", "Used", "Total");
     RAMBLOCK_FOREACH(block) {
@@ -1655,7 +1650,6 @@ void ram_block_dump(Monitor *mon)
                        (uint64_t)block->max_length);
         g_free(psize);
     }
-    rcu_read_unlock();
 }
=20
 #ifdef __linux__
@@ -2009,11 +2003,10 @@ static unsigned long last_ram_page(void)
     RAMBlock *block;
     ram_addr_t last =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     RAMBLOCK_FOREACH(block) {
         last =3D MAX(last, block->offset + block->max_length);
     }
-    rcu_read_unlock();
     return last >> TARGET_PAGE_BITS;
 }
=20
@@ -2100,7 +2093,7 @@ void qemu_ram_set_idstr(RAMBlock *new_block, const =
char *name, DeviceState *dev)
     }
     pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     RAMBLOCK_FOREACH(block) {
         if (block !=3D new_block &&
             !strcmp(block->idstr, new_block->idstr)) {
@@ -2109,7 +2102,6 @@ void qemu_ram_set_idstr(RAMBlock *new_block, const =
char *name, DeviceState *dev)
             abort();
         }
     }
-    rcu_read_unlock();
 }
=20
 /* Called with iothread lock held.  */
@@ -2651,17 +2643,16 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, boo=
l round_offset,
=20
     if (xen_enabled()) {
         ram_addr_t ram_addr;
-        rcu_read_lock();
+        RCU_READ_LOCK_GUARD();
         ram_addr =3D xen_ram_addr_from_mapcache(ptr);
         block =3D qemu_get_ram_block(ram_addr);
         if (block) {
             *offset =3D ram_addr - block->offset;
         }
-        rcu_read_unlock();
         return block;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     block =3D atomic_rcu_read(&ram_list.mru_block);
     if (block && block->host && host - block->host < block->max_length) =
{
         goto found;
@@ -2677,7 +2668,6 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool =
round_offset,
         }
     }
=20
-    rcu_read_unlock();
     return NULL;
=20
 found:
@@ -2685,7 +2675,6 @@ found:
     if (round_offset) {
         *offset &=3D TARGET_PAGE_MASK;
     }
-    rcu_read_unlock();
     return block;
 }
=20
@@ -3281,10 +3270,9 @@ MemTxResult address_space_read_full(AddressSpace *=
as, hwaddr addr,
     FlatView *fv;
=20
     if (len > 0) {
-        rcu_read_lock();
+        RCU_READ_LOCK_GUARD();
         fv =3D address_space_to_flatview(as);
         result =3D flatview_read(fv, addr, attrs, buf, len);
-        rcu_read_unlock();
     }
=20
     return result;
@@ -3298,10 +3286,9 @@ MemTxResult address_space_write(AddressSpace *as, =
hwaddr addr,
     FlatView *fv;
=20
     if (len > 0) {
-        rcu_read_lock();
+        RCU_READ_LOCK_GUARD();
         fv =3D address_space_to_flatview(as);
         result =3D flatview_write(fv, addr, attrs, buf, len);
-        rcu_read_unlock();
     }
=20
     return result;
@@ -3341,7 +3328,7 @@ static inline MemTxResult address_space_write_rom_i=
nternal(AddressSpace *as,
     hwaddr addr1;
     MemoryRegion *mr;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     while (len > 0) {
         l =3D len;
         mr =3D address_space_translate(as, addr, &addr1, &l, true, attrs=
);
@@ -3366,7 +3353,6 @@ static inline MemTxResult address_space_write_rom_i=
nternal(AddressSpace *as,
         buf +=3D l;
         addr +=3D l;
     }
-    rcu_read_unlock();
     return MEMTX_OK;
 }
=20
@@ -3511,10 +3497,9 @@ bool address_space_access_valid(AddressSpace *as, =
hwaddr addr,
     FlatView *fv;
     bool result;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     fv =3D address_space_to_flatview(as);
     result =3D flatview_access_valid(fv, addr, len, is_write, attrs);
-    rcu_read_unlock();
     return result;
 }
=20
@@ -3569,13 +3554,12 @@ void *address_space_map(AddressSpace *as,
     }
=20
     l =3D len;
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     fv =3D address_space_to_flatview(as);
     mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
=20
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
-            rcu_read_unlock();
             return NULL;
         }
         /* Avoid unbounded allocations */
@@ -3591,7 +3575,6 @@ void *address_space_map(AddressSpace *as,
                                bounce.buffer, l);
         }
=20
-        rcu_read_unlock();
         *plen =3D l;
         return bounce.buffer;
     }
@@ -3601,7 +3584,6 @@ void *address_space_map(AddressSpace *as,
     *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     ptr =3D qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
-    rcu_read_unlock();
=20
     return ptr;
 }
@@ -3869,13 +3851,12 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr)
     hwaddr l =3D 1;
     bool res;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     mr =3D address_space_translate(&address_space_memory,
                                  phys_addr, &phys_addr, &l, false,
                                  MEMTXATTRS_UNSPECIFIED);
=20
     res =3D !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
-    rcu_read_unlock();
     return res;
 }
=20
@@ -3884,14 +3865,13 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func,=
 void *opaque)
     RAMBlock *block;
     int ret =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     RAMBLOCK_FOREACH(block) {
         ret =3D func(block, opaque);
         if (ret) {
             break;
         }
     }
-    rcu_read_unlock();
     return ret;
 }
=20
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e96e621de5..ad158bb247 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -193,30 +193,29 @@ static inline bool cpu_physical_memory_get_dirty(ra=
m_addr_t start,
     end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
     page =3D start >> TARGET_PAGE_BITS;
=20
-    rcu_read_lock();
-
-    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+    WITH_RCU_READ_LOCK_GUARD() {
+        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+
+        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        base =3D page - offset;
+        while (page < end) {
+            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SI=
ZE);
+            unsigned long num =3D next - base;
+            unsigned long found =3D find_next_bit(blocks->blocks[idx],
+                                                num, offset);
+            if (found < num) {
+                dirty =3D true;
+                break;
+            }
=20
-    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-    base =3D page - offset;
-    while (page < end) {
-        unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long num =3D next - base;
-        unsigned long found =3D find_next_bit(blocks->blocks[idx], num, =
offset);
-        if (found < num) {
-            dirty =3D true;
-            break;
+            page =3D next;
+            idx++;
+            offset =3D 0;
+            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
         }
-
-        page =3D next;
-        idx++;
-        offset =3D 0;
-        base +=3D DIRTY_MEMORY_BLOCK_SIZE;
     }
=20
-    rcu_read_unlock();
-
     return dirty;
 }
=20
@@ -234,7 +233,7 @@ static inline bool cpu_physical_memory_all_dirty(ram_=
addr_t start,
     end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
     page =3D start >> TARGET_PAGE_BITS;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
=20
     blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
=20
@@ -256,8 +255,6 @@ static inline bool cpu_physical_memory_all_dirty(ram_=
addr_t start,
         base +=3D DIRTY_MEMORY_BLOCK_SIZE;
     }
=20
-    rcu_read_unlock();
-
     return dirty;
 }
=20
@@ -309,13 +306,11 @@ static inline void cpu_physical_memory_set_dirty_fl=
ag(ram_addr_t addr,
     idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
     offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
=20
     blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
=20
     set_bit_atomic(offset, blocks->blocks[idx]);
-
-    rcu_read_unlock();
 }
=20
 static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
@@ -334,39 +329,37 @@ static inline void cpu_physical_memory_set_dirty_ra=
nge(ram_addr_t start,
     end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
     page =3D start >> TARGET_PAGE_BITS;
=20
-    rcu_read_lock();
+    WITH_RCU_READ_LOCK_GUARD() {
+        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
+            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i]);
+        }
=20
-    for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
-        blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i]);
-    }
+        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        base =3D page - offset;
+        while (page < end) {
+            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SI=
ZE);
=20
-    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-    base =3D page - offset;
-    while (page < end) {
-        unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks=
[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx]=
,
+                                  offset, next - page);
+            }
=20
-        if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
-            bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[idx=
],
-                              offset, next - page);
+            page =3D next;
+            idx++;
+            offset =3D 0;
+            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
         }
-        if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
-            bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
-                              offset, next - page);
-        }
-        if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
-            bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
-                              offset, next - page);
-        }
-
-        page =3D next;
-        idx++;
-        offset =3D 0;
-        base +=3D DIRTY_MEMORY_BLOCK_SIZE;
     }
=20
-    rcu_read_unlock();
-
     xen_hvm_modified_memory(start, length);
 }
=20
@@ -396,36 +389,35 @@ static inline void cpu_physical_memory_set_dirty_le=
bitmap(unsigned long *bitmap,
         offset =3D BIT_WORD((start >> TARGET_PAGE_BITS) %
                           DIRTY_MEMORY_BLOCK_SIZE);
=20
-        rcu_read_lock();
+        WITH_RCU_READ_LOCK_GUARD() {
+            for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
+                blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])=
->blocks;
+            }
=20
-        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
-            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])->bl=
ocks;
-        }
+            for (k =3D 0; k < nr; k++) {
+                if (bitmap[k]) {
+                    unsigned long temp =3D leul_to_cpu(bitmap[k]);
=20
-        for (k =3D 0; k < nr; k++) {
-            if (bitmap[k]) {
-                unsigned long temp =3D leul_to_cpu(bitmap[k]);
+                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], te=
mp);
=20
-                atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
+                    if (global_dirty_log) {
+                        atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][o=
ffset],
+                                  temp);
+                    }
=20
-                if (global_dirty_log) {
-                    atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offse=
t],
-                              temp);
+                    if (tcg_enabled()) {
+                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset=
],
+                                  temp);
+                    }
                 }
=20
-                if (tcg_enabled()) {
-                    atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], t=
emp);
+                if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)=
) {
+                    offset =3D 0;
+                    idx++;
                 }
             }
-
-            if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
-                offset =3D 0;
-                idx++;
-            }
         }
=20
-        rcu_read_unlock();
-
         xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
     } else {
         uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CL=
IENTS_NOCODE;
diff --git a/memory.c b/memory.c
index 978da3d3df..c952eabb5d 100644
--- a/memory.c
+++ b/memory.c
@@ -779,14 +779,13 @@ FlatView *address_space_get_flatview(AddressSpace *=
as)
 {
     FlatView *view;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     do {
         view =3D address_space_to_flatview(as);
         /* If somebody has replaced as->current_map concurrently,
          * flatview_ref returns false.
          */
     } while (!flatview_ref(view));
-    rcu_read_unlock();
     return view;
 }
=20
@@ -2166,12 +2165,11 @@ int memory_region_get_fd(MemoryRegion *mr)
 {
     int fd;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     while (mr->alias) {
         mr =3D mr->alias;
     }
     fd =3D mr->ram_block->fd;
-    rcu_read_unlock();
=20
     return fd;
 }
@@ -2181,14 +2179,13 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr)
     void *ptr;
     uint64_t offset =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     while (mr->alias) {
         offset +=3D mr->alias_offset;
         mr =3D mr->alias;
     }
     assert(mr->ram_block);
     ptr =3D qemu_map_ram_ptr(mr->ram_block, offset);
-    rcu_read_unlock();
=20
     return ptr;
 }
@@ -2578,12 +2575,11 @@ MemoryRegionSection memory_region_find(MemoryRegi=
on *mr,
                                        hwaddr addr, uint64_t size)
 {
     MemoryRegionSection ret;
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     ret =3D memory_region_find_rcu(mr, addr, size);
     if (ret.mr) {
         memory_region_ref(ret.mr);
     }
-    rcu_read_unlock();
     return ret;
 }
=20
@@ -2591,9 +2587,8 @@ bool memory_region_present(MemoryRegion *container,=
 hwaddr addr)
 {
     MemoryRegion *mr;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     mr =3D memory_region_find_rcu(container, addr, 1).mr;
-    rcu_read_unlock();
     return mr && mr !=3D container;
 }
=20
--=20
2.23.0


