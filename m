Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC630C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D8820774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVT7+lIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D8820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vtj-0000Bo-Lv
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpu-0000J0-1r
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vps-0004ev-70
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHvkvqrDQdFIeZusYpEAEAEbDUde8jnG5Rq1y2LnWV4=;
 b=VVT7+lIQ7ZYYRwH6wCIY1Y5JtNS/xJUKwTQa08s71vZgoUA3UP+Gs6YYGiI/vyaWcRk8hd
 bTOqc52YfT1q0SneR95caazSKEQE0AV2zoS8D/12GEEr4DIW1i7cTtVhBAxT94EDzZt96O
 TMJ+igkBqNLOIJ/GxxW5gwHxTbMGHLw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-6gegs7doPXC2-B3Wxw5hYw-1; Wed, 12 Aug 2020 14:50:50 -0400
X-MC-Unique: 6gegs7doPXC2-B3Wxw5hYw-1
Received: by mail-wr1-f72.google.com with SMTP id r14so1225460wrq.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rHvkvqrDQdFIeZusYpEAEAEbDUde8jnG5Rq1y2LnWV4=;
 b=H+IHlm+0LhZeiiZw5VF9U3lG5EHPvlnBTtpmXwvOVmroqe/KMUa/NrDeN88xV0rjjN
 2YHbhnoLLgo+0h4imy2rTZNg6BHvBXZ4jFvP3n9fEYdqrOkEWUyYJyUKPt4+kg+wcNIM
 sD2FAJoUfWQ7KOdNT43epeet621w7vSVBHJN3ahLqyekiCHfx2zDRcH8BhEVxSBtKmUe
 sixhoGy+9NF0tbN9vgWCOMJMvSSkYLcT/Dvnq8ZNL5AkQgSEdYRa7HqMSATfW3JEwGSO
 Ml8AKyb8Gc9zZocacuGaIWcqDqrmNle+B58hSecsxHNin+KEQJxJB0f26Ho6LWuga1/Y
 BIZg==
X-Gm-Message-State: AOAM531Q7Q4uKL86LOQfUDlP8NDNbccUyb8YFgvIPAJqJFDKFuE8PTOL
 Jzqxw5hOIp683SHYwY3J4sxOx004U/ZAub8vcCDqNkBD33dMngmtL63RItV5slTr4niImIZLdtR
 zbXgP/KzgF4gtruY=
X-Received: by 2002:a1c:a54e:: with SMTP id o75mr930320wme.181.1597258248727; 
 Wed, 12 Aug 2020 11:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUC7zGpNe1OL2dFHlzG5SyFMG31tt+IxXOHmXTjx5/i4/ozwFgOv8AeijxGWsSjntkkQ0Nsg==
X-Received: by 2002:a1c:a54e:: with SMTP id o75mr930308wme.181.1597258248589; 
 Wed, 12 Aug 2020 11:50:48 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v16sm5085725wmj.14.2020.08.12.11.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/14] block/nvme: Use common error path in
 nvme_add_io_queue()
Date: Wed, 12 Aug 2020 20:50:06 +0200
Message-Id: <20200812185014.18267-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
index 53448b7d23..3101f1ad55 100644
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
2.21.3


