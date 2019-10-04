Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B2C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229E22070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229E22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLrD-0001RG-7n
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iGLBC-0006vZ-5w
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iGLBB-0004tb-08
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iGLBA-0004tH-Of; Fri, 04 Oct 2019 06:51:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D19E110CC1EE;
 Fri,  4 Oct 2019 10:51:19 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16C135D6B2;
 Fri,  4 Oct 2019 10:51:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] s390x/mmu: Inject PGM_ADDRESSING on bogus table
 addresses
Date: Fri,  4 Oct 2019 12:50:59 +0200
Message-Id: <20191004105102.15821-5-david@redhat.com>
In-Reply-To: <20191004105102.15821-1-david@redhat.com>
References: <20191004105102.15821-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 04 Oct 2019 10:51:20 +0000 (UTC)
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

Let's document how it works and inject PGM_ADDRESSING if reading of
table entries fails.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index f6ae444655..71dee0a5d9 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -93,6 +93,27 @@ target_ulong mmu_real2abs(CPUS390XState *env, target_u=
long raddr)
     return raddr;
 }
=20
+static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
+                                    uint64_t *entry)
+{
+    CPUState *cs =3D env_cpu(env);
+
+    /*
+     * According to the PoP, these table addresses are "unpredictably re=
al
+     * or absolute". Also, "it is unpredictable whether the address wrap=
s
+     * or an addressing exception is recognized".
+     *
+     * We treat them as absolute addresses and don't wrap them.
+     */
+    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIE=
D,
+                                    (uint8_t *)entry, sizeof(*entry)) !=3D
+                 MEMTX_OK)) {
+        return false;
+    }
+    *entry =3D be64_to_cpu(*entry);
+    return true;
+}
+
 /* Decode page table entry (normal 4KB page) */
 static int mmu_translate_pte(CPUS390XState *env, target_ulong vaddr,
                              uint64_t asc, uint64_t pt_entry,
@@ -118,7 +139,6 @@ static int mmu_translate_segment(CPUS390XState *env, =
target_ulong vaddr,
                                  target_ulong *raddr, int *flags, int rw=
,
                                  bool exc)
 {
-    CPUState *cs =3D env_cpu(env);
     uint64_t origin, offs, pt_entry;
=20
     if (st_entry & SEGMENT_ENTRY_RO) {
@@ -134,7 +154,9 @@ static int mmu_translate_segment(CPUS390XState *env, =
target_ulong vaddr,
     /* Look up 4KB page entry */
     origin =3D st_entry & SEGMENT_ENTRY_ORIGIN;
     offs  =3D (vaddr & VADDR_PX) >> 9;
-    pt_entry =3D ldq_phys(cs->as, origin + offs);
+    if (!read_table_entry(env, origin + offs, &pt_entry)) {
+        return PGM_ADDRESSING;
+    }
     return mmu_translate_pte(env, vaddr, asc, pt_entry, raddr, flags, rw=
, exc);
 }
=20
@@ -144,7 +166,6 @@ static int mmu_translate_region(CPUS390XState *env, t=
arget_ulong vaddr,
                                 target_ulong *raddr, int *flags, int rw,
                                 bool exc)
 {
-    CPUState *cs =3D env_cpu(env);
     uint64_t origin, offs, new_entry;
     const int pchks[4] =3D {
         PGM_SEGMENT_TRANS, PGM_REG_THIRD_TRANS,
@@ -154,7 +175,9 @@ static int mmu_translate_region(CPUS390XState *env, t=
arget_ulong vaddr,
     origin =3D entry & REGION_ENTRY_ORIGIN;
     offs =3D (vaddr >> (17 + 11 * level / 4)) & 0x3ff8;
=20
-    new_entry =3D ldq_phys(cs->as, origin + offs);
+    if (!read_table_entry(env, origin + offs, &new_entry)) {
+        return PGM_ADDRESSING;
+    }
=20
     if ((new_entry & REGION_ENTRY_INV) !=3D 0) {
         return pchks[level / 4];
--=20
2.21.0


