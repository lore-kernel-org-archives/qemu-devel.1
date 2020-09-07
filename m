Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1114C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DB3208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DB3208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDJo-0000iK-C9
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHl-0005Wb-OI
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHi-0002ah-AJ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:01 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYLqs-1k2RRG0GHK-00VMwQ; Mon, 07 Sep 2020 11:17:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] linux-user: Correctly start brk after executable
Date: Mon,  7 Sep 2020 11:17:45 +0200
Message-Id: <20200907091748.376101-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907091748.376101-1-laurent@vivier.eu>
References: <20200907091748.376101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HLvEtCc5PtWXC2xo7Ndqgm+mYK96AUT4t6eH5zgwKk045TqSoB9
 c6h/Un65x8n32V5gK1YPWQVW1DxBfk4s0QF9DWPQx9b9W1p2AxygNz2lTP0Wsfk9LE0BkF+
 o1u1lJ0tR2pky9aG1t1rVg697oajUhNWfPSrbkeeXQFsclmot/52DfVE4dYM2TpprR4Fm2n
 xDvso3j/jof631DVgdliQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1qbchAxfz4I=:iMPVq6XjzZf2oP1FW46DYE
 +wzJPWgqCjlaezwMhbc15gskMs9fJeweEBb1RK8PaaYr/xnLU5677u/Yf804hwfz+i3LpXIfk
 kr3HuZ+brQUvP6cqwZpuu++LNSLoEEt51lLRJw45vjissKiyaARNzkOWes6mnYWZV7Ezh+ZQz
 pVRFgduJK75QumxgedgrzgzWZWNg/nYjzI9ziOmtZDnYPwTxOC0LsU3XLsHzPldP2Q3c2NQ8k
 3/iAxvk0RBoFSntzhyIHB1tCfHVSh6jxhQSn33a1L7ZPhZ/EmAlogkDcwmEvAsMVSR56UolUN
 enw36cbQkKUksZaQakQoJ+zP5LtUl/8N0KY1n8EaPVt7ezDN/IRpXCQ38H0W+bZK9biwLelEg
 5vqolg637i9ph8+G6OQRrS/7tu6pUqKkgZjJl2ut8EAG8n9RL25BFDSJkMfLnfcgjskMhNR+1
 6/4VHkxAMfUg5JrcurWTpbAjMeaaQOZKDH0oaQMGmCk9nMglOgSVx+aU44wyf3+sZSmMbKWIm
 dfsVc4j0f5ScWmD/f5uY0ier758zhzToku3K4dNZmOkjqe1gLnedLNb0YzZdwWPXliBKA8TO7
 dtf0aLufeSevupE+lpNB0hTLS/lmWgV4i9bqSy9R/eIYt/Huo7zs462F7oiDIzTMDv2i5dbOX
 5jI+pYQjtM+GAfnQnYWbBIuxOh1mKLzjj5+d0pfL5jbm3MEJEpuQyE9gDqVVT5uzuB+h63ebW
 Q99n9MiFzcb+YfJdLMZAcrRYAFi6NdKR8DhjvGf/zDa9mG6yn9YRuiadpzjSjwT4f43JpWflF
 QIEIUENTX4j5xmLXd1jUWYOEHd+rMEkUSjK326wWGnf59MfKH4G7E1ia3ZmFZLjHOE7kvsh
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:17:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>

info->brk was erroneously set to the end of highest addressed
writable segment which could result it in overlapping the executable.

As per load_elf_binary in fs/binfmt_elf.c in Linux, it should be
set to end of highest addressed segment.

Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200728224615.326675-1-T.E.Baldwin99@members.leeds.ac.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 04c28cbb9ecb..4961e6119e24 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2580,9 +2580,9 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -2637,7 +2637,6 @@ static void load_elf_image(const char *image_name, int image_fd,
     if (info->end_data == 0) {
         info->start_data = info->end_code;
         info->end_data = info->end_code;
-        info->brk = info->end_code;
     }
 
     if (qemu_log_enabled()) {
-- 
2.26.2


