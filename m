Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913CCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B34A2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="dMla40T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B34A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6DQk-0003mf-Hk
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 09:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1k656y-00034J-OV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 00:45:08 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:51002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1k656t-0000XQ-Gb
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 00:45:06 -0400
Received: by mail-pj1-x1035.google.com with SMTP id e4so2195578pjd.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 21:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ymbq0fI8IdEu2KgMabrZZCPF3UyfAuYJCEFO8Pn1QI=;
 b=dMla40T5IPgd4cpvlluEUDJxJDtdESnX8e8gbc9oU+zBRvH1Omfda7L4kwdL03hctx
 JK/8HwoQLOgM5Wl67DIlVNRo13I++oEw6eDvSDnMuxW37K4oOzKVXmqfAamtodPD9HHM
 Tq2ZNZv3RXzlqrbxGaI6iEUg3DXNhIbVxnU+4TdO5vfJQK1LkO2m7VnGP/MvTJCD7J2i
 E730aK2Oq0OmwJt9S+sENqHnGse0E9aSNlsxymIU4qq+vfAUu9hI/oRCuhm6RyalH+BY
 gaeGHouM3UlvXo0GPtbBI7GhMYBoTTw28e4rykPo0m6lQtGz7oo6Xu7FE28QuqNyRX/K
 R/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ymbq0fI8IdEu2KgMabrZZCPF3UyfAuYJCEFO8Pn1QI=;
 b=sxVEcc8BGKtHbUwKmrefuyMGxpDFNN99f3wE2RjtzBvD5rB/fXLaWKvL+JDJeIytSD
 Y4LxGddUv9MOxUdARjXn8mJmlugsaugJ8SiBrZit5/dxyHtet3Dzb5iUKF9GZpljN9xi
 BkL5zf1DHEfaMOvbc6DLiSOSIf6ujELcI7R6LAUpXH0jzWB6aaWSHY1kwCdi9NjbCoRQ
 g3rb3lkWMIXu32uYC1rW7FKkedD0oe5waTpZNjOUgjfdV/9mnNxXB6VwQVXBAezUc7+7
 GeN9828rR/gLXvOc1Duf8JrDV4QnHksjdG7FbZ8isqcH/XDMxfu+h+xRIlbT/RxbOGl4
 ecQg==
X-Gm-Message-State: AOAM532Jj7OoDEXDQ7ITEcdGdyk83+bCVnKBFmj/vvUoc4N4Mj9y5uFb
 SjXyeTLNJbkEHUlsPwscJ+gu2toW32U8vw==
X-Google-Smtp-Source: ABdhPJwx0b1o3u7hFc/tBq9RR0OfUiAco8qQeowYilg2zQ98M8ubRPW6boGZ6hJkOyRh8S+zhBXAzA==
X-Received: by 2002:a17:902:d212:: with SMTP id
 t18mr2386728ply.235.1597293900279; 
 Wed, 12 Aug 2020 21:45:00 -0700 (PDT)
Received: from MacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id z29sm4109746pfj.182.2020.08.12.21.44.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Aug 2020 21:44:59 -0700 (PDT)
From: wanghonghao <wanghonghao@bytedance.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] QSLIST: add atomic replace operation
Date: Thu, 13 Aug 2020 12:44:44 +0800
Message-Id: <20200813044445.23233-1-wanghonghao@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Aug 2020 09:37:10 -0400
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
Cc: kwolf@redhat.com, wanghonghao <wanghonghao@bytedance.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace a queue with another atomicly. It's useful when we need to transfer
queues between threads.

Signed-off-by: wanghonghao <wanghonghao@bytedance.com>
---
 include/qemu/queue.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 456a5b01ee..a3ff544193 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -226,6 +226,10 @@ struct {                                                                \
         (dest)->slh_first = atomic_xchg(&(src)->slh_first, NULL);        \
 } while (/*CONSTCOND*/0)
 
+#define QSLIST_REPLACE_ATOMIC(dest, src) do {                                 \
+        (src)->slh_first = atomic_xchg(&(dest)->slh_first, (src)->slh_first); \
+} while (/*CONSTCOND*/0)
+
 #define QSLIST_REMOVE_HEAD(head, field) do {                             \
         typeof((head)->slh_first) elm = (head)->slh_first;               \
         (head)->slh_first = elm->field.sle_next;                         \
-- 
2.24.3 (Apple Git-128)


