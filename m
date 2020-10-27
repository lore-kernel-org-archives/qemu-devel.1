Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB0C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A05206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9USzSOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A05206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPp1-0003X1-Kg
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSX-00031k-KV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSV-0004FY-VD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7fBCIQ/1BkfqoPLON3TqQaNLgboMKILqf/ROXQloYA=;
 b=D9USzSOzyANn/jANOYByR8mkYpdg7EYcD8+Vq09yBA4cEkOFsDkZRjdh6hqLzJldH3J/yv
 C638030DA4JCfRxTjgzJ2YN4seG13Rqk6sQhROMXi+7ROV1CzEiw6nwrGutjSGMZ4B9MKA
 9YnsuGwwtxo4mk3ZIi6oeilncd+KS8U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-4ln7PhDBOZa0A2fZ_bjsxA-1; Tue, 27 Oct 2020 09:56:13 -0400
X-MC-Unique: 4ln7PhDBOZa0A2fZ_bjsxA-1
Received: by mail-ed1-f70.google.com with SMTP id n16so695236edw.19
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a7fBCIQ/1BkfqoPLON3TqQaNLgboMKILqf/ROXQloYA=;
 b=a/+zQpOAI7jrdHcFcOXNCb7ZZvcv3Ci+vMxti0elu3NQ0UeqJjcDBnF6u3uMGjYcSX
 eyra+opjYGDppqL+X7+8BNKrp7AyIY4ymDm5lG/t1j0oepLVLlVAigPcWvs3vBeDOz/S
 Fxy23zWkonMSBllT8MRnxu6zNLKw3QNeusk9P8arw5LAJTn/MuIG4NDpBGBzRoSWa+3/
 4h/rlAO/Rqsye1w6/h1OkFJS6DXTr55bt6EImG6g7OncGLdskQKkgmiW2b/SlSzoTOg5
 frMby0tKDPRGk/CoKPJS++3ggv37gWUKSQSJt7cFQwT9b+4426/3deoShHpOlqQHRp/H
 L3pg==
X-Gm-Message-State: AOAM532UyN1Ipk+EuLu6rOW1VGqoANa9tiw05kyN+pcjHX6BjFKqRBHg
 Wq/5L3TxYhUn5IZ+z1xw2zeeExM6HuGJGYZcJjxj2X332ui8/ljFqiXHI2J02nq1XOYP8P65PC1
 FDmcIAdWIYJ0Ha+Q=
X-Received: by 2002:a17:906:1804:: with SMTP id
 v4mr2593852eje.201.1603806972001; 
 Tue, 27 Oct 2020 06:56:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZgJ0Yhl0g+IaSqdnBKcqOlMQmDkgQVickfFpeBkLGikNBaXcoPQA5gqttgXSEN0pAPYoMDg==
X-Received: by 2002:a17:906:1804:: with SMTP id
 v4mr2593829eje.201.1603806971794; 
 Tue, 27 Oct 2020 06:56:11 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id qq10sm1126501ejb.31.2020.10.27.06.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/25] block/nvme: Trace controller capabilities
Date: Tue, 27 Oct 2020 14:55:26 +0100
Message-Id: <20201027135547.374946-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Controllers have different capabilities and report them in the
CAP register. We are particularly interested by the page size
limits.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


