Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27FC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0673920672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0673920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVZw-000235-46
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <schwab@suse.de>) id 1jLVYw-0001P8-DU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <schwab@suse.de>) id 1jLVYv-0008Dr-1x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:58750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <schwab@suse.de>) id 1jLVYu-00084q-RS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:29:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 660EFB1D7B
 for <qemu-devel@nongnu.org>; Mon,  6 Apr 2020 17:29:10 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Use getcwd syscall directly
X-Yow: Are you still SEXUALLY ACTIVE?  Did you BRING th' REINFORCEMENTS?
Date: Mon, 06 Apr 2020 17:18:19 +0200
Message-ID: <mvmftdg8wxw.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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

The glibc getcwd function returns different errors than the getcwd
syscall, which triggers an assertion failure in the glibc getcwd function
when running under the emulation.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 83c2891169..90c5433fec 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -375,14 +375,7 @@ static bitmask_transtbl fcntl_flags_tbl[] = {
   { 0, 0, 0, 0 }
 };
 
-static int sys_getcwd1(char *buf, size_t size)
-{
-  if (getcwd(buf, size) == NULL) {
-      /* getcwd() sets errno */
-      return (-1);
-  }
-  return strlen(buf)+1;
-}
+_syscall2(int, sys_getcwd1, char *, buf, size_t, size)
 
 #ifdef TARGET_NR_utimensat
 #if defined(__NR_utimensat)
-- 
2.26.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

