Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91920C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681982054F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681982054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahyx-0001bl-LB
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hahmH-0001WF-Cg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hahmF-0002jt-JU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hahmB-0002Np-8q; Tue, 11 Jun 2019 10:29:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D6B78553D;
 Tue, 11 Jun 2019 14:28:46 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36CCD17F41;
 Tue, 11 Jun 2019 14:28:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Tue, 11 Jun 2019 16:28:20 +0200
Message-Id: <20190611142821.3874-2-eric.auger@redhat.com>
In-Reply-To: <20190611142821.3874-1-eric.auger@redhat.com>
References: <20190611142821.3874-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 14:28:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] hw/arm/smmuv3: Remove spurious error
 messages on IOVA invalidations
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An IOVA/ASID invalidation is notified to all IOMMU Memory Regions
through smmuv3_inv_notifiers_iova/smmuv3_notify_iova.

When the notification occurs it is possible that some of the
PCIe devices associated to the notified regions do not have a
valid stream table entry. In that case we output a LOG_GUEST_ERROR
message.

invalid sid=3D<SID> (L1STD span=3D0)
"smmuv3_notify_iova error decoding the configuration for iommu mr=3D<MR>

This is unfortunate as the user gets the impression that there
are some translation decoding errors whereas there are not.

This patch adds a new field in SMMUEventInfo that tells whether
the detction of an invalid STE msut lead to an error report.
invalid_ste_allowed is set before doing the invalidations and
kept unset on actual translation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

I also experimented to pass Error handles to all the subfunctions
and handle the Error at top level but that's intricate to sort
out the various kinds of errors, whether they need to be logged,
and if so if they match LOG_GUEST_ERRoR mask or unimplemented
mask. So I think just passing this boolean has a lesser impact on
the code base.
---
 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b160289cd1..d190181ef1 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -381,6 +381,7 @@ typedef struct SMMUEventInfo {
     uint32_t sid;
     bool recorded;
     bool record_trans_faults;
+    bool inval_ste_allowed;
     union {
         struct {
             uint32_t ssid;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index fd8ec7860e..e2f07d2864 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -404,7 +404,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid=
, STE *ste,
=20
         span =3D L1STD_SPAN(&l1std);
=20
-        if (!span) {
+        if (!span && !event->inval_ste_allowed) {
             /* l2ptr is not valid */
             qemu_log_mask(LOG_GUEST_ERROR,
                           "invalid sid=3D%d (L1STD span=3D0)\n", sid);
@@ -602,7 +602,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegi=
on *mr, hwaddr addr,
     SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s =3D sdev->smmu;
     uint32_t sid =3D smmu_get_sid(sdev);
-    SMMUEventInfo event =3D {.type =3D SMMU_EVT_NONE, .sid =3D sid};
+    SMMUEventInfo event =3D {.type =3D SMMU_EVT_NONE,
+                           .sid =3D sid,
+                           .inval_ste_allowed =3D false};
     SMMUPTWEventInfo ptw_info =3D {};
     SMMUTranslationStatus status;
     SMMUState *bs =3D ARM_SMMU(s);
@@ -795,16 +797,13 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *m=
r,
                                dma_addr_t iova)
 {
     SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
-    SMMUEventInfo event =3D {};
+    SMMUEventInfo event =3D {.inval_ste_allowed =3D true};
     SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg;
     IOMMUTLBEntry entry;
=20
     cfg =3D smmuv3_get_config(sdev, &event);
     if (!cfg) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s error decoding the configuration for iommu mr=3D=
%s\n",
-                      __func__, mr->parent_obj.name);
         return;
     }
=20
--=20
2.20.1


