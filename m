Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3AA208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il/zBo9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3AA208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nzQ-00031F-MO
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nug-0003js-2G
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nud-0006Dc-88
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyQg0f8W8M9I/uKJA3ih2AcbkHq7TajNoPXSDgqGq4I=;
 b=Il/zBo9ZrqRuyvdXYWFkYvSxrh18wI4SyXttKzt6AIUNGc2P/+qCjorU1A4i6qMX3NuetZ
 joUntxHIPK2HWNopPqyT7xGpl3znsx1Y4DDPS4Tm7DEl2S+nh64CXBqpR2Kbr9i+iTs2dZ
 tZD5M6CGeQikYaOBpZ67i4zBpN+ejQw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-vha2TIT5P8eEXpSbskUbqw-1; Thu, 20 Aug 2020 12:59:36 -0400
X-MC-Unique: vha2TIT5P8eEXpSbskUbqw-1
Received: by mail-wm1-f70.google.com with SMTP id d22so1006094wmd.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QyQg0f8W8M9I/uKJA3ih2AcbkHq7TajNoPXSDgqGq4I=;
 b=aPbfLyTNge1E8qJ7x0Gj6F2QUWEV6SXGoV7C/0kh7QaU2o0VLIUO+0uuIu1xIECmPH
 Wxb2NGyifxpRvzwnJQBvnIEknn/bhFK9dLIRBvIpSeMrbxkqm8TUeBn2gxr0uPdbqlmi
 rNEow7Rsb91kMN2wDj1h15utTE91n386K02JKvadNM0Mfzxh7d1eq74Msvu8IjYoeSGo
 w6rZR2qbkRhL4XgZTHhZD/S1O4G1cFhP5OI3AizSpgmg77WINlYps8F9hj9KWvoiUcvZ
 vp/99MzgmtPyYf/iyMYxnRxkzFaeUB+FBy9rhXQITyAo2lhQFFVzx34k3Ktq/pBrqB3y
 7Y/Q==
X-Gm-Message-State: AOAM532EUlNBvi0YBwP+jyLUogTae5ZCv0jyl4fwN+n0jwWGwsGBjUdM
 vr2oaB7jcTet4NYzTHzJD2+Fq0h3QEGd6O4eU44lnYVgADI1evvkNBT4m7msBkHTTfYkIM7QLXm
 diM90lRinGVqDvaw=
X-Received: by 2002:adf:fac8:: with SMTP id a8mr4111289wrs.368.1597942775259; 
 Thu, 20 Aug 2020 09:59:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydMsAUhYQbfhGtVA5j/dvyfPGyX+ZXJ2dmEgjyQE5ING4JH30IKSDnuP94sT2fxWnFq3Ngdg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr4111278wrs.368.1597942775110; 
 Thu, 20 Aug 2020 09:59:35 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o125sm5413165wma.27.2020.08.20.09.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/15] block/nvme: Use common error path in
 nvme_add_io_queue()
Date: Thu, 20 Aug 2020 18:58:52 +0200
Message-Id: <20200820165901.1139109-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rearrange nvme_add_io_queue() by using a common error path.
This will be proven useful in few commits where we add IRQ
notification to the IO queues.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 53448b7d230..3101f1ad55d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -649,8 +649,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%d]", n);
-        nvme_free_queue_pair(q);
-        return false;
+        goto out_error;
     }
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_SQ,
@@ -660,13 +659,15 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%d]", n);
-        nvme_free_queue_pair(q);
-        return false;
+        goto out_error;
     }
     s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
     s->queues[n] = q;
     s->nr_queues++;
     return true;
+out_error:
+    nvme_free_queue_pair(q);
+    return false;
 }
 
 static bool nvme_poll_cb(void *opaque)
-- 
2.26.2


