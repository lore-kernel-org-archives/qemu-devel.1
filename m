Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31596C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E582520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="AKYgOR2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E582520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAPmw-0007jG-66
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 23:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kAPmK-0006yr-4e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 23:37:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:37420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kAPmG-0008Sp-Ss
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 23:37:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id x25so6227687pff.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 20:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EgIP577Iq8PSMU58GdFspNTxnjQVYrSR9GlxKjDiHNE=;
 b=AKYgOR2dLX9CaNITcEBpUbUz4SYGfl4s3WUS0IN9mm5X9Jtc37Jt3CFN6YTymIrHNz
 EnsktTBUVBGTax5EXtqqAJT+VpY5NSh4Tnz6H+rsGAtjtKqnoiC02Vfqmard5sjXXHKQ
 inn9Z24TqxXslVNoXJw9bxNA6nw3ZgAqpoj3LC+KAIYTyk1n1GjX94hqf3/HRcaidO60
 wYMsdWVtXYFg81dP/3/B0vgcAB+wF95Da0UsuopIzgwcSK/NAM2GVAa6y92QvGK92537
 4WP+N6mxKSF5yrXWWeMM+M5tVVCO8njyutDHAkG/V2SkFApUSmnzBrQ6qzS4pQGD0lPL
 tGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EgIP577Iq8PSMU58GdFspNTxnjQVYrSR9GlxKjDiHNE=;
 b=tdyvAjxCHb/8qCoSVXgqfKWWQWGmLbdtclZs4cof5v5eLsGGiRIBskFbTnbO2q1he/
 881B8m9kFs2j5wTc/5xfdBKC2FLo7gkZmAIS9lzTeyr+GVQmq/JLPtQWZUB4ZuEld9xn
 Fvg95h8kRCamHTNWW2XAGS52D+dl9Ym62F09M6b+y+fhMUi2tgAHlR/J8ZKx22VTT+b4
 qtndPTqp/yK9OrNMvzSjdYuuagNotNtWiOw5/q53/apJ495QaBPU4hnUY7j1LOTLVJVD
 MGJwzlDItH9sVZ0kAl4vB6fAKgTdN5oSLWIZ9OW+UBfhpeiLFd8MyVxlytoOT1LUvT2U
 XYLg==
X-Gm-Message-State: AOAM533vg/EY186YtL1xn/e7qwdy29a/RPfnY2gUTNT1A58quk9Ae+vC
 FJ1gbDBzmUvqDHi/3shsfaqHUg==
X-Google-Smtp-Source: ABdhPJyIdaCyGrb0qqMQVt/tMc6eSGQcG2ysBCRqaxslsOUAq8Yd6TEo2F28PNx9Ya6Jj8VfdeMcfg==
X-Received: by 2002:a17:902:a50d:: with SMTP id
 s13mr5991873plq.135.1598326659545; 
 Mon, 24 Aug 2020 20:37:39 -0700 (PDT)
Received: from MacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id l24sm13036191pff.20.2020.08.24.20.37.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2020 20:37:39 -0700 (PDT)
From: wanghonghao <wanghonghao@bytedance.com>
To: stefanha@redhat.com
Subject: [PATCH v2 1/2] QSLIST: add atomic replace operation
Date: Tue, 25 Aug 2020 11:37:18 +0800
Message-Id: <20200825033719.19360-1-wanghonghao@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200824152659.GA7124@stefanha-x1.localdomain>
References: <20200824152659.GA7124@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org, wanghonghao <wanghonghao@bytedance.com>
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
index 456a5b01ee..62efad2438 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -226,6 +226,10 @@ struct {                                                                \
         (dest)->slh_first = atomic_xchg(&(src)->slh_first, NULL);        \
 } while (/*CONSTCOND*/0)
 
+#define QSLIST_REPLACE_ATOMIC(dest, src, old) do {                            \
+        (old)->slh_first = atomic_xchg(&(dest)->slh_first, (src)->slh_first); \
+} while (/*CONSTCOND*/0)
+
 #define QSLIST_REMOVE_HEAD(head, field) do {                             \
         typeof((head)->slh_first) elm = (head)->slh_first;               \
         (head)->slh_first = elm->field.sle_next;                         \
-- 
2.24.3 (Apple Git-128)


