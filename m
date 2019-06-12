Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC9C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BED120896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BED120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCKH-0002qn-Sn
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbCGB-00070j-Pe
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbCG8-0007uw-0Y
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbCG6-0007ph-0S; Wed, 12 Jun 2019 19:02:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA17E300414E;
 Wed, 12 Jun 2019 23:02:11 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-37.brq.redhat.com [10.40.204.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAF9A5F9A7;
 Wed, 12 Jun 2019 23:02:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 01:02:02 +0200
Message-Id: <20190612230202.878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 23:02:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH] spapr_pci: Fix Null pointer dereferences
 in spapr_dt_pci_bus()
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 14e714900f6 refactored the call to spapr_dt_drc(),
but used an incorrect object owner as argument.

This fixes:

  /hw/ppc/spapr_pci.c: 1367 in spapr_dt_pci_bus()
  >>>     CID 1401933:  Null pointer dereferences  (FORWARD_NULL)
  >>>     Dereferencing null pointer "bus".
  1367         ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
  1368                            SPAPR_DR_CONNECTOR_TYPE_PCI);

Fixes: 14e714900f6
Reported-by: Coverity (CID 1401933)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 957ae88bbd..e0cd3f11f1 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1364,8 +1364,7 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, PC=
IBus *bus,
         }
     }
=20
-    ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
-                       SPAPR_DR_CONNECTOR_TYPE_PCI);
+    ret =3D spapr_dt_drc(fdt, offset, OBJECT(sphb), SPAPR_DR_CONNECTOR_T=
YPE_PCI);
     if (ret) {
         return ret;
     }
--=20
2.20.1


