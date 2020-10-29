Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2672076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyMjI9HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2672076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4PJ-0006h5-7n
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jr-00067a-9N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jk-0006YC-4d
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNTJ5igNyyXKkWieXTvLU2UcanJIdRIlRwN2Ir3xgfg=;
 b=YyMjI9HXPXjEuiTT7LEsQczaQ/swk272L0mmyZbRxpWjp/sjkOMv+YkfQxQj9IO7mj0d/P
 1vNVgnoNJR4KTv5qwMORwjhyONTot7lxOIXpj8XqibxNpdiA5OM2s8Jm569/zr2RHkB5G1
 Vi6Lgcbv9XK7HMaDpci4z17KzG1rQUo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-mIqPevmvMjq0Mx106GNdng-1; Thu, 29 Oct 2020 05:33:53 -0400
X-MC-Unique: mIqPevmvMjq0Mx106GNdng-1
Received: by mail-ed1-f71.google.com with SMTP id a15so937370eda.15
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LNTJ5igNyyXKkWieXTvLU2UcanJIdRIlRwN2Ir3xgfg=;
 b=kuwRbrtlH5tIpHfuGpRXfC+5KWHD01xgIjNQ4pc8ToZf3oeu5CPpK/owjD2XjmSxcS
 NrwA+cpScbwStpAK2nvvYV9IYbDNhoKiQHhmoKw8oTqhb3m4mOkPs2mqcT0FjrzxUrDu
 F0u/J4/uuTX2eMkQg72fy8V4U1hKIjScF3phxqN0Dj3NmGkBBRFFLHs6WJlMFfJoQmi7
 fdKwUCgGvuB9OzNsfCoYqo3kJ2YbYzZGsP4BXEsb06H8H0sFW7ZI888yIwBWdce6EjJ6
 PxJgtclyYgsNcva7e091lYZhVzMLKTOegM/0pZNjoth5T5Bk8vSu1lVYudIdkQxHckg5
 laqA==
X-Gm-Message-State: AOAM533FiMY+R+MmIDBsCMAmNTrMvNmDeLS2NTvjc+dn20ECdPTYpNvL
 HYhgmSou9N5jXUcplbep4iDQIxbEgzKdz2VKD6xnTF/eS1yW3WuCZGca5BYPjjdwB02bWCrTWlP
 luuYicbLF8WnGYuw=
X-Received: by 2002:a17:906:f148:: with SMTP id
 gw8mr518344ejb.192.1603964032301; 
 Thu, 29 Oct 2020 02:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztTl+bsWy4FrmaMCFpQbfLGLKKcnQIg2bTntM3tBGkLjyLF1s0qLKsE7iZ9jsaLp8s9OC3/A==
X-Received: by 2002:a17:906:f148:: with SMTP id
 gw8mr518331ejb.192.1603964032094; 
 Thu, 29 Oct 2020 02:33:52 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b24sm398626edt.68.2020.10.29.02.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:33:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 08/25] block/nvme: Move definitions before
 structure declarations
Date: Thu, 29 Oct 2020 10:32:49 +0100
Message-Id: <20201029093306.1063879-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to use some definitions in structure declarations,
move them earlier. No logical change.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e95d59d3126..b0629f5de80 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -41,6 +41,16 @@
 
 typedef struct BDRVNVMeState BDRVNVMeState;
 
+/* Same index is used for queues and IRQs */
+#define INDEX_ADMIN     0
+#define INDEX_IO(n)     (1 + n)
+
+/* This driver shares a single MSIX IRQ for the admin and I/O queues */
+enum {
+    MSIX_SHARED_IRQ_IDX = 0,
+    MSIX_IRQ_COUNT = 1
+};
+
 typedef struct {
     int32_t  head, tail;
     uint8_t  *queue;
@@ -81,15 +91,6 @@ typedef struct {
     QEMUBH      *completion_bh;
 } NVMeQueuePair;
 
-#define INDEX_ADMIN     0
-#define INDEX_IO(n)     (1 + n)
-
-/* This driver shares a single MSIX IRQ for the admin and I/O queues */
-enum {
-    MSIX_SHARED_IRQ_IDX = 0,
-    MSIX_IRQ_COUNT = 1
-};
-
 struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
-- 
2.26.2


