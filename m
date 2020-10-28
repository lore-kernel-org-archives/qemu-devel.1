Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72191C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F7822454
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F7822454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbvQ-0002Hd-PW
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnw-0003qi-H8; Tue, 27 Oct 2020 23:07:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnv-0006in-1h; Tue, 27 Oct 2020 23:07:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so1915864pgd.12;
 Tue, 27 Oct 2020 20:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DqK0hZ8mt8LWfTZqV1hfM2y+gt2SV2gfJzd9rHBJS8g=;
 b=dQLneSouHcvNMRHgioM1SFJqmIyjilmd7mehshMZBkfLvqWMSNg4n/7JGrn9ECa+JK
 oUKvasr8Ht/2Efu2i6UUPlchrtN96893biAJufWbLRtmS1FKJ5DisuzINvfIpWTaGcyA
 DZOR0qruDw2z3OCmRe9Op7LdZxtRhGIPFvG/1heTOJFhTgQunpQYmJmd0o4RbnYk/AFm
 JrmwVzNxQvb1nT0Ue5kdoOV5vZGO9a3lhJkg7CoMH5PDT3dWSJL46xrnAnVAkEV6I++8
 zAtYiN9EdTfZhJSGC2+HJVmeUB6NxxO4fdpZPiWsch6JMrr09yloSgXFNxZLwF0uwk5k
 6EcQ==
X-Gm-Message-State: AOAM532DR+3K4nr5I9Evq2dFvPc7IvrWmZMUsMCU4HNo+cMrVkdwkt2a
 HzOzD5CQWwUswAln69k3awWCJD/4agw=
X-Google-Smtp-Source: ABdhPJxOdEllNjyw1vx5xWHafjR6terG8COwykwvCHLDJ+jU75WFBWbJ45JEWLpPXgEpet6FExzgWw==
X-Received: by 2002:aa7:92c3:0:b029:163:d2d6:8db1 with SMTP id
 k3-20020aa792c30000b0290163d2d68db1mr5130208pfa.17.1603854433003; 
 Tue, 27 Oct 2020 20:07:13 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.93])
 by smtp.gmail.com with ESMTPSA id n6sm3407219pjj.34.2020.10.27.20.07.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 20:07:12 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] block: check availablity for preadv/pwritev on mac
Date: Tue, 27 Oct 2020 20:07:01 -0700
Message-Id: <20201028030701.14086-8-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028030701.14086-1-j@getutm.app>
References: <20201028030701.14086-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.193;
 envelope-from=osy86github@gmail.com; helo=mail-pg1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 23:07:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

macOS 11/iOS 14 added preadv/pwritev APIs. Due to weak linking, configure
will succeed with CONFIG_PREADV even when targeting a lower OS version. We
therefore need to check at run time if we can actually use these APIs.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 block/file-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5560fd20ac..b5a7ce483d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1394,12 +1394,24 @@ static bool preadv_present = true;
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
2.28.0


