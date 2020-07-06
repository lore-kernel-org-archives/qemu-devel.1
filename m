Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93771C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3A020724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYTuetJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3A020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMOy-0002O0-JY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMCk-0002K3-Dj
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:10:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMCQ-0003EO-GC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594023000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY3ATDw4Mrmehr4vtAvncGOqy6nnKAyW/bS/G9STJj0=;
 b=bYTuetJc8gUPYdGFhX3JrOGI5NaySMhZEC3rtaeOETsTfkInRc0KWbT0W469yeqI4xC7+n
 3Jv/S3bIiZO7p18vxILuRwJXYaG4Y0LdHUq6Vfh7/kOe8g2tSWHi5P7llFgMZUOdi9JhVw
 3uDRuVWPRf/tgW3qMB2l9DPiCizcFgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-Bg0yUhOxMsmzqbSCX_gUSA-1; Mon, 06 Jul 2020 04:09:58 -0400
X-MC-Unique: Bg0yUhOxMsmzqbSCX_gUSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BDA956B39;
 Mon,  6 Jul 2020 08:09:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23DAB100239A;
 Mon,  6 Jul 2020 08:09:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 461731135237; Mon,  6 Jul 2020 10:09:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/44] qdev: Use returned bool to check for failure,
 Coccinelle part
Date: Mon,  6 Jul 2020 10:09:37 +0200
Message-Id: <20200706080950.403087-32-armbru@redhat.com>
In-Reply-To: <20200706080950.403087-1-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit enables conversion of

    qdev_prop_set_drive_err(..., &err);
    if (err) {
    ...
    }

to

    if (!qdev_prop_set_drive_err(..., errp)) {
    ...
    }

Coccinelle script:

    @@
    identifier fun = qdev_prop_set_drive_err;
    expression list args;
    typedef Error;
    Error *err;
    @@
    -    fun(args, &err);
    -    if (err)
    +    if (!fun(args, &err))
         {
             ...
         }

One line break tidied up manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/scsi/scsi-bus.c | 3 +--
 hw/sd/sd.c         | 3 +--
 hw/sd/ssi-sd.c     | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index a83939f7d0..38b66a2f45 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -277,8 +277,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     if (serial && object_property_find(OBJECT(dev), "serial", NULL)) {
         qdev_prop_set_string(dev, "serial", serial);
     }
-    qdev_prop_set_drive_err(dev, "drive", blk, &err);
-    if (err) {
+    if (!qdev_prop_set_drive_err(dev, "drive", blk, &err)) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
         return NULL;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 97a9d32964..5137168d66 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -706,8 +706,7 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
 
     obj = object_new(TYPE_SD_CARD);
     dev = DEVICE(obj);
-    qdev_prop_set_drive_err(dev, "drive", blk, &err);
-    if (err) {
+    if (!qdev_prop_set_drive_err(dev, "drive", blk, &err)) {
         error_reportf_err(err, "sd_init failed: ");
         return NULL;
     }
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 4d91f603fa..e0fb9f3093 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -254,9 +254,8 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     dinfo = drive_get_next(IF_SD);
     carddev = qdev_new(TYPE_SD_CARD);
     if (dinfo) {
-        qdev_prop_set_drive_err(carddev, "drive", blk_by_legacy_dinfo(dinfo),
-                                &err);
-        if (err) {
+        if (!qdev_prop_set_drive_err(carddev, "drive",
+                                     blk_by_legacy_dinfo(dinfo), &err)) {
             goto fail;
         }
     }
-- 
2.26.2


