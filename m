Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B89C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2A320753
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GgoZGmKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2A320753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLq4o-00012q-E2
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jLq42-0008D7-9N
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jLq41-0000VR-8g
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:22:58 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:13489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jLq40-0000TJ-Sf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1586272977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qk1Y4jepw5ZUFH8O7s3prQyFWb+r4UOxrpJ04Jwz6vo=;
 b=GgoZGmKK8TkTo9wAHfUFKoEhYh/MDrfWcpPNJ1Y1JIrfmIqy8rvZHY6u
 tDz9e0Zt3WTw0El01IYb5I6lf/dU8Kg4GAtR8ANDISHSNhpdNtDjL51Be
 1aPnNz1EtCJYRY/0RaJjs3A5Bie29mmW5vJPCeCDNnXTysbMZT7Q//di9 4=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: uJfw3vKfJcYjs2uYVUJY2Vqq4/96T8V+v/wBgcIrMvNqvt5u1WxRVXNo6wLv9KOa+i4hoW+dp1
 nvxF367qo1JJakgKbTVrvv124fXRlU1hiM1DezCI8AD65BnARTYJPyEmjXkdZgyRbUAPLfm430
 /CqeFeUgiyHOPAsksTFtT24nF7GshbMxRELlvxmk1s+L6BEaASJLDYHTQE2n+Y7VatC/LvrAG/
 BpEnnGqdJeavXRQqX6usRCNYpETrfT8sLyjQPmM533ZTEbdhPsXW4syivaAfud+3Jo0h/T81q/
 KP4=
X-SBRS: 2.7
X-MesageID: 15534900
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,355,1580792400"; d="scan'208";a="15534900"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 1/3] hw/usb/xen-usb.c: Pass struct usbback_req* to
 usbback_packet_complete()
Date: Tue, 7 Apr 2020 16:22:35 +0100
Message-ID: <20200407152237.1468704-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407152237.1468704-1-anthony.perard@citrix.com>
References: <20200407152237.1468704-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200323164318.26567-1-peter.maydell@linaro.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/usb/xen-usb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 1fc2f32ce93d..961190d0f78c 100644
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
Anthony PERARD


