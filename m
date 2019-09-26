Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDFAC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3545820872
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3545820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQri-00060i-Fe
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDQpG-0004GY-IJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDQpF-0007hp-CW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDQpF-0007hM-4J; Thu, 26 Sep 2019 06:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58E863082131;
 Thu, 26 Sep 2019 10:16:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80D6860A9F;
 Thu, 26 Sep 2019 10:16:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/5] s390x/mmu: Implement Instruction-Execution-Protection
 Facility
Date: Thu, 26 Sep 2019 12:16:25 +0200
Message-Id: <20190926101627.23376-4-david@redhat.com>
In-Reply-To: <20190926101627.23376-1-david@redhat.com>
References: <20190926101627.23376-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 26 Sep 2019 10:16:40 +0000 (UTC)
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

IEP support in the mmu is fairly easy. Set the right permissions for TLB
entries and properly report an exception.

Make sure to handle EDAT-2 by setting bit 56/60/61 of the TEID (TEC) to
the right values.

Let's keep s390_cpu_get_phys_page_debug() working even if IEP is
active. Switch MMU_DATA_LOAD - this has no other effects any more as the
ASC to be used is now fully selected outside of mmu_translate().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        |  1 +
 target/s390x/helper.c     |  6 +++++-
 target/s390x/mmu_helper.c | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 690b94c8ea..6eb7c07013 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -315,6 +315,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define CR0_EDAT                0x0000000000800000ULL
 #define CR0_AFP                 0x0000000000040000ULL
 #define CR0_VECTOR              0x0000000000020000ULL
+#define CR0_IEP                 0x0000000000100000ULL
 #define CR0_EMERGENCY_SIGNAL_SC 0x0000000000004000ULL
 #define CR0_EXTERNAL_CALL_SC    0x0000000000002000ULL
 #define CR0_CKC_SC              0x0000000000000800ULL
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 948c0398d4..bf503b56ee 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -63,7 +63,11 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vadd=
r vaddr)
         asc =3D PSW_ASC_PRIMARY;
     }
=20
-    if (mmu_translate(env, vaddr, MMU_INST_FETCH, asc, &raddr, &prot, fa=
lse)) {
+    /*
+     * We want to read code even if IEP is active. Use MMU_DATA_LOAD ins=
tead
+     * of MMU_INST_FETCH.
+     */
+    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, fal=
se)) {
         return -1;
     }
     return raddr;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 8abc5d31d8..ff8b077f82 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -121,6 +121,8 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
     const bool edat1 =3D (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
     const bool edat2 =3D edat1 && s390_has_feat(S390_FEAT_EDAT_2);
+    const bool iep =3D (env->cregs[0] & CR0_IEP) &&
+                     s390_has_feat(S390_FEAT_INSTRUCTION_EXEC_PROT);
     const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
     const int asce_p =3D asce & ASCE_PRIVATE_SPACE;
     hwaddr gaddr =3D asce & ASCE_ORIGIN;
@@ -227,6 +229,9 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
             *flags &=3D ~PAGE_WRITE;
         }
         if (edat2 && (entry & REGION3_ENTRY_FC)) {
+            if (iep && (entry & REGION3_ENTRY_IEP)) {
+                *flags &=3D ~PAGE_EXEC;
+            }
             *raddr =3D (entry & REGION3_ENTRY_RFAA) |
                      (vaddr & REGION3_ENTRY_RFAA);
             return 0;
@@ -254,6 +259,9 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
             *flags &=3D ~PAGE_WRITE;
         }
         if (edat1 && (entry & SEGMENT_ENTRY_FC)) {
+            if (iep && (entry & SEGMENT_ENTRY_IEP)) {
+                *flags &=3D ~PAGE_EXEC;
+            }
             *raddr =3D (entry & SEGMENT_ENTRY_SFAA) |
                      (vaddr & ~SEGMENT_ENTRY_SFAA);
             return 0;
@@ -276,6 +284,9 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
     if (entry & PAGE_ENTRY_P) {
         *flags &=3D ~PAGE_WRITE;
     }
+    if (iep && (entry & PAGE_ENTRY_IEP)) {
+        *flags &=3D ~PAGE_EXEC;
+    }
=20
     *raddr =3D entry & TARGET_PAGE_MASK;
     return 0;
@@ -434,6 +445,16 @@ int mmu_translate(CPUS390XState *env, target_ulong v=
addr, int rw, uint64_t asc,
         return -1;
     }
=20
+    /* check for Instruction-Execution-Protection */
+    if (unlikely(rw =3D=3D MMU_INST_FETCH && !(*flags & PAGE_EXEC))) {
+        if (exc) {
+            /* IEP sets bit 56 and 61 */
+            tec |=3D 0x84;
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


