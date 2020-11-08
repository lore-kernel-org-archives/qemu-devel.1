Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C3C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3612420897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612420897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdFb-0003Nh-Aj
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDY-0001Ye-7X; Sun, 08 Nov 2020 00:26:20 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDW-0004xI-No; Sun, 08 Nov 2020 00:26:19 -0500
Received: by mail-pf1-f182.google.com with SMTP id o129so5112874pfb.1;
 Sat, 07 Nov 2020 21:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DqK0hZ8mt8LWfTZqV1hfM2y+gt2SV2gfJzd9rHBJS8g=;
 b=hN5p0J4HLkid8amfNbV2h9E0lquFW9LqgnCLfuGorzhNW5wVtDeoQ6A8Np/XzOILK/
 itijVds+O9yhwesj0okktJfyHnGHRa/kvZ4GmYv2VrGcyEpLIDRiYICZWnyMyK+1mizL
 zSxDg01AYfWb5em2OvrPXDGBhoTv5OhrtSjnJ2BZpV9YqYqdwTGuPhZpMBtFnemDxYEF
 0fAB1zRQSttJN5lsfTqrd9TfdPAM0hVcZOyXyQVp+D9zAWtvBGVairUcsXi1HIXrzkIN
 7AplDBzzxL+RXdz/zWOyD/zNkdTPzBB/mwd3UKGKAb0DcC+FJU1KDGtTZrhJIMtDg7Yp
 KaTw==
X-Gm-Message-State: AOAM530wPHTUTQPFYkW+FH3d8FS3Uw6F1BnC1iPGTwnbcDqMi9PrCX2j
 NvNnxXdJtajjZyjapwVcuKqFzOQVTGM=
X-Google-Smtp-Source: ABdhPJxs/tKfn73Ob7Zhs5pFo4+/NTK209PI+9+fFtcXaOlmDCkzyOZ/za/DIHoQxh7pqu89I5AlXg==
X-Received: by 2002:a65:6649:: with SMTP id z9mr7914138pgv.18.1604813176408;
 Sat, 07 Nov 2020 21:26:16 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:16 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/7] block: check availablity for preadv/pwritev on mac
Date: Sat,  7 Nov 2020 21:26:05 -0800
Message-Id: <20201108052605.45840-8-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108052605.45840-1-j@getutm.app>
References: <20201108052605.45840-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.182;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f182.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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


