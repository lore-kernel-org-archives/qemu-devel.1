Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E173C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095A6206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69Nt-0006Y0-NT
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i698e-00046I-Tg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i698d-0003Pc-GI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i698d-0003P4-8L; Fri, 06 Sep 2019 03:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EF7510F23EC;
 Fri,  6 Sep 2019 07:58:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A33991001284;
 Fri,  6 Sep 2019 07:58:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:37 +0200
Message-Id: <20190906075750.14791-16-david@redhat.com>
In-Reply-To: <20190906075750.14791-1-david@redhat.com>
References: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 06 Sep 2019 07:58:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 15/28] s390x/tcg: Fault-safe memset
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

Replace fast_memset() by access_memset(), that first tries to probe
access to all affected pages (maximum is two). We'll use the same
mechanism for other types of accesses soon.

Only in very rare cases (especially TLB_NOTDIRTY), we'll have to
fallback to ld/st helpers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 99 ++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 22 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 8dd58b3ab1..8d654b24e7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -117,27 +117,82 @@ static inline void cpu_stsize_data_ra(CPUS390XState=
 *env, uint64_t addr,
     }
 }
=20
-static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
-                        uint32_t l, uintptr_t ra)
-{
-    int mmu_idx =3D cpu_mmu_index(env, false);
+/*
+ * An access covers at most 4096 bytes and therefore at most two pages. =
If
+ * we can't access the host page directly, we'll have to do I/O access
+ * via ld/st helpers.
+ */
+typedef struct S390Access {
+    target_ulong vaddr1;
+    target_ulong vaddr2;
+    char *haddr1;
+    char *haddr2;
+    uint16_t size1;
+    uint16_t size2;
+} S390Access;
+
+static S390Access access_prepare_idx(CPUS390XState *env, vaddr vaddr, in=
t size,
+                                     MMUAccessType access_type, int mmu_=
idx,
+                                     uintptr_t ra)
+{
+    S390Access access =3D {
+        .vaddr1 =3D vaddr,
+        .size1 =3D MIN(size, -(vaddr | TARGET_PAGE_MASK)),
+    };
+
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
+static void access_memset_idx(CPUS390XState *env, vaddr vaddr, uint8_t b=
yte,
+                              int size, int mmu_idx, uintptr_t ra)
+{
+    S390Access desta =3D access_prepare_idx(env, vaddr, size, MMU_DATA_S=
TORE,
+                                          mmu_idx, ra);
+#ifdef CONFIG_USER_ONLY
+    g_assert(desta.haddr1 && (desta.haddr2 || !desta.size2));
+    memset(desta.haddr1, byte, desta.size1);
+    memset(desta.haddr2, byte, desta.size2);
+#else
+    TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
+    int i;
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
-        } else {
-            /* We failed to get access to the whole page. The next write
-               access will likely fill the QEMU TLB for the next iterati=
on.  */
-            cpu_stb_data_ra(env, dest, byte, ra);
-            dest++;
-            l--;
+    if (likely(desta.haddr1)) {
+        memset(desta.haddr1, byte, desta.size1);
+    } else {
+        for (i =3D 0; i < desta.size1; i++) {
+            helper_ret_stb_mmu(env, desta.vaddr1 + i, byte, oi, ra);
+        }
+    }
+    if (likely(!desta.size2)) {
+        return;
+    }
+    if (likely(desta.haddr2)) {
+            memset(desta.haddr2, byte, desta.size2);
+    } else {
+        for (i =3D 0; i < desta.size2; i++) {
+            helper_ret_stb_mmu(env, desta.vaddr2 + i, byte, oi, ra);
         }
     }
+#endif
+}
+
+static void access_memset(CPUS390XState *env, vaddr vaddr, uint8_t byte,
+                          int size, uintptr_t ra)
+{
+    int mmu_idx =3D cpu_mmu_index(env, false);
+
+    access_memset_idx(env, vaddr, byte, size, mmu_idx, ra);
 }
=20
 #ifndef CONFIG_USER_ONLY
@@ -267,7 +322,7 @@ static uint32_t do_helper_xc(CPUS390XState *env, uint=
32_t l, uint64_t dest,
=20
     /* xor with itself is the same as memset(0) */
     if (src =3D=3D dest) {
-        fast_memset(env, dest, 0, l + 1, ra);
+        access_memset(env, dest, 0, l + 1, ra);
         return 0;
     }
=20
@@ -329,7 +384,7 @@ static uint32_t do_helper_mvc(CPUS390XState *env, uin=
t32_t l, uint64_t dest,
      * behave like memmove().
      */
     if (dest =3D=3D src + 1) {
-        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
+        access_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
     } else if (!is_destructive_overlap(env, dest, src, l)) {
         fast_memmove(env, dest, src, l, ra);
     } else {
@@ -798,7 +853,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
     } else if (wordsize =3D=3D 1) {
         /* Pad the remaining area */
         *destlen -=3D len;
-        fast_memset(env, *dest, pad, len, ra);
+        access_memset(env, *dest, pad, len, ra);
         *dest =3D wrap_address(env, *dest + len);
     } else {
         /* The remaining length selects the padding byte. */
@@ -852,7 +907,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1=
, uint32_t r2)
     while (destlen) {
         cur_len =3D MIN(destlen, 2048);
         if (!srclen) {
-            fast_memset(env, dest, pad, cur_len, ra);
+            access_memset(env, dest, pad, cur_len, ra);
         } else {
             cur_len =3D MIN(cur_len, srclen);
=20
--=20
2.21.0


