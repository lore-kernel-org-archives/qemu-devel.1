Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE8C4345E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F3020829
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F3020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=members.leeds.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Yfg-0006lg-5C
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 19:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <T.E.Baldwin99@members.leeds.ac.uk>)
 id 1k0YeR-0005pA-1w
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 19:04:51 -0400
Received: from [31.132.33.241] (port=47098 helo=pi.majoroak.me.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <T.E.Baldwin99@members.leeds.ac.uk>)
 id 1k0YeP-0003W1-3A
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 19:04:50 -0400
Received: from [2001:470:1f09:8f6:2e0:4cff:fe39:267e]
 (helo=localhost.localdomain)
 by pi.majoroak.me.uk with esmtp (Exim 4.92)
 (envelope-from <T.E.Baldwin99@members.leeds.ac.uk>)
 id 1k0YMa-0000mh-VC; Tue, 28 Jul 2020 23:46:37 +0100
From: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Date: Tue, 28 Jul 2020 23:46:15 +0100
Message-Id: <20200728224615.326675-1-T.E.Baldwin99@members.leeds.ac.uk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:470:1f09:8f6:2e0:4cff:fe39:267e
X-SA-Exim-Mail-From: T.E.Baldwin99@members.leeds.ac.uk
Subject: [PATCH] linux-user: Correctly start brk after executable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on pi.majoroak.me.uk)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 31.132.33.241 (failed)
Received-SPF: none client-ip=31.132.33.241;
 envelope-from=T.E.Baldwin99@members.leeds.ac.uk; helo=pi.majoroak.me.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 18:46:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

info->brk was erroneously set to the end of highest addressed
writable segment which could result it in overlapping the executable.

As per load_elf_binary in fs/binfmt_elf.c in Linux, it should be
set to end of highest addressed segment.

Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
---
 linux-user/elfload.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7e7f642332..d5d444f698 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2564,9 +2564,9 @@ static void load_elf_image(const char *image_name, int image_fd,
                 if (vaddr_ef > info->end_data) {
                     info->end_data = vaddr_ef;
                 }
-                if (vaddr_em > info->brk) {
-                    info->brk = vaddr_em;
-                }
+            }
+            if (vaddr_em > info->brk) {
+                info->brk = vaddr_em;
             }
         } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
             char *interp_name;
@@ -2621,7 +2621,6 @@ static void load_elf_image(const char *image_name, int image_fd,
     if (info->end_data == 0) {
         info->start_data = info->end_code;
         info->end_data = info->end_code;
-        info->brk = info->end_code;
     }
 
     if (qemu_log_enabled()) {
-- 
2.25.1

Given an executable with a read-write segment between 2 executable segments
qemu was unmapping most of the execuateble instead of area reserved for brk
at the end of the execuatable.

