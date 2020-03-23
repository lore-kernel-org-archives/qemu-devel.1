Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D4C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB8720722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRxjntSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB8720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQBG-0000Fj-II
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQAe-0008EI-V2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQAd-0005lz-Ju
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:43:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGQAc-0005lF-RD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:43:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id p10so5532509wrt.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/n6IqjRnzQwn9OgJiIphU3qnPEgngPDRG3PtfiwJ4qk=;
 b=NRxjntSKnhh9cuYpICqvqbe+5VDzXuLAOjYJ5Vb/FaXOe+Vntbb+vKct0kXsLg6Tv0
 QWkBpP3UmWolQDRckN3ukCTsNnKo08mHxum4mzpw6tG/JjH7/LDftIBFpx9gM2ZorH5x
 Mhe1Rv4a53jXiRby8HHP5xNaiXInzhaCpfJyRDe/zH2bhfYRPp0O+7Do7+RNINvhajV5
 dljhVMYNAYdqpn2s5o4oWBMNnyXftom+ctI5zzNztzh2yuuO2fC6axL35HhzsAMMar7c
 1bu6pvUhIFN5uPeItM6P1li2m7hzTC6m9bXE1vX5VZiray6gPwTUrU5N4X4H9ora+9He
 l/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/n6IqjRnzQwn9OgJiIphU3qnPEgngPDRG3PtfiwJ4qk=;
 b=EWd+Uxu5Yyh9kc4WYFDTY7Cvrdh7ujVxUG+6a9nvkp3RNqSkPLpDiXcQ7XfOwBa5ar
 O4+hH7UbztH2HsXLCgOtGLNPdI3wnvUtOh6Cnb1C3d709j/YGfLR6qByIlcfqh8PzMrZ
 s6ZTNqbY4/1A6LPyXuWt94qVJ1PwTbk0h0C5gJWfiVVN679aZ0mIDMvet8CxhAnzhSMk
 cI6d9ekcnlVIRc46x3W8YDLUR2tuRj1LA/nTRDA7fRnHMpHWXWsPQpCroIk/bN9gf0qQ
 0TXNYbyyjcgaRy8hXfse/JXsJMlGcB2xhsH8+3rtpoXfpICFA1Qi9jPaPTlnVusMxoUe
 d2vw==
X-Gm-Message-State: ANhLgQ3Yud5Vg8Ai6/a3qwKpi5RThwHnxTcCWnAYPw2pBEQ5D+/Tpk1U
 RamdmGCQ/a7owOa+UXimJOKI5HczgQNY1g==
X-Google-Smtp-Source: ADFU+vuKOy8jajjJhmhzqHPvB3MT8/sixoy6pVIJWxEIeLGqaKFXu7CbBFTVuUuDcyuYaC4GIyK2Qg==
X-Received: by 2002:adf:e98b:: with SMTP id h11mr11516307wrm.409.1584981800964; 
 Mon, 23 Mar 2020 09:43:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k3sm167767wmf.16.2020.03.23.09.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:43:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC] hw/usb/xen-usb.c: Pass struct usbback_req* to
 usbback_packet_complete()
Date: Mon, 23 Mar 2020 16:43:18 +0000
Message-Id: <20200323164318.26567-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function usbback_packet_complete() currently takes a USBPacket*,
which must be a pointer to the packet field within a struct
usbback_req; the function uses container_of() to get the struct
usbback_req* given the USBPacket*.

This is unnecessarily confusing (and in particular it confuses the
Coverity Scan analysis, resulting in the false positive CID 1421919
where it thinks that we write off the end of the structure). Since
both callsites already have the pointer to the struct usbback_req,
just pass that in directly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is an RFC because:
 * I'm not very familiar with the Xen bits of QEMU
 * the main rationale here is to change something that's
   confusing Coverity -- the code as it stands isn't wrong
 * the only testing I've done is "make check"
Still, the change seems like a good thing to me as a human reader...

PS: QEMU's MAINTAINERS file stanza for Xen doesn't pick up
that this file is Xen related, so it could use an extra F: line.

 hw/usb/xen-usb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 1fc2f32ce93..961190d0f78 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -347,13 +347,11 @@ static int32_t usbback_xlat_status(int status)
     return -ESHUTDOWN;
 }
 
-static void usbback_packet_complete(USBPacket *packet)
+static void usbback_packet_complete(struct usbback_req *usbback_req)
 {
-    struct usbback_req *usbback_req;
+    USBPacket *packet = &usbback_req->packet;
     int32_t status;
 
-    usbback_req = container_of(packet, struct usbback_req, packet);
-
     QTAILQ_REMOVE(&usbback_req->stub->submit_q, usbback_req, q);
 
     status = usbback_xlat_status(packet->status);
@@ -566,7 +564,7 @@ static void usbback_dispatch(struct usbback_req *usbback_req)
 
     usb_handle_packet(usbback_req->stub->dev, &usbback_req->packet);
     if (usbback_req->packet.status != USB_RET_ASYNC) {
-        usbback_packet_complete(&usbback_req->packet);
+        usbback_packet_complete(usbback_req);
     }
     return;
 
@@ -993,7 +991,7 @@ static void xen_bus_complete(USBPort *port, USBPacket *packet)
 
     usbif = usbback_req->usbif;
     TR_REQ(&usbif->xendev, "\n");
-    usbback_packet_complete(packet);
+    usbback_packet_complete(usbback_req);
 }
 
 static USBPortOps xen_usb_port_ops = {
-- 
2.20.1


