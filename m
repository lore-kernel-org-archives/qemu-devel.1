Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B3ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3192F2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="kFH12W7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3192F2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL51G-0006Wq-8L
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1iL4zT-00048Q-49
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1iL4zP-0005w2-U7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:34:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1iL4zP-0005vI-HV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:34:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id p4so2147072wrm.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dOmlIbeNYpXo5dapN5KerUVR+VrVNCpDMxLHYss3XE4=;
 b=kFH12W7CrlD7DPl7HWa7Ejs8H03bfrqZhkGZ/m7Ht91+1AnCC4N/dGkLsOMDs6n5UI
 14NQoCXulgIIgBxTP4lUM3rtuwxnVR1N94niWr6GSs/UuUIHYYQYiiQS0JaUErTPHFhn
 sbxTj/jnrKz8pNV2BMweKPSlV3NxMFO62Md41NCWfXnJBGQwCXsCKEx0dfFIUkaFs5rb
 pO8e2yJbM93jJ1bqEwRMKC0Iphq0FXgL4244yP1R1lNlD+DlyCqx0ujhIw8kw2/6z1V1
 2XdlJYEoPAtLDnnwJlhG7Vwt3eXymTMIsuGwxbLz33shUgsHu0dPOA9+tG95/4hACDN9
 O3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dOmlIbeNYpXo5dapN5KerUVR+VrVNCpDMxLHYss3XE4=;
 b=ian9SiKxd+cgVc4HrnGxf434TdTbJ16LYHfBZ73Kfjl0O4zLNGepA+3TT7jalNi3hQ
 DRpcB5e0NSMtcJfLm7S2m0/3LQuu/sfQKLuhqs/eCw+rwqpghuBKxWqs9VQpRVmtqXTG
 Fz8zl8YCzN+SHEE5ha4p/myBHJQVU/aSe2Ggq7F7v0VE18iY0fI/8IraTNUHOriyOdvg
 N4WVmcQ8iL6WkfBv5xf/cZJQNtNHui7BY0+ooPJ8POYwN1q1jadK4eBqi7SZQ0AlPQSD
 ZbVQEnpBrLnWd3jJ4JelyF6L+GG+3brb+4kmIhcBWG3Cmjnvp4gKDsLPcI5nhMqR7M0d
 KIww==
X-Gm-Message-State: APjAAAX4OJBykr7IDV6+GJ8KgF91VTFTbbtQZ8X7nJmnycjTnWDiFJP1
 94riLhIk88jZXPDrNHszNMdmBFbG80w=
X-Google-Smtp-Source: APXvYqxhG0qrluqwzam9sizHTVQFLLKy+OjJ7YS/ZnX+N/XnCMsZNruYpqqejsQKieE4aaWbkXxufw==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr2962662wri.341.1571315684740; 
 Thu, 17 Oct 2019 05:34:44 -0700 (PDT)
Received: from bark.daynix ([141.226.163.173])
 by smtp.gmail.com with ESMTPSA id r2sm2077576wrm.3.2019.10.17.05.34.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 05:34:44 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH 1/1] qga: Add "guest-get-memory-block-info" to blacklist
Date: Thu, 17 Oct 2019 15:34:38 +0300
Message-Id: <20191017123438.87703-2-basil@daynix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191017123438.87703-1-basil@daynix.com>
References: <20191017123438.87703-1-basil@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <bsalman@redhat.com>

Memory block commands are only supported for linux with sysfs,
"guest-get-memory-block-info" was not in blacklist for other
cases.

Reported on:
https://bugzilla.redhat.com/show_bug.cgi?id=1751431

Signed-off-by: Basil Salman <bsalman@redhat.com>
---
 qga/commands-posix.c | 3 ++-
 qga/commands-win32.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index dfc05f5b8a..1c1a165dae 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2730,7 +2730,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
             "guest-suspend-hybrid", "guest-network-get-interfaces",
             "guest-get-vcpus", "guest-set-vcpus",
             "guest-get-memory-blocks", "guest-set-memory-blocks",
-            "guest-get-memory-block-size", NULL};
+            "guest-get-memory-block-size", "guest-get-memory-block-info",
+            NULL};
         char **p = (char **)list;
 
         while (*p) {
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6b67f16faf..1c9ec9c094 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1894,7 +1894,7 @@ GList *ga_command_blacklist_init(GList *blacklist)
         "guest-suspend-hybrid",
         "guest-set-vcpus",
         "guest-get-memory-blocks", "guest-set-memory-blocks",
-        "guest-get-memory-block-size",
+        "guest-get-memory-block-size", "guest-get-memory-block-info",
         NULL};
     char **p = (char **)list_unsupported;
 
-- 
2.17.2


