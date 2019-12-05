Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8702DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F0C20675
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F0C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iciFA-0006Yo-S0
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iciCt-0004su-L8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iciCq-0000UD-F2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:53:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:11202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iciCo-0000Fx-Dc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:53:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="201639778"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by orsmga007.jf.intel.com with ESMTP; 04 Dec 2019 19:53:16 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 0/2] QEMU: Dynamic trap/untrap of VFIO PCI BARs 
Date: Wed,  4 Dec 2019 22:44:51 -0500
Message-Id: <20191205034451.30181-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, zhenyuw@linux.intel.com, shaopeng.he@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset enables PCI BARs to be dynamically trapped/passthroughed
in response to vendor driver's needs.

To dynamic trap/untrap PCI BARs, 3 info required:
(1) which part of PCI BARs are to be trapped/passthroughed
(2) when to do the trap/passthrough transition
(3) to trap or to passthrough

Patch 1 let vendor driver specify which sparse mmaped subregions are
disablable. Therefore providing the first info.

Patch 2 probes and creates dynamic trap bar info region, whose
"dt_fd" field provides the second info, and
"trap" field provide the third info.

The corresponding kernel implementation is at
https://www.spinics.net/lists/kernel/msg3337337.html.


Yan Zhao (2):
  hw/vfio: add a 'disablable' flag to sparse mmaped region
  hw/vfio/pci: init dynamic-trap-bar-info region

 hw/vfio/common.c              |  28 +++++++-
 hw/vfio/pci.c                 | 117 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h                 |   5 ++
 hw/vfio/trace-events          |   4 +-
 include/hw/vfio/vfio-common.h |   2 +
 linux-headers/linux/vfio.h    |  13 ++++
 6 files changed, 167 insertions(+), 2 deletions(-)

-- 
2.17.1


