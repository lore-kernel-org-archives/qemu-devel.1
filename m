Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A875AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAEA20724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAKvN0GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAEA20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrppP-0002Vz-Ma
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpks-0002Rt-44
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkp-00041V-Ct
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXdIespWFUCgh9geAcuRTrSY8JSFvRPXQ9z+IG0M7kw=;
 b=aAKvN0GM2dCKd1WyCuPe291FH42EHvNDc1niYrngpY0jShm5xEn8bXXil+9FvkxRuhiwL4
 Fh+yNMxVxfLN9UzVwQ05GtyX3YX5LxDBFyE4Dfj3tJl+g9gAqG1sX+Q4w0Pnl+cWjwPs2C
 WzzxbEdhCzgpZe3MmFD7SlQrQPm93yg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-QFAXcHzQO7ee_TDDiMgtPA-1; Sat, 04 Jul 2020 17:31:19 -0400
X-MC-Unique: QFAXcHzQO7ee_TDDiMgtPA-1
Received: by mail-wm1-f72.google.com with SMTP id v6so38553207wmg.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GXdIespWFUCgh9geAcuRTrSY8JSFvRPXQ9z+IG0M7kw=;
 b=eG+l4aPTpBx4EwefHcI3LOiKs8V6rJYBc1glAxLV3nlDekPWBB6Yi1+/8ZzbHYwbqV
 TC7PqrjY0T3kMjrKSE9Il7O/bud4VsKZTa9GQO68d9i3ZIorB3ckkWkaI+UsgbbQec27
 gPw0spd6ODD9tVp+M2o5zG7V+Nno3tY1OHkA0lwdUUwaJeb5/IfaD/BfyxXk0U0ooTd9
 2uoFqKXYMgSw4uO5tE0kHNOCcE/frZ6BcMEEDAmRhCp9oOT7rJbak1uiq+a67tlomf1E
 Pk5VK7lBAVgHEqF3ho+SQXclhQTeSvxdAk69oAxyaKh+DGY6WpHAhRRWnSEys36ZwesY
 lbIA==
X-Gm-Message-State: AOAM530G1g3uYZ1IxVWQHDjqhDYNKBVlQGsITv7VXa3T8B4kc6wU2drG
 iM5cOTND4ofLM7g5jJRVUTCVSkIfeDnlQHVAcM+gH00XWYz0XgcuN2oncEqpwc8uypao6VH6MeA
 yp9UwqS1bGPxtHFs=
X-Received: by 2002:adf:8067:: with SMTP id 94mr40293986wrk.427.1593898277904; 
 Sat, 04 Jul 2020 14:31:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGnHVNp/PTtr1kaDiCDEDYLt8M9rfZlwbZcIBV+HFX/50zKAm8JENrHozbThl8RynU198Mcw==
X-Received: by 2002:adf:8067:: with SMTP id 94mr40293975wrk.427.1593898277774; 
 Sat, 04 Jul 2020 14:31:17 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w13sm17780609wrr.67.2020.07.04.14.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 05/16] block/nvme: Improve error message when IO queue
 creation failed
Date: Sat,  4 Jul 2020 23:30:40 +0200
Message-Id: <20200704213051.19749-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use the same error message for different failures.
Display a different error whether it is the CQ or the SQ.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 28762d7ee8..5898a2eab9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -648,7 +648,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
@@ -659,7 +659,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
-- 
2.21.3


