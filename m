Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655B4C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C05E20854
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="UqKDrQFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C05E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHrPB-00036O-D7
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 10:55:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrNi-0002DZ-MC
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-00019P-VJ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:37 -0400
Received: from m12-13.163.com ([220.181.12.13]:58274)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-000169-9s
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=nto7dRdt8+6HlFMrTC
	L4RjigEIgC4k8QVhUb2RlYSSc=; b=UqKDrQFmctzTyKnTzenjoP1bx3Ou6Jd5os
	mqwqu69+WvOkY7e42YYz2VNfczDeR66eDz/y2fELufZS8eSEIbbM7j8w9+dywRjo
	TVqPuN+RKeuU7v4EIGKqQNyqKgxO5+lusFTSBnK1YGM8c9pNElcmPLxVa9SDxEhp
	vjqQr3hog=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowABXKKbvMbtc5Pi_Ag--.9861S4;
	Sat, 20 Apr 2019 22:51:30 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 07:51:19 -0700
Message-Id: <20190420145120.122847-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420145120.122847-1-liq3ea@163.com>
References: <20190420145120.122847-1-liq3ea@163.com>
X-CM-TRANSID: DcCowABXKKbvMbtc5Pi_Ag--.9861S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUx1CJUUUUU
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBaxKcbVetu+ZtOAAAs6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH 2/3] edu: mmio: allow mmio read dispatch accept
 8 bytes
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
Message-ID: <20190420145119.eFnidMhYqseUU0fG3W668OP8JkrffAhIcw1C7l9QZgE@z>

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



