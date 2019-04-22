Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91964C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5988D20685
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jEblY0WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5988D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIZz1-00026a-MZ
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 10:31:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwF-0007vk-TN
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgs-0005LK-6y
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
Received: from m12-12.163.com ([220.181.12.12]:58458)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgr-0005J2-J8
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=ocpxbx74syTndxPAzj
	CBgtsjTGrKulmkE9I+7Wjy7y8=; b=jEblY0WWsbJd32TqMq9FfXfXlz1M/C5uFR
	zkcq0fcoxGYEvBPn0zxxKR4sSciaciZ4TdNDg+3PkkwYQogI+G3nfzoqNH43cR7c
	ttpfalnQaQojET6OkgIx4fIZvt28FDzTyL/PeJuV8UPjtBC9kb48cP+VkBcPv2UC
	vSxul3U4w=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp8 (Coremail) with SMTP id DMCowACXUzO0y71cvQ2cBg--.39054S4;
	Mon, 22 Apr 2019 22:12:08 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Mon, 22 Apr 2019 07:11:55 -0700
Message-Id: <20190422141156.15746-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422141156.15746-1-liq3ea@163.com>
References: <20190422141156.15746-1-liq3ea@163.com>
X-CM-TRANSID: DMCowACXUzO0y71cvQ2cBg--.39054S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrJryrCw15Zr4UAr13CryxAFb_yoWxArc_X3
	yjka93ZrWq9Fyak3WqvFn5Zr17tw4rZrZxZw4Iqrs7ArZ0krWrA34v9FnrGr4SqrZxWryU
	Z3yDuF92kr9IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8t5r7UUUUU==
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbitByebVSIbq8CGwAAsf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.12
Subject: [Qemu-devel] [PATCH v3 2/3] edu: mmio: allow 64-bit access in read
 dispatch
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
Cc: philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
	Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422141155.gkF0PEbtx_GQgMdf83qyN9Htzs8yFWyWgp-EgCsamOc@z>

The edu spec says when address >= 0x80, the MMIO area can
be accessed by 64-bit.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v2:
Fix an error per Phillippe's advice

 hw/misc/edu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 65fc32b928..33de05141f 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
     EduState *edu = opaque;
     uint64_t val = ~0ULL;
 
-    if (size != 4) {
+    if (addr < 0x80 && size != 4) {
+        return val;
+    }
+
+    if (addr >= 0x80 && size != 4 && size != 8) {
         return val;
     }
 
-- 
2.17.1



