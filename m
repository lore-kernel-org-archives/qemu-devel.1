Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A6BC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5F120737
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5F120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNsk0-0003I6-9Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 02:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsjI-0002tI-AI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsjG-0006ag-ER
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:37:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:44624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jNsjG-0006Zu-7W
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:37:58 -0400
IronPort-SDR: NKV7W5KFRDiMM6FcCN3wij8cw9rJOkTbaaDNxrOsdzSVu7tTPfcMTGBeGuo4YRHuv/BVWn3z2b
 Guvym1pouzXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 23:37:53 -0700
IronPort-SDR: UK22bhjduU339CqIPOqCEHcICwmOlRN7ukYDwG4+UqNIoh2HRjTN1Nx3gQs7mwVe6JgUfM7F+A
 6/oVAhnr0tfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="276813149"
Received: from dpdk-zhirun.sh.intel.com ([10.67.119.121])
 by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2020 23:37:51 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] drop writes to read-only ram device & vfio regions
Date: Mon, 13 Apr 2020 06:36:27 +0000
Message-Id: <20200413063627.84608-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, xin.zeng@intel.com,
 alex.williamson@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

patch 1 modifies handler of ram device memory regions to drop guest writes
to read-only ram device memory regions

patch 2 modifies handler of non-mmap'd read-only vfio regions to drop guest
writes to those regions 

patch 3 set read-only flag to mmap'd read-only vfio regions, so that guest
writes to those regions would be trapped.
without patch 1, host qemu would then crash on guest write to those read-only
regions.
with patch 1, host qemu would drop the writes.

Changelog:
v3:
-refreshed and Cc Stefan for reviewing of tracing part

v2:
-split one big patches into smaller ones (Philippe)
-modify existing trace to record guest writes to read-only memory (Alex)
-modify vfio_region_write() to drop guest writes to non-mmap'd read-only
 region (Alex)

Yan Zhao (3):
  memory: drop guest writes to read-only ram device regions
  hw/vfio: drop guest writes to ro regions
  hw/vfio: let read-only flag take effect for mmap'd regions

 hw/vfio/common.c     | 12 +++++++++++-
 hw/vfio/trace-events |  2 +-
 memory.c             |  6 +++++-
 trace-events         |  2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.17.1


