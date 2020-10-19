Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56602222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56602222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKJQ-0000vs-Df
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 21:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUK9S-0000X5-Lk; Sun, 18 Oct 2020 21:39:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUK9K-0008Mn-Ri; Sun, 18 Oct 2020 21:39:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id r10so407544plx.3;
 Sun, 18 Oct 2020 18:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aerwzx5CfwUpxb8Z2TCaJlKj8/Zz1MgoB4yIi6WTy8A=;
 b=aX1OjiadNXrNb2VA0Mjf26g5gpBy3M22n4I6eC1NQmaKYFZMuAdzDAEr6FpKCoEcJL
 pAehM2KgqB0Jqa1Vp1Vtfkdfjx4ySByXaC0XsycZrYt7O+gvYG39NF2AKbwEWYHRMW0Q
 7tHjAa34utllWwhjFfr5jkqGnqFTxHGdJ++OGuU2n8aN1kr4f2ETMQNYlHCvJi9eJ35n
 T4GBmbNl5HmMRdFvyf5YNImTwohpnzv1VUWJJiunsBbQ4xbySOXFqr2KiEOeGNs0pSDx
 +XCV33XPVsXEci2+/hIJ2dElrsQPord+eUHkOc+LDKmpfJRPo5x2xmAENOIAczgkcM39
 g6SA==
X-Gm-Message-State: AOAM531jNFbZ55E5XqEcrSC/zCkSFhZzOr5HtkjP/s38jodTBV93FPEo
 mJxiJD4cjxznem/sW662Bn5I6LDkbTxJDg==
X-Google-Smtp-Source: ABdhPJzMNIMw5xVAP1VX/DrJcL8pdzOTCx7kZBPK6uNtVdFdxFYmNyNRhOjEh5BWxxzU0XHuBviGZA==
X-Received: by 2002:a17:90a:a107:: with SMTP id
 s7mr15204221pjp.208.1603071584850; 
 Sun, 18 Oct 2020 18:39:44 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.115])
 by smtp.gmail.com with ESMTPSA id p8sm2446607pgs.34.2020.10.18.18.39.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 18:39:44 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] block: check availablity for preadv/pwritev on mac
Date: Sun, 18 Oct 2020 18:39:28 -0700
Message-Id: <20201019013928.72770-10-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019013928.72770-1-j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.196;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 21:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

macOS 11/iOS 14 added preadv/pwritev APIs. Due to weak linking, configure
will succeed with CONFIG_PREADV even when targeting a lower OS version. We
therefore need to check at run time if we can actually use these APIs.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 block/file-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index cdc73b5f1d..d7482036a3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1393,12 +1393,24 @@ static bool preadv_present = true;
 static ssize_t
 qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset)
 {
+#ifdef CONFIG_DARWIN /* preadv introduced in macOS 11 */
+    if (!__builtin_available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)) {
+        preadv_present = false;
+        return -ENOSYS;
+    } else
+#endif
     return preadv(fd, iov, nr_iov, offset);
 }
 
 static ssize_t
 qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
 {
+#ifdef CONFIG_DARWIN /* pwritev introduced in macOS 11 */
+    if (!__builtin_available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)) {
+        preadv_present = false;
+        return -ENOSYS;
+    } else
+#endif
     return pwritev(fd, iov, nr_iov, offset);
 }
 
-- 
2.24.3 (Apple Git-128)


