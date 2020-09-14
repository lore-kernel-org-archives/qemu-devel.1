Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9004C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BED20759
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BED20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnkx-0003g8-LM
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnho-0006Yh-I7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24274
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhk-0000j3-Im
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-3wbgwIsvMISxskem7uJjTg-1; Mon, 14 Sep 2020 08:35:29 -0400
X-MC-Unique: 3wbgwIsvMISxskem7uJjTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 327C91084D70;
 Mon, 14 Sep 2020 12:35:28 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0EE2105509D;
 Mon, 14 Sep 2020 12:35:26 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/15] spapr: Simplify error handling in
 spapr_vio_busdev_realize()
Date: Mon, 14 Sep 2020 14:34:57 +0200
Message-Id: <20200914123505.612812-8-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the return value of spapr_irq_findone() and spapr_irq_claim()
to detect failures. This allows to reduce the error propagation
overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_vio.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 731080d989f1..44fdd64b88af 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -474,7 +474,6 @@ static void spapr_vio_busdev_realize(DeviceState *qdev,=
 Error **errp)
     SpaprVioDevice *dev =3D (SpaprVioDevice *)qdev;
     SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
     char *id;
-    Error *local_err =3D NULL;
=20
     if (dev->reg !=3D -1) {
         /*
@@ -510,16 +509,15 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
     dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
=20
     if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        dev->irq =3D spapr_irq_findone(spapr, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        int irq =3D spapr_irq_findone(spapr, errp);
+
+        if (irq < 0) {
             return;
         }
+        dev->irq =3D irq;
     }
=20
-    spapr_irq_claim(spapr, dev->irq, false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (spapr_irq_claim(spapr, dev->irq, false, errp) < 0) {
         return;
     }
=20
--=20
2.26.2


