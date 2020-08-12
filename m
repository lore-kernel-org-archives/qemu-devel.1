Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422BAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EF9207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GlM1pmOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EF9207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5skz-0006Qv-80
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k5skS-00061E-Mg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:33:04 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:60964)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1k5skK-0003bD-Jd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=u2yv/k47RsBsknn3xb
 BIKcTeAGHoWv8+YLZNRmou1ws=; b=GlM1pmOTvxR40nXuEEKH403V3Z7XcojCr/
 40pES6/XuKP3VXiP5NJT+4rmCylfRzHWa1pjfPeZtVgSO6siFCf7RDuSrUgWsj/V
 flP5QMVBGm78NOKEicvdSd/9kQ9rYXmvNrhOIGaaFY34YkUDcKoI2WGDC/idLW6t
 1jCUmwSwg=
Received: from localhost.localdomain (unknown [115.204.177.14])
 by smtp1 (Coremail) with SMTP id GdxpCgAn4yJkCzRfJYmZAQ--.697S4;
 Wed, 12 Aug 2020 23:31:49 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: kraxel@redhat.com,
	alxndr@bu.edu
Subject: [PATCH] hw: xhci: check return value of 'usb_packet_map'
Date: Wed, 12 Aug 2020 08:31:39 -0700
Message-Id: <20200812153139.15146-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgAn4yJkCzRfJYmZAQ--.697S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr18Jw4rtFW7Jw1Utw1rXrb_yoW8urWfpF
 Wj9FyvgF4rtry8CFnxAr4UAa15Gw4kAFn7uryIqF4jvF4UXw1YqFWYqrWfur13GFy7Jw1U
 GF4qyFZYqr17Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQmRUUUUUU=
X-Originating-IP: [115.204.177.14]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbitAd+bVSIiQ6OMAAAsF
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 11:32:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we don't check the return value of 'usb_packet_map',
this will cause an UAF issue. This is LP#1891341.
Following is the reproducer provided in:
-->https://bugs.launchpad.net/qemu/+bug/1891341

cat << EOF | ./i386-softmmu/qemu-system-i386 -device nec-usb-xhci \
-trace usb\* -device usb-audio -device usb-storage,drive=mydrive \
-drive id=mydrive,file=null-co://,size=2M,format=raw,if=none \
-nodefaults -nographic -qtest stdio
outl 0xcf8 0x80001016
outl 0xcfc 0x3c009f0d
outl 0xcf8 0x80001004
outl 0xcfc 0xc77695e
writel 0x9f0d000000000040 0xffff3655
writeq 0x9f0d000000002000 0xff2f9e0000000000
write 0x1d 0x1 0x27
write 0x2d 0x1 0x2e
write 0x17232 0x1 0x03
write 0x17254 0x1 0x06
write 0x17278 0x1 0x34
write 0x3d 0x1 0x27
write 0x40 0x1 0x2e
write 0x41 0x1 0x72
write 0x42 0x1 0x01
write 0x4d 0x1 0x2e
write 0x4f 0x1 0x01
writeq 0x9f0d000000002000 0x5c051a0100000000
write 0x34001d 0x1 0x13
write 0x340026 0x1 0x30
write 0x340028 0x1 0x08
write 0x34002c 0x1 0xfe
write 0x34002d 0x1 0x08
write 0x340037 0x1 0x5e
write 0x34003a 0x1 0x05
write 0x34003d 0x1 0x05
write 0x34004d 0x1 0x13
writeq 0x9f0d000000002000 0xff00010100400009
EOF

This patch fixes this.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/usb/hcd-xhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36fe6..42f93ba048 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1615,7 +1615,10 @@ static int xhci_setup_packet(XHCITransfer *xfer)
     xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
     usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
                      xfer->trbs[0].addr, false, xfer->int_req);
-    usb_packet_map(&xfer->packet, &xfer->sgl);
+    if (usb_packet_map(&xfer->packet, &xfer->sgl)) {
+        qemu_sglist_destroy(&xfer->sgl);
+        return -1;
+    }
     DPRINTF("xhci: setup packet pid 0x%x addr %d ep %d\n",
             xfer->packet.pid, ep->dev->addr, ep->nr);
     return 0;
-- 
2.17.1


