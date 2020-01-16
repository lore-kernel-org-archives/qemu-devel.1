Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1A6C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F8520684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9eWnaT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F8520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isB5W-0007q1-UJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 14:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3e-00058x-Th
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3d-0007Ua-Rr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:58 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isB3c-0007Sw-2E
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:56 -0500
Received: by mail-pl1-x644.google.com with SMTP id f20so8775210plj.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 11:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BF/LvenLVteHucTa2gOslze21R5NBa9gmgvuCLp0CGM=;
 b=v9eWnaT4uk14sUqPhUBJHZNkGk0PkX99tH3ogHXmtHQ3VhZrzOEeZmpD9XApE1vn9Y
 PsGUX6L+SIiqiBy5BMpOm3g2jt/YhDvVO52z9+QBrblWqLkmp+yXq/ymPPsGvtaYOecn
 1G/P8lXkXCq1aL9M4xiv6bFrLDAzyJOKLkBl+lOkeXXV7Qq09wTxWJnJGCpzWd4F/g4/
 b+Ck51pHLQ+OEw6gOqg2iNqWkIsY0MoPh8I7NiprSb1bzKLo3GkLKLyoAZTG98gtCKhR
 BRuI6j3Y9O++RvsvTkp3nxfHjgrQegrqXhckBRFiZlpmFXbK3Vn6X6SZiL0Y/BRT41sM
 9YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BF/LvenLVteHucTa2gOslze21R5NBa9gmgvuCLp0CGM=;
 b=KZApnvN31k8YL9RlWevKQwaXn1mEnbXQ871nHms2bQ6FSPCH7R41Z7SFfPEKHH74u3
 Quz5+7V+OWwrlmPm3G7ZD1m5GbqJ2AVkuwfeAOvVtaljFhgPra1tfqdXIdW/wEK0FL1W
 levXu3ecJhZ27pfV36Xf5Pd0/NH91BgsGpAoqDrjGkwseTycfbPea3zYZqCCAXEJ0Dj3
 8tFKaA3i3XSybuWFWMGgE/o5Wo/cxcyTQQu8g8PSxChzEtN6fKUwzySpATBPhIPg06Ae
 sHaxLlzHyuxCb4i8FkcYGt3zIwWJxtApKh3FtZvqrsLw57oNlQJBA7Or67PJIwCZF6xA
 NTrQ==
X-Gm-Message-State: APjAAAWbgZzEiyfqfGgSMTBLCnEdPICvxfeDOWbjx65QNozSqM8/wsa0
 +Bk3T+rgsNCljUng0pTIL/38iBrKyVI=
X-Google-Smtp-Source: APXvYqzk5IeP4GoyZA1rSIFEdBxOsGPw5rpOcm/lpjNEcTdFZO9Z/MPGvIc3RUKGoH3wMYVtXC8Pwg==
X-Received: by 2002:a17:90a:17e5:: with SMTP id
 q92mr1033873pja.28.1579203834928; 
 Thu, 16 Jan 2020 11:43:54 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id g2sm26411831pgn.59.2020.01.16.11.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 11:43:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] linux-user: Flush out implementation of gettimeofday
Date: Thu, 16 Jan 2020 09:43:41 -1000
Message-Id: <20200116194341.402-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116194341.402-1-richard.henderson@linaro.org>
References: <20200116194341.402-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first argument, timeval, is allowed to be NULL.

The second argument, timezone, was missing.  While its use is
deprecated, it is still present in the syscall.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index eb867a5296..628b4de9a1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1219,6 +1219,23 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
+                                             struct timezone *tz)
+{
+    struct target_timezone *target_tz;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
+    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
+
+    unlock_user_struct(target_tz, target_tz_addr, 1);
+
+    return 0;
+}
+
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -8567,10 +8584,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
+            struct timezone tz;
+
+            ret = get_errno(gettimeofday(&tv, &tz));
             if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
+                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
                     return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
+                    return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.20.1


