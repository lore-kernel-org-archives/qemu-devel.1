Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180E0206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180E0206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHSd-0008L5-4S
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jKHLX-0003f6-OZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jKHLW-00025V-3B
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:06:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:20879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jKHLV-000210-QX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:06:34 -0400
IronPort-SDR: q0QoLRdJP6apxulI68mfBondVJm/3UJ5PJzkhPQnxxzhi+DxotkMAhUPC5kQh5eW5OPzT/nHO5
 f/fv8vKCluoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 01:06:23 -0700
IronPort-SDR: NISk3zbcXuFDbGuX/wE17VrJQMqChUvarIaDscMcItoXfGWfyfSjIAhcvJ8navQcHs+aS4iHoI
 GkJADR3OEfMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="273862777"
Received: from dpdk-zhirun.sh.intel.com ([10.67.119.121])
 by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2020 01:06:21 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] drop writes to read-only ram device & vfio regions
Date: Fri,  3 Apr 2020 16:56:57 +0000
Message-Id: <20200403165657.20566-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com, philmd@redhat.com, xin.zeng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

patch 1 modifies handler of ram device memory regions to drop guest writes
to read-only ram device memory regions

patch 2 modifies handler of non-mmap'd read-only vfio regions to drop guest
writes to those regions 

patch 3 let mmap'd read-only vfio regions be able to generate vmexit for
guest write. so, without patch 1, host qemu would crash on guest write to
this read-only region. with patch 1, host qemu would drop the writes.

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


