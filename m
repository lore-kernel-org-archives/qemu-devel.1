Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BBAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5048F2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNtWGwv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFdn-00064I-Fe
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY8-0001oE-NC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY7-0001gz-PZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id y20so2052047wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HjYqSzvHtl5IkDZCqrdUA6rE1xLPxwurQ8ThMttAuSk=;
 b=dNtWGwv2LFkot0wFJqToTlE/YJmpYC7aXQLsdqA06TqMXvjccOybvKOI60pBmJeuoF
 28deD0ebYz9Jm3TknnDqajIuxtRm7ZIs5abgR7w7dwjzXHJ3yftU/rqOAJicF/Dg3edd
 Hdc3QUEmK+8YF1+vTMHjNpCUnwRO+RXR9y+aHP4DUQwMv3R1reNWmKMCP4r1czbe8VH2
 wKcm6ien0sTJ5i7VTY+wIR2RHvN8zZ6XgwpcpfCmTXYjX2lUEhGU2h8lNMQqHD+mHtMn
 RjfSXmDvZDfgkmIf57UrVkU+7zYtWh8ge4l7tj7OF4XE4w5s0Mr9X/zUfgVdmixYE7OJ
 2K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HjYqSzvHtl5IkDZCqrdUA6rE1xLPxwurQ8ThMttAuSk=;
 b=JfV6gQEeB3jBYx/rfZrE/Fq6Zepi7139RmORwBliAP98eSmPhIJq7bJhYt01V+UJR9
 l0Yqa+R3FlNjJKDkvIKd++1ro7oyhhX1IhTvvppvknX/DgbKTJXYdQ0v4L5mZiKNUmYe
 ArzXvGC3gvtiW2VFcaqmrbFPWp/1zH0Z452nfYBVDliwohjOO8Vrz82VMqv4qAOAPpSo
 uqUcgVL8x5zsCc4IllF1qYMH03ogwqJ+0xyG/J+f3XIz1huEVc8+bZjdqquxn0Da/Wj8
 DxeaAfk7ov9sa7TOaQKY1RmSQymqeU3pT2UoYerpc162AXyRpk1qaFWlI1W63l959TrS
 Cncw==
X-Gm-Message-State: AOAM531EorsWg5F38iDmZLiB9abiKbM5cV2VBMJXFGUISQCx14pMnrvB
 +pgfU4bz+ZPkJhYnPkREivcNdl9hywYq3g==
X-Google-Smtp-Source: ABdhPJymlXPMMN7WmDMAcWndhiPJx1njmLtHIEUPaQxTDn2LsViPfLFa7iLzaSWjADCA9bVTT3yMBA==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr3746058wmg.21.1591375830120; 
 Fri, 05 Jun 2020 09:50:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/29] usb: add short-packet handling to usb-storage driver
Date: Fri,  5 Jun 2020 17:49:56 +0100
Message-Id: <20200605165007.12095-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Zimmerman <pauldzim@gmail.com>

The dwc-hsotg (dwc2) USB host depends on a short packet to
indicate the end of an IN transfer. The usb-storage driver
currently doesn't provide this, so fix it.

I have tested this change rather extensively using a PC
emulation with xhci, ehci, and uhci controllers, and have
not observed any regressions.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Message-id: 20200520235349.21215-6-pauldzim@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/dev-storage.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 4eba47538d8..a5204b6f2a3 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -229,6 +229,9 @@ static void usb_msd_copy_data(MSDState *s, USBPacket *p)
     usb_packet_copy(p, scsi_req_get_buf(s->req) + s->scsi_off, len);
     s->scsi_len -= len;
     s->scsi_off += len;
+    if (len > s->data_len) {
+        len = s->data_len;
+    }
     s->data_len -= len;
     if (s->scsi_len == 0 || s->data_len == 0) {
         scsi_req_continue(s->req);
@@ -303,6 +306,9 @@ static void usb_msd_command_complete(SCSIRequest *req, uint32_t status, size_t r
             if (s->data_len) {
                 int len = (p->iov.size - p->actual_length);
                 usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
+                }
                 s->data_len -= len;
             }
             if (s->data_len == 0) {
@@ -469,6 +475,9 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 int len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
+                    if (len > s->data_len) {
+                        len = s->data_len;
+                    }
                     s->data_len -= len;
                     if (s->data_len == 0) {
                         s->mode = USB_MSDM_CSW;
@@ -528,13 +537,17 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 int len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
+                    if (len > s->data_len) {
+                        len = s->data_len;
+                    }
                     s->data_len -= len;
                     if (s->data_len == 0) {
                         s->mode = USB_MSDM_CSW;
                     }
                 }
             }
-            if (p->actual_length < p->iov.size) {
+            if (p->actual_length < p->iov.size && (p->short_not_ok ||
+                    s->scsi_len >= p->ep->max_packet_size)) {
                 DPRINTF("Deferring packet %p [wait data-in]\n", p);
                 s->packet = p;
                 p->status = USB_RET_ASYNC;
-- 
2.20.1


