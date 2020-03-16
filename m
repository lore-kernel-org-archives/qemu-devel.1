Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8870CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438272073C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mgXXjraP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438272073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDwk0-0001ij-F9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1jDwjN-0001Jc-Hb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1jDwjL-0000B8-Ei
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:53:00 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:48654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1jDwjK-0008BB-3z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1584391978; x=1615927978;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D7v3avag7dsppDcCokSGg5MG/3GnMjxD6ahu0l8C+JI=;
 b=mgXXjraPspV6UJIUUxSxDNc6vZrAut6d8Ym60Onrl3MG5yMuHdG+SVI7
 4vBIS4c/UEOMrxMIcoOiK4z4bftnkx69wWnQUkHDV7WN4HW7XKiAU1tVI
 aAAOVSFE30hkxxO6DrsDjwrY1dq/gYp9nh3j8DKMzNFDFvuIWvcJ1DP2N I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Mar 2020 13:52:56 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 16 Mar 2020 13:52:55 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 4C38E886; Mon, 16 Mar 2020 15:52:55 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Enable strace for TARGET_NR_llseek
Date: Mon, 16 Mar 2020 15:52:20 -0500
Message-Id: <1584391940-29281-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, riku.voipio@iki.fi,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

linux-user/syscall.c handles the case where TARGET_NR_llseek (one underscore)
is defined and TARGET_NR__llseek (two underscores)
    /* Newer kernel ports have llseek() instead of _llseek() */
    #if defined(TARGET_NR_llseek) && !defined(TARGET_NR__llseek)
    #define TARGET_NR__llseek TARGET_NR_llseek
    #endif

Unfortunately, strace will print "Unknown syscall" in this case.  This patch
fixes that problem.

Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
---
 linux-user/strace.c    | 2 +-
 linux-user/strace.list | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f7130b..4bcc00b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1667,7 +1667,7 @@ print_linkat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR__llseek
+#ifdef defined(TARGET_NR__llseek) || defined(TARGET_NR_llseek)
 static void
 print__llseek(const struct syscallname *name,
     abi_long arg0, abi_long arg1, abi_long arg2,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e9..5a01e95 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -503,6 +503,9 @@
 #ifdef TARGET_NR__llseek
 { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
 #endif
+#ifdef TARGET_NR_llseek
+{ TARGET_NR_llseek, "_llseek" , NULL, print__llseek, NULL },
+#endif
 #ifdef TARGET_NR_lock
 { TARGET_NR_lock, "lock" , NULL, NULL, NULL },
 #endif
-- 
2.7.4


