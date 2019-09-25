Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1179C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3B721D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3B721D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7GO-0003CN-Ok
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iD6mt-0006Rq-7q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iD6mr-000466-Qd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:52:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iD6mr-00045k-IR; Wed, 25 Sep 2019 08:52:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF91F18C8935;
 Wed, 25 Sep 2019 12:52:52 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-14.ams2.redhat.com [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03D3A600C8;
 Wed, 25 Sep 2019 12:52:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] s390x/mmu: Inject DAT exceptions from a single place
Date: Wed, 25 Sep 2019 14:52:32 +0200
Message-Id: <20190925125236.4043-4-david@redhat.com>
In-Reply-To: <20190925125236.4043-1-david@redhat.com>
References: <20190925125236.4043-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 25 Sep 2019 12:52:52 +0000 (UTC)
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

Let's return the PGM from the translation functions on error and inject
based on that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 63 +++++++++++----------------------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 847fb240fb..f6ae444655 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -48,26 +48,6 @@ static void trigger_access_exception(CPUS390XState *en=
v, uint32_t type,
     }
 }
=20
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
@@ -119,12 +99,10 @@ static int mmu_translate_pte(CPUS390XState *env, tar=
get_ulong vaddr,
                              target_ulong *raddr, int *flags, int rw, bo=
ol exc)
 {
     if (pt_entry & PAGE_INVALID) {
-        trigger_page_fault(env, vaddr, PGM_PAGE_TRANS, asc, rw, exc);
-        return -1;
+        return PGM_PAGE_TRANS;
     }
     if (pt_entry & PAGE_RES0) {
-        trigger_page_fault(env, vaddr, PGM_TRANS_SPEC, asc, rw, exc);
-        return -1;
+        return PGM_TRANS_SPEC;
     }
     if (pt_entry & PAGE_RO) {
         *flags &=3D ~PAGE_WRITE;
@@ -179,13 +157,11 @@ static int mmu_translate_region(CPUS390XState *env,=
 target_ulong vaddr,
     new_entry =3D ldq_phys(cs->as, origin + offs);
=20
     if ((new_entry & REGION_ENTRY_INV) !=3D 0) {
-        trigger_page_fault(env, vaddr, pchks[level / 4], asc, rw, exc);
-        return -1;
+        return pchks[level / 4];
     }
=20
     if ((new_entry & REGION_ENTRY_TYPE_MASK) !=3D level) {
-        trigger_page_fault(env, vaddr, PGM_TRANS_SPEC, asc, rw, exc);
-        return -1;
+        return PGM_TRANS_SPEC;
     }
=20
     if (level =3D=3D ASCE_TYPE_SEGMENT) {
@@ -197,8 +173,7 @@ static int mmu_translate_region(CPUS390XState *env, t=
arget_ulong vaddr,
     offs =3D (vaddr >> (28 + 11 * (level - 4) / 4)) & 3;
     if (offs < ((new_entry & REGION_ENTRY_TF) >> 6)
         || offs > (new_entry & REGION_ENTRY_LENGTH)) {
-        trigger_page_fault(env, vaddr, pchks[level / 4 - 1], asc, rw, ex=
c);
-        return -1;
+        return pchks[level / 4 - 1];
     }
=20
     if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_RO)) {
@@ -226,38 +201,31 @@ static int mmu_translate_asce(CPUS390XState *env, t=
arget_ulong vaddr,
     switch (level) {
     case ASCE_TYPE_REGION1:
         if ((vaddr >> 62) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_REG_FIRST_TRANS, asc, rw,=
 exc);
-            return -1;
+            return PGM_REG_FIRST_TRANS;
         }
         break;
     case ASCE_TYPE_REGION2:
         if (vaddr & 0xffe0000000000000ULL) {
-            trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
-            return -1;
+            return PGM_ASCE_TYPE;
         }
         if ((vaddr >> 51 & 3) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_REG_SEC_TRANS, asc, rw, e=
xc);
-            return -1;
+            return PGM_REG_SEC_TRANS;
         }
         break;
     case ASCE_TYPE_REGION3:
         if (vaddr & 0xfffffc0000000000ULL) {
-            trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
-            return -1;
+            return PGM_ASCE_TYPE;
         }
         if ((vaddr >> 40 & 3) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_REG_THIRD_TRANS, asc, rw,=
 exc);
-            return -1;
+            return PGM_REG_THIRD_TRANS;
         }
         break;
     case ASCE_TYPE_SEGMENT:
         if (vaddr & 0xffffffff80000000ULL) {
-            trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
-            return -1;
+            return PGM_ASCE_TYPE;
         }
         if ((vaddr >> 29 & 3) > (asce & ASCE_TABLE_LENGTH)) {
-            trigger_page_fault(env, vaddr, PGM_SEGMENT_TRANS, asc, rw, e=
xc);
-            return -1;
+            return PGM_SEGMENT_TRANS;
         }
         break;
     }
@@ -400,8 +368,11 @@ int mmu_translate(CPUS390XState *env, target_ulong v=
addr, int rw, uint64_t asc,
=20
     /* perform the DAT translation */
     r =3D mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw, ex=
c);
-    if (r) {
-        return r;
+    if (unlikely(r)) {
+        if (exc) {
+            trigger_access_exception(env, r, ilen, tec);
+        }
+        return -1;
     }
=20
     /* check for DAT protection */
--=20
2.21.0


