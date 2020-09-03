Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2157B206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFUUr761"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2157B206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoVq-0006TB-7F
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoM4-0008JP-Lb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoM1-0007pt-TY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpInLQtjibVwG+zHArB9u5D41zSFCvAlrqN3dTWS+aM=;
 b=IFUUr7611XcwQORD9cLpiLrR0GqqBhaRWRiv3ZpML8zvkfbq5iy1RwG1ryqNM/pvViIOkj
 s4lbO5LeJU0/O4B/r0tBUcnMROGo2gS8NPimUgtcD66TNCpiclIDBYQ1cU9G0qrGwwJkOn
 48p0kD2mO/gML6k1MSyAhUMFHv8HhFc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-KbZxYBdGPOufh3muQOhwfg-1; Thu, 03 Sep 2020 08:28:36 -0400
X-MC-Unique: KbZxYBdGPOufh3muQOhwfg-1
Received: by mail-wr1-f70.google.com with SMTP id n15so1005834wrv.23
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TpInLQtjibVwG+zHArB9u5D41zSFCvAlrqN3dTWS+aM=;
 b=QOZ+PDBCpepYte9qVlFz5oALBMvmDb/DWRHYUUmpKndRTkxO1DgdEI032XFYmYYEvy
 WIqNnFj9cmNVrFXjydLLIw7mPyPlmvhJIHSsHiYqgQ04iot8WThAGVgHftIRmQ7b1OKg
 oPqfzjh13fWdYCoO6Rqu/KaM9ff6hJfjcgD2TWoZtDZbhPZyp+IGWo3rLeTABlX2WO2S
 zM7A9qW0SkY/pLPui432r0oiKhMlIEbNxRyHkb9XxGneNPBfa9hqeCmD98DUmK6+pfgQ
 4ikdLxiD+bqXydMnDHjYEyFPUJWcHwnV0eKPFyMZqKuz3DY2dCt7Ie8qxu1Fc/OvKq2Z
 v+mA==
X-Gm-Message-State: AOAM530Nuhe2thWBj4azTu6tApsQNVtde0J0Vcee8emHYo9m9lpiVgw7
 eowPE/niUExXYP+cZlIbllECyqU499lxK3sUbFiObyWT3APkr3JAl9OHN/GQosM+5MyZmGBkAwT
 mw7gvfnUzfHB97tQ=
X-Received: by 2002:a5d:6852:: with SMTP id o18mr2196693wrw.113.1599136114514; 
 Thu, 03 Sep 2020 05:28:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8CmIhwAQ9b93PJpqyYHFIs49vhIFH4Ne2ggMTM6P2hhq/nbFCE1VZQ5IjKH/daarphlDDJg==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr2196671wrw.113.1599136114366; 
 Thu, 03 Sep 2020 05:28:34 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id y207sm4495098wmc.17.2020.09.03.05.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/15] block/nvme: Use common error path in
 nvme_add_io_queue()
Date: Thu,  3 Sep 2020 14:27:54 +0200
Message-Id: <20200903122803.405265-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rearrange nvme_add_io_queue() by using a common error path.
This will be proven useful in few commits where we add IRQ
notification to the IO queues.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 91dba4ec5db..909a565184d 100644
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


