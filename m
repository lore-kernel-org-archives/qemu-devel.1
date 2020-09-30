Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A10C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF45A206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v/slURBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF45A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkMC-0006dL-VM
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD9-0005Wm-Gs; Wed, 30 Sep 2020 18:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD7-0007wn-Sl; Wed, 30 Sep 2020 18:04:31 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A52A42075F;
 Wed, 30 Sep 2020 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503468;
 bh=lxmqCE+QiOMb+CQMDE6EiVOQtrXtjsUVVji5oSDyOzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=v/slURBI+cdxYNRCB+Vj4bJu56nbTvVJah7VLMDROKJIgYNSak+Y5vNaLElJXxM3+
 nSrTEaMDsNvcKTVBhjl0Cr2g9ZR75NdDIsikzm7VBJZKqwE9g0O10kYQvfq0fP8ieg
 ZFksmokKHwePtayHZUiZro8+usE87ll8cNik8JBk=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 9/9] hw/block/nvme: report actual LBA data shift in LBAF
Date: Wed, 30 Sep 2020 15:04:14 -0700
Message-Id: <20200930220414.562527-10-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Calculate the data shift value to report based on the set value of
logical_block_size device property.

In the process, use a local variable to calculate the LBA format
index instead of the hardcoded value 0. This makes the code more
readable and it will make it easier to add support for multiple LBA
formats in the future.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme-ns.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 2ba0263dda..a85e5fdb42 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -47,6 +47,8 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
+    int lba_index;
+
     if (!blkconf_blocksizes(&ns->blkconf, errp)) {
         return -1;
     }
@@ -67,6 +69,9 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         n->features.vwc = 0x1;
     }
 
+    lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    ns->id_ns.lbaf[lba_index].ds = 31 - clz32(ns->blkconf.logical_block_size);
+
     return 0;
 }
 
-- 
2.24.1


