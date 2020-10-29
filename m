Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5148BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72692076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct8Rm56t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72692076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4TA-0002z6-Nk
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KQ-0007BQ-AT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KN-0006jn-PX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uk13P8LCKUO2+gTBuoYZIar/VXLSwVbHDVchagy2v9g=;
 b=ct8Rm56tFcblCqlRbllqXZfHRi6oUkygOL4a7bJOBn5ndtsk3M4O4NXE62T6BXw48WvGc4
 JbaaGJSLQ1Yk8ogJiu08IBqgQTGGtXP+b6EaEchx6b1iQNFPVvfPAkJ/yWHbUYv7PyxEqa
 AY1aZ+eoATzkS0SdplnhF2Wcx73hMfg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-qfCPOU8QOPO7szw8IzWH8g-1; Thu, 29 Oct 2020 05:34:37 -0400
X-MC-Unique: qfCPOU8QOPO7szw8IzWH8g-1
Received: by mail-ed1-f70.google.com with SMTP id n16so929637edw.19
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uk13P8LCKUO2+gTBuoYZIar/VXLSwVbHDVchagy2v9g=;
 b=UxPRK5x0ddp6Hp2mnv/2By36BaRCdfBAd1wQ/sQcqnXLi2BFNEEDzVED55a+HviWh8
 B+OuItA4iay/9ADJImim3c4hOEvbXhQHPPFKnK8123/dT3LZWL0p2WMNc894eVkkmaU8
 MFrlC8SWSsme/34zvZVuZCg5rDEU9Z8NezNpeQreM5++O7bjgazlgPu3xlMFl1tinIwk
 hspSwR4zZNRPCp5MjXTORMIn3G5MV/F+fPaKxQsbWKGIL4oNqPq0yPdqKBzjDi5YvwcW
 V9P11uzqaa/EbLu283SsnCwxq0xUdJkS4Xs5ZnuNldMIkcbqZpDZR64CZsoVlNL84be9
 0wTw==
X-Gm-Message-State: AOAM5308CCJaE9dbpFbgAfcytp2bX92+L6vG+XimB8orSfkJ92eAAUsr
 ZQORG/gdTedrnaYFdcpvae7PORsnXKfwD/G3fiR8ZtOh+TXdViDeRCi2zjO0/xHpVEkehK0Cap0
 lqvor9qrC5rqwTaE=
X-Received: by 2002:a17:906:3092:: with SMTP id
 18mr3151795ejv.43.1603964075356; 
 Thu, 29 Oct 2020 02:34:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbjM2Fpj5bt3pLxqZcx9djWaztai0dnd9QsR+pjSkJnrj3nhT6Umio4zz7kcYBYWoYzyDdsw==
X-Received: by 2002:a17:906:3092:: with SMTP id
 18mr3151781ejv.43.1603964075144; 
 Thu, 29 Oct 2020 02:34:35 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id oz18sm1151838ejb.55.2020.10.29.02.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 16/25] block/nvme: Simplify nvme_cmd_sync()
Date: Thu, 29 Oct 2020 10:32:57 +0100
Message-Id: <20201029093306.1063879-17-philmd@redhat.com>
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

As all commands use the ADMIN queue, it is pointless to pass
it as argument each time. Remove the argument, and rename the
function as nvme_admin_cmd_sync() to make this new behavior
clearer.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index eed12f4933c..cd875555caf 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -481,16 +481,17 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     qemu_mutex_unlock(&q->lock);
 }
 
-static void nvme_cmd_sync_cb(void *opaque, int ret)
+static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
 {
     int *pret = opaque;
     *pret = ret;
     aio_wait_kick();
 }
 
-static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
-                         NvmeCmd *cmd)
+static int nvme_admin_cmd_sync(BlockDriverState *bs, NvmeCmd *cmd)
 {
+    BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *q = s->queues[INDEX_ADMIN];
     AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     int ret = -EINPROGRESS;
@@ -498,7 +499,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     if (!req) {
         return -EBUSY;
     }
-    nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
+    nvme_submit_command(q, req, cmd, nvme_admin_cmd_sync_cb, &ret);
 
     AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
     return ret;
@@ -535,7 +536,7 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     memset(id, 0, sizeof(*id));
     cmd.dptr.prp1 = cpu_to_le64(iova);
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_admin_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to identify controller");
         goto out;
     }
@@ -558,7 +559,7 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     memset(id, 0, sizeof(*id));
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_admin_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to identify namespace");
         goto out;
     }
@@ -664,7 +665,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
         .cdw11 = cpu_to_le32(NVME_CQ_IEN | NVME_CQ_PC),
     };
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_admin_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%u]", n);
         goto out_error;
     }
@@ -674,7 +675,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
         .cdw11 = cpu_to_le32(NVME_SQ_PC | (n << 16)),
     };
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_admin_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%u]", n);
         goto out_error;
     }
@@ -887,7 +888,7 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
         .cdw11 = cpu_to_le32(enable ? 0x01 : 0x00),
     };
 
-    ret = nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd);
+    ret = nvme_admin_cmd_sync(bs, &cmd);
     if (ret) {
         error_setg(errp, "Failed to configure NVMe write cache");
     }
-- 
2.26.2


