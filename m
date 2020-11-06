Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC41C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194B620715
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpkXAVaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194B620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Bu-0004eQ-Sz
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb5A5-0003Cm-WB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb5A4-00020M-Fr
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604682266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Y8CFV0FsZyXFJC+vbP/pWrux/jc89V1kGuvlpHPTJ4=;
 b=VpkXAVajuwuKDqJ8kMCoNJUIlYJmPTSQI8eIct1R4I1tRLESCnfcw0tKP8NxrYSGCL0Owd
 NmUFpvf+n/LqFjZhw47IWTo7rBB+hxAtLvZGT6qqsGN5qTqDnxUNAT8+ZTzcZ2cgShQaHG
 REhwNCMCwLZo+BBGNOKBQCZmhyxldwE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-ldLX5oNfPcmyEPADy0reZw-1; Fri, 06 Nov 2020 12:04:24 -0500
X-MC-Unique: ldLX5oNfPcmyEPADy0reZw-1
Received: by mail-wr1-f71.google.com with SMTP id r16so679666wrw.22
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Y8CFV0FsZyXFJC+vbP/pWrux/jc89V1kGuvlpHPTJ4=;
 b=lx0kIlxVuNaedR5qAiASlfSltMAnwvpnOC8k+q3xdzuq941pd3iJx7Pnek4kMGlip4
 GLMvmJeIu011nTetO4U6Oc/E25EaISb6Uoof0378iumiJbSoWf0heaGSgqg6sSBFh6n8
 7HtFRKIuf2kDlHs0xezkzL8QMFwmBPMQc9V7ifQ8m8HVKigGMLpiPlVfsPF7Ai8jNdhW
 2Od3C3CRmU4YxjwYDkPXBXOzHX9gK8r3XhoE2ffD6DodUmtKyryLEAEHxRTSz32sqj22
 QWClBBgT3E2eU4Us5j8knfDGfmo3HvbiBv0M2DJGrOhWY1l9kw83T6jBaaD4xZAePNyj
 j+mg==
X-Gm-Message-State: AOAM532QNB/r3KPQtv2jQnqBR6b5WFbzkM13SVX9vg+o+iY0CV+P8f0y
 5cu2zUJ67mkZGrsg21n6pEzbkx/p3jybpawC8UfBtegrDXF2OV2AI6trkzwAeC6dlye6iuRauDw
 2JvSexPJHhF72kb0=
X-Received: by 2002:adf:dd90:: with SMTP id x16mr3527725wrl.47.1604682263037; 
 Fri, 06 Nov 2020 09:04:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyF9dkEmtisMjBG+P10QOqCmJW3OqZAN0NEceG7yctwzhsZWO+NA8vN+kKrXVzUb4fyVfhVRg==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr3527706wrl.47.1604682262895; 
 Fri, 06 Nov 2020 09:04:22 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id w11sm3254763wmg.36.2020.11.06.09.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:04:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 2/2] hw/scsi/scsi-disk: Use SCSI_DISK_GET_CLASS() macro
Date: Fri,  6 Nov 2020 18:04:04 +0100
Message-Id: <20201106170404.4130486-3-philmd@redhat.com>
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

Use the SCSI_DISK_GET_CLASS() macro to match the rest of
the codebase.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/scsi/scsi-disk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d2b9cb28da1..deb51ec8e7d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -338,7 +338,7 @@ static void scsi_read_complete(void *opaque, int ret)
 static void scsi_do_read(SCSIDiskReq *r, int ret)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
+    SCSIDiskClass *sdc = SCSI_DISK_GET_CLASS(s);
 
     assert (r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
@@ -438,7 +438,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
 {
     bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
+    SCSIDiskClass *sdc = SCSI_DISK_GET_CLASS(s);
     BlockErrorAction action = blk_get_error_action(s->qdev.conf.blk,
                                                    is_read, error);
 
@@ -538,7 +538,7 @@ static void scsi_write_data(SCSIRequest *req)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
+    SCSIDiskClass *sdc = SCSI_DISK_GET_CLASS(s);
 
     /* No data transfer may already be in progress */
     assert(r->req.aiocb == NULL);
@@ -2149,7 +2149,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
-    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
+    SCSIDiskClass *sdc = SCSI_DISK_GET_CLASS(s);
     uint32_t len;
     uint8_t command;
 
-- 
2.26.2


