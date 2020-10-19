Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BBC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202642225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202642225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUNh5-0008UH-Tz
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 01:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNai-000424-29; Mon, 19 Oct 2020 01:20:17 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNag-0005I3-0n; Mon, 19 Oct 2020 01:20:15 -0400
Received: by mail-pj1-f68.google.com with SMTP id gm14so4690236pjb.2;
 Sun, 18 Oct 2020 22:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aerwzx5CfwUpxb8Z2TCaJlKj8/Zz1MgoB4yIi6WTy8A=;
 b=Yn25EFjxSD/KnPbgQ/qXsuFIm59oqhXvl7T3GO0monq3KSwnxnvTyOjzB7FZ41sbjh
 eKcD8sTn5Y96WBCnUiSM0B38ifikD7UhYecGXGYaq3W7+W/o53M8Gr4BLFXTRIgEook4
 Ef25+HWtkSN0B4og/Z7ELMkzo56HkJfHmLi0w54SdwGH3z1FmWUjKZSbfbC5ecmGqw1U
 ju40G+6NCiWc/r13yHjcOwyw5E3CskOnNEc3ygNUAZotl8/T4om2Ycb6jxhZ8NpDQtGs
 AyePckzZsnjrLAsDsapUmgIeWpLTyYJEWCl3nNA/vy4HpZhKjPUW7VzuPvTKgIsLQJ0c
 Ga8A==
X-Gm-Message-State: AOAM53264d+ApQGMKNvIP0KZSNuErBs2Kh3Iv/lGdQYedO7OpU10tmS6
 dvo/sJFKAZpKVaEjPQ9DXyzIJBtKdnM=
X-Google-Smtp-Source: ABdhPJxe/GlykmrbD3o62xgzxaGCOxE4X+EOYKi4s3iXP1fAvON0iWp1Y3QNV55kfaPJrWU1cvViZA==
X-Received: by 2002:a17:90b:8cc:: with SMTP id
 ds12mr10566252pjb.174.1603084810243; 
 Sun, 18 Oct 2020 22:20:10 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.253])
 by smtp.gmail.com with ESMTPSA id p6sm10673904pjd.1.2020.10.18.22.20.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 22:20:09 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 9/9] block: check availablity for preadv/pwritev on
 mac
Date: Sun, 18 Oct 2020 22:19:53 -0700
Message-Id: <20201019051953.90107-10-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019051953.90107-1-j@getutm.app>
References: <20201019051953.90107-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.68; envelope-from=osy86github@gmail.com;
 helo=mail-pj1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:20:10
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


