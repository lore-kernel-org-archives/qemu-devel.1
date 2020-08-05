Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996A1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631B72250E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9t5aehY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631B72250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3PPH-0003zf-KD
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 15:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3POj-0003Ur-6D
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:48:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55939
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3POf-0008Pp-RY
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596656899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ua8vzGT2EBSgdeNzQOoLqmsEH3spXT1WCJ+PlW9rv0g=;
 b=K9t5aehYUYHRjdiRNPyX4gXs60BVpmUyhvO4mZnJQRqH3RghPKV/LsSYzqVOBLWk2ImQ0a
 mRorIYZp9uhZABjL8rTpmfhbskp1q75PC946zZR3wLjjE1AhhD0w4RIlCIaQ2CZgnvBapc
 uPYG5L+mQ5aGhA5K1E1yc3xs7iFp62E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-H1FYUOb9Pb-Q6LC7kk2uYg-1; Wed, 05 Aug 2020 15:48:18 -0400
X-MC-Unique: H1FYUOb9Pb-Q6LC7kk2uYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B98280183C;
 Wed,  5 Aug 2020 19:48:17 +0000 (UTC)
Received: from localhost (ovpn-112-108.rdu2.redhat.com [10.10.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0D4F10013D7;
 Wed,  5 Aug 2020 19:48:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ide: Get rid of IDEDrive struct
Date: Wed,  5 Aug 2020 15:48:12 -0400
Message-Id: <20200805194812.1735218-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The struct had a single field (IDEDevice dev), and is only used
in the QOM type declarations and property lists.  We can simply
use the IDEDevice struct directly instead.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ide/qdev.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7f66..dd3867d8b3 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -157,10 +157,6 @@ int ide_get_bios_chs_trans(BusState *bus, int unit)
 
 /* --------------------------------- */
 
-typedef struct IDEDrive {
-    IDEDevice dev;
-} IDEDrive;
-
 static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
@@ -297,19 +293,19 @@ static void ide_drive_realize(IDEDevice *dev, Error **errp)
 }
 
 #define DEFINE_IDE_DEV_PROPERTIES()                     \
-    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
-    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
-    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
-    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
-    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
+    DEFINE_BLOCK_PROPERTIES(IDEDevice, conf),        \
+    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDevice, conf),  \
+    DEFINE_PROP_STRING("ver",  IDEDevice, version),  \
+    DEFINE_PROP_UINT64("wwn",  IDEDevice, wwn, 0),   \
+    DEFINE_PROP_STRING("serial",  IDEDevice, serial),\
+    DEFINE_PROP_STRING("model", IDEDevice, model)
 
 static Property ide_hd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
-    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
+    DEFINE_BLOCK_CHS_PROPERTIES(IDEDevice, conf),
     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
-                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
-    DEFINE_PROP_UINT16("rotation_rate", IDEDrive, dev.rotation_rate, 0),
+                IDEDevice, chs_trans, BIOS_ATA_TRANSLATION_AUTO),
+    DEFINE_PROP_UINT16("rotation_rate", IDEDevice, rotation_rate, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -327,7 +323,6 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
 static const TypeInfo ide_hd_info = {
     .name          = "ide-hd",
     .parent        = TYPE_IDE_DEVICE,
-    .instance_size = sizeof(IDEDrive),
     .class_init    = ide_hd_class_init,
 };
 
@@ -350,7 +345,6 @@ static void ide_cd_class_init(ObjectClass *klass, void *data)
 static const TypeInfo ide_cd_info = {
     .name          = "ide-cd",
     .parent        = TYPE_IDE_DEVICE,
-    .instance_size = sizeof(IDEDrive),
     .class_init    = ide_cd_class_init,
 };
 
@@ -373,7 +367,6 @@ static void ide_drive_class_init(ObjectClass *klass, void *data)
 static const TypeInfo ide_drive_info = {
     .name          = "ide-drive",
     .parent        = TYPE_IDE_DEVICE,
-    .instance_size = sizeof(IDEDrive),
     .class_init    = ide_drive_class_init,
 };
 
-- 
2.26.2


