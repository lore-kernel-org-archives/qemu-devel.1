Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 03:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FAD208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 03:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FAD208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je95O-0002FX-6M
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 23:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1je94d-0000rv-W7
 for qemu-devel@nongnu.org; Wed, 27 May 2020 23:19:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:32183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1je94c-00022M-6E
 for qemu-devel@nongnu.org; Wed, 27 May 2020 23:19:15 -0400
IronPort-SDR: Ph0SiAFxivuLIMu063PgS9Ec4lSGJAOLrx2WoKzoA0dUttH+n2vjOwgOcwItD+w//bnyG1736d
 zMqr51votJBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 20:19:03 -0700
IronPort-SDR: t+LtGEXeARTMZ2Shl4OcySXEvKYq1dxLLhGLiO4TWavy2Cle9hP4FaSwFvPcQ/YYbh8NtNj14I
 J73oamybp/Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="310775941"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
 by FMSMGA003.fm.intel.com with ESMTP; 27 May 2020 20:19:03 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] VMD endpoint passthrough support
Date: Wed, 27 May 2020 23:02:37 -0400
Message-Id: <20200528030240.16024-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=jonathan.derrick@intel.com; helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 23:19:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This set contains 2 patches for Linux and 1 for QEMU. VMD device
8086:28C0 contains information in registers to assist with direct
assignment passthrough. Several other VMD devices don't have this
information, but hypervisors can easily provide the guest with this
information through various means.

The QEMU patch provides the information in an emulated vendor-specific
PCI capability. Existing VMD devices don't conflict with the offset
chosen for the capability.

The Linux patch allows guest kernels to use the passthrough information
emulated by the QEMU patch, by matching against the vendor-specific PCI
capability if it exists.

V2 Ref:
https://lore.kernel.org/linux-pci/20200511190129.9313-1-jonathan.derrick@intel.com/

Changes from v2:
Uses vendor-specific PCI capability rather than emulating the 28C0
MEMBAR/VMLOCK modes.

Changes from v1:
v1 changed the VMD Subsystem ID to QEMU's so that the guest driver could
match against it. This was unnecessary as the VMLOCK register and shadow
membar registers could be safely emulated. Future VMDs will be aligned
on these register bits.

Jon Derrick (2):
  PCI: vmd: Filter resource type bits from shadow register
  PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

-- 
1.8.3.1


