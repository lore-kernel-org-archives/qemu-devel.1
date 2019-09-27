Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D9C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212782146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212782146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrtE-00037W-9X
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDqPr-0008Pu-8J
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDqPq-0002UG-0M
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDqPp-0002U7-OD; Fri, 27 Sep 2019 09:36:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 563B9C05E740;
 Fri, 27 Sep 2019 09:58:45 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4BE1001281;
 Fri, 27 Sep 2019 09:58:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] s390x/mmu: Move DAT protection handling out of
 mmu_translate_asce()
Date: Fri, 27 Sep 2019 11:58:26 +0200
Message-Id: <20190927095831.23543-3-david@redhat.com>
In-Reply-To: <20190927095831.23543-1-david@redhat.com>
References: <20190927095831.23543-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 27 Sep 2019 09:58:45 +0000 (UTC)
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
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll reuse the ilen and tec definitions in mmu_translate
soon also for all other DAT exceptions we inject. Move it to the caller,
where we can later pair it up with other protection checks, like IEP.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 6a7ad33c4d..847fb240fb 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -48,20 +48,6 @@ static void trigger_access_exception(CPUS390XState *en=
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
-    if (!exc) {
-        return;
-    }
-
-    trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, tec);
-}
-
 static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
                                uint32_t type, uint64_t asc, int rw, bool=
 exc)
 {
@@ -229,7 +215,6 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
                               int *flags, int rw, bool exc)
 {
     int level;
-    int r;
=20
     if (asce & ASCE_REAL_SPACE) {
         /* direct mapping */
@@ -277,14 +262,8 @@ static int mmu_translate_asce(CPUS390XState *env, ta=
rget_ulong vaddr,
         break;
     }
=20
-    r =3D mmu_translate_region(env, vaddr, asc, asce, level, raddr, flag=
s, rw,
-                             exc);
-    if (!r && rw =3D=3D MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
-        trigger_prot_fault(env, vaddr, asc, rw, exc);
-        return -1;
-    }
-
-    return r;
+    return mmu_translate_region(env, vaddr, asc, asce, level, raddr, fla=
gs, rw,
+                                exc);
 }
=20
 static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
@@ -369,6 +348,10 @@ static void mmu_handle_skey(target_ulong addr, int r=
w, int *flags)
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64=
_t asc,
                   target_ulong *raddr, int *flags, bool exc)
 {
+    /* Code accesses have an undefined ilc, let's use 2 bytes. */
+    const int ilen =3D (rw =3D=3D MMU_INST_FETCH) ? 2 : ILEN_AUTO;
+    uint64_t tec =3D (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
+                   (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ);
     uint64_t asce;
     int r;
=20
@@ -421,6 +404,16 @@ int mmu_translate(CPUS390XState *env, target_ulong v=
addr, int rw, uint64_t asc,
         return r;
     }
=20
+    /* check for DAT protection */
+    if (unlikely(rw =3D=3D MMU_DATA_STORE && !(*flags & PAGE_WRITE))) {
+        if (exc) {
+            /* DAT sets bit 61 only */
+            tec |=3D 0x4;
+            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
+        }
+        return -1;
+    }
+
 nodat:
     /* Convert real address -> absolute address */
     *raddr =3D mmu_real2abs(env, *raddr);
--=20
2.21.0


