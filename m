Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0070CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C394E2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C394E2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB95u-00073J-3K
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@cn.fujitsu.com>)
 id 1kB94y-0006VE-M5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:00:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51412
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lizhijian@cn.fujitsu.com>) id 1kB94w-0004dl-Oh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:00:00 -0400
X-IronPort-AV: E=Sophos;i="5.76,358,1592841600"; d="scan'208";a="98605503"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 27 Aug 2020 11:59:55 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
 by cn.fujitsu.com (Postfix) with ESMTP id C98DD48990D9;
 Thu, 27 Aug 2020 11:59:53 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 27 Aug 2020 11:59:54 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 27 Aug 2020 11:59:53 +0800
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <kraxel@redhat.com>, <mst@redhat.com>
Subject: [PATCH v3] virtio-gpu: fix unmap the already mapped items
Date: Thu, 27 Aug 2020 11:58:55 +0800
Message-ID: <20200827035855.24354-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-yoursite-MailScanner-ID: C98DD48990D9.ACF94
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Received-SPF: none client-ip=183.91.158.132;
 envelope-from=lizhijian@cn.fujitsu.com; helo=heian.cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 23:41:38
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

we go here either (!(*iov)[i].iov_base) or (len != l), so we need to consider
to unmap the 'i'th item as well when the 'i'th item is not nil

CC: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
v2: address Gerd's comments
v3: leave (*iov)[i].iov_len as the real mapped len (Li Qiang)
---
 hw/display/virtio-gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f0dd7c150..90be4e3ed7 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -646,9 +646,9 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
         uint64_t a = le64_to_cpu(ents[i].addr);
         uint32_t l = le32_to_cpu(ents[i].length);
         hwaddr len = l;
-        (*iov)[i].iov_len = l;
         (*iov)[i].iov_base = dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
                                             a, &len, DMA_DIRECTION_TO_DEVICE);
+        (*iov)[i].iov_len = len;
         if (addr) {
             (*addr)[i] = a;
         }
@@ -656,6 +656,9 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                           " resource %d element %d\n",
                           __func__, ab->resource_id, i);
+            if ((*iov)[i].iov_base) {
+                i++; /* cleanup the 'i'th map */
+            }
             virtio_gpu_cleanup_mapping_iov(g, *iov, i);
             g_free(ents);
             *iov = NULL;
-- 
2.28.0




