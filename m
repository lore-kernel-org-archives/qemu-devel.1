Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF75C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06ECF20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcgH6HKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06ECF20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjEJ-0006EN-PM
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAa-0004HV-1s
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAT-0000rf-Tn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKV0WLjtIuXuPWZBe66EqUXPKE/Tlow7+lo7RAkaIjU=;
 b=bcgH6HKIZ0Ll3ty3TV3DVGjlH/d4c+WWI30W7YYRXqyeLjY7gMJGeDTo3+GvGMLoWqI2QQ
 FuYPvLRkqF3tN5mHsA0ZG6FwsGlAwOxLTAnocCXwrs+5lUCqh6lRoIbXzTEM6WEYOPphiO
 2c7KzsHKOX8wd/9Er0zlF41h+rzMtP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-XI73lhc7P5K6r3mdJe3eMg-1; Wed, 14 Oct 2020 11:58:19 -0400
X-MC-Unique: XI73lhc7P5K6r3mdJe3eMg-1
Received: by mail-wm1-f70.google.com with SMTP id m14so16466wmi.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NKV0WLjtIuXuPWZBe66EqUXPKE/Tlow7+lo7RAkaIjU=;
 b=RtDLp3p6UcUkgzv+1wE6gHYs5nn3gsOwsTIZMr9DAomlZzJFZYlzIMGKLyQfwHiy8l
 iQQRwHb/tAv9xFY8ktk+Ls3NF8el8NwvRgODKJb3beX9eLSK85PaTL37UwZ0JkVhs0Uy
 tFDHvENAznP4DBGgMcCCbMeuoslJRNzexNIoC3Ei+TZWWWHLOOnZKsekqkn3PahRngq/
 I8tAwQIsLnnlKDpXtonrWxzGjQzjrgOfgTA3uOfB8OZU/KqJOuaJX/KEfg3so8nUYFtV
 +25V1P6A8BPijRMOM6C8Vw6v+8FidU/WU6T/fPV5xkYyqCzDNTm6Nb66b8c10mLIV+Wb
 /bhg==
X-Gm-Message-State: AOAM532eZXhnUTqovAFcrUOi9ErPrAbcTELPo+iJfc3OvTshp06aS8qV
 N+JZRYaZXkcFmXsU9QbolXvd6AyeLC8vIzVE5px9iac5NDX1EO0BNxPpG0/YiHWNP+FtG/xy5I4
 JTtLovJ2D9rSmg8s=
X-Received: by 2002:a1c:9949:: with SMTP id b70mr119916wme.116.1602691097984; 
 Wed, 14 Oct 2020 08:58:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3oYUQT/8tb+WIc7o1xKH8zo1BJuFESxiUhXIColPAKAlulTqIZ7WoFwBrT5Q3YQ2sW7bX3g==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr119902wme.116.1602691097839; 
 Wed, 14 Oct 2020 08:58:17 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u195sm110593wmu.18.2020.10.14.08.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/15] block/nvme: Move nvme_poll_cb() earlier
Date: Wed, 14 Oct 2020 17:57:56 +0200
Message-Id: <20201014155810.102841-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use this callback in nvme_add_io_queue()
in few commits. To avoid forward-declaring it, move it
before. No logical change.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 5f662c55bbe..a534c61b6b6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -627,6 +627,16 @@ static void nvme_handle_event(EventNotifier *n)
     nvme_poll_queues(s);
 }
 
+static bool nvme_poll_cb(void *opaque)
+{
+    EventNotifier *e = opaque;
+    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
+                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
+
+    trace_nvme_poll_cb(s);
+    return nvme_poll_queues(s);
+}
+
 static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
@@ -669,16 +679,6 @@ out_error:
     return false;
 }
 
-static bool nvme_poll_cb(void *opaque)
-{
-    EventNotifier *e = opaque;
-    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
-                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
-
-    trace_nvme_poll_cb(s);
-    return nvme_poll_queues(s);
-}
-
 static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
-- 
2.26.2


