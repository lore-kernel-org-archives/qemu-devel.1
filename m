Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A49C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BC820B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BC820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf1T-00021R-VG
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52088)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1huewH-0002hZ-Cn
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1huewF-0000gt-En
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1huewD-0000eK-RS; Mon, 05 Aug 2019 11:30:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C1E63084295;
 Mon,  5 Aug 2019 15:30:13 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF64960F88;
 Mon,  5 Aug 2019 15:30:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:29:42 +0200
Message-Id: <20190805152947.28536-5-david@redhat.com>
In-Reply-To: <20190805152947.28536-1-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 05 Aug 2019 15:30:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 4/9] s390x/mmu: Add EDAT2
 translation support
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This only adds basic support to the DAT translation, but no EDAT2 support
for TCG. E.g., the gdbstub under kvm uses this function, too, to
translate virtual addresses.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index de7798284d..5c9c7d385d 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -139,6 +139,7 @@ static int mmu_translate_asce(CPUS390XState *env, tar=
get_ulong vaddr,
 {
     const bool edat1 =3D (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
+    const bool edat2 =3D edat1 && s390_has_feat(S390_FEAT_EDAT_2);
     const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
     const int asce_p =3D asce & ASCE_PRIVATE_SPACE;
     hwaddr gaddr =3D asce & ASCE_ORIGIN;
@@ -234,9 +235,16 @@ static int mmu_translate_asce(CPUS390XState *env, ta=
rget_ulong vaddr,
         if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION3) {
             return PGM_TRANS_SPEC;
         }
+        if (edat2 && (entry & REGION3_ENTRY_CR) && asce_p) {
+            return PGM_TRANS_SPEC;
+        }
         if (edat1 && (entry & REGION_ENTRY_P)) {
             *flags &=3D ~PAGE_WRITE;
         }
+        if (edat2 && (entry & REGION3_ENTRY_FC)) {
+            *raddr =3D entry & REGION3_ENTRY_RFAA;
+            return 0;
+        }
         if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
             VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
             return PGM_SEGMENT_TRANS;
--=20
2.21.0


