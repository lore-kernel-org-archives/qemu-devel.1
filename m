Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B68020757
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="oC86i0we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B68020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFYT-00013u-LF
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 08:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1jNFX9-00082p-P2
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1jNFX7-0001w8-Uj
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:46:50 -0400
Received: from email6.ustc.edu.cn ([2001:da8:d800::8]:34065 helo=ustc.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1jNFX5-0001qX-Bh
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=B3Spx15nOr
 itC6UHHdhFr4XIxOPxo7WLYNHhCujyS5I=; b=oC86i0we1fB6dRdj8xIC3Og67X
 RQjdINXU5v+pEQhr0nEu5mqgVKs6GTS382j7Vm1sF6Uu56VlAs21hIAe8LpQEU4v
 GjqgXCXyLMM2tWAGENqFtdGNaVbs3YQCIfmh+lV6kkUIAqH7eCioq/ZoWw9GnHMw
 PrgEG+TdI4f5S9VGg=
Received: from localhost.localdomain (unknown [114.246.35.138])
 by newmailweb.ustc.edu.cn (Coremail) with SMTP id
 LkAmygDXgkwrvJFetTsMAA--.19507S2; 
 Sat, 11 Apr 2020 20:46:35 +0800 (CST)
From: lixinyu <precinct@mail.ustc.edu.cn>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com,
 lixinyu <precinct@mail.ustc.edu.cn>
Subject: [PATCH] tcg/mips: mips sync* encode error
Date: Sat, 11 Apr 2020 20:46:12 +0800
Message-Id: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDXgkwrvJFetTsMAA--.19507S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWDur47GFW3KFyUCF15urg_yoW8Gr1DpF
 1UCr1UKr10gFW5GrnxCr1UXFyxG393JFZ8A3Z2qr98X3Z0qrWqq34rtF40qF4jyrWrJ3yI
 vrW5Kr1aqa4xAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
 v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-CM-SenderInfo: 5suhuxxqfwqzxdloh3xvwfhvlgxou0/
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:da8:d800::8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OPC_SYNC_WMB, OPC_SYNC_MB, OPC_SYNC_ACQUIRE, OPC_SYNC_RELEASE and
OPC_SYNC_RMB have wrong encode. According to the mips manual,
their encode should be 'OPC_SYNC | 0x?? << 6' rather than
'OPC_SYNC | 0x?? << 5'. Wrong encode can lead illegal instruction
errors. These instructions often appear with multi-threaded
simulation.

Signed-off-by: lixinyu <precinct@mail.ustc.edu.cn>
---
 tcg/mips/tcg-target.inc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 1da663ce84..4d32ebc1df 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -404,11 +404,11 @@ typedef enum {
 
     /* MIPS r6 introduced names for weaker variants of SYNC.  These are
        backward compatible to previous architecture revisions.  */
-    OPC_SYNC_WMB     = OPC_SYNC | 0x04 << 5,
-    OPC_SYNC_MB      = OPC_SYNC | 0x10 << 5,
-    OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 5,
-    OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 5,
-    OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 5,
+    OPC_SYNC_WMB     = OPC_SYNC | 0x04 << 6,
+    OPC_SYNC_MB      = OPC_SYNC | 0x10 << 6,
+    OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 6,
+    OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 6,
+    OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 6,
 
     /* Aliases for convenience.  */
     ALIAS_PADD     = sizeof(void *) == 4 ? OPC_ADDU : OPC_DADDU,
-- 
2.20.1



