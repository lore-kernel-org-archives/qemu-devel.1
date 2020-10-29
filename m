Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25902076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NckW2u9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25902076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4LV-00084F-N5
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JM-0005xx-Se
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JL-0006Qa-06
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OTYCQauWLqy/pYJjIYbS2aJ8PCndAOeGCZKOtfKeEs=;
 b=NckW2u9gF93EyL1uU1v/mM2XCbeOBCCggA51Vlz+GIVKcoR3SQ77DdL4q1CxVST+49kLgp
 lC+4DKmZJqjIolc6g7J6+TGX0YkMdLjgJHkRRAvIndAfYabfJkhRFsXnkLVKlo1nkJvv80
 XvxDTYCXIgeVe+4umNLyyx3kIfH1oIk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-igD4E1AAMhGklUedCKoYUg-1; Thu, 29 Oct 2020 05:33:32 -0400
X-MC-Unique: igD4E1AAMhGklUedCKoYUg-1
Received: by mail-ed1-f69.google.com with SMTP id dn20so938659edb.14
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8OTYCQauWLqy/pYJjIYbS2aJ8PCndAOeGCZKOtfKeEs=;
 b=ghmcfdCNzclzCyb3afkNZ/tvPjnor9ed24zIlF1RNWoqS+ozXFFq40o7/G+lqNGky3
 31nUulsdSBSeRywLMk70RVjVAqozu/audnchYrzObEmH5OC3A5VdsOvarFEnaLkm1l1q
 eCkcKKeL3S3aWugt0VJ7xSrz9v4/g/LGER68bIyfXgC3BkPfD0KPGbyE5oe1SgJuqzBu
 M5HQuOw182v/XeGi6z5Dc4CdUrBLsn2L92Do2W2bxoYBRHwZ0rQTNALwQoNHGw5tNt16
 PZprSkbJHzsbqyWIP5YJ7GO/jdOmRZ3mQ9GTky+I0l9jMtYeyijN5w9NH5d41Xm4v/7n
 +5mQ==
X-Gm-Message-State: AOAM531+QdjK5lMXar94u87SVGnM4H1Xw2L35zQdJAiuiciRZwS80AAB
 olpZfBZpxEuGQYWpdw3tIWhc5jqmgmH5zruuyya7g8AZhSxOIEkx4xrmvQIe9yybll0MFhMgA5j
 /6bVTjRAAHy0vQu0=
X-Received: by 2002:a05:6402:3056:: with SMTP id
 bu22mr2970999edb.252.1603964011016; 
 Thu, 29 Oct 2020 02:33:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNGB271VNY8YtLI//fo52gK1aTdhRzFjRvhd88T54f99mHfTTD3TOoj5UU1sgoncKt2f7mlQ==
X-Received: by 2002:a05:6402:3056:: with SMTP id
 bu22mr2970984edb.252.1603964010863; 
 Thu, 29 Oct 2020 02:33:30 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z18sm378105ejf.41.2020.10.29.02.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:33:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 04/25] block/nvme: Trace controller capabilities
Date: Thu, 29 Oct 2020 10:32:45 +0100
Message-Id: <20201029093306.1063879-5-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Controllers have different capabilities and report them in the
CAP register. We are particularly interested by the page size
limits.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 13 +++++++++++++
 block/trace-events |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 6f1d7f9b2a1..361b5772b7a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -727,6 +727,19 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
      * Initialization". */
 
     cap = le64_to_cpu(regs->cap);
+    trace_nvme_controller_capability_raw(cap);
+    trace_nvme_controller_capability("Maximum Queue Entries Supported",
+                                     1 + NVME_CAP_MQES(cap));
+    trace_nvme_controller_capability("Contiguous Queues Required",
+                                     NVME_CAP_CQR(cap));
+    trace_nvme_controller_capability("Doorbell Stride",
+                                     2 << (2 + NVME_CAP_DSTRD(cap)));
+    trace_nvme_controller_capability("Subsystem Reset Supported",
+                                     NVME_CAP_NSSRS(cap));
+    trace_nvme_controller_capability("Memory Page Size Minimum",
+                                     1 << (12 + NVME_CAP_MPSMIN(cap)));
+    trace_nvme_controller_capability("Memory Page Size Maximum",
+                                     1 << (12 + NVME_CAP_MPSMAX(cap)));
     if (!NVME_CAP_CSS(cap)) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
diff --git a/block/trace-events b/block/trace-events
index 0955c85c783..b90b07b15fa 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -134,6 +134,8 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
 
 # nvme.c
+nvme_controller_capability_raw(uint64_t value) "0x%08"PRIx64
+nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
 nvme_kick(void *s, int queue) "s %p queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
 nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
-- 
2.26.2


