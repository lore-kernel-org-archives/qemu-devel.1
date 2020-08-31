Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85842C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB502073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAxkrFCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB502073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfNJ-0006mD-EJ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFh-0008R5-6k
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFd-0006d3-5A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVf/UE+JMYlpL1srU0dpkzi9EtkgTXpYauLVVSsyaJo=;
 b=bAxkrFCspS2Ideqlccu8mbP2j85a+N8BN8DQ2kipEnX6r1fP2IuGovP3Lt0kZKyP2MH8RD
 TodbMhVj3N8gONAg+BotMWjOlZZ5pqB5/V0S8FBWCgybzXl6rRzXT0htPhAo+OO2vjCK/u
 a4RZ1d9McugEflKMcV2IF3URHexsqH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-wqceQQviMruu0PjBXGVj5g-1; Mon, 31 Aug 2020 04:33:07 -0400
X-MC-Unique: wqceQQviMruu0PjBXGVj5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2CF4802B7B;
 Mon, 31 Aug 2020 08:33:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCF1E81183;
 Mon, 31 Aug 2020 08:33:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E59359C90; Mon, 31 Aug 2020 10:33:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] hw: xhci: check return value of 'usb_packet_map'
Date: Mon, 31 Aug 2020 10:32:44 +0200
Message-Id: <20200831083301.6357-2-kraxel@redhat.com>
In-Reply-To: <20200831083301.6357-1-kraxel@redhat.com>
References: <20200831083301.6357-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 Alexander Bulekov <alxndr@bu.edu>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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
2.27.0


