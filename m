Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B6C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 04:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697C4227BF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 04:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697C4227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifcS1-0001pO-Po
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 23:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1ifaiC-0008Ej-TQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 21:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1ifaiA-0004OJ-Og
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 21:29:47 -0500
Received: from email6.ustc.edu.cn ([2001:da8:d800::8]:33264 helo=ustc.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1ifai9-0003pQ-U5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 21:29:46 -0500
Received: from lxy.loongson.cn (unknown [114.242.206.180])
 by newmailweb.ustc.edu.cn (Coremail) with SMTP id
 LkAmygBnbc2F9_Jd4kJhAQ--.3943S2; 
 Fri, 13 Dec 2019 10:29:27 +0800 (CST)
From: Xinyu Li <precinct@mail.ustc.edu.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user:Fix align mistake when mmap guest space
Date: Fri, 13 Dec 2019 10:29:19 +0800
Message-Id: <20191213022919.5934-1-precinct@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: LkAmygBnbc2F9_Jd4kJhAQ--.3943S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWrWFykXF4xJw1rXrWrXwb_yoW8Gw15pF
 ZxCrn7WrWjqFy5Xw17t3sakw4jqas0kFWYkry3A348ArsxXF1a9rnFga4UWrWDCF4vgw4q
 9FZ5twn7Ww1UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-CM-SenderInfo: 5suhuxxqfwqzxdloh3xvwfhvlgxou0/
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:da8:d800::8
X-Mailman-Approved-At: Thu, 12 Dec 2019 23:10:17 -0500
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu, Xinyu Li <precinct@mail.ustc.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In init_guest_space, we need to mmap guest space. If the return address
of first mmap is not aligned with align, which was set to MAX(SHMLBA,
qemu_host_page_size), we need unmap and a new mmap(space is larger than
first size). The new size is named real_size, which is aligned_size +
qemu_host_page_size. alugned_size is the guest space size. And add a
qemu_host_page_size to avoid memory error when we align real_start
manually (ROUND_UP(real_start, align)). But when SHMLBA >
qemu_host_page_size, the added size will smaller than the size to align,
which can make a mistake(in a mips machine, it appears). So change
real_size from aligned_size +qemu_host_page_size
to aligned_size + align will solve it.

Signed-off-by: Xinyu Li <precinct@mail.ustc.edu.cn>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6693e5760..312ded0779 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2189,7 +2189,7 @@ unsigned long init_guest_space(unsigned long host_start,
              * to where we need to put the commpage.
              */
             munmap((void *)real_start, host_size);
-            real_size = aligned_size + qemu_host_page_size;
+            real_size = aligned_size + align;
             real_start = (unsigned long)
                 mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
             if (real_start == (unsigned long)-1) {
-- 
2.17.1



