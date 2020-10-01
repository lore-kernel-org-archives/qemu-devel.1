Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0AC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A3F2075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP/RrD+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A3F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1fZ-0006zv-Ie
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO1Sq-0000Is-W5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO1Sl-0003cu-Ek
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601569786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GFpPeAXjKc/8xBfSvvEE2WqFS5XinOd4OXRsQgDMK1U=;
 b=DP/RrD+BsQqiCGbYgawf4Q22qxh2yBH/gTaCSXp4b4G2FGYoP253cyVKJrpEK4meu+jW44
 jAHNk0chO4EpJGSvrFN3Sv0dQoT/MMiIziHPfXCoKyBWVGQA1QtYkagYXWhiIKHyIcowey
 MOp+vQFeGeq6qg0wG9W91ARlJGlFIFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-pTRD-Oa8NJ2o_8drGXtSkQ-1; Thu, 01 Oct 2020 12:29:45 -0400
X-MC-Unique: pTRD-Oa8NJ2o_8drGXtSkQ-1
Received: by mail-wr1-f72.google.com with SMTP id f18so2257971wrv.19
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GFpPeAXjKc/8xBfSvvEE2WqFS5XinOd4OXRsQgDMK1U=;
 b=miEgASn+TvBc0UXZC4yDoHfFCq8nGimssEA7+aeYmQCZiXTQ/plq0LHfeBQTTo6nW6
 agSRoTBQH1AypgVSbOiu2z9HseB3AZlQUzJKVRfdMCE0YtXeV028VWYIwqh/UpNKYsDW
 vqztFNXo2/AiJ1fZhYGvx6x9PXchMyGu5kIMtPgPI8LuIvvBIgr5FovqQT1K70coHx5z
 oxDtV8zf8fMYy6jF16DIUOYMcJ/cYLNVIJJXa/jJ9CME8GxFiJWNC2wP/Y/5GgLrHclm
 iby6mfeqFSjkGjsBaGduZ/IfqXMMVAfgPzSAJ3zILUtQ6fisvKtt3/i9QH6N8PfOrxv3
 QT8w==
X-Gm-Message-State: AOAM530KbBQCaBU/p03Eh8Mzsviy4te7e1Dln9ZJcXH6HUDI4uR5x4mW
 W8CepfVWBhmMwPwbU2Q4WF2lN8KUHqWkWcivsFpU7/G+4QwovZN9jXsRLXgijj/aGbcZjhLI0oL
 43BOItC9XCrQMA9w=
X-Received: by 2002:a5d:4811:: with SMTP id l17mr10297747wrq.252.1601569782890; 
 Thu, 01 Oct 2020 09:29:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjTaHuHL75fRAn9iekkKWdwW9UYcdNq30QjO1/sEKgB54Xr0JqhV2TL9p0wC9M0U6PZhXgwg==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr10297721wrq.252.1601569782655; 
 Thu, 01 Oct 2020 09:29:42 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m13sm704376wml.5.2020.10.01.09.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:29:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] block/nvme: Add driver statistics for access alignment and
 hw errors
Date: Thu,  1 Oct 2020 18:29:39 +0200
Message-Id: <20201001162939.1567915-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep statistics of some hardware errors, and number of
aligned/unaligned I/O accesses.

QMP example booting a full RHEL 8.3 aarch64 guest:

{ "execute": "query-blockstats" }
{
    "return": [
        {
            "device": "",
            "node-name": "drive0",
            "stats": {
                "flush_total_time_ns": 6026948,
                "wr_highest_offset": 3383991230464,
                "wr_total_time_ns": 807450995,
                "failed_wr_operations": 0,
                "failed_rd_operations": 0,
                "wr_merged": 3,
                "wr_bytes": 50133504,
                "failed_unmap_operations": 0,
                "failed_flush_operations": 0,
                "account_invalid": false,
                "rd_total_time_ns": 1846979900,
                "flush_operations": 130,
                "wr_operations": 659,
                "rd_merged": 1192,
                "rd_bytes": 218244096,
                "account_failed": false,
                "idle_time_ns": 2678641497,
                "rd_operations": 7406,
            },
            "driver-specific": {
                "driver": "nvme",
                "completion-errors": 0,
                "unaligned-accesses": 2959,
                "aligned-accesses": 4477
            },
            "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"
        }
    ]
}

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: 'access-nb' -> 'accesses' (Stefan)
---
 qapi/block-core.json | 24 +++++++++++++++++++++++-
 block/nvme.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 86ed72ef9f..dec17e3036 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -941,6 +941,27 @@
       'discard-nb-failed': 'uint64',
       'discard-bytes-ok': 'uint64' } }
 
+##
+# @BlockStatsSpecificNvme:
+#
+# NVMe driver statistics
+#
+# @completion-errors: The number of completion errors.
+#
+# @aligned-accesses: The number of aligned accesses performed by
+#                    the driver.
+#
+# @unaligned-accesses: The number of unaligned accesses performed by
+#                      the driver.
+#
+# Since: 5.2
+##
+{ 'struct': 'BlockStatsSpecificNvme',
+  'data': {
+      'completion-errors': 'uint64',
+      'aligned-accesses': 'uint64',
+      'unaligned-accesses': 'uint64' } }
+
 ##
 # @BlockStatsSpecific:
 #
@@ -953,7 +974,8 @@
   'discriminator': 'driver',
   'data': {
       'file': 'BlockStatsSpecificFile',
-      'host_device': 'BlockStatsSpecificFile' } }
+      'host_device': 'BlockStatsSpecificFile',
+      'nvme': 'BlockStatsSpecificNvme' } }
 
 ##
 # @BlockStats:
diff --git a/block/nvme.c b/block/nvme.c
index f4f27b6da7..ba6d066067 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -133,6 +133,12 @@ struct BDRVNVMeState {
 
     /* PCI address (required for nvme_refresh_filename()) */
     char *device;
+
+    struct {
+        uint64_t completion_errors;
+        uint64_t aligned_accesses;
+        uint64_t unaligned_accesses;
+    } stats;
 };
 
 #define NVME_BLOCK_OPT_DEVICE "device"
@@ -389,6 +395,9 @@ static bool nvme_process_completion(NVMeQueuePair *q)
             break;
         }
         ret = nvme_translate_error(c);
+        if (ret) {
+            s->stats.completion_errors++;
+        }
         q->cq.head = (q->cq.head + 1) % NVME_QUEUE_SIZE;
         if (!q->cq.head) {
             q->cq_phase = !q->cq_phase;
@@ -1146,8 +1155,10 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     assert(QEMU_IS_ALIGNED(bytes, s->page_size));
     assert(bytes <= s->max_transfer);
     if (nvme_qiov_aligned(bs, qiov)) {
+        s->stats.aligned_accesses++;
         return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
     }
+    s->stats.unaligned_accesses++;
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
     buf = qemu_try_memalign(s->page_size, bytes);
 
@@ -1443,6 +1454,21 @@ static void nvme_unregister_buf(BlockDriverState *bs, void *host)
     qemu_vfio_dma_unmap(s->vfio, host);
 }
 
+static BlockStatsSpecific *nvme_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats = g_new(BlockStatsSpecific, 1);
+    BDRVNVMeState *s = bs->opaque;
+
+    stats->driver = BLOCKDEV_DRIVER_NVME;
+    stats->u.nvme = (BlockStatsSpecificNvme) {
+        .completion_errors = s->stats.completion_errors,
+        .aligned_accesses = s->stats.aligned_accesses,
+        .unaligned_accesses = s->stats.unaligned_accesses,
+    };
+
+    return stats;
+}
+
 static const char *const nvme_strong_runtime_opts[] = {
     NVME_BLOCK_OPT_DEVICE,
     NVME_BLOCK_OPT_NAMESPACE,
@@ -1476,6 +1502,7 @@ static BlockDriver bdrv_nvme = {
     .bdrv_refresh_filename    = nvme_refresh_filename,
     .bdrv_refresh_limits      = nvme_refresh_limits,
     .strong_runtime_opts      = nvme_strong_runtime_opts,
+    .bdrv_get_specific_stats  = nvme_get_specific_stats,
 
     .bdrv_detach_aio_context  = nvme_detach_aio_context,
     .bdrv_attach_aio_context  = nvme_attach_aio_context,
-- 
2.26.2


