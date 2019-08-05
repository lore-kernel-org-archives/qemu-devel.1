Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABAC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FEC20651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FEC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf2S-0003OZ-4d
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1huewJ-0002ma-Rr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1huewH-0000hu-D1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1huewF-0000ap-A3; Mon, 05 Aug 2019 11:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A15483F4C;
 Mon,  5 Aug 2019 15:30:10 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0504E60C83;
 Mon,  5 Aug 2019 15:30:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:29:41 +0200
Message-Id: <20190805152947.28536-4-david@redhat.com>
In-Reply-To: <20190805152947.28536-1-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 05 Aug 2019 15:30:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 3/9] s390x/mmu: DAT translation
 rewrite
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's rewrite the DAT translation in a non-recursive way, similar to
arch/s390/kvm/gaccess.c:guest_translate() in KVM. This makes the
code much easier to read, compare and maintain.

Use better names for the region/section/page table entries and for the
macros to extract relevant parts from virtual address. Introduce defines
for all defined bits, this will come in handy soon.

All access exceptions now directly go via trigger_access_exception(),
at a central point. DAT protection checks are performed at a central
place.

Also, we now catch and indicate invalid addresses of page tables. All
table entries are accessed via read_table_entry().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        |  77 +++++---
 target/s390x/mem_helper.c |  13 +-
 target/s390x/mmu_helper.c | 360 +++++++++++++++++---------------------
 3 files changed, 229 insertions(+), 221 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index c34992bb2e..1ff14250bd 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -554,26 +554,63 @@ QEMU_BUILD_BUG_ON(sizeof(SysIB) !=3D 4096);
 #define ASCE_TYPE_SEGMENT     0x00        /* segment table type         =
      */
 #define ASCE_TABLE_LENGTH     0x03        /* region table length        =
      */
=20
-#define REGION_ENTRY_ORIGIN   (~0xfffULL) /* region/segment table origin=
    */
-#define REGION_ENTRY_RO       0x200       /* region/segment protection b=
it  */
-#define REGION_ENTRY_TF       0xc0        /* region/segment table offset=
    */
-#define REGION_ENTRY_INV      0x20        /* invalid region table entry =
    */
-#define REGION_ENTRY_TYPE_MASK 0x0c       /* region/segment table type m=
ask */
-#define REGION_ENTRY_TYPE_R1  0x0c        /* region first table type    =
    */
-#define REGION_ENTRY_TYPE_R2  0x08        /* region second table type   =
    */
-#define REGION_ENTRY_TYPE_R3  0x04        /* region third table type    =
    */
-#define REGION_ENTRY_LENGTH   0x03        /* region third length        =
    */
-
-#define SEGMENT_ENTRY_ORIGIN  (~0x7ffULL) /* segment table origin       =
 */
-#define SEGMENT_ENTRY_FC      0x400       /* format control             =
 */
-#define SEGMENT_ENTRY_RO      0x200       /* page protection bit        =
 */
-#define SEGMENT_ENTRY_INV     0x20        /* invalid segment table entry=
 */
-
-#define VADDR_PX              0xff000     /* page index bits   */
-
-#define PAGE_RO               0x200       /* HW read-only bit  */
-#define PAGE_INVALID          0x400       /* HW invalid bit    */
-#define PAGE_RES0             0x800       /* bit must be zero  */
+#define REGION_ENTRY_ORIGIN         0xfffffffffffff000ULL
+#define REGION_ENTRY_P              0x0000000000000200ULL
+#define REGION_ENTRY_TF             0x00000000000000c0ULL
+#define REGION_ENTRY_I              0x0000000000000020ULL
+#define REGION_ENTRY_TT             0x000000000000000cULL
+#define REGION_ENTRY_TL             0x0000000000000003ULL
+
+#define REGION_ENTRY_TT_REGION1     0x000000000000000cULL
+#define REGION_ENTRY_TT_REGION2     0x0000000000000008ULL
+#define REGION_ENTRY_TT_REGION3     0x0000000000000004ULL
+
+#define REGION3_ENTRY_RFAA          0xffffffff80000000ULL
+#define REGION3_ENTRY_AV            0x0000000000010000ULL
+#define REGION3_ENTRY_ACC           0x000000000000f000ULL
+#define REGION3_ENTRY_F             0x0000000000000800ULL
+#define REGION3_ENTRY_FC            0x0000000000000400ULL
+#define REGION3_ENTRY_IEP           0x0000000000000100ULL
+#define REGION3_ENTRY_CR            0x0000000000000010ULL
+
+#define SEGMENT_ENTRY_ORIGIN        0xfffffffffffff800ULL
+#define SEGMENT_ENTRY_SFAA          0xfffffffffff80000ULL
+#define SEGMENT_ENTRY_AV            0x0000000000010000ULL
+#define SEGMENT_ENTRY_ACC           0x000000000000f000ULL
+#define SEGMENT_ENTRY_F             0x0000000000000800ULL
+#define SEGMENT_ENTRY_FC            0x0000000000000400ULL
+#define SEGMENT_ENTRY_P             0x0000000000000200ULL
+#define SEGMENT_ENTRY_IEP           0x0000000000000100ULL
+#define SEGMENT_ENTRY_I             0x0000000000000020ULL
+#define SEGMENT_ENTRY_CS            0x0000000000000010ULL
+#define SEGMENT_ENTRY_TT            0x000000000000000cULL
+
+#define SEGMENT_ENTRY_TT_REGION1    0x000000000000000cULL
+#define SEGMENT_ENTRY_TT_REGION2    0x0000000000000008ULL
+#define SEGMENT_ENTRY_TT_REGION3    0x0000000000000004ULL
+#define SEGMENT_ENTRY_TT_SEGMENT    0x0000000000000000ULL
+
+#define PAGE_ENTRY_0                0x0000000000000800ULL
+#define PAGE_ENTRY_I                0x0000000000000400ULL
+#define PAGE_ENTRY_P                0x0000000000000200ULL
+#define PAGE_ENTRY_IEP              0x0000000000000100ULL
+
+#define VADDR_REGION1_TX_MASK       0xffe0000000000000ULL
+#define VADDR_REGION2_TX_MASK       0x001ffc0000000000ULL
+#define VADDR_REGION3_TX_MASK       0x000003ff80000000ULL
+#define VADDR_SEGMENT_TX_MASK       0x000000007ff00000ULL
+#define VADDR_PAGE_TX_MASK          0x00000000000ff000ULL
+
+#define VADDR_REGION1_TX(vaddr)     (((vaddr) & VADDR_REGION1_TX_MASK) >=
> 53)
+#define VADDR_REGION2_TX(vaddr)     (((vaddr) & VADDR_REGION2_TX_MASK) >=
> 42)
+#define VADDR_REGION3_TX(vaddr)     (((vaddr) & VADDR_REGION3_TX_MASK) >=
> 31)
+#define VADDR_SEGMENT_TX(vaddr)     (((vaddr) & VADDR_SEGMENT_TX_MASK) >=
> 20)
+#define VADDR_PAGE_TX(vaddr)        (((vaddr) & VADDR_PAGE_TX_MASK) >> 1=
2)
+
+#define VADDR_REGION1_TL(vaddr)     (((vaddr) & 0xc000000000000000ULL) >=
> 62)
+#define VADDR_REGION2_TL(vaddr)     (((vaddr) & 0x0018000000000000ULL) >=
> 51)
+#define VADDR_REGION3_TL(vaddr)     (((vaddr) & 0x0000030000000000ULL) >=
> 40)
+#define VADDR_SEGMENT_TL(vaddr)     (((vaddr) & 0x0000000060000000ULL) >=
> 29)
=20
 #define SK_C                    (0x1 << 1)
 #define SK_R                    (0x1 << 2)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 29d9eaa5b7..46cc0d66f7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1936,9 +1936,9 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, =
uint64_t r2, uint32_t m4)
             /* addresses are not wrapped in 24/31bit mode but table inde=
x is */
             raddr =3D table + ((index + i) & 0x7ff) * sizeof(entry);
             entry =3D cpu_ldq_real_ra(env, raddr, ra);
-            if (!(entry & REGION_ENTRY_INV)) {
+            if (!(entry & REGION_ENTRY_I)) {
                 /* we are allowed to not store if already invalid */
-                entry |=3D REGION_ENTRY_INV;
+                entry |=3D REGION_ENTRY_I;
                 cpu_stq_real_ra(env, raddr, entry, ra);
             }
         }
@@ -1963,17 +1963,18 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pt=
o, uint64_t vaddr,
=20
     /* Compute the page table entry address */
     pte_addr =3D (pto & SEGMENT_ENTRY_ORIGIN);
-    pte_addr +=3D (vaddr & VADDR_PX) >> 9;
+    pte_addr +=3D VADDR_PAGE_TX(vaddr) * 8;
=20
     /* Mark the page table entry as invalid */
     pte =3D cpu_ldq_real_ra(env, pte_addr, ra);
-    pte |=3D PAGE_INVALID;
+    pte |=3D PAGE_ENTRY_I;
+
     cpu_stq_real_ra(env, pte_addr, pte, ra);
=20
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
     if (m4 & 1) {
-        if (vaddr & ~VADDR_PX) {
+        if (vaddr & ~VADDR_PAGE_TX_MASK) {
             tlb_flush_page(cs, page);
             /* XXX 31-bit hack */
             tlb_flush_page(cs, page ^ 0x80000000);
@@ -1982,7 +1983,7 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto,=
 uint64_t vaddr,
             tlb_flush(cs);
         }
     } else {
-        if (vaddr & ~VADDR_PX) {
+        if (vaddr & ~VADDR_PAGE_TX_MASK) {
             tlb_flush_page_all_cpus_synced(cs, page);
             /* XXX 31-bit hack */
             tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 9c0d9b5c5f..de7798284d 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -72,44 +72,6 @@ static void trigger_access_exception(CPUS390XState *en=
v, uint32_t type,
     }
 }
=20
-static void trigger_prot_fault(CPUS390XState *env, target_ulong vaddr,
-                               uint64_t asc, int rw, bool exc)
-{
-    uint64_t tec;
-
-    tec =3D vaddr | (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ) | 4 =
| asc >> 46;
-
-    DPRINTF("%s: trans_exc_code=3D%016" PRIx64 "\n", __func__, tec);
-
-    if (!exc) {
-        return;
-    }
-
-    trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, tec);
-}
-
-static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
-                               uint32_t type, uint64_t asc, int rw, bool=
 exc)
-{
-    int ilen =3D ILEN_AUTO;
-    uint64_t tec;
-
-    tec =3D vaddr | (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ) | as=
c >> 46;
-
-    DPRINTF("%s: trans_exc_code=3D%016" PRIx64 "\n", __func__, tec);
-
-    if (!exc) {
-        return;
-    }
-
-    /* Code accesses have an undefined ilc.  */
-    if (rw =3D=3D MMU_INST_FETCH) {
-        ilen =3D 2;
-    }
-
-    trigger_access_exception(env, type, ilen, tec);
-}
-
 /* check whether the address would be proteted by Low-Address Protection=
 */
 static bool is_low_address(uint64_t addr)
 {
@@ -155,183 +117,171 @@ target_ulong mmu_real2abs(CPUS390XState *env, tar=
get_ulong raddr)
     return raddr;
 }
=20
-/* Decode page table entry (normal 4KB page) */
-static int mmu_translate_pte(CPUS390XState *env, target_ulong vaddr,
-                             uint64_t asc, uint64_t pt_entry,
-                             target_ulong *raddr, int *flags, int rw, bo=
ol exc)
+static inline int read_table_entry(hwaddr gaddr, uint64_t *entry)
 {
-    if (pt_entry & PAGE_INVALID) {
-        DPRINTF("%s: PTE=3D0x%" PRIx64 " invalid\n", __func__, pt_entry)=
;
-        trigger_page_fault(env, vaddr, PGM_PAGE_TRANS, asc, rw, exc);
-        return -1;
+    /*
+     * According to the PoP, these table addresses are "unpredictably re=
al
+     * or absolute". Also, "it is unpredictable whether the address wrap=
s
+     * or an addressing exception is recognized".
+     *
+     * We treat them as absolute addresses and don't wrap them.
+     */
+    if (address_space_read(&address_space_memory, gaddr, MEMTXATTRS_UNSP=
ECIFIED,
+                           (uint8_t *)entry, sizeof(*entry)) !=3D MEMTX_=
OK) {
+        return -EFAULT;
     }
-    if (pt_entry & PAGE_RES0) {
-        trigger_page_fault(env, vaddr, PGM_TRANS_SPEC, asc, rw, exc);
-        return -1;
-    }
-    if (pt_entry & PAGE_RO) {
-        *flags &=3D ~PAGE_WRITE;
-    }
-
-    *raddr =3D pt_entry & ASCE_ORIGIN;
-
-    PTE_DPRINTF("%s: PTE=3D0x%" PRIx64 "\n", __func__, pt_entry);
-
+    *entry =3D be64_to_cpu(*entry);
     return 0;
 }
=20
-/* Decode segment table entry */
-static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
-                                 uint64_t asc, uint64_t st_entry,
-                                 target_ulong *raddr, int *flags, int rw=
,
-                                 bool exc)
-{
-    CPUState *cs =3D env_cpu(env);
-    uint64_t origin, offs, pt_entry;
-
-    if (st_entry & SEGMENT_ENTRY_RO) {
-        *flags &=3D ~PAGE_WRITE;
-    }
-
-    if ((st_entry & SEGMENT_ENTRY_FC) && (env->cregs[0] & CR0_EDAT)) {
-        /* Decode EDAT1 segment frame absolute address (1MB page) */
-        *raddr =3D (st_entry & 0xfffffffffff00000ULL) | (vaddr & 0xfffff=
);
-        PTE_DPRINTF("%s: SEG=3D0x%" PRIx64 "\n", __func__, st_entry);
-        return 0;
-    }
-
-    /* Look up 4KB page entry */
-    origin =3D st_entry & SEGMENT_ENTRY_ORIGIN;
-    offs  =3D (vaddr & VADDR_PX) >> 9;
-    pt_entry =3D ldq_phys(cs->as, origin + offs);
-    PTE_DPRINTF("%s: 0x%" PRIx64 " + 0x%" PRIx64 " =3D> 0x%016" PRIx64 "=
\n",
-                __func__, origin, offs, pt_entry);
-    return mmu_translate_pte(env, vaddr, asc, pt_entry, raddr, flags, rw=
, exc);
-}
-
-/* Decode region table entries */
-static int mmu_translate_region(CPUS390XState *env, target_ulong vaddr,
-                                uint64_t asc, uint64_t entry, int level,
-                                target_ulong *raddr, int *flags, int rw,
-                                bool exc)
-{
-    CPUState *cs =3D env_cpu(env);
-    uint64_t origin, offs, new_entry;
-    const int pchks[4] =3D {
-        PGM_SEGMENT_TRANS, PGM_REG_THIRD_TRANS,
-        PGM_REG_SEC_TRANS, PGM_REG_FIRST_TRANS
-    };
-
-    PTE_DPRINTF("%s: 0x%" PRIx64 "\n", __func__, entry);
-
-    origin =3D entry & REGION_ENTRY_ORIGIN;
-    offs =3D (vaddr >> (17 + 11 * level / 4)) & 0x3ff8;
-
-    new_entry =3D ldq_phys(cs->as, origin + offs);
-    PTE_DPRINTF("%s: 0x%" PRIx64 " + 0x%" PRIx64 " =3D> 0x%016" PRIx64 "=
\n",
-                __func__, origin, offs, new_entry);
-
-    if ((new_entry & REGION_ENTRY_INV) !=3D 0) {
-        DPRINTF("%s: invalid region\n", __func__);
-        trigger_page_fault(env, vaddr, pchks[level / 4], asc, rw, exc);
-        return -1;
-    }
-
-    if ((new_entry & REGION_ENTRY_TYPE_MASK) !=3D level) {
-        trigger_page_fault(env, vaddr, PGM_TRANS_SPEC, asc, rw, exc);
-        return -1;
-    }
-
-    if (level =3D=3D ASCE_TYPE_SEGMENT) {
-        return mmu_translate_segment(env, vaddr, asc, new_entry, raddr, =
flags,
-                                     rw, exc);
-    }
-
-    /* Check region table offset and length */
-    offs =3D (vaddr >> (28 + 11 * (level - 4) / 4)) & 3;
-    if (offs < ((new_entry & REGION_ENTRY_TF) >> 6)
-        || offs > (new_entry & REGION_ENTRY_LENGTH)) {
-        DPRINTF("%s: invalid offset or len (%lx)\n", __func__, new_entry=
);
-        trigger_page_fault(env, vaddr, pchks[level / 4 - 1], asc, rw, ex=
c);
-        return -1;
-    }
-
-    if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_RO)) {
-        *flags &=3D ~PAGE_WRITE;
-    }
-
-    /* yet another region */
-    return mmu_translate_region(env, vaddr, asc, new_entry, level - 4,
-                                raddr, flags, rw, exc);
-}
-
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
-                              uint64_t asc, uint64_t asce, target_ulong =
*raddr,
-                              int *flags, int rw, bool exc)
+                              uint64_t asce, target_ulong *raddr, int *f=
lags)
 {
-    int level;
-    int r;
+    const bool edat1 =3D (env->cregs[0] & CR0_EDAT) &&
+                       s390_has_feat(S390_FEAT_EDAT);
+    const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
+    const int asce_p =3D asce & ASCE_PRIVATE_SPACE;
+    hwaddr gaddr =3D asce & ASCE_ORIGIN;
+    uint64_t entry;
=20
     if (asce & ASCE_REAL_SPACE) {
-        /* direct mapping */
         *raddr =3D vaddr;
         return 0;
     }
=20
-    level =3D asce & ASCE_TYPE_MASK;
-    switch (level) {
+    switch (asce & ASCE_TYPE_MASK) {
     case ASCE_TYPE_REGION1:
-        if ((vaddr >> 62) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_REG_FIRST_TRANS, asc, rw,=
 exc);
-            return -1;
+        if (VADDR_REGION1_TL(vaddr) > asce_tl) {
+            return PGM_REG_FIRST_TRANS;
         }
+        gaddr +=3D VADDR_REGION1_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_REGION2:
-        if (vaddr & 0xffe0000000000000ULL) {
-            DPRINTF("%s: vaddr doesn't fit 0x%16" PRIx64
-                    " 0xffe0000000000000ULL\n", __func__, vaddr);
-            trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
-            return -1;
+        if (VADDR_REGION1_TX(vaddr)) {
+            return PGM_ASCE_TYPE;
         }
-        if ((vaddr >> 51 & 3) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_REG_SEC_TRANS, asc, rw, e=
xc);
-            return -1;
+        if (VADDR_REGION2_TL(vaddr) > asce_tl) {
+            return PGM_REG_SEC_TRANS;
         }
+        gaddr +=3D VADDR_REGION2_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_REGION3:
-        if (vaddr & 0xfffffc0000000000ULL) {
-            DPRINTF("%s: vaddr doesn't fit 0x%16" PRIx64
-                    " 0xfffffc0000000000ULL\n", __func__, vaddr);
-            trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
-            return -1;
+        if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr)) {
+            return PGM_ASCE_TYPE;
         }
-        if ((vaddr >> 40 & 3) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_REG_THIRD_TRANS, asc, rw,=
 exc);
-            return -1;
+        if (VADDR_REGION3_TL(vaddr) > asce_tl) {
+            return PGM_REG_THIRD_TRANS;
         }
+        gaddr +=3D VADDR_REGION3_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_SEGMENT:
-        if (vaddr & 0xffffffff80000000ULL) {
-            DPRINTF("%s: vaddr doesn't fit 0x%16" PRIx64
-                    " 0xffffffff80000000ULL\n", __func__, vaddr);
-            trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
-            return -1;
+        if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr) ||
+            VADDR_REGION3_TX(vaddr)) {
+            return PGM_ASCE_TYPE;
         }
-        if ((vaddr >> 29 & 3) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_SEGMENT_TRANS, asc, rw, e=
xc);
-            return -1;
+        if (VADDR_SEGMENT_TL(vaddr) > asce_tl) {
+            return PGM_SEGMENT_TRANS;
         }
+        gaddr +=3D VADDR_SEGMENT_TX(vaddr) * 8;
+        break;
+    }
+    switch (asce & ASCE_TYPE_MASK) {
+    case ASCE_TYPE_REGION1:
+        if (read_table_entry(gaddr, &entry)) {
+            return PGM_ADDRESSING;
+        }
+        if (entry & REGION_ENTRY_I) {
+            return PGM_REG_FIRST_TRANS;
+        }
+        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION1) {
+            return PGM_TRANS_SPEC;
+        }
+        if (VADDR_REGION2_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
+            VADDR_REGION2_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
+            return PGM_REG_SEC_TRANS;
+        }
+        if (edat1 && (entry & REGION_ENTRY_P)) {
+            *flags &=3D ~PAGE_WRITE;
+        }
+        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION2_TX(vaddr=
) * 8;
+        /* FALL THROUGH */
+    case ASCE_TYPE_REGION2:
+        if (read_table_entry(gaddr, &entry)) {
+            return PGM_ADDRESSING;
+        }
+        if (entry & REGION_ENTRY_I) {
+            return PGM_REG_SEC_TRANS;
+        }
+        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION2) {
+            return PGM_TRANS_SPEC;
+        }
+        if (VADDR_REGION3_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
+            VADDR_REGION3_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
+            return PGM_REG_THIRD_TRANS;
+        }
+        if (edat1 && (entry & REGION_ENTRY_P)) {
+            *flags &=3D ~PAGE_WRITE;
+        }
+        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION3_TX(vaddr=
) * 8;
+        /* FALL THROUGH */
+    case ASCE_TYPE_REGION3:
+        if (read_table_entry(gaddr, &entry)) {
+            return PGM_ADDRESSING;
+        }
+        if (entry & REGION_ENTRY_I) {
+            return PGM_REG_THIRD_TRANS;
+        }
+        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION3) {
+            return PGM_TRANS_SPEC;
+        }
+        if (edat1 && (entry & REGION_ENTRY_P)) {
+            *flags &=3D ~PAGE_WRITE;
+        }
+        if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
+            VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
+            return PGM_SEGMENT_TRANS;
+        }
+        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_SEGMENT_TX(vaddr=
) * 8;
+        /* FALL THROUGH */
+    case ASCE_TYPE_SEGMENT:
+        if (read_table_entry(gaddr, &entry)) {
+            return PGM_ADDRESSING;
+        }
+        if (entry & SEGMENT_ENTRY_I) {
+            return PGM_SEGMENT_TRANS;
+        }
+        if ((entry & SEGMENT_ENTRY_TT) !=3D SEGMENT_ENTRY_TT_SEGMENT) {
+            return PGM_TRANS_SPEC;
+        }
+        if ((entry & SEGMENT_ENTRY_CS) && asce_p) {
+            return PGM_TRANS_SPEC;
+        }
+        if (entry & SEGMENT_ENTRY_P) {
+            *flags &=3D ~PAGE_WRITE;
+        }
+        if (edat1 && (entry & SEGMENT_ENTRY_FC)) {
+            *raddr =3D entry & SEGMENT_ENTRY_SFAA;
+            return 0;
+        }
+        gaddr =3D (entry & SEGMENT_ENTRY_ORIGIN) + VADDR_PAGE_TX(vaddr) =
* 8;
         break;
     }
=20
-    r =3D mmu_translate_region(env, vaddr, asc, asce, level, raddr, flag=
s, rw,
-                             exc);
-    if (!r && rw =3D=3D MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
-        trigger_prot_fault(env, vaddr, asc, rw, exc);
-        return -1;
+    if (read_table_entry(gaddr, &entry)) {
+        return PGM_ADDRESSING;
+    }
+    if (entry & PAGE_ENTRY_I) {
+        return PGM_PAGE_TRANS;
+    }
+    if (entry & PAGE_ENTRY_0) {
+        return PGM_TRANS_SPEC;
+    }
+    if (entry & PAGE_ENTRY_P) {
+        *flags &=3D ~PAGE_WRITE;
     }
=20
-    return r;
+    *raddr =3D entry & TARGET_PAGE_MASK;
+    return 0;
 }
=20
 /**
@@ -347,9 +297,14 @@ static int mmu_translate_asce(CPUS390XState *env, ta=
rget_ulong vaddr,
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64=
_t asc,
                   target_ulong *raddr, int *flags, bool exc)
 {
+    /* Code accesses have an undefined ilc, let's use 2 bytes. */
+    const int ilen =3D (rw =3D=3D MMU_INST_FETCH) ? 2 : ILEN_AUTO;
+    uint64_t tec =3D (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
+                   (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ);
+    uint64_t asce;
     static S390SKeysState *ss;
     static S390SKeysClass *skeyclass;
-    int r =3D -1;
+    int r;
     uint8_t key;
=20
     if (unlikely(!ss)) {
@@ -380,25 +335,21 @@ int mmu_translate(CPUS390XState *env, target_ulong =
vaddr, int rw, uint64_t asc,
=20
     if (!(env->psw.mask & PSW_MASK_DAT)) {
         *raddr =3D vaddr;
-        r =3D 0;
-        goto out;
+        goto nodat;
     }
=20
     switch (asc) {
     case PSW_ASC_PRIMARY:
         PTE_DPRINTF("%s: asc=3Dprimary\n", __func__);
-        r =3D mmu_translate_asce(env, vaddr, asc, env->cregs[1], raddr, =
flags,
-                               rw, exc);
+        asce =3D env->cregs[1];
         break;
     case PSW_ASC_HOME:
         PTE_DPRINTF("%s: asc=3Dhome\n", __func__);
-        r =3D mmu_translate_asce(env, vaddr, asc, env->cregs[13], raddr,=
 flags,
-                               rw, exc);
+        asce =3D env->cregs[13];
         break;
     case PSW_ASC_SECONDARY:
         PTE_DPRINTF("%s: asc=3Dsecondary\n", __func__);
-        r =3D mmu_translate_asce(env, vaddr, PSW_ASC_SECONDARY, env->cre=
gs[7],
-                               raddr, flags, rw, exc);
+        asce =3D env->cregs[7];
         break;
     case PSW_ASC_ACCREG:
     default:
@@ -406,11 +357,30 @@ int mmu_translate(CPUS390XState *env, target_ulong =
vaddr, int rw, uint64_t asc,
         break;
     }
=20
- out:
+    /* perform the translation */
+    r =3D mmu_translate_asce(env, vaddr, asce, raddr, flags);
+    if (r) {
+        if (exc) {
+            trigger_access_exception(env, r, ilen, tec);
+        }
+        return -1;
+    }
+
+    /* check for DAT protection */
+    if (rw =3D=3D MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
+        if (exc) {
+            /* DAT sets bit 61 only */
+            tec |=3D 0x4;
+            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
+        }
+        return -1;
+    }
+
+nodat:
     /* Convert real address -> absolute address */
     *raddr =3D mmu_real2abs(env, *raddr);
=20
-    if (r =3D=3D 0 && *raddr < ram_size) {
+    if (*raddr < ram_size) {
         if (skeyclass->get_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &key)=
) {
             trace_get_skeys_nonzero(r);
             return 0;
@@ -430,7 +400,7 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
ddr, int rw, uint64_t asc,
         }
     }
=20
-    return r;
+    return 0;
 }
=20
 /**
--=20
2.21.0


