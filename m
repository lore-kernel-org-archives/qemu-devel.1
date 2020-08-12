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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF03C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2740D2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cxgjsWsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2740D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tTL-0001mv-Fa
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k5tRX-00088v-T5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:17:35 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:48532)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1k5tRV-0000ro-QH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=iY81cxWdJw4lIYtwVt
 sOx9r7yB42oXXD9xUYFBQlRgA=; b=cxgjsWsQAeWhdbx0mu+l9wXhJB9GmGw88W
 vLNvn6kjFfLI1HS13GTmUk9eWzuGMhYweS9vCFjQfwAhSNUckJ5dP4D+TyjNmBLy
 3hig8jen0BqTo5eIV+lS7uIPyBfAr7jzTkGTsrzIpYhvKIPdPARHiayS26LxUbgu
 0nLNxyNxU=
Received: from localhost.localdomain (unknown [115.204.177.14])
 by smtp1 (Coremail) with SMTP id GdxpCgDn3NkZFjRfTrSfAQ--.821S4;
 Thu, 13 Aug 2020 00:17:30 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: kraxel@redhat.com
Subject: [PATCH 2/2] hw: ehci: check return value of 'usb_packet_map'
Date: Wed, 12 Aug 2020 09:17:27 -0700
Message-Id: <20200812161727.29412-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgDn3NkZFjRfTrSfAQ--.821S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF13AF17CF4rJrW5GF1Utrb_yoW8Jw13p3
 Z8WF95Kw1ft3Z0qF4fA3WFyr1jyw4vyryIkayxXw1IvwsFg39Yqr109rZ5CFyqqFyrua1U
 Wr4DXr1Y9a12vrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhYFZUUUUU=
X-Originating-IP: [115.204.177.14]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKRp+bVXlxT0x-wAAsm
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

If 'usb_packet_map' fails, we should stop to process the usb
request.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/usb/hcd-ehci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 58cceacbf8..4da446d2de 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1373,7 +1373,10 @@ static int ehci_execute(EHCIPacket *p, const char *action)
         spd = (p->pid == USB_TOKEN_IN && NLPTR_TBIT(p->qtd.altnext) == 0);
         usb_packet_setup(&p->packet, p->pid, ep, 0, p->qtdaddr, spd,
                          (p->qtd.token & QTD_TOKEN_IOC) != 0);
-        usb_packet_map(&p->packet, &p->sgl);
+        if (usb_packet_map(&p->packet, &p->sgl)) {
+            qemu_sglist_destroy(&p->sgl);
+            return -1;
+        }
         p->async = EHCI_ASYNC_INITIALIZED;
     }
 
@@ -1453,7 +1456,10 @@ static int ehci_process_itd(EHCIState *ehci,
             if (ep && ep->type == USB_ENDPOINT_XFER_ISOC) {
                 usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false,
                                  (itd->transact[i] & ITD_XACT_IOC) != 0);
-                usb_packet_map(&ehci->ipacket, &ehci->isgl);
+                if (usb_packet_map(&ehci->ipacket, &ehci->isgl)) {
+                    qemu_sglist_destroy(&ehci->isgl);
+                    return -1;
+                }
                 usb_handle_packet(dev, &ehci->ipacket);
                 usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
             } else {
-- 
2.17.1


