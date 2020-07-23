Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC679C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB4520714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB4520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydjf-00080k-1O
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfN-0003Gy-9i; Thu, 23 Jul 2020 12:01:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:36927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfK-0006jP-EO; Thu, 23 Jul 2020 12:01:52 -0400
IronPort-SDR: PQZHZ4eQ60ompf1bNc/obCjFPub14AgYQcxDy3PMl+2b7FD2FohteWH5U2m7xfQExoLIZWbERb
 u7kv9wIOXmxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150543455"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="150543455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 09:01:48 -0700
IronPort-SDR: DfeKIEwem2bWAJMNeGXQltjSFJJDGUE93Mmv5EdsZ/b2PBuoJvUPqXiyr8fRXg2ZUUjnG3ii45
 RpxstpocNNCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="319033172"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.61.79])
 by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 09:01:46 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v5 1/3] memory: export memory_region_to_absolute_addr()
 function
Date: Thu, 23 Jul 2020 09:03:23 -0700
Message-Id: <20200723160325.41734-2-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
References: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 12:01:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Cc: pbonzini@redhat.com, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change exports memory_region_to_absolute_addr() function so it can
be used by drivers requiring to calculate absolute address for memory
subregions when memory hierarchy is used.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 include/exec/memory.h | 9 +++++++++
 softmmu/memory.c      | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..6e5bba602e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2017,6 +2017,15 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          MemOp op,
                                          MemTxAttrs attrs);
 
+/**
+ * memory_region_to_absolute_addr: walk through memory hierarchy to retrieve
+ * absolute address for given MemoryRegion.
+ *
+ * @mr: #MemoryRegion to scan through
+ * @offset: starting offset within mr
+ */
+hwaddr memory_region_to_absolute_addr(MemoryRegion *mr, hwaddr offset);
+
 /**
  * address_space_init: initializes an address space
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 9200b20130..deff3739ff 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -399,7 +399,7 @@ static inline uint64_t memory_region_shift_write_access(uint64_t *value,
     return tmp;
 }
 
-static hwaddr memory_region_to_absolute_addr(MemoryRegion *mr, hwaddr offset)
+hwaddr memory_region_to_absolute_addr(MemoryRegion *mr, hwaddr offset)
 {
     MemoryRegion *root;
     hwaddr abs_addr = offset;
-- 
2.21.1


