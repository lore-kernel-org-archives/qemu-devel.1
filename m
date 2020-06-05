Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552F12074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzdQMNbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552F12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9XU-0008Ri-Go
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9V0-0003Bv-2M
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Uz-0006MI-4W
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRYsrlcMJ+je+ABJIYEYDBzMrp4zayKgKqABdV4YMxU=;
 b=AzdQMNbswDE50oqk2Y3c1LUIYmCjo0rqC7qlC2bV9xNfCoQfL8cnYRQAp4ImNisY+oaQwm
 wc2Jgggr7KSoBEzrT6S5AuP1uDO6xqpisfekWhEvQ23Ckzwdkf9bLTI3Oxj/8r+AL0wBcw
 mUDSmvS4H5jiEvRdlTjR/8fVhT5EfOI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-0TdILqnZPNCgn9a0Y5tM2A-1; Fri, 05 Jun 2020 06:22:48 -0400
X-MC-Unique: 0TdILqnZPNCgn9a0Y5tM2A-1
Received: by mail-wr1-f70.google.com with SMTP id e1so3612158wrm.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cRYsrlcMJ+je+ABJIYEYDBzMrp4zayKgKqABdV4YMxU=;
 b=TWcg5Pj3LPo3TBHBgLY6pvsPPkMhziRUgTTDoI6w4qnQpstM6VwYhFIb7MJZy63Nyt
 0iPAdjqW774N/Ptoq82XFLr2Nk72bFvYagO8zVSrBDmBDpjhIVQJmN8Br6jxvk9rzp20
 ZPenWjbdO3M7D7mEhnshFw50Wn88tV4dpiUy4VUBGRU8wf8ILb1zxc57AP5l60DWcdNV
 uT+7lEb2p0blbJGpNwTbidmJdn5f1trfT7d+SuM81HWAeLaOrhIN/IWgdp1ZAxJ4XNvl
 uO7yUik91063Fs7XoaW/BwF+GjRddMVRxkOvubx5arxVHkbAZ7z7KwqGS1VLFsIaYzHR
 IDSQ==
X-Gm-Message-State: AOAM532njREEoNN2vY1HlTzwGqaaMic5zPghq3p7iUGh3kE3UM9qO+Lx
 hIeACo+gUU4s59Q9lisXu4TeD6HHp2uAZ+kra6IAiYCylUNMSHuwxK1X1N6Q2KWzbVhZVKzmL57
 LlucCq42BDp269eA=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr8438670wru.427.1591352567295; 
 Fri, 05 Jun 2020 03:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+JLK9/ntgQbZo38cdkK2hTaX6oy5bAz5lch6x0izVj6+m863pEHDAQYaFM3i917menv3kvQ==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr8438653wru.427.1591352567016; 
 Fri, 05 Jun 2020 03:22:47 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 5sm10953453wmd.19.2020.06.05.03.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:22:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/11] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
Date: Fri,  5 Jun 2020 12:22:22 +0200
Message-Id: <20200605102230.21493-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Only move the state machine to ReceivingData if there is no
pending error.  This avoids later OOB access while processing
commands queued.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.3 Data Read

  Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

  4.3.4 Data Write

  Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

Fixes: CVE-2020-13253
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 64 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f1b12b49db..90d5ff6209 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1150,13 +1150,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
             if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1167,13 +1169,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
             if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1213,20 +1217,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (sd->data_start + sd->blk_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
+                sd->card_status |= WP_VIOLATION;
+                return sd_r1;
+            }
+            if (sd->csd[14] & 0x30) {
+                sd->card_status |= WP_VIOLATION;
+                return sd_r1;
+            }
+
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
-
-            if (sd->data_start + sd->blk_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-            }
-            if (sd_wp_addr(sd, sd->data_start)) {
-                sd->card_status |= WP_VIOLATION;
-            }
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-            }
             return sd_r1;
 
         default:
@@ -1240,20 +1248,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (sd->data_start + sd->blk_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
+                sd->card_status |= WP_VIOLATION;
+                return sd_r1;
+            }
+            if (sd->csd[14] & 0x30) {
+                sd->card_status |= WP_VIOLATION;
+                return sd_r1;
+            }
+
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
-
-            if (sd->data_start + sd->blk_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-            }
-            if (sd_wp_addr(sd, sd->data_start)) {
-                sd->card_status |= WP_VIOLATION;
-            }
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-            }
             return sd_r1;
 
         default:
-- 
2.21.3


