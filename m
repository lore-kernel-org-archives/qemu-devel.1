Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF069C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9413B20830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9413B20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rsj-0000xn-AB
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i9rX5-0003KL-KK
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i9rX3-0000R3-Jt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i9rX3-0000Qn-8x; Mon, 16 Sep 2019 09:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9318086E86F;
 Mon, 16 Sep 2019 13:59:08 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A29110013A1;
 Mon, 16 Sep 2019 13:59:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:57:53 +0200
Message-Id: <20190916135806.1269-17-david@redhat.com>
In-Reply-To: <20190916135806.1269-1-david@redhat.com>
References: <20190916135806.1269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 16 Sep 2019 13:59:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 16/29] s390x/tcg: Fault-safe memset
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
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace fast_memset() by access_memset(), that first tries to probe
access to all affected pages (maximum is two). We'll use the same
mechanism for other types of accesses soon.

Only in very rare cases (especially TLB_NOTDIRTY), we'll have to
fallback to ld/st helpers. Try to speed up that case as suggested by
Richard.

We'll rework most involved handlers soon to do all accesses via new
fault-safe helpers, especially MVC.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 123 +++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 20 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a24506676b..dd5da70746 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -117,27 +117,95 @@ static inline void cpu_stsize_data_ra(CPUS390XState=
 *env, uint64_t addr,
     }
 }
=20
-static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
-                        uint32_t l, uintptr_t ra)
+/* An access covers at most 4096 bytes and therefore at most two pages. =
*/
+typedef struct S390Access {
+    target_ulong vaddr1;
+    target_ulong vaddr2;
+    char *haddr1;
+    char *haddr2;
+    uint16_t size1;
+    uint16_t size2;
+    /*
+     * If we can't access the host page directly, we'll have to do I/O a=
ccess
+     * via ld/st helpers. These are internal details, so we store the
+     * mmu idx to do the access here instead of passing it around in the
+     * helpers. Maybe, one day we can get rid of ld/st access - once we =
can
+     * handle TLB_NOTDIRTY differently. We don't expect these special ac=
cesses
+     * to trigger exceptions - only if we would have TLB_NOTDIRTY on LAP
+     * pages, we might trigger a new MMU translation - very unlikely tha=
t
+     * the mapping changes in between and we would trigger a fault.
+     */
+    int mmu_idx;
+} S390Access;
+
+static S390Access access_prepare(CPUS390XState *env, vaddr vaddr, int si=
ze,
+                                 MMUAccessType access_type, int mmu_idx,
+                                 uintptr_t ra)
 {
-    int mmu_idx =3D cpu_mmu_index(env, false);
+    S390Access access =3D {
+        .vaddr1 =3D vaddr,
+        .size1 =3D MIN(size, -(vaddr | TARGET_PAGE_MASK)),
+        .mmu_idx =3D mmu_idx,
+    };
=20
-    while (l > 0) {
-        void *p =3D tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, mmu_idx=
);
-        if (p) {
-            /* Access to the whole page in write mode granted.  */
-            uint32_t l_adj =3D adj_len_to_page(l, dest);
-            memset(p, byte, l_adj);
-            dest +=3D l_adj;
-            l -=3D l_adj;
+    g_assert(size > 0 && size <=3D 4096);
+    access.haddr1 =3D probe_access(env, access.vaddr1, access.size1, acc=
ess_type,
+                                 mmu_idx, ra);
+
+    if (unlikely(access.size1 !=3D size)) {
+        /* The access crosses page boundaries. */
+        access.vaddr2 =3D wrap_address(env, vaddr + access.size1);
+        access.size2 =3D size - access.size1;
+        access.haddr2 =3D probe_access(env, access.vaddr2, access.size2,
+                                     access_type, mmu_idx, ra);
+    }
+    return access;
+}
+
+/* Helper to handle memset on a single page. */
+static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *hadd=
r,
+                             uint8_t byte, uint16_t size, int mmu_idx,
+                             uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    g_assert(haddr);
+    memset(haddr, byte, size);
+#else
+    TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
+    int i;
+
+    if (likely(haddr)) {
+        memset(haddr, byte, size);
+    } else {
+        /*
+         * Do a single access and test if we can then get access to the
+         * page. This is especially relevant to speed up TLB_NOTDIRTY.
+         */
+        g_assert(size > 0);
+        helper_ret_stb_mmu(env, vaddr, byte, oi, ra);
+        haddr =3D tlb_vaddr_to_host(env, vaddr, MMU_DATA_STORE, mmu_idx)=
;
+        if (likely(haddr)) {
+            memset(haddr + 1, byte, size - 1);
         } else {
-            /* We failed to get access to the whole page. The next write
-               access will likely fill the QEMU TLB for the next iterati=
on.  */
-            cpu_stb_data_ra(env, dest, byte, ra);
-            dest++;
-            l--;
+            for (i =3D 1; i < size; i++) {
+                helper_ret_stb_mmu(env, vaddr + i, byte, oi, ra);
+            }
         }
     }
+#endif
+}
+
+static void access_memset(CPUS390XState *env, S390Access *desta,
+                          uint8_t byte, uintptr_t ra)
+{
+
+    do_access_memset(env, desta->vaddr1, desta->haddr1, byte, desta->siz=
e1,
+                     desta->mmu_idx, ra);
+    if (likely(!desta->size2)) {
+        return;
+    }
+    do_access_memset(env, desta->vaddr2, desta->haddr2, byte, desta->siz=
e2,
+                     desta->mmu_idx, ra);
 }
=20
 #ifndef CONFIG_USER_ONLY
@@ -259,15 +327,19 @@ uint32_t HELPER(nc)(CPUS390XState *env, uint32_t l,=
 uint64_t dest,
 static uint32_t do_helper_xc(CPUS390XState *env, uint32_t l, uint64_t de=
st,
                              uint64_t src, uintptr_t ra)
 {
+    const int mmu_idx =3D cpu_mmu_index(env, false);
+    S390Access desta;
     uint32_t i;
     uint8_t c =3D 0;
=20
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
=20
+    desta =3D access_prepare(env, dest, l + 1, MMU_DATA_STORE, mmu_idx, =
ra);
+
     /* xor with itself is the same as memset(0) */
     if (src =3D=3D dest) {
-        fast_memset(env, dest, 0, l + 1, ra);
+        access_memset(env, &desta, 0, ra);
         return 0;
     }
=20
@@ -315,6 +387,8 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, u=
int64_t dest,
 static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t d=
est,
                               uint64_t src, uintptr_t ra)
 {
+    const int mmu_idx =3D cpu_mmu_index(env, false);
+    S390Access desta;
     uint32_t i;
=20
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
@@ -323,13 +397,15 @@ static uint32_t do_helper_mvc(CPUS390XState *env, u=
int32_t l, uint64_t dest,
     /* MVC always copies one more byte than specified - maximum is 256 *=
/
     l++;
=20
+    desta =3D access_prepare(env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+
     /*
      * "When the operands overlap, the result is obtained as if the oper=
ands
      * were processed one byte at a time". Only non-destructive overlaps
      * behave like memmove().
      */
     if (dest =3D=3D src + 1) {
-        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
+        access_memset(env, &desta, cpu_ldub_data_ra(env, src, ra), ra);
     } else if (!is_destructive_overlap(env, dest, src, l)) {
         fast_memmove(env, dest, src, l, ra);
     } else {
@@ -775,7 +851,9 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
                                uint64_t *src, uint64_t *srclen,
                                uint16_t pad, int wordsize, uintptr_t ra)
 {
+    const int mmu_idx =3D cpu_mmu_index(env, false);
     int len =3D MIN(*destlen, -(*dest | TARGET_PAGE_MASK));
+    S390Access desta;
     int i, cc;
=20
     if (*destlen =3D=3D *srclen) {
@@ -805,7 +883,8 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
     } else if (wordsize =3D=3D 1) {
         /* Pad the remaining area */
         *destlen -=3D len;
-        fast_memset(env, *dest, pad, len, ra);
+        desta =3D access_prepare(env, *dest, len, MMU_DATA_STORE, mmu_id=
x, ra);
+        access_memset(env, &desta, pad, ra);
         *dest =3D wrap_address(env, *dest + len);
     } else {
         /* The remaining length selects the padding byte. */
@@ -825,6 +904,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
 /* move long */
 uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
+    const int mmu_idx =3D cpu_mmu_index(env, false);
     uintptr_t ra =3D GETPC();
     uint64_t destlen =3D env->regs[r1 + 1] & 0xffffff;
     uint64_t dest =3D get_address(env, r1);
@@ -832,6 +912,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1=
, uint32_t r2)
     uint64_t src =3D get_address(env, r2);
     uint8_t pad =3D env->regs[r2 + 1] >> 24;
     uint32_t cc, cur_len;
+    S390Access desta;
=20
     if (is_destructive_overlap(env, dest, src, MIN(srclen, destlen))) {
         cc =3D 3;
@@ -859,7 +940,9 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1=
, uint32_t r2)
     while (destlen) {
         cur_len =3D MIN(destlen, -(dest | TARGET_PAGE_MASK));
         if (!srclen) {
-            fast_memset(env, dest, pad, cur_len, ra);
+            desta =3D access_prepare(env, dest, cur_len, MMU_DATA_STORE,=
 mmu_idx,
+                                   ra);
+            access_memset(env, &desta, pad, ra);
         } else {
             cur_len =3D MIN(MIN(srclen, -(src | TARGET_PAGE_MASK)), cur_=
len);
=20
--=20
2.21.0


