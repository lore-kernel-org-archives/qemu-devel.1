Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E09C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF5922404
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3msZQBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF5922404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Bj-0000lz-DX
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0A2-0007Bd-Pu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0A0-0008EA-9i
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5p4tPu2TXjCzyH8ugJtEh2K4jonp6V4FsAYE5GR61Q=;
 b=W3msZQBxSYG9rhkQbnp3zJCd6RAT3Esl3SC6ukG2rI2Wob1TRCUHicEdIIVnMx8gqXgNi2
 TdzUzymPQPLXN5O/HKCeHsZXZAuRj4dF12u/rdR2VibPJJs28AfStBNsi7qFmqrmMq6LDk
 fk+34X+lxjgOGFPWW3TKfXFPelGoPME=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-N_8FUwJZNM-47a-ztDHoLg-1; Mon, 26 Oct 2020 06:55:27 -0400
X-MC-Unique: N_8FUwJZNM-47a-ztDHoLg-1
Received: by mail-wm1-f71.google.com with SMTP id f191so5548142wmf.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W5p4tPu2TXjCzyH8ugJtEh2K4jonp6V4FsAYE5GR61Q=;
 b=VVRWkHifOOfmRmfiRcEqk5gT9rGcSqS6Nresob/0V8rnV3be5H1pPx5DDjVbRHUNH6
 4eYxFGMz+SeRTi612FSsVJTZRqNeQi2YMk9qtPFEnf7M4myNuOpvCKz8ECiYqxsik16+
 VBpm3bPQ9D9ikyGFxGKp79XcDL3V1PNE310JqzcLar6CBhzOn65kSWwAfDB7Wn/Xs9VI
 0j0vRd3fUsoLgN0+wVx79hqQMjPe189kpOExxK/rf+dpACzJaRB7kx0GAx5iVFpt1cRQ
 CYz1nDIpP5Tn9z9VZ6FRjjSXF31FD2szL8L8+z4eSQB3hdpKGm07Q3IoTT9kZhHW89B9
 JPRQ==
X-Gm-Message-State: AOAM531joSr18yUomkFj7xRckz3S7TMnWsjXFEci8c4OhQjECC88FBnk
 mcXygTrZa9+gd1ZYhKm6GqdRt0p3NG074r5xHL0ewPC67N7CY/aYBC7lcEQ8119JlueQPpL2jqb
 aG2HKNsxtfLgC6WA=
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr16563047wrt.137.1603709726445; 
 Mon, 26 Oct 2020 03:55:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVe+9JTZp3qp5jWBddiD8ybrIJ6tz51eInzL2wyLjC2LjAT3R04O9eDZwCyFG6bb89m+Rmmg==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr16563021wrt.137.1603709726215; 
 Mon, 26 Oct 2020 03:55:26 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s2sm22714740wmf.45.2020.10.26.03.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/19] block/nvme: Trace controller capabilities
Date: Mon, 26 Oct 2020 11:54:49 +0100
Message-Id: <20201026105504.4023620-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
index 5abd7257cac..3b6d3972ec2 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -720,6 +720,16 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
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
index 0e351c3fa3d..3f141dc6801 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -134,6 +134,7 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
 
 # nvme.c
+nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
 nvme_kick(void *s, int queue) "s %p queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
 nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
-- 
2.26.2


