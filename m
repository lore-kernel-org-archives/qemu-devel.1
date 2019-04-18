Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CEC10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 07:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0A5217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 07:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0A5217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH12M-00006d-G6
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 03:00:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hH10S-0007JD-4J
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hH0qS-00060i-V0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:48:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:17087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hH0qS-0005vB-Kl
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:48:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Apr 2019 23:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,364,1549958400"; d="scan'208";a="136790430"
Received: from vmmtaopc.sh.intel.com ([10.239.13.92])
	by orsmga006.jf.intel.com with ESMTP; 17 Apr 2019 23:48:19 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	ehabkost@redhat.com,
	pbonzini@redhat.com
Date: Thu, 18 Apr 2019 14:45:59 +0800
Message-Id: <20190418064602.24558-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH v2 0/3] numa: move numa global variables into
 MachineState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418064559.kOiP2Dfz3_F1v_g3C8tnzz-FODIgqDgcAL-w_EWIA2M@z>

The aim of this patch is to add struct NumaState in MachineState
and move existing numa global nb_numa_nodes into NumaState.
And add variable numa_support into MachineClass to decide which
submachines support NUMA.

---
Changes in v2:
    - fix the mistake in numa_complete_configuration in numa.c
    - add MachineState into some functions to avoid using
    qdev_get_machine
    - add some if experssion to avoid the NumaState is null 

Tao Xu (3):
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState

 exec.c                              |  5 ++-
 hw/acpi/aml-build.c                 |  9 ++--
 hw/arm/boot.c                       |  4 +-
 hw/arm/virt-acpi-build.c            | 17 ++++---
 hw/arm/virt.c                       |  7 ++-
 hw/core/machine.c                   | 16 +++++--
 hw/i386/acpi-build.c                |  4 +-
 hw/i386/pc.c                        |  9 +++-
 hw/mem/pc-dimm.c                    |  2 +
 hw/pci-bridge/pci_expander_bridge.c |  2 +
 hw/ppc/spapr.c                      | 37 ++++++++++++++--
 hw/ppc/spapr_pci.c                  |  2 +
 include/hw/acpi/aml-build.h         |  2 +-
 include/hw/boards.h                 | 21 +++++++++
 include/sysemu/numa.h               | 13 +-----
 monitor.c                           |  4 +-
 numa.c                              | 69 ++++++++++++++++-------------
 17 files changed, 156 insertions(+), 67 deletions(-)

-- 
2.17.1


