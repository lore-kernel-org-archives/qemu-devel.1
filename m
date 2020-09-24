Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D4023600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3AIuFFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D4023600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOUr-0008VV-AW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUx-0003O7-7E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUo-0006Ht-2f
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRx9VPEInYcDlJiu1UzYV+oCMUQGsOR+qty0u0XiqXQ=;
 b=c3AIuFFdAReB6sGXCA/itlIk24b6kchArqAFTgrbikGRcEKmDMICTC347qis6i+wnZW95l
 Szs/Os5N0MIGatgx5OkshXoUkVobJpMEALKVvw8WNAYx3fyHCc75rB7BFPbqko99UVfPQn
 4yq8ESoo0PhcudjyzSYdV+WM8oEsC3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-XXx1uAUZMDCEnjQoV4570A-1; Thu, 24 Sep 2020 05:24:54 -0400
X-MC-Unique: XXx1uAUZMDCEnjQoV4570A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A68F39CC1A;
 Thu, 24 Sep 2020 09:24:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 860455576C;
 Thu, 24 Sep 2020 09:24:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 87/92] hw/net/can: sja1000 ignore CAN FD frames
Date: Thu, 24 Sep 2020 05:23:09 -0400
Message-Id: <20200924092314.1722645-88-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
Message-Id: <48d9ebf6b64e7652851c12fe4566e06b44803372.1600069689.git.pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/can/can_sja1000.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index ec66d4232d..42d2f99dfb 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -323,11 +323,16 @@ static void buff2frame_bas(const uint8_t *buff, qemu_can_frame *frame)
 static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
 {
     int i;
+    int dlen = frame->can_dlc;
 
     if (frame->can_id & QEMU_CAN_ERR_FLAG) { /* error frame, NOT support now. */
         return -1;
     }
 
+    if (dlen > 8) {
+        return -1;
+    }
+
     buff[0] = 0x0f & frame->can_dlc; /* DLC */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[0] |= (1 << 6);
@@ -338,18 +343,18 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
         buff[2] = extract32(frame->can_id, 13, 8); /* ID.20~ID.13 */
         buff[3] = extract32(frame->can_id, 5, 8);  /* ID.12~ID.05 */
         buff[4] = extract32(frame->can_id, 0, 5) << 3; /* ID.04~ID.00,xxx */
-        for (i = 0; i < frame->can_dlc; i++) {
+        for (i = 0; i < dlen; i++) {
             buff[5 + i] = frame->data[i];
         }
-        return frame->can_dlc + 5;
+        return dlen + 5;
     } else { /* SFF */
         buff[1] = extract32(frame->can_id, 3, 8); /* ID.10~ID.03 */
         buff[2] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
-        for (i = 0; i < frame->can_dlc; i++) {
+        for (i = 0; i < dlen; i++) {
             buff[3 + i] = frame->data[i];
         }
 
-        return frame->can_dlc + 3;
+        return dlen + 3;
     }
 
     return -1;
@@ -358,6 +363,7 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
 static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
 {
     int i;
+    int dlen = frame->can_dlc;
 
      /*
       * EFF, no support for BasicMode
@@ -369,17 +375,21 @@ static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
         return -1;
     }
 
+    if (dlen > 8) {
+        return -1;
+    }
+
     buff[0] = extract32(frame->can_id, 3, 8); /* ID.10~ID.03 */
     buff[1] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[1] |= (1 << 4);
     }
     buff[1] |= frame->can_dlc & 0x0f;
-    for (i = 0; i < frame->can_dlc; i++) {
+    for (i = 0; i < dlen; i++) {
         buff[2 + i] = frame->data[i];
     }
 
-    return frame->can_dlc + 2;
+    return dlen + 2;
 }
 
 static void can_sja_update_pel_irq(CanSJA1000State *s)
@@ -766,6 +776,13 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
     if (frames_cnt <= 0) {
         return 0;
     }
+    if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
+        if (DEBUG_FILTER) {
+            can_display_msg("[cansja]: ignor fd frame ", frame);
+        }
+        return 1;
+    }
+
     if (DEBUG_FILTER) {
         can_display_msg("[cansja]: receive ", frame);
     }
-- 
2.26.2



