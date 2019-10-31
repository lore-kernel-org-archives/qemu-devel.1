Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAECCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C1220873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIIwH3Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C1220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQCyq-0008SH-6L
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iQCqk-0004Ve-Mq
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iQCqi-00005q-R5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:59:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iQCqi-0008WQ-Ms
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572537540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFaYgYqoRE/mPMgv2QBpnHLrD9yiGIOjEkSql3P4gPc=;
 b=PIIwH3Mx5i//5BQ8FqObEMJvKdtStVU1sYas4p7BjxQHEc+A4bTF1QnCApf/BVfyIjvhK/
 yCs0QLDc95QzNcpsDzUWotfnWSuL1aTvE1jXcodk5qtGSEXXIGh1NeFpfyN2Ymv5YbhfWp
 rdmhoPPtd8Rv530PFWFEkW/gtX3oIS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-WvyeaFcEOgGQHJkr-XCzGA-1; Thu, 31 Oct 2019 11:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC8D02EDC;
 Thu, 31 Oct 2019 15:58:56 +0000 (UTC)
Received: from probe.redhat.com (ovpn-126-19.rdu2.redhat.com [10.10.126.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C655600CD;
 Thu, 31 Oct 2019 15:58:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 5/9] scsi: Propagate unrealize() callback to scsi-hd
Date: Thu, 31 Oct 2019 11:56:32 -0400
Message-Id: <20191031155636.18589-6-jsnow@redhat.com>
In-Reply-To: <20191031155636.18589-1-jsnow@redhat.com>
References: <20191031155636.18589-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WvyeaFcEOgGQHJkr-XCzGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sam Eiderman <sameid@google.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

We will need to add LCHS removal logic to scsi-hd's unrealize() in the
next commit.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/scsi/scsi-bus.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index d77a92361b..332ef602f4 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -59,6 +59,7 @@ struct SCSIRequest {
 typedef struct SCSIDeviceClass {
     DeviceClass parent_class;
     void (*realize)(SCSIDevice *dev, Error **errp);
+    void (*unrealize)(SCSIDevice *dev, Error **errp);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index bccb7cc4c6..359d50d6d0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -59,6 +59,14 @@ static void scsi_device_realize(SCSIDevice *s, Error **e=
rrp)
     }
 }
=20
+static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
+{
+    SCSIDeviceClass *sc =3D SCSI_DEVICE_GET_CLASS(s);
+    if (sc->unrealize) {
+        sc->unrealize(s, errp);
+    }
+}
+
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        void *hba_private)
 {
@@ -217,12 +225,20 @@ static void scsi_qdev_realize(DeviceState *qdev, Erro=
r **errp)
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev =3D SCSI_DEVICE(qdev);
+    Error *local_err =3D NULL;
=20
     if (dev->vmsentry) {
         qemu_del_vm_change_state_handler(dev->vmsentry);
     }
=20
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
+
+    scsi_device_unrealize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     blockdev_mark_auto_del(dev->conf.blk);
 }
=20
--=20
2.21.0


