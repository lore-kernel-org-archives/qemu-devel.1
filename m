Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE705C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B0622B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CobZojqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B0622B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGcG-0002PS-NC
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGbD-0001qj-5j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:01:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGbB-0000vz-7P
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598529704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zE5Z/PVgsTj3IeGXFdZQDTapzomPjiQH8ioVEUKuTf8=;
 b=CobZojqg4DWDWabXxHr5amEOsMu3KuxPZVHHmAoM+Ahcyt3Qzvg1d1Xw4lTBRurJIrUp31
 uaO5yJeosrB0/P3yrXFTf0QKMAZNuumkGE33lO2WK9/iDHhE3qElzfrqcyPQYumAJGj23/
 0TU2C17vlchO5Q/1LieP4PQnGqRqve4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-H2Oic-H5NwuXdCzwIkt3kQ-1; Thu, 27 Aug 2020 08:01:39 -0400
X-MC-Unique: H2Oic-H5NwuXdCzwIkt3kQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929F21DE10;
 Thu, 27 Aug 2020 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-91.phx2.redhat.com
 [10.3.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABC667B9F3;
 Thu, 27 Aug 2020 12:01:36 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] xhci: check return value from usb_packet_map
Date: Thu, 27 Aug 2020 17:29:33 +0530
Message-Id: <20200827115933.1851563-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While setting up a packet in xhci_setup_packet() routine,
usb_packet_map() may return an error. Check this return value
before further processing the packet, to avoid use-after-free
issue.

 -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fxhci_uaf_2
  #0  __interceptor_free (/lib64/libasan.so.6+0xb0307)
  #1  qemu_vfree ../util/oslib-posix.c:247
  #2  address_space_unmap ../exec.c:3635
  #3  dma_memory_unmap ../include/sysemu/dma.h:145
  #4  usb_packet_unmap ../hw/usb/libhw.c:65
  #5  usb_packet_map ../hw/usb/libhw.c:54
  #6  xhci_setup_packet ../hw/usb/hcd-xhci.c:1618
  #7  xhci_fire_ctl_transfer ../hw/usb/hcd-xhci.c:1722
  #8  xhci_kick_epctx ../hw/usb/hcd-xhci.c:1991
  #9  xhci_kick_ep ../hw/usb/hcd-xhci.c:1861
  #10 xhci_doorbell_write ../hw/usb/hcd-xhci.c:3162
  ...

Reported-by: Ruhr-University <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/usb/hcd-xhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 67a18fe2b6..848e7e935f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1615,7 +1615,14 @@ static int xhci_setup_packet(XHCITransfer *xfer)
     xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
     usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
                      xfer->trbs[0].addr, false, xfer->int_req);
-    usb_packet_map(&xfer->packet, &xfer->sgl);
+    if (usb_packet_map(&xfer->packet, &xfer->sgl) < 0) {
+        DPRINTF("xhci: setup packet failed: pid: 0x%x addr %d ep %d\n",
+                xfer->packet.pid, ep->dev->addr, ep->nr);
+        usb_packet_cleanup(&xfer->packet);
+        qemu_sglist_destroy(&xfer->sgl);
+        return -1;
+    }
+
     DPRINTF("xhci: setup packet pid 0x%x addr %d ep %d\n",
             xfer->packet.pid, ep->dev->addr, ep->nr);
     return 0;
-- 
2.26.2


