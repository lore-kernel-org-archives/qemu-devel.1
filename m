Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D947A206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D947A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69Ni-0006F4-BJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i698h-0004AH-W1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i698f-0003Rh-IZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i698f-0003Qr-87; Fri, 06 Sep 2019 03:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89A2A8980E2;
 Fri,  6 Sep 2019 07:58:36 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8A461000321;
 Fri,  6 Sep 2019 07:58:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:38 +0200
Message-Id: <20190906075750.14791-17-david@redhat.com>
In-Reply-To: <20190906075750.14791-1-david@redhat.com>
References: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 06 Sep 2019 07:58:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 16/28] s390x/tcg: Fault-safe memmove
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace fast_memmove() variants by access_memmove() variants, that
first try to probe access to all affected pages (maximum is two pages).

In MVCOS, simply always call access_memmove_as() and drop the TODO
about LAP. LAP is already handled in the MMU.

Get rid of adj_len_to_page(), which is now unused.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 204 +++++++++++++++++++++-----------------
 1 file changed, 115 insertions(+), 89 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 8d654b24e7..db678ddf47 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -65,17 +65,6 @@ static bool is_destructive_overlap(CPUS390XState *env,=
 uint64_t dest,
     return dest > src && dest <=3D src + len - 1;
 }
=20
-/* Reduce the length so that addr + len doesn't cross a page boundary.  =
*/
-static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
-{
-#ifndef CONFIG_USER_ONLY
-    if ((addr & ~TARGET_PAGE_MASK) + len - 1 >=3D TARGET_PAGE_SIZE) {
-        return -(addr | TARGET_PAGE_MASK);
-    }
-#endif
-    return len;
-}
-
 /* Trigger a SPECIFICATION exception if an address or a length is not
    naturally aligned.  */
 static inline void check_alignment(CPUS390XState *env, uint64_t v,
@@ -129,6 +118,7 @@ typedef struct S390Access {
     char *haddr2;
     uint16_t size1;
     uint16_t size2;
+    int mmu_idx;
 } S390Access;
=20
 static S390Access access_prepare_idx(CPUS390XState *env, vaddr vaddr, in=
t size,
@@ -138,6 +128,7 @@ static S390Access access_prepare_idx(CPUS390XState *e=
nv, vaddr vaddr, int size,
     S390Access access =3D {
         .vaddr1 =3D vaddr,
         .size1 =3D MIN(size, -(vaddr | TARGET_PAGE_MASK)),
+        .mmu_idx =3D mmu_idx,
     };
=20
     g_assert(size > 0 && size <=3D 4096);
@@ -195,42 +186,112 @@ static void access_memset(CPUS390XState *env, vadd=
r vaddr, uint8_t byte,
     access_memset_idx(env, vaddr, byte, size, mmu_idx, ra);
 }
=20
-#ifndef CONFIG_USER_ONLY
-static void fast_memmove_idx(CPUS390XState *env, uint64_t dest, uint64_t=
 src,
-                             uint32_t len, int dest_idx, int src_idx,
-                             uintptr_t ra)
-{
-    TCGMemOpIdx oi_dest =3D make_memop_idx(MO_UB, dest_idx);
-    TCGMemOpIdx oi_src =3D make_memop_idx(MO_UB, src_idx);
-    uint32_t len_adj;
-    void *src_p;
-    void *dest_p;
-    uint8_t x;
-
-    while (len > 0) {
-        src =3D wrap_address(env, src);
-        dest =3D wrap_address(env, dest);
-        src_p =3D tlb_vaddr_to_host(env, src, MMU_DATA_LOAD, src_idx);
-        dest_p =3D tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, dest_idx=
);
-
-        if (src_p && dest_p) {
-            /* Access to both whole pages granted.  */
-            len_adj =3D adj_len_to_page(adj_len_to_page(len, src), dest)=
;
-            memmove(dest_p, src_p, len_adj);
+static uint8_t access_get_byte(CPUS390XState *env, const S390Access *acc=
ess,
+                               int offset, uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    if (offset < access->size1) {
+        return ldub_p(access->haddr1 + offset);
+    } else {
+        return ldub_p(access->haddr2 + offset - access->size1);
+    }
+#else
+    TCGMemOpIdx oi =3D make_memop_idx(MO_UB, access->mmu_idx);
+
+    if (offset < access->size1) {
+        if (likely(access->haddr1)) {
+            return ldub_p(access->haddr1 + offset);
+        }
+        return helper_ret_ldub_mmu(env, access->vaddr1 + offset, oi, ra)=
;
+    }
+    if (access->haddr2) {
+        return ldub_p(access->haddr2 + offset - access->size1);
+    }
+    return helper_ret_ldub_mmu(env, access->vaddr2 + offset - access->si=
ze1, oi,
+                               ra);
+#endif
+}
+
+static void access_set_byte(CPUS390XState *env, const S390Access *access=
,
+                            int offset, uint8_t byte, uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    if (offset < access->size1) {
+        stb_p(access->haddr1 + offset, byte);
+    } else {
+        stb_p(access->haddr2 + offset - access->size1, byte);
+    }
+#else
+    TCGMemOpIdx oi =3D make_memop_idx(MO_UB, access->mmu_idx);
+
+    if (offset < access->size1) {
+        if (likely(access->haddr1)) {
+            stb_p(access->haddr1 + offset, byte);
         } else {
-            /* We failed to get access to one or both whole pages. The n=
ext
-               read or write access will likely fill the QEMU TLB for th=
e
-               next iteration.  */
-            len_adj =3D 1;
-            x =3D helper_ret_ldub_mmu(env, src, oi_src, ra);
-            helper_ret_stb_mmu(env, dest, x, oi_dest, ra);
+            helper_ret_stb_mmu(env, access->vaddr1 + offset, byte, oi, r=
a);
+        }
+    } else {
+        if (likely(access->haddr2)) {
+            stb_p(access->haddr2 + offset - access->size1, byte);
+        } else {
+            helper_ret_stb_mmu(env, access->vaddr2 + offset - access->si=
ze1,
+                               byte, oi, ra);
+        }
+    }
+#endif
+}
+
+/*
+ * Move data with the same semantics as memmove() in case ranges don't o=
verlap
+ * or src > dest. Undefined behavior on destructive overlaps.
+ */
+static void access_memmove_idx(CPUS390XState *env, vaddr dest, vaddr src=
,
+                               int size, int dest_idx, int src_idx,
+                               uintptr_t ra)
+{
+    S390Access srca =3D access_prepare_idx(env, src, size, MMU_DATA_LOAD=
, src_idx,
+                                         ra);
+    S390Access desta =3D access_prepare_idx(env, dest, size, MMU_DATA_ST=
ORE,
+                                          dest_idx, ra);
+    uint16_t diff;
+
+    /* Fallback to slow access in case we don't have access to all host =
pages */
+    if (unlikely(!desta.haddr1 || (desta.size2 && !desta.haddr2) ||
+                 !srca.haddr1 || (srca.size2 && !srca.haddr2))) {
+        uint8_t byte;
+        int i;
+
+        for (i =3D 0; i < desta.size1 + desta.size2; i++) {
+            byte =3D access_get_byte(env, &srca, i, ra);
+            access_set_byte(env, &desta, i, byte, ra);
         }
-        src +=3D len_adj;
-        dest +=3D len_adj;
-        len -=3D len_adj;
+        return;
+    }
+
+    if (srca.size1 =3D=3D desta.size1) {
+        memmove(desta.haddr1, srca.haddr1, srca.size1);
+        memmove(desta.haddr2, srca.haddr2, srca.size2);
+    } else if (srca.size1 < desta.size1) {
+        diff =3D desta.size1 - srca.size1;
+        memmove(desta.haddr1, srca.haddr1, srca.size1);
+        memmove(desta.haddr1 + srca.size1, srca.haddr2, diff);
+        memmove(desta.haddr2, srca.haddr2 + diff, desta.size2);
+    } else {
+        diff =3D srca.size1 - desta.size1;
+        memmove(desta.haddr1, srca.haddr1, desta.size1);
+        memmove(desta.haddr2, srca.haddr1 + desta.size1, diff);
+        memmove(desta.haddr2 + diff, srca.haddr2, srca.size2);
     }
 }
=20
+static void access_memmove(CPUS390XState *env, vaddr dest, vaddr src,
+                           int size, uintptr_t ra)
+{
+    int mmu_idx =3D cpu_mmu_index(env, false);
+
+    access_memmove_idx(env, dest, src, size, mmu_idx, mmu_idx, ra);
+}
+
 static int mmu_idx_from_as(uint8_t as)
 {
     switch (as) {
@@ -246,43 +307,14 @@ static int mmu_idx_from_as(uint8_t as)
     }
 }
=20
-static void fast_memmove_as(CPUS390XState *env, uint64_t dest, uint64_t =
src,
-                            uint32_t len, uint8_t dest_as, uint8_t src_a=
s,
-                            uintptr_t ra)
+static void access_memmove_as(CPUS390XState *env, uint64_t dest, uint64_=
t src,
+                              uint32_t len, uint8_t dest_as, uint8_t src=
_as,
+                              uintptr_t ra)
 {
     int src_idx =3D mmu_idx_from_as(src_as);
     int dest_idx =3D mmu_idx_from_as(dest_as);
=20
-    fast_memmove_idx(env, dest, src, len, dest_idx, src_idx, ra);
-}
-#endif
-
-static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src=
,
-                         uint32_t l, uintptr_t ra)
-{
-    int mmu_idx =3D cpu_mmu_index(env, false);
-
-    while (l > 0) {
-        void *src_p =3D tlb_vaddr_to_host(env, src, MMU_DATA_LOAD, mmu_i=
dx);
-        void *dest_p =3D tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, mm=
u_idx);
-        if (src_p && dest_p) {
-            /* Access to both whole pages granted.  */
-            uint32_t l_adj =3D adj_len_to_page(l, src);
-            l_adj =3D adj_len_to_page(l_adj, dest);
-            memmove(dest_p, src_p, l_adj);
-            src +=3D l_adj;
-            dest +=3D l_adj;
-            l -=3D l_adj;
-        } else {
-            /* We failed to get access to one or both whole pages. The n=
ext
-               read or write access will likely fill the QEMU TLB for th=
e
-               next iteration.  */
-            cpu_stb_data_ra(env, dest, cpu_ldub_data_ra(env, src, ra), r=
a);
-            src++;
-            dest++;
-            l--;
-        }
-    }
+    access_memmove_idx(env, dest, src, len, dest_idx, src_idx, ra);
 }
=20
 /* and on array */
@@ -386,7 +418,7 @@ static uint32_t do_helper_mvc(CPUS390XState *env, uin=
t32_t l, uint64_t dest,
     if (dest =3D=3D src + 1) {
         access_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
     } else if (!is_destructive_overlap(env, dest, src, l)) {
-        fast_memmove(env, dest, src, l, ra);
+        access_memmove(env, dest, src, l, ra);
     } else {
         for (i =3D 0; i < l; i++) {
             uint8_t x =3D cpu_ldub_data_ra(env, src + i, ra);
@@ -744,7 +776,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0=
, uint64_t r1, uint64_t r2)
      * - CC-option with surpression of page-translation exceptions
      * - Store r1/r2 register identifiers at real location 162
      */
-    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE, GETPC());
+    access_memmove(env, r1, r2, TARGET_PAGE_SIZE, GETPC());
     return 0; /* data moved */
 }
=20
@@ -847,7 +879,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
         len =3D MIN(len, *srclen);
         *destlen -=3D len;
         *srclen -=3D len;
-        fast_memmove(env, *dest, *src, len, ra);
+        access_memmove(env, *dest, *src, len, ra);
         *src =3D wrap_address(env, *src + len);
         *dest =3D wrap_address(env, *dest + len);
     } else if (wordsize =3D=3D 1) {
@@ -911,7 +943,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1=
, uint32_t r2)
         } else {
             cur_len =3D MIN(cur_len, srclen);
=20
-            fast_memmove(env, dest, src, cur_len, ra);
+            access_memmove(env, dest, src, cur_len, ra);
             src =3D wrap_address(env, src + cur_len);
             srclen -=3D cur_len;
             env->regs[r2 + 1] =3D deposit64(env->regs[r2 + 1], 0, 24, sr=
clen);
@@ -2453,16 +2485,10 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64=
_t dest, uint64_t src,
         s390_program_interrupt(env, PGM_ADDRESSING, 6, ra);
     }
=20
-    /* FIXME: a) LAP
-     *        b) Access using correct keys
-     *        c) AR-mode
-     */
-#ifdef CONFIG_USER_ONLY
-    /* psw keys are never valid in user mode, we will never reach this *=
/
-    g_assert_not_reached();
-#else
-    fast_memmove_as(env, dest, src, len, dest_as, src_as, ra);
-#endif
+    /* FIXME: Access using correct keys and AR-mode */
+    if (len) {
+        access_memmove_as(env, dest, src, len, dest_as, src_as, ra);
+    }
=20
     return cc;
 }
--=20
2.21.0


