Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9847FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEEA2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOxQ0PPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEEA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo36S-00070X-IC
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zn-0001Bj-Ll
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zl-0001Jt-EL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khGN3yBeBscrbWry0yO/E7AO7oL3m8AMBQlv+dTs4fA=;
 b=VOxQ0PPuSkQViCpBRv/XvhIDrBMtcHwsY2JVoY0LRX02tPzVfGALE+48NlVWirGuLAgONP
 U+s/WbbSA818ReyP8Cf4OeeiBQjN2+3UHh0dZnanVjxNlVnrN7Wsqe8yEwaYDnGoKbX1ms
 WC7eVgT4FHMZj3dFqlUbC26pUb3tH5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-2Zw9wRL_M2KMMBwW69VWwQ-1; Wed, 24 Jun 2020 06:51:04 -0400
X-MC-Unique: 2Zw9wRL_M2KMMBwW69VWwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16447107ACCA;
 Wed, 24 Jun 2020 10:51:03 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B3155D9C5;
 Wed, 24 Jun 2020 10:51:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/31] hw/scsi/megasas: Fix possible out-of-bounds array access
 in tracepoints
Date: Wed, 24 Jun 2020 06:50:28 -0400
Message-Id: <20200624105048.375353-11-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Some tracepoints in megasas.c use a guest-controlled value as an index
into the mfi_frame_desc[] array. Thus a malicious guest could cause an
out-of-bounds error here. Fortunately, the impact is very low since this
can only happen when the corresponding tracepoints have been enabled
before, but the problem should be fixed anyway with a proper check.

Buglink: https://bugs.launchpad.net/qemu/+bug/1882065
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200615072629.32321-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 634af0bbb8..5cfd1bf22e 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -54,10 +54,6 @@
 #define MEGASAS_FLAG_USE_QUEUE64   1
 #define MEGASAS_MASK_USE_QUEUE64   (1 << MEGASAS_FLAG_USE_QUEUE64)
 
-static const char *mfi_frame_desc[] = {
-    "MFI init", "LD Read", "LD Write", "LD SCSI", "PD SCSI",
-    "MFI Doorbell", "MFI Abort", "MFI SMP", "MFI Stop"};
-
 typedef struct MegasasCmd {
     uint32_t index;
     uint16_t flags;
@@ -183,6 +179,20 @@ static void megasas_frame_set_scsi_status(MegasasState *s,
     stb_pci_dma(pci, frame + offsetof(struct mfi_frame_header, scsi_status), v);
 }
 
+static inline const char *mfi_frame_desc(unsigned int cmd)
+{
+    static const char *mfi_frame_descs[] = {
+        "MFI init", "LD Read", "LD Write", "LD SCSI", "PD SCSI",
+        "MFI Doorbell", "MFI Abort", "MFI SMP", "MFI Stop"
+    };
+
+    if (cmd < ARRAY_SIZE(mfi_frame_descs)) {
+        return mfi_frame_descs[cmd];
+    }
+
+    return "Unknown";
+}
+
 /*
  * Context is considered opaque, but the HBA firmware is running
  * in little endian mode. So convert it to little endian, too.
@@ -1670,25 +1680,25 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
     if (is_logical) {
         if (target_id >= MFI_MAX_LD || lun_id != 0) {
             trace_megasas_scsi_target_not_present(
-                mfi_frame_desc[frame_cmd], is_logical, target_id, lun_id);
+                mfi_frame_desc(frame_cmd), is_logical, target_id, lun_id);
             return MFI_STAT_DEVICE_NOT_FOUND;
         }
     }
     sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
 
     cmd->iov_size = le32_to_cpu(cmd->frame->header.data_len);
-    trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
+    trace_megasas_handle_scsi(mfi_frame_desc(frame_cmd), is_logical,
                               target_id, lun_id, sdev, cmd->iov_size);
 
     if (!sdev || (megasas_is_jbod(s) && is_logical)) {
         trace_megasas_scsi_target_not_present(
-            mfi_frame_desc[frame_cmd], is_logical, target_id, lun_id);
+            mfi_frame_desc(frame_cmd), is_logical, target_id, lun_id);
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
     if (cdb_len > 16) {
         trace_megasas_scsi_invalid_cdb_len(
-                mfi_frame_desc[frame_cmd], is_logical,
+                mfi_frame_desc(frame_cmd), is_logical,
                 target_id, lun_id, cdb_len);
         megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
         cmd->frame->header.scsi_status = CHECK_CONDITION;
@@ -1706,7 +1716,7 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
     cmd->req = scsi_req_new(sdev, cmd->index, lun_id, cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
-                mfi_frame_desc[frame_cmd], target_id, lun_id);
+                mfi_frame_desc(frame_cmd), target_id, lun_id);
         megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
         cmd->frame->header.scsi_status = BUSY;
         s->event_count++;
@@ -1751,17 +1761,17 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
     }
 
     trace_megasas_handle_io(cmd->index,
-                            mfi_frame_desc[frame_cmd], target_id, lun_id,
+                            mfi_frame_desc(frame_cmd), target_id, lun_id,
                             (unsigned long)lba_start, (unsigned long)lba_count);
     if (!sdev) {
         trace_megasas_io_target_not_present(cmd->index,
-            mfi_frame_desc[frame_cmd], target_id, lun_id);
+            mfi_frame_desc(frame_cmd), target_id, lun_id);
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
     if (cdb_len > 16) {
         trace_megasas_scsi_invalid_cdb_len(
-            mfi_frame_desc[frame_cmd], 1, target_id, lun_id, cdb_len);
+            mfi_frame_desc(frame_cmd), 1, target_id, lun_id, cdb_len);
         megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
         cmd->frame->header.scsi_status = CHECK_CONDITION;
         s->event_count++;
@@ -1781,7 +1791,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
                             lun_id, cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
-            mfi_frame_desc[frame_cmd], target_id, lun_id);
+            mfi_frame_desc(frame_cmd), target_id, lun_id);
         megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
         cmd->frame->header.scsi_status = BUSY;
         s->event_count++;
-- 
2.26.2



