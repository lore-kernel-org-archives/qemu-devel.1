Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC0C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE3820854
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="H6VeRnKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE3820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHsfW-0005tH-A2
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 12:16:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdm-0004qD-2g
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdl-0001sT-9U
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:58 -0400
Received: from m12-13.163.com ([220.181.12.13]:43525)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdj-0001pk-Qo
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=nto7dRdt8+6HlFMrTC
	L4RjigEIgC4k8QVhUb2RlYSSc=; b=H6VeRnKJG0WJgylteVj/2p0YduTNT3XSSK
	3Z6Zu9QkpVQyJXgOZXToFbBGKhICWY2GuiI4WvnaLOFaSJgZaGG5SEoQFsKICJ0D
	qEnWEhIpdjMP9iVpiUoxv7XgiDj9O8fuNBxoiiy80UMUXGMNNf7KJ7uWJ4lBvfUS
	6AL9880ao=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowAAXzKN4RbtcjaXHAg--.9660S4;
	Sun, 21 Apr 2019 00:14:52 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 09:14:45 -0700
Message-Id: <20190420161446.2274-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420161446.2274-1-liq3ea@163.com>
References: <20190420161446.2274-1-liq3ea@163.com>
X-CM-TRANSID: DcCowAAXzKN4RbtcjaXHAg--.9660S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcj2NDUUUU
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLxycbVUMI5lrMAAAs6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH v2 2/3] edu: mmio: allow mmio read dispatch
 accept 8 bytes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420161445.I_6NLxWgyQQWrhhNfE9ubmdHKd7pg0EXWudIx8yLSWs@z>

The edu spec said when address >= 0x80, the MMIO area can
be accessed by 8 bytes.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/misc/edu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 65fc32b928..4018dddcb8 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -189,6 +189,10 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
         return val;
     }
 
+    if (addr >= 0x80 && size != 4 && size != 8) {
+        return val;
+    }
+
     switch (addr) {
     case 0x00:
         val = 0x010000edu;
-- 
2.17.1



