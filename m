Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47646221FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJyG9T3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47646221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmOxx-0000ie-HP
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 17:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jmOwk-00075o-V8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:53:14 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jmOwj-00029o-Bd
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:53:14 -0400
Received: by mail-pg1-x542.google.com with SMTP id v11so5056770pgb.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=fLhsBOE/Ie7X1lQJNtWOQpBAge+hkeMZxYyQv8gw5/8=;
 b=IJyG9T3lTnQz4uBf4iAzffv+bWmkF2o8P8OIgsxWK9fPFQHFkzedwWw2Eau/434Sqy
 z4Al1ez+CHki30TFREbs1pnSCBwx/Qfhs5QZhOQoebBrznB/WnXVcbs4dQ2vMMw4LLiv
 rkMQuSPtoouqk0CSCfzyRmHP3EXy3FdgBp57vUkd5M8wXj6y/5jcGspWzD7zuTmeMHfW
 RnaOseO7nVYHMna38Pf1v50aGRG/cWFbxnVin1F/93PrO8FMLzF9mpgA5KFsbY4TDqYp
 35rekHevZX+UaM4qrtvNYTlp/aEnDsGyZuH5B+RufMLRi7StpVdCwFyUg8ujSLHrIA0b
 T5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=fLhsBOE/Ie7X1lQJNtWOQpBAge+hkeMZxYyQv8gw5/8=;
 b=S2us26Wrv7ZEu/qCIsUK2uZUvsRtZS/QjM0/YelJHTGDxhAttNJA0hsGxa1Qq71EML
 +HWszHIQ0apoakt97MDuARilYVK1cyCEjqQq+iM5Lm6lHPLOnBfpqHxMDyNmlJIVEb0y
 sYN4v7yoH1TWSiIXRx0dRs1Q4l1o2rwFBorCu2laWsSiOTqev3nzlErWKzaYgetvCExl
 WtilGFQsfIXV3HKLsITurVZf2Itq0nlFhDC3GoWQUyUElSLiBFjiRO3GmvGq5vjMkIqq
 Xyyp3Jbg1+/FHuczixQHQj/iIjGQTfMakxP7fAbfkhWEc9MPlHYMzjrSjs4MneqgkNV1
 kAPQ==
X-Gm-Message-State: AOAM533FM14ijI94ZIXQvdvNi36HvgHgLAnjlrsr7pIq1JyxfXl7uQfY
 8j1YCsapf5+cmXjvXJ1JL88=
X-Google-Smtp-Source: ABdhPJxbpA2QKrEQyIRN6qxwBvqW/4nmdjrcJVH9WC8KYYNn6S0qkate1ur94/Qu/db0SV+wy2vziA==
X-Received: by 2002:a65:4488:: with SMTP id l8mr4564203pgq.327.1592603590871; 
 Fri, 19 Jun 2020 14:53:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id t24sm5850531pgm.10.2020.06.19.14.53.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jun 2020 14:53:10 -0700 (PDT)
Subject: [PATCH 1/2] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Fri, 19 Jun 2020 14:53:09 -0700
Message-ID: <20200619215309.25598.7553.stgit@localhost.localdomain>
In-Reply-To: <20200619214912.25598.8400.stgit@localhost.localdomain>
References: <20200619214912.25598.8400.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

In addition add the necessary locking to provent any potential races
between the accesses of the cmd_id and the status.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a430a..7f3af266f674 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*
@@ -592,14 +593,16 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
-    if (s->free_page_report_cmd_id == UINT_MAX) {
+    qemu_mutex_lock(&s->free_page_lock);
+
+    if (s->free_page_report_cmd_id++ == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-    } else {
-        s->free_page_report_cmd_id++;
     }
 
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    qemu_mutex_unlock(&s->free_page_lock);
+
     virtio_notify_config(vdev);
 }
 


