Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC6BC388F4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B1E217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B1E217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrTj-0002s3-JY
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDqQW-0000TH-P9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDqQU-0002fR-S8
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDqQS-0002ZN-Pu; Fri, 27 Sep 2019 09:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B5FAC02491D;
 Fri, 27 Sep 2019 09:58:58 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47DDF1001B20;
 Fri, 27 Sep 2019 09:58:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] s390x/mmu: DAT table definition overhaul
Date: Fri, 27 Sep 2019 11:58:30 +0200
Message-Id: <20190927095831.23543-7-david@redhat.com>
In-Reply-To: <20190927095831.23543-1-david@redhat.com>
References: <20190927095831.23543-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 27 Sep 2019 09:58:58 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's use consitent names for the region/section/page table entries and
for the macros to extract relevant parts from virtual address. Make them
match the definitions in the PoP - e.g., how the relevant bits are actual=
ly
called.

Introduce defines for all bits declared in the PoP. This will come in
handy in follow-up patches.

Add a note where additional information about s390x and the used
definitions can be found.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        | 81 +++++++++++++++++++++++++++++----------
 target/s390x/mem_helper.c | 12 +++---
 target/s390x/mmu_helper.c | 37 ++++++++++--------
 3 files changed, 87 insertions(+), 43 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 163dae13d7..690b94c8ea 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1,6 +1,10 @@
 /*
  * S/390 virtual CPU header
  *
+ * For details on the s390x architecture and used definitions (e.g.,
+ * PSW, PER and DAT (Dynamic Address Translation)), please refer to
+ * the "z/Architecture Principles of Operations" - a.k.a. PoP.
+ *
  *  Copyright (c) 2009 Ulrich Hecht
  *  Copyright IBM Corp. 2012, 2018
  *
@@ -558,26 +562,63 @@ QEMU_BUILD_BUG_ON(sizeof(SysIB) !=3D 4096);
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
index 44e535856d..08c5cc6a99 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2252,9 +2252,9 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, =
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
@@ -2279,17 +2279,17 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pt=
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
@@ -2298,7 +2298,7 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto,=
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
index aaf5b23513..a114fb1628 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -119,13 +119,13 @@ static int mmu_translate_pte(CPUS390XState *env, ta=
rget_ulong vaddr,
                              uint64_t asc, uint64_t pt_entry,
                              target_ulong *raddr, int *flags, int rw, bo=
ol exc)
 {
-    if (pt_entry & PAGE_INVALID) {
+    if (pt_entry & PAGE_ENTRY_I) {
         return PGM_PAGE_TRANS;
     }
-    if (pt_entry & PAGE_RES0) {
+    if (pt_entry & PAGE_ENTRY_0) {
         return PGM_TRANS_SPEC;
     }
-    if (pt_entry & PAGE_RO) {
+    if (pt_entry & PAGE_ENTRY_P) {
         *flags &=3D ~PAGE_WRITE;
     }
=20
@@ -141,19 +141,20 @@ static int mmu_translate_segment(CPUS390XState *env=
, target_ulong vaddr,
 {
     uint64_t origin, offs, pt_entry;
=20
-    if (st_entry & SEGMENT_ENTRY_RO) {
+    if (st_entry & SEGMENT_ENTRY_P) {
         *flags &=3D ~PAGE_WRITE;
     }
=20
     if ((st_entry & SEGMENT_ENTRY_FC) && (env->cregs[0] & CR0_EDAT)) {
         /* Decode EDAT1 segment frame absolute address (1MB page) */
-        *raddr =3D (st_entry & 0xfffffffffff00000ULL) | (vaddr & 0xfffff=
);
+        *raddr =3D (st_entry & SEGMENT_ENTRY_SFAA) |
+                 (vaddr & ~SEGMENT_ENTRY_SFAA);
         return 0;
     }
=20
     /* Look up 4KB page entry */
     origin =3D st_entry & SEGMENT_ENTRY_ORIGIN;
-    offs  =3D (vaddr & VADDR_PX) >> 9;
+    offs =3D VADDR_PAGE_TX(vaddr) * 8;
     if (!read_table_entry(env, origin + offs, &pt_entry)) {
         return PGM_ADDRESSING;
     }
@@ -179,11 +180,11 @@ static int mmu_translate_region(CPUS390XState *env,=
 target_ulong vaddr,
         return PGM_ADDRESSING;
     }
=20
-    if ((new_entry & REGION_ENTRY_INV) !=3D 0) {
+    if (new_entry & REGION_ENTRY_I) {
         return pchks[level / 4];
     }
=20
-    if ((new_entry & REGION_ENTRY_TYPE_MASK) !=3D level) {
+    if ((new_entry & REGION_ENTRY_TT) !=3D level) {
         return PGM_TRANS_SPEC;
     }
=20
@@ -195,11 +196,11 @@ static int mmu_translate_region(CPUS390XState *env,=
 target_ulong vaddr,
     /* Check region table offset and length */
     offs =3D (vaddr >> (28 + 11 * (level - 4) / 4)) & 3;
     if (offs < ((new_entry & REGION_ENTRY_TF) >> 6)
-        || offs > (new_entry & REGION_ENTRY_LENGTH)) {
+        || offs > (new_entry & REGION_ENTRY_TL)) {
         return pchks[level / 4 - 1];
     }
=20
-    if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_RO)) {
+    if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_P)) {
         *flags &=3D ~PAGE_WRITE;
     }
=20
@@ -212,6 +213,7 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
                               uint64_t asc, uint64_t asce, target_ulong =
*raddr,
                               int *flags, int rw, bool exc)
 {
+    const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
     int level;
=20
     if (asce & ASCE_REAL_SPACE) {
@@ -223,31 +225,32 @@ static int mmu_translate_asce(CPUS390XState *env, t=
arget_ulong vaddr,
     level =3D asce & ASCE_TYPE_MASK;
     switch (level) {
     case ASCE_TYPE_REGION1:
-        if ((vaddr >> 62) > (asce & ASCE_TABLE_LENGTH)) {
+        if (VADDR_REGION1_TL(vaddr) > asce_tl) {
             return PGM_REG_FIRST_TRANS;
         }
         break;
     case ASCE_TYPE_REGION2:
-        if (vaddr & 0xffe0000000000000ULL) {
+        if (VADDR_REGION1_TX(vaddr)) {
             return PGM_ASCE_TYPE;
         }
-        if ((vaddr >> 51 & 3) > (asce & ASCE_TABLE_LENGTH)) {
+        if (VADDR_REGION2_TL(vaddr) > asce_tl) {
             return PGM_REG_SEC_TRANS;
         }
         break;
     case ASCE_TYPE_REGION3:
-        if (vaddr & 0xfffffc0000000000ULL) {
+        if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr)) {
             return PGM_ASCE_TYPE;
         }
-        if ((vaddr >> 40 & 3) > (asce & ASCE_TABLE_LENGTH)) {
+        if (VADDR_REGION3_TL(vaddr) > asce_tl) {
             return PGM_REG_THIRD_TRANS;
         }
         break;
     case ASCE_TYPE_SEGMENT:
-        if (vaddr & 0xffffffff80000000ULL) {
+        if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr) ||
+            VADDR_REGION3_TX(vaddr)) {
             return PGM_ASCE_TYPE;
         }
-        if ((vaddr >> 29 & 3) > (asce & ASCE_TABLE_LENGTH)) {
+        if (VADDR_SEGMENT_TL(vaddr) > asce_tl) {
             return PGM_SEGMENT_TRANS;
         }
         break;
--=20
2.21.0


