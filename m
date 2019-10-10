Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E12FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA03208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA03208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWpY-0004DA-V0
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWiC-0003Rd-8F
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWiB-0005lF-5E
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWiA-0005kh-W8; Thu, 10 Oct 2019 07:34:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 202013D94D;
 Thu, 10 Oct 2019 11:34:26 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2B35C22C;
 Thu, 10 Oct 2019 11:34:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 08/31] s390x/mmu: Add EDAT2 translation support
Date: Thu, 10 Oct 2019 13:33:33 +0200
Message-Id: <20191010113356.5017-9-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 10 Oct 2019 11:34:26 +0000 (UTC)
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This only adds basic support to the DAT translation, but no EDAT2 support
for TCG. E.g., the gdbstub under kvm uses this function, too, to
translate virtual addresses.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index dc33c63b1d..e27e21328b 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -120,6 +120,7 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
 {
     const bool edat1 =3D (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
+    const bool edat2 =3D edat1 && s390_has_feat(S390_FEAT_EDAT_2);
     const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
     const int asce_p =3D asce & ASCE_PRIVATE_SPACE;
     hwaddr gaddr =3D asce & ASCE_ORIGIN;
@@ -217,13 +218,21 @@ static int mmu_translate_asce(CPUS390XState *env, t=
arget_ulong vaddr,
         if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION3) {
             return PGM_TRANS_SPEC;
         }
-        if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
-            VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
-            return PGM_SEGMENT_TRANS;
+        if (edat2 && (entry & REGION3_ENTRY_CR) && asce_p) {
+            return PGM_TRANS_SPEC;
         }
         if (edat1 && (entry & REGION_ENTRY_P)) {
             *flags &=3D ~PAGE_WRITE;
         }
+        if (edat2 && (entry & REGION3_ENTRY_FC)) {
+            *raddr =3D (entry & REGION3_ENTRY_RFAA) |
+                     (vaddr & ~REGION3_ENTRY_RFAA);
+            return 0;
+        }
+        if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
+            VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
+            return PGM_SEGMENT_TRANS;
+        }
         gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_SEGMENT_TX(vaddr=
) * 8;
         /* fall through */
     case ASCE_TYPE_SEGMENT:
--=20
2.21.0


