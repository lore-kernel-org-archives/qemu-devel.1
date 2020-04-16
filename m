Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B18C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C769206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9eJX6KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C769206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBHZ-00024H-Gr
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFX-00080d-N0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFW-00042d-PU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jPBFW-00042N-MH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587069398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap+Pt4fSPMW5Snij4O6Cep7cm0g2WkDrl1yiJWCRlzk=;
 b=S9eJX6KF2jmkb95LUUTgsN9tgIS+Io4dhsHttQEEwrDZ7sJLZ+CLRvTZH3h+Ooq+zIOdB7
 YsBCorlP7FVjMrbqz2H+WOwOitAzyzttct89OO8DWqY3Cs+TrzXIAPb+3Y/guk2uHmy0Y7
 4KNei1cG1SB5fDnwH1oym+jxfrCUss8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-77ki8K5WNXmGOUm74Y_f4A-1; Thu, 16 Apr 2020 16:36:34 -0400
X-MC-Unique: 77ki8K5WNXmGOUm74Y_f4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC57018C43C0;
 Thu, 16 Apr 2020 20:36:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C165CA099C;
 Thu, 16 Apr 2020 20:36:31 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] scsi/scsi_bus: switch search direction in scsi_device_find
Date: Thu, 16 Apr 2020 23:36:21 +0300
Message-Id: <20200416203624.32366-2-mlevitsk@redhat.com>
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change will allow us to convert the bus children list to RCU,
while not changing the logic of this function

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/scsi-bus.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1c980cab38..7bbc37acec 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1584,7 +1584,7 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channe=
l, int id, int lun)
     BusChild *kid;
     SCSIDevice *target_dev =3D NULL;
=20
-    QTAILQ_FOREACH_REVERSE(kid, &bus->qbus.children, sibling) {
+    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         SCSIDevice *dev =3D SCSI_DEVICE(qdev);
=20
@@ -1592,7 +1592,15 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int chann=
el, int id, int lun)
             if (dev->lun =3D=3D lun) {
                 return dev;
             }
-            target_dev =3D dev;
+
+            /*
+             * If we don't find exact match (channel/bus/lun),
+             * we will return the first device which matches channel/bus
+             */
+
+            if (!target_dev) {
+                target_dev =3D dev;
+            }
         }
     }
     return target_dev;
--=20
2.17.2


