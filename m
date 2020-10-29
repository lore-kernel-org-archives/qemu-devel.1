Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58799C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908C02076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0LxP+Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908C02076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4PG-0006Yh-HI
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jv-0006EJ-4Y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Js-0006aq-UH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+MwM4zuNe+rNYGXGpfeK41VSib34xtRzDIP8WoYZOs=;
 b=T0LxP+Hub2oDOqnuMNCLj/y3U5tGd+VHmOwPLw3pA/isG8JMMX397FfqWqrFL/95xzDidZ
 tKNM1wyw3GUU0DrCe411YclmD28dOu61w+1qEreBIwe62PKQgw4etzHrtrCY+9BJHmGQCB
 M4E4IxRprO7W/jtWclu5qDi8iB7v/V8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-xNwsfrrqMvuWu6tV1aBMqQ-1; Thu, 29 Oct 2020 05:34:04 -0400
X-MC-Unique: xNwsfrrqMvuWu6tV1aBMqQ-1
Received: by mail-ed1-f72.google.com with SMTP id bs10so918652edb.22
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C+MwM4zuNe+rNYGXGpfeK41VSib34xtRzDIP8WoYZOs=;
 b=asj9IZhNNtcE/stwMAS5VGdD646H6n42Q2a+EOSLoWlSZ9jh4r+5D5zjuIQVROJoio
 rU/oM0xcW1APqRRHrT4O6BaURUa0D30GocTtxcK/X/MfZQRwtRNWEoz9jzoU5RKG3aEc
 rVgA1OJcqLmBjMs3K21YOMKpy6aL/zBrDteEw0kZXlKrPTYUeLXI+efCOwOSsL580pLm
 YHvA+EZMZG3G8EeFYUNlJICb/mgzsD2Bxx6wU8Dq0NddVmbSsc+pcxTZKSFYdg8FfbX5
 0QDKQDasF/YDXff4B/xsvo0C0E+DdvWIyPyJHlGMzMYZ9YYfMLBq7tZlqWOXxOaa84LD
 lKYw==
X-Gm-Message-State: AOAM532zhLS04BpS0x66A24J3hr9bl9whsybuEh3h173O9sicuPlHAAq
 hvqcX/I2++sOtMI08zHOKg8CbM6+mX7jcAKVJChoZHIGwy6xmWQlJLCA2HolQwZPUQagXXiX0H7
 6ZG96/EkMGG8ytNg=
X-Received: by 2002:a50:8125:: with SMTP id 34mr3152140edc.39.1603964043060;
 Thu, 29 Oct 2020 02:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF4kkM/D9J7bCjTQpyvr3ZD4e+DAev94YnVBvQHSdQCIOAaI9hOoQR1Cw/w4IUExJsIfzPKQ==
X-Received: by 2002:a50:8125:: with SMTP id 34mr3152120edc.39.1603964042834;
 Thu, 29 Oct 2020 02:34:02 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id k26sm1166658edf.85.2020.10.29.02.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 10/25] block/nvme: Make nvme_identify() return
 boolean indicating error
Date: Thu, 29 Oct 2020 10:32:51 +0100
Message-Id: <20201029093306.1063879-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just for consistency, following the example documented since
commit e3fe3988d7 ("error: Document Error API usage rules"),
return a boolean value indicating an error is set or not.
Directly pass errp as the local_err is not requested in our
case.

Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index c450499111e..98335012457 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -506,9 +506,11 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     return ret;
 }
 
-static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
+/* Returns true on success, false on failure. */
+static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    bool ret = false;
     union {
         NvmeIdCtrl ctrl;
         NvmeIdNs ns;
@@ -585,10 +587,13 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         goto out;
     }
 
+    ret = true;
     s->blkshift = lbaf->ds;
 out:
     qemu_vfio_dma_unmap(s->vfio, id);
     qemu_vfree(id);
+
+    return ret;
 }
 
 static bool nvme_poll_queue(NVMeQueuePair *q)
@@ -701,7 +706,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t cap;
     uint64_t timeout_ms;
     uint64_t deadline, now;
-    Error *local_err = NULL;
     volatile NvmeBar *regs = NULL;
 
     qemu_co_mutex_init(&s->dma_map_lock);
@@ -818,9 +822,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                            &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, nvme_handle_event, nvme_poll_cb);
 
-    nvme_identify(bs, namespace, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_identify(bs, namespace, errp)) {
         ret = -EIO;
         goto out;
     }
-- 
2.26.2


