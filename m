Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BDC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF1022258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgGt4xAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF1022258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPZ8-0001Fn-R1
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSy-0003GP-Gb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSv-0004K3-Ce
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCeDQAW3OylaJlAm+u7tQregjbauJK7WkWlW+Me7/c4=;
 b=PgGt4xAfWFYAvfTBl7BrcVNI1V4SQAxXx7eoWdGOi9D3PfuVqwjc1DQHOf1GXjD0yoEIxM
 kzX6if4iHGc89B9Ve8zxdSKpPfTQZT+mRZDy/vES3lbxBe8RKh/baS28UYzbb7HxtzQLq1
 TfHc98gDj/CXHLZg0fTHnpFQ7144QIY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-ouQ4QRCYOqaVuOA0OO7P2A-1; Tue, 27 Oct 2020 09:56:40 -0400
X-MC-Unique: ouQ4QRCYOqaVuOA0OO7P2A-1
Received: by mail-ed1-f72.google.com with SMTP id dc23so708492edb.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bCeDQAW3OylaJlAm+u7tQregjbauJK7WkWlW+Me7/c4=;
 b=JvsocXTR+IdZSKRLYVlH/WJQQB0foAJ5C9iOHQl6PxWJxqipKGMkijHhrWikqG3LMd
 ZfsYiqnxBPV9UYwHSEPQWCQHjlQpx/uK4/la+toC6CQ7gPWmZJwEB/Ud1EmBlnTnWaKv
 oMVu7hNG2zDZYSpSx8Hfl8rcv2CgOR3y/3z3Tp/zRObfJKnBGOul59gAekmFWTOnh8T1
 7RQxBZLLAcG5jkLKOnI3znVFtTlXbJhDXKkHNxJ1EhKtSJKIdAcL2/90ePnJYSDFgr6t
 WLsR3Z1cDNcSa4bVsx80yMmfB8FvmybXIPcpaQkxsUjPATizRrgcFDy5LumB9TOKTB2Z
 /JiA==
X-Gm-Message-State: AOAM531PnkTk4wphb2XBKj1tAqrTCwkgxkTzx4Tdod7BuLjByqX3dmBo
 J79XFVmdZUu2uV0QlspOMBlNZHvBjf9O0W9fziVydjrCIZyMuGQVlK+1B+pSE27cSxO/p+O3VcM
 lThzUYLym2dYSOZQ=
X-Received: by 2002:a50:d59c:: with SMTP id v28mr2274723edi.241.1603806998790; 
 Tue, 27 Oct 2020 06:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAwSF4f4rrTMI+a8ODIG6OfZI5BURK+UmdQXTYcav9Cc/jo9sLKzMajOd2or3BiMUZZ/WwkA==
X-Received: by 2002:a50:d59c:: with SMTP id v28mr2274697edi.241.1603806998620; 
 Tue, 27 Oct 2020 06:56:38 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i14sm1028621edu.40.2020.10.27.06.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/25] block/nvme: Move definitions before structure
 declarations
Date: Tue, 27 Oct 2020 14:55:31 +0100
Message-Id: <20201027135547.374946-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to use some definitions in structure declarations,
move them earlier. No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index be14350f959..30075e230ca 100644
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


