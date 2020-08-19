Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B014320738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HO1alSUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B014320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Gx8-0000mc-SD
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwK-0007UY-Ls
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwH-0006hd-Jx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Q58pM6hzCpeUvPleshLRLxqTZwkCFL5s1oyv7sseI5Y=;
 b=HO1alSUvgGG3k71XrhK7Q8nKrHwF7EmO6DZL0ZCjWiSCu3hHzqraxdT9DZeJX7GTXO2ZYP
 N0DxjnFtWiOfyQOEBmzo8M4FQWql8D9DyU+w1w8n7W5tWyiCsti4R5vY5WhTFa5j5kQ4F7
 GqTR9CxZLf3rSx4JViXvlFzA4AfHeos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-lMez1liVOaeMtZA0iCDf9w-1; Wed, 19 Aug 2020 01:46:49 -0400
X-MC-Unique: lMez1liVOaeMtZA0iCDf9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81F081084C87;
 Wed, 19 Aug 2020 05:46:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3121C600DD;
 Wed, 19 Aug 2020 05:46:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 582B29AE2; Wed, 19 Aug 2020 07:46:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] hw: xhci: check return value of 'usb_packet_map'
Date: Wed, 19 Aug 2020 07:46:28 +0200
Message-Id: <20200819054644.30610-2-kraxel@redhat.com>
In-Reply-To: <20200819054644.30610-1-kraxel@redhat.com>
References: <20200819054644.30610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:38:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@163.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

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

Buglink: https://bugs.launchpad.net/qemu/+bug/1891341
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-id: 20200812153139.15146-1-liq3ea@163.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 67a18fe2b64c..46a2186d912a 100644
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
2.18.4


