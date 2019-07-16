Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C41C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BDA20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BDA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOqn-0005Gg-Gl
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49695)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hnOqQ-0004WK-TB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hnOqP-0000z7-Cq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:54:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:20977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hnOqP-0000xO-1u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:54:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 07:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; d="scan'208";a="319014742"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by orsmga004.jf.intel.com with ESMTP; 16 Jul 2019 07:54:11 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Tue, 16 Jul 2019 22:51:10 +0800
Message-Id: <20190716145121.19578-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v7 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
according to the command line. The ACPI HMAT describes the memory attributes,
such as memory side cache attributes and bandwidth and latency details,
related to the Memory Proximity Domain.
The software is expected to use HMAT information as hint for optimization.

In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
the platform's HMAT tables.

The V6 RESEND patches link:
https://patchwork.kernel.org/cover/11036461/

Changelog:
v7:
    - Defer 11-13 of patch v6, because the driver of _HMA hasn't been
      implemented in kernel driver
    - Drop the HMAT_LB_MEM_CACHE_LAST_LEVEL which is not used in
      ACPI 6.3 (Jonathan)
    - Add bit mask in flags of hmat-lb (Jonathan)
    - Add a marco to indicate the type is latency or bandwidth (Jonathan)
v6:
    - Rebase to upstream, move numa globals in arm/sbsa-ref
    - When used once or twice in the function, use
      ms->numa_state->num_nodes(numa_info) directly (Igor)
    - Correct some mistakes
    - Use once monitor_printf in hmp_info_numa (Igor)
    - Add new patch to extend CLI of "-numa node" option to indicate the
      initiator numa node-id (Dan)
    - Update to ACPI 6.3 (Jonathan)
    - Add QMP interface to update HMAT at runtime (Igor)
    - Add test cases for ACPI HMAT

Liu Jingqi (5):
  hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
  hmat acpi: Build System Locality Latency and Bandwidth Information
    Structure(s)
  hmat acpi: Build Memory Side Cache Information Structure(s)
  numa: Extend the CLI to provide memory latency and bandwidth
    information
  numa: Extend the CLI to provide memory side cache information

Tao Xu (6):
  hw/arm: simplify arm_load_dtb
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState
  numa: Extend CLI to provide initiator information for numa nodes
  tests/bios-tables-test: add test cases for ACPI HMAT

 exec.c                              |   5 +-
 hw/acpi/Kconfig                     |   5 +
 hw/acpi/Makefile.objs               |   1 +
 hw/acpi/aml-build.c                 |   9 +-
 hw/acpi/hmat.c                      | 256 +++++++++++++++++++++++++
 hw/acpi/hmat.h                      | 103 ++++++++++
 hw/arm/aspeed.c                     |   5 +-
 hw/arm/boot.c                       |  20 +-
 hw/arm/collie.c                     |   8 +-
 hw/arm/cubieboard.c                 |   5 +-
 hw/arm/exynos4_boards.c             |   7 +-
 hw/arm/highbank.c                   |   8 +-
 hw/arm/imx25_pdk.c                  |   5 +-
 hw/arm/integratorcp.c               |   8 +-
 hw/arm/kzm.c                        |   5 +-
 hw/arm/mainstone.c                  |   5 +-
 hw/arm/mcimx6ul-evk.c               |   5 +-
 hw/arm/mcimx7d-sabre.c              |   5 +-
 hw/arm/musicpal.c                   |   8 +-
 hw/arm/nseries.c                    |   5 +-
 hw/arm/omap_sx1.c                   |   5 +-
 hw/arm/palm.c                       |  10 +-
 hw/arm/raspi.c                      |   6 +-
 hw/arm/realview.c                   |   5 +-
 hw/arm/sabrelite.c                  |   5 +-
 hw/arm/sbsa-ref.c                   |  12 +-
 hw/arm/spitz.c                      |   5 +-
 hw/arm/tosa.c                       |   8 +-
 hw/arm/versatilepb.c                |   5 +-
 hw/arm/vexpress.c                   |   5 +-
 hw/arm/virt-acpi-build.c            |  19 +-
 hw/arm/virt.c                       |  17 +-
 hw/arm/xilinx_zynq.c                |   8 +-
 hw/arm/xlnx-versal-virt.c           |   7 +-
 hw/arm/xlnx-zcu102.c                |   5 +-
 hw/arm/z2.c                         |   8 +-
 hw/core/machine-hmp-cmds.c          |  12 +-
 hw/core/machine.c                   |  38 +++-
 hw/core/numa.c                      | 287 ++++++++++++++++++++++++----
 hw/i386/acpi-build.c                |   7 +-
 hw/i386/pc.c                        |  13 +-
 hw/mem/pc-dimm.c                    |   2 +
 hw/pci-bridge/pci_expander_bridge.c |   3 +-
 hw/ppc/spapr.c                      |  33 ++--
 hw/ppc/spapr_pci.c                  |   4 +-
 include/hw/acpi/aml-build.h         |   2 +-
 include/hw/arm/boot.h               |   4 +-
 include/hw/boards.h                 |   1 +
 include/qemu/typedefs.h             |   2 +
 include/sysemu/numa.h               |  30 ++-
 include/sysemu/sysemu.h             |  23 +++
 qapi/machine.json                   | 183 +++++++++++++++++-
 qemu-options.hx                     |  84 +++++++-
 tests/bios-tables-test.c            |  43 +++++
 54 files changed, 1131 insertions(+), 248 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

-- 
2.20.1


