Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9571C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E6A206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egnW5wrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNhf-0003xs-9s
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTc-0000mE-HW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTY-00061D-Cw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=od6JXIY1fcP2j39Qow/9a/can0bTK6XDiYgmSrU6a9s=;
 b=egnW5wrkxBmdKKu1yM33FybpVPi8U5WprgUMS66sbNnW4USDNGq4jpbi2PxK+sLoXYLgzY
 49rHWPNZmEgBKkhwRRkQRUswF/ehYpJ+Fv1iz6+VE9D68St8tJdXXQ6ekt8kmk4McHL9u1
 a3I3nDlzPL5mCVLqoitJqz3Vu7oItHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-qJDoMuWmNU672fwyO8xODg-1; Thu, 24 Sep 2020 05:23:37 -0400
X-MC-Unique: qJDoMuWmNU672fwyO8xODg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A468C1DE19;
 Thu, 24 Sep 2020 09:23:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B52873672;
 Thu, 24 Sep 2020 09:23:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/92] scsi-generic: Fix HM-zoned device scan
Date: Thu, 24 Sep 2020 05:22:07 -0400
Message-Id: <20200924092314.1722645-26-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Several important steps during device scan depend on SCSI type of the
device. For example, max_transfer property is only determined and
assigned if the device has the type of TYPE_DISK.

Host-managed ZBC disks retain most of the properties of regular SCSI
drives, but they have their own SCSI device type, 0x14. This prevents
the proper assignment of max_transfer property for HM-zoned devices in
scsi-generic driver leading to I/O errors if the maximum i/o size
calculated at the guest exceeds the host value.

To fix this, define TYPE_ZBC to have the standard value from SCSI ZBC
standard spec. Several scan steps that were previously done only for
TYPE_DISK devices, are now performed for the SCSI devices having
TYPE_ZBC too.

Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-Id: <20200811225122.17342-3-dmitry.fomichev@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c   | 10 ++++++----
 include/scsi/constants.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 86ed0a3822..2cb23ca891 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -162,7 +162,8 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
         }
     }
 
-    if (s->type == TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
+    if ((s->type == TYPE_DISK || s->type == TYPE_ZBC) &&
+        (r->req.cmd.buf[1] & 0x01)) {
         page = r->req.cmd.buf[2];
         if (page == 0xb0) {
             uint32_t max_transfer =
@@ -299,10 +300,11 @@ static void scsi_read_complete(void * opaque, int ret)
     }
     blk_set_guest_block_size(s->conf.blk, s->blocksize);
 
-    /* Patch MODE SENSE device specific parameters if the BDS is opened
+    /*
+     * Patch MODE SENSE device specific parameters if the BDS is opened
      * readonly.
      */
-    if ((s->type == TYPE_DISK || s->type == TYPE_TAPE) &&
+    if ((s->type == TYPE_DISK || s->type == TYPE_TAPE || s->type == TYPE_ZBC) &&
         blk_is_read_only(s->conf.blk) &&
         (r->req.cmd.buf[0] == MODE_SENSE ||
          r->req.cmd.buf[0] == MODE_SENSE_10) &&
@@ -617,7 +619,7 @@ static void scsi_generic_read_device_identification(SCSIDevice *s)
 void scsi_generic_read_device_inquiry(SCSIDevice *s)
 {
     scsi_generic_read_device_identification(s);
-    if (s->type == TYPE_DISK) {
+    if (s->type == TYPE_DISK || s->type == TYPE_ZBC) {
         scsi_generic_set_vpd_bl_emulation(s);
     } else {
         s->needs_vpd_bl_emulation = false;
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 874176019e..2a32c08b5e 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -218,6 +218,7 @@
 #define TYPE_ENCLOSURE      0x0d    /* Enclosure Services Device */
 #define TYPE_RBC            0x0e    /* Simplified Direct-Access Device */
 #define TYPE_OSD            0x11    /* Object-storage Device */
+#define TYPE_ZBC            0x14    /* Host-managed Zoned SCSI Device */
 #define TYPE_WLUN           0x1e    /* Well known LUN */
 #define TYPE_NOT_PRESENT    0x1f
 #define TYPE_INACTIVE       0x20
-- 
2.26.2



