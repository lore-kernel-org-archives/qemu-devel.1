Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CFEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010E02075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="miu2FzPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010E02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mbS-00006r-8M
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k8mZ7-00063N-Hd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:33:21 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:50530)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k8mYx-0001JG-Vx
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=SGo0/rZjkdIaHgPdjA
 l4VR7TZNzaaVx7v4AaOvg0zO4=; b=miu2FzPpLBBeSI7Av2ArhhxyH76QzPCzTo
 ncbr3TUmRGBAwKhSEFxoBZHf3R75UQy9ZF1lkHadEhmHANTs2yoxuMcfO8EA31nM
 j+A+BgWoRcVzaCDJzl3m7AJshmbI4W2NORpk6tEKOILCARwPTdjkdIlb3QQwejR5
 BXDn38qKA=
Received: from localhost.localdomain (unknown [36.27.24.138])
 by smtp5 (Coremail) with SMTP id HdxpCgC3gtuNlz5f3eOdEg--.39S4;
 Thu, 20 Aug 2020 23:32:30 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: kraxel@redhat.com
Subject: [PATCH] hw: cirrus_vga: mask 'off_begin' in cirrus_invalidate_region()
Date: Thu, 20 Aug 2020 08:32:28 -0700
Message-Id: <20200820153228.85587-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgC3gtuNlz5f3eOdEg--.39S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry7uFWUuFWDZF4UWw43GFg_yoW8trW5p3
 4jk3ZxX34UGr18Aw15G3WrCwsIkryUta1qk3y5Gr1kWF1Utw17A3W5tF4Ygw1ru3W8Ars8
 Kr42yrWkGr1qvwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziuyI5UUUUU=
X-Originating-IP: [36.27.24.138]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBaw+GbVet1slXngAAsj
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 11:32:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: alxndr@bu.edu, liq3ea@gmail.com, qemu-devel@nongnu.org,
 Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the while loop of cirrus_invalidate_region() the 'off_begin'
increases every loop. It may be greater than 's->cirrus_addr_mask' thus
trigger the assert in the loop.

Following reproducer is provied in:

-->https://bugs.launchpad.net/qemu/+bug/1880189

qemu-system-i386 -M isapc,accel=qtest -vga cirrus -qtest stdio << 'EOF'
outl 0x03b1 0x2fdc1001
outb 0x03cc 0xe
outb 0x03cc 0xe
outb 0x03cc 0x2f
outb 0x03cc 0xe
outb 0x03cc 0x2f
outb 0x03cc 0xe
outl 0x03cc 0xedc100e
outb 0x03cc 0x2f
outl 0x03cc 0xe24f40e
outl 0x03cc 0x2f23dc12
outl 0x03cc 0xe23f40e
outl 0x03cc 0xe31dc12
outb 0x03cc 0x2f
outl 0x03cc 0xe2af40e
outl 0x03cc 0x2f235612
outl 0x03cc 0xe23f40e
outl 0x03cc 0xe31dc12
outb 0x03cc 0x2f
outl 0x03cc 0x2fdcf40e
outb 0x03cc 0xe
outl 0x03cc 0xedc100e
outb 0x03cc 0x2f
outl 0x03cc 0xe24f40e
outl 0x03cc 0xe23dc12
outb 0x03cc 0x2f
outl 0x03cc 0xedc100e
outl 0x03cc 0x2fdc400e
outb 0x03cc 0xe
outl 0x03cc 0xe130100e
outb 0x03cc 0x2f
outl 0x03cc 0xe23f40e
outl 0x03cc 0xe31dc12
outb 0x03cc 0x2f
outl 0x03cc 0xe33f40e
outl 0x03cc 0xdc235612
outb 0x03cc 0xe
outl 0x03cc 0x2fdc400e
outb 0x03cc 0xe
outl 0x03cc 0xfb24100e
outb 0x03cc 0x2f
outl 0x03cc 0xdc10dc0e
outl 0x03cc 0x2f31dc12
outl 0x03cc 0xe23f40e
outl 0x03cc 0xe31dc12
outb 0x03cc 0x2f
outl 0x03cc 0xe23f40e
outl 0x03cc 0xe31dc12
outb 0x03cc 0x2f
outl 0x03cc 0x1021f40e
EOF

This patch fixes this.

Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/display/cirrus_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 212d6f5e61..93fabd19a7 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -644,7 +644,7 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
         off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
         assert(off_cur_end >= off_cur);
         memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
-        off_begin += off_pitch;
+        off_begin = (off_begin + off_pitch) & s->cirrus_addr_mask;
     }
 }
 
-- 
2.17.1


