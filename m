Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E3CC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3732083B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3732083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1jl-0002qf-Sp
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU1iz-0002N2-Sz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU1iy-00016W-P3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:27:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:47960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jU1iy-00015n-8A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:27:04 -0400
IronPort-SDR: Yw6su3UWqstEdf5IrZ0O1sQIQBL78dJOhLwortMzn/rxhGOAWT+zuF8k/n5hmLfmdm0wemLpAx
 813BymVM51jQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 22:27:00 -0700
IronPort-SDR: UG8qIIyDSoPbFx0MfH4kC7m0yUDeCgvQZEiFVUKdxu4Ftl3I6MAduc/NpSYHoE8O7oAiOaKqQr
 nWoZBe9HSYqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="459440672"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 22:26:58 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: pbonzini@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v5 0/3] drop writes to read-only ram device & vfio regions
Date: Thu, 30 Apr 2020 01:15:58 -0400
Message-Id: <20200430051558.28991-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=yan.y.zhao@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:42:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, xin.zeng@intel.com, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

guest writes to read-only memory regions need to be dropped.

patch 1 modifies handler of ram device memory regions to drop guest writes
to read-only ram device memory regions

patch 2 modifies handler of non-mmap'd read-only vfio regions to drop guest
writes to those regions 

patch 3 set read-only flag to mmap'd read-only vfio regions, so that guest
writes to those regions would be trapped.
without patch 1, host qemu would then crash on guest write to those
read-only regions.
with patch 1, host qemu would drop the writes.

Changelog:
v5:
-changed write handler of ram device memory region from .write to
.write_with_attrs in patch 1 (Paolo)
(for vfio region in patch 2, I still keep the operations as .read & .write.
the reasons are:
1. vfio_region_ops are for mmio/pio regions. the top level read/write
dispatcher in kvm just ignores their return values. (the return value of
address_space_rw() is just ignored)
2. there are a lot of callers to vfio_region_read() and
vfio_region_write(), who actually do not care about the return values
)
-minor changes on text format in error logs.

v4:
-instead of modifying tracing log, added qemu_log_mask(LOG_GUEST_ERROR...)
to log guest writes to read-only regions (Philippe)

for
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

 hw/vfio/common.c | 17 +++++++++++++++--
 memory.c         | 15 ++++++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.17.1


