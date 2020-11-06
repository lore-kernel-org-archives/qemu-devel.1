Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8352C55ABD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300D520715
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkJmqr5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300D520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5C8-0005Ch-2E
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb59y-00037k-QN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:04:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb59x-0001zp-8l
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604682260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3wfZcCwMKslEFjXlVJ3jqNVIPb5NGo7EYNvTAtaW0Y=;
 b=CkJmqr5rq/S0c5B8iLC+5esbs1LfG2GpD7iT6y0xtPh0Hu6TvGs7r7W2cUYgh8P+SwWo9B
 SvN2CjXcw/nYSBjoNRmB/w3hDg5bqGgR2QXwxFGu7R9oPUSkk4KKwpXav1aexq3wYr2XAB
 w0DLEXsk8ehFsfFC9m27JVw64nirNFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-BfMjHUOnPQ-z2WgeBhK1sw-1; Fri, 06 Nov 2020 12:04:18 -0500
X-MC-Unique: BfMjHUOnPQ-z2WgeBhK1sw-1
Received: by mail-wm1-f70.google.com with SMTP id g3so658411wmh.9
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K3wfZcCwMKslEFjXlVJ3jqNVIPb5NGo7EYNvTAtaW0Y=;
 b=c4ORW1AJHfCnswYOuVuGGKpsEvmDj1xtHPTVLE46nAhsk0CE3mA3cH5RuSYiKutcBN
 VlA4wHhzgGdudKGInKuFg3s/f+KvsNm+p4FnakftiXz1yb8P9eSJ2vnzcNCLH4CNkzD8
 D8DByGqa/1EhM/DuVyAy4vUdwJbADkiOLHXRbPZ1QhO57lXjGWwM0jKuZUzWaz8XNIkI
 cZuV63IhhsubmqI7prNuWSQw7MHCSFXzJQPFMX494RO6kwwW5NcfZ9bpp/DzQNQVsRXZ
 0Xgn/TM7guqjKkF9FtX/7Viwe94cP7utLEC29odi7xBIz/yHQR9Ldvq3TpCFmYdTJ1L+
 Te0Q==
X-Gm-Message-State: AOAM531GViz3DrW7O3hyvLnRYfOeJHvgNwDsxQ0pBJd1wLwuBOPrdoq7
 4XegQDnHsgyoNgJHz5FFt1XL4Fsz17ofvQ50sRwCFXLJAEyfg8RqYzj86iJPuzu3P5UbK3nqOAc
 EzonFzXA3BGLgZ6Y=
X-Received: by 2002:adf:f104:: with SMTP id r4mr3786246wro.202.1604682257496; 
 Fri, 06 Nov 2020 09:04:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrk2TqWGpdD7Y2fa525+AMJB0ebORXfqExvGopeDXyoNqS1xNofDTgfu3VzWwoXdNxVQ3rfA==
X-Received: by 2002:adf:f104:: with SMTP id r4mr3786210wro.202.1604682257274; 
 Fri, 06 Nov 2020 09:04:17 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v123sm3330004wme.7.2020.11.06.09.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:04:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 1/2] hw/scsi/scsi-disk: Rename type as TYPE_SCSI_DISK
Date: Fri,  6 Nov 2020 18:04:03 +0100
Message-Id: <20201106170404.4130486-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170404.4130486-1-philmd@redhat.com>
References: <20201106170404.4130486-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename TYPE_SCSI_DISK without the '_BASE' suffix to match
the other abstract types in the codebase.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/scsi/scsi-disk.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e859534eaf3..d2b9cb28da1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -53,9 +53,9 @@
 #define DEFAULT_MAX_UNMAP_SIZE      (1 * GiB)
 #define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
-#define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
+#define TYPE_SCSI_DISK              "scsi-disk-base"
 
-OBJECT_DECLARE_TYPE(SCSIDiskState, SCSIDiskClass, SCSI_DISK_BASE)
+OBJECT_DECLARE_TYPE(SCSIDiskState, SCSIDiskClass, SCSI_DISK)
 
 struct SCSIDiskClass {
     SCSIDeviceClass parent_class;
@@ -2956,7 +2956,7 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
 static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
+    SCSIDiskClass *sdc = SCSI_DISK_CLASS(klass);
 
     dc->fw_name = "disk";
     dc->reset = scsi_disk_reset;
@@ -2966,7 +2966,7 @@ static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo scsi_disk_base_info = {
-    .name          = TYPE_SCSI_DISK_BASE,
+    .name          = TYPE_SCSI_DISK,
     .parent        = TYPE_SCSI_DEVICE,
     .class_init    = scsi_disk_base_class_initfn,
     .instance_size = sizeof(SCSIDiskState),
@@ -3036,7 +3036,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
 
 static const TypeInfo scsi_hd_info = {
     .name          = "scsi-hd",
-    .parent        = TYPE_SCSI_DISK_BASE,
+    .parent        = TYPE_SCSI_DISK,
     .class_init    = scsi_hd_class_initfn,
 };
 
@@ -3067,7 +3067,7 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
 
 static const TypeInfo scsi_cd_info = {
     .name          = "scsi-cd",
-    .parent        = TYPE_SCSI_DISK_BASE,
+    .parent        = TYPE_SCSI_DISK,
     .class_init    = scsi_cd_class_initfn,
 };
 
@@ -3090,7 +3090,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
-    SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
+    SCSIDiskClass *sdc = SCSI_DISK_CLASS(klass);
 
     sc->realize      = scsi_block_realize;
     sc->alloc_req    = scsi_block_new_request;
@@ -3106,7 +3106,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
 
 static const TypeInfo scsi_block_info = {
     .name          = "scsi-block",
-    .parent        = TYPE_SCSI_DISK_BASE,
+    .parent        = TYPE_SCSI_DISK,
     .class_init    = scsi_block_class_initfn,
 };
 #endif
@@ -3146,7 +3146,7 @@ static void scsi_disk_class_initfn(ObjectClass *klass, void *data)
 
 static const TypeInfo scsi_disk_info = {
     .name          = "scsi-disk",
-    .parent        = TYPE_SCSI_DISK_BASE,
+    .parent        = TYPE_SCSI_DISK,
     .class_init    = scsi_disk_class_initfn,
 };
 
-- 
2.26.2


