Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7547120867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7547120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLuz-0004wh-E0
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iGLBb-00073S-9X
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iGLBW-00056o-LB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iGLBR-00052r-JB; Fri, 04 Oct 2019 06:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4838E18CB906;
 Fri,  4 Oct 2019 10:51:35 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A416C5D6B2;
 Fri,  4 Oct 2019 10:51:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/7] s390x/mmu: Convert to non-recursive page table walk
Date: Fri,  4 Oct 2019 12:51:02 +0200
Message-Id: <20191004105102.15821-8-david@redhat.com>
In-Reply-To: <20191004105102.15821-1-david@redhat.com>
References: <20191004105102.15821-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 04 Oct 2019 10:51:35 +0000 (UTC)
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
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A non-recursive implementation allows to make better use of the
branch predictor, avoids function calls, and makes the implementation of
new features only for a subset of region table levels easier.

We can now directly compare our implementation to the KVM gaccess
implementation in arch/s390/kvm/gaccess.c:guest_translate().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 208 ++++++++++++++++++++------------------
 1 file changed, 108 insertions(+), 100 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index a114fb1628..dc33c63b1d 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -114,107 +114,16 @@ static inline bool read_table_entry(CPUS390XState =
*env, hwaddr gaddr,
     return true;
 }
=20
-/* Decode page table entry (normal 4KB page) */
-static int mmu_translate_pte(CPUS390XState *env, target_ulong vaddr,
-                             uint64_t asc, uint64_t pt_entry,
-                             target_ulong *raddr, int *flags, int rw, bo=
ol exc)
-{
-    if (pt_entry & PAGE_ENTRY_I) {
-        return PGM_PAGE_TRANS;
-    }
-    if (pt_entry & PAGE_ENTRY_0) {
-        return PGM_TRANS_SPEC;
-    }
-    if (pt_entry & PAGE_ENTRY_P) {
-        *flags &=3D ~PAGE_WRITE;
-    }
-
-    *raddr =3D pt_entry & TARGET_PAGE_MASK;
-    return 0;
-}
-
-/* Decode segment table entry */
-static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
-                                 uint64_t asc, uint64_t st_entry,
-                                 target_ulong *raddr, int *flags, int rw=
,
-                                 bool exc)
-{
-    uint64_t origin, offs, pt_entry;
-
-    if (st_entry & SEGMENT_ENTRY_P) {
-        *flags &=3D ~PAGE_WRITE;
-    }
-
-    if ((st_entry & SEGMENT_ENTRY_FC) && (env->cregs[0] & CR0_EDAT)) {
-        /* Decode EDAT1 segment frame absolute address (1MB page) */
-        *raddr =3D (st_entry & SEGMENT_ENTRY_SFAA) |
-                 (vaddr & ~SEGMENT_ENTRY_SFAA);
-        return 0;
-    }
-
-    /* Look up 4KB page entry */
-    origin =3D st_entry & SEGMENT_ENTRY_ORIGIN;
-    offs =3D VADDR_PAGE_TX(vaddr) * 8;
-    if (!read_table_entry(env, origin + offs, &pt_entry)) {
-        return PGM_ADDRESSING;
-    }
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
-    uint64_t origin, offs, new_entry;
-    const int pchks[4] =3D {
-        PGM_SEGMENT_TRANS, PGM_REG_THIRD_TRANS,
-        PGM_REG_SEC_TRANS, PGM_REG_FIRST_TRANS
-    };
-
-    origin =3D entry & REGION_ENTRY_ORIGIN;
-    offs =3D (vaddr >> (17 + 11 * level / 4)) & 0x3ff8;
-
-    if (!read_table_entry(env, origin + offs, &new_entry)) {
-        return PGM_ADDRESSING;
-    }
-
-    if (new_entry & REGION_ENTRY_I) {
-        return pchks[level / 4];
-    }
-
-    if ((new_entry & REGION_ENTRY_TT) !=3D level) {
-        return PGM_TRANS_SPEC;
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
-        || offs > (new_entry & REGION_ENTRY_TL)) {
-        return pchks[level / 4 - 1];
-    }
-
-    if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_P)) {
-        *flags &=3D ~PAGE_WRITE;
-    }
-
-    /* yet another region */
-    return mmu_translate_region(env, vaddr, asc, new_entry, level - 4,
-                                raddr, flags, rw, exc);
-}
-
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
                               uint64_t asc, uint64_t asce, target_ulong =
*raddr,
                               int *flags, int rw, bool exc)
 {
+    const bool edat1 =3D (env->cregs[0] & CR0_EDAT) &&
+                       s390_has_feat(S390_FEAT_EDAT);
     const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
-    int level;
+    const int asce_p =3D asce & ASCE_PRIVATE_SPACE;
+    hwaddr gaddr =3D asce & ASCE_ORIGIN;
+    uint64_t entry;
=20
     if (asce & ASCE_REAL_SPACE) {
         /* direct mapping */
@@ -222,12 +131,12 @@ static int mmu_translate_asce(CPUS390XState *env, t=
arget_ulong vaddr,
         return 0;
     }
=20
-    level =3D asce & ASCE_TYPE_MASK;
-    switch (level) {
+    switch (asce & ASCE_TYPE_MASK) {
     case ASCE_TYPE_REGION1:
         if (VADDR_REGION1_TL(vaddr) > asce_tl) {
             return PGM_REG_FIRST_TRANS;
         }
+        gaddr +=3D VADDR_REGION1_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_REGION2:
         if (VADDR_REGION1_TX(vaddr)) {
@@ -236,6 +145,7 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
         if (VADDR_REGION2_TL(vaddr) > asce_tl) {
             return PGM_REG_SEC_TRANS;
         }
+        gaddr +=3D VADDR_REGION2_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_REGION3:
         if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr)) {
@@ -244,6 +154,7 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
         if (VADDR_REGION3_TL(vaddr) > asce_tl) {
             return PGM_REG_THIRD_TRANS;
         }
+        gaddr +=3D VADDR_REGION3_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_SEGMENT:
         if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr) ||
@@ -253,11 +164,108 @@ static int mmu_translate_asce(CPUS390XState *env, =
target_ulong vaddr,
         if (VADDR_SEGMENT_TL(vaddr) > asce_tl) {
             return PGM_SEGMENT_TRANS;
         }
+        gaddr +=3D VADDR_SEGMENT_TX(vaddr) * 8;
+        break;
+    }
+
+    switch (asce & ASCE_TYPE_MASK) {
+    case ASCE_TYPE_REGION1:
+        if (!read_table_entry(env, gaddr, &entry)) {
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
+        /* fall through */
+    case ASCE_TYPE_REGION2:
+        if (!read_table_entry(env, gaddr, &entry)) {
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
+        /* fall through */
+    case ASCE_TYPE_REGION3:
+        if (!read_table_entry(env, gaddr, &entry)) {
+            return PGM_ADDRESSING;
+        }
+        if (entry & REGION_ENTRY_I) {
+            return PGM_REG_THIRD_TRANS;
+        }
+        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION3) {
+            return PGM_TRANS_SPEC;
+        }
+        if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
+            VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
+            return PGM_SEGMENT_TRANS;
+        }
+        if (edat1 && (entry & REGION_ENTRY_P)) {
+            *flags &=3D ~PAGE_WRITE;
+        }
+        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_SEGMENT_TX(vaddr=
) * 8;
+        /* fall through */
+    case ASCE_TYPE_SEGMENT:
+        if (!read_table_entry(env, gaddr, &entry)) {
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
+            *raddr =3D (entry & SEGMENT_ENTRY_SFAA) |
+                     (vaddr & ~SEGMENT_ENTRY_SFAA);
+            return 0;
+        }
+        gaddr =3D (entry & SEGMENT_ENTRY_ORIGIN) + VADDR_PAGE_TX(vaddr) =
* 8;
         break;
     }
=20
-    return mmu_translate_region(env, vaddr, asc, asce, level, raddr, fla=
gs, rw,
-                                exc);
+    if (!read_table_entry(env, gaddr, &entry)) {
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
+    }
+
+    *raddr =3D entry & TARGET_PAGE_MASK;
+    return 0;
 }
=20
 static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
--=20
2.21.0


