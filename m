Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE82C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F944206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKmDgwca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F944206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjK9-0005WB-78
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBM-0004hU-9L
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBK-0000yL-Hr
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjmUmabdPFrqIWe27bV/PHgVzD7yxSTl/8t6QReuLlI=;
 b=aKmDgwca57V7ATeoD19DpJg+f4WGCDpKTTfDsgtJH1ixB//jevVXqn7U8Jc9yehjAoZLcT
 C6/vuRB+ON6paws6zbgu/UAVIdk/TFAtBX+g699XiJk+IRJoRvTtk5lye5uCDeVJeh2U3Y
 qR82b6hSyJScBunXMr2vYMl/GvWf+5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-SqK6CnflMVWaQxZNDmat4Q-1; Wed, 14 Oct 2020 11:59:12 -0400
X-MC-Unique: SqK6CnflMVWaQxZNDmat4Q-1
Received: by mail-wm1-f70.google.com with SMTP id g71so13134wmg.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HjmUmabdPFrqIWe27bV/PHgVzD7yxSTl/8t6QReuLlI=;
 b=tkHfS/3Zs3YHkDIEw1tn82NFNv6OlCDF8gzAo4155PqhY4CXvBu0cwzzzF1ETY2S2X
 KVUDVkl+AW6mdnDauF0oq0OyXhsmyZAl1YoI/+vU7QNOI5BYCa9yi1/w7eKJfNxlkVZM
 AiwWmwwQqlFAAgnNcozJvIDJZlAZ1JbbhMTrochM7tYSsD3e6dUTPyD2xLFy6aa79o3o
 QAzLafgoANmYyJ25092ZX57XMKB5dkPrdaqv8BEOA65elnVowysxj1mRmbG7w4Ujuopb
 HmqOicCeOCy8hh08RwCKfsp+QP98uhBB+lTmyxkcUc9kg0KBN9mRQiizIyiHNExW5CeL
 dH5g==
X-Gm-Message-State: AOAM533MnQK2xMU7ocUT6JERrP/QucvDkbVQhrB+3A6hXc5bsmAUwgBY
 5bzzG+9+ybWKlpWR2AHL7heTRtV7h3iQiaue3VZj24rNyKIML+t55eQxN7rDqxSIS7pEVxc0cvk
 cl6TZ2RJQ9N7DvXA=
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr141912wme.18.1602691147910;
 Wed, 14 Oct 2020 08:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTCbHG7OyDh9+X4wwi0BcuIZEZiLxT8dDgXYokzetAJfBJy4+u1HRLfPIgjPrJGskXMtGz/A==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr141895wme.18.1602691147688;
 Wed, 14 Oct 2020 08:59:07 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z11sm5527165wrh.70.2020.10.14.08.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:59:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/15] block/nvme: Trace controller capabilities
Date: Wed, 14 Oct 2020 17:58:06 +0200
Message-Id: <20201014155810.102841-12-philmd@redhat.com>
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

Controllers have different capabilities and report them in the
CAP register. We are particularly interested by the page size
limits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 10 ++++++++++
 block/trace-events |  1 +
 2 files changed, 11 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 11fba2d754d..fad727416ee 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -725,6 +725,16 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
      * Initialization". */
 
     cap = le64_to_cpu(regs->cap);
+    trace_nvme_controller_capability("Maximum Queue Entries Supported",
+                                     NVME_CAP_MQES(cap));
+    trace_nvme_controller_capability("Contiguous Queues Required",
+                                     NVME_CAP_CQR(cap));
+    trace_nvme_controller_capability("Subsystem  Reset Supported",
+                                     NVME_CAP_NSSRS(cap));
+    trace_nvme_controller_capability("Memory Page Size Minimum",
+                                     NVME_CAP_MPSMIN(cap));
+    trace_nvme_controller_capability("Memory Page Size Maximum",
+                                     NVME_CAP_MPSMAX(cap));
     if (!NVME_CAP_CSS(cap)) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
diff --git a/block/trace-events b/block/trace-events
index 6694c23e1c1..8a24d7a8650 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -134,6 +134,7 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
 
 # nvme.c
+nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
 nvme_kick(void *s, unsigned q_index) "s %p q #%u"
 nvme_dma_flush_queue_wait(void *s) "s %p"
 nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
-- 
2.26.2


