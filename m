Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA252C48BDB
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B072082E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B072082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk8FW-0001Rj-ET
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hk8Dy-0008Eu-Fe
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hk8Dv-0003NO-KA
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:31568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hk8Du-000363-Hd
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jul 2019 07:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,462,1557212400"; d="scan'208";a="185497810"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2019 07:32:41 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  7 Jul 2019 22:29:44 +0800
Message-Id: <20190707142958.31316-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v6 00/14] Build ACPI Heterogeneous Memory
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

The V5 patches link:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03138.html

Changelog:
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

v5:
    - spilt the 1-6/11 and 8/11 from patch v4 to build Memory Subsystem
    Address Range Structure(s) and System Locality Latency and Bandwidth
    Information Structure(s) firstly.
    - add 1/8 of patch v5 to simplify arm_load_dtb() (Igor)
    - drop the helper machine_num_numa_nodes() and use
    machine->numa_state->num_nodes (and numa_state->nodes) directly (Igor)
    - Add more descriptions from ACPI spec (Igor)
    - Add the reason of using stub (Igor)
    - Use GArray for NUMA memory ranges data (Igor)
    - Separate hmat_build_lb() (Igor)
    - Drop all global variables and use local variables instead (Igor)
    - Add error message when base unit < 10
    - Update the hmat-lb option example by using '-numa cpu'
    and '-numa memdev' (Igor)

v4:
    - send the patch of "move numa global variables into MachineState"
    together with HMAT patches.
    https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03662.html
    - spilt the 1/8 of v3 patch into two patches, 4/11 introduces
    build_mem_ranges() and 5/11 builds HMAT (Igor)
    - use build_append_int_noprefix() to build parts of ACPI table in
    all patches (Igor)
    - Split 8/8 of patch v3 into two parts, 10/11 introduces NFIT
    generalizations (build_acpi_aml_common), and use it in 11/11 to
    simplify hmat_build_aml (Igor)
    - use MachineState instead of PCMachineState to build HMAT more
    generalic (Igor)
    - move the 7/8 v3 patch into the former patches
    - update the version tag from 4.0 to 4.1
v3:
    - rebase the fixing patch into the jingqi's patches (Eric)
    - update the version tag from 3.10 to 4.0 (Eric)
v2:
  Per Igor and Eric's comments, fix some coding style and small issues:
    - update the version number in qapi/misc.json
    - including the expansion of the acronym HMAT in qapi/misc.json
    - correct spell mistakes in qapi/misc.json and qemu-options.hx
    - fix the comment syle in hw/i386/acpi-build.c
    and hw/acpi/hmat.h
   - remove some unnecessary head files in hw/acpi/hmat.c 
   - use hardcoded numbers from spec to generate
   Memory Subsystem Address Range Structure in hw/acpi/hmat.c
   - drop the struct AcpiHmat and AcpiHmatSpaRange
    in hw/acpi/hmat.h
   - rewrite NFIT code to build _HMA method

Liu Jingqi (6):
  hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
  hmat acpi: Build System Locality Latency and Bandwidth Information
    Structure(s)
  hmat acpi: Build Memory Side Cache Information Structure(s)
  numa: Extend the CLI to provide memory latency and bandwidth
    information
  numa: Extend the CLI to provide memory side cache information
  hmat acpi: Implement _HMA method to update HMAT at runtime

Tao Xu (8):
  hw/arm: simplify arm_load_dtb
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState
  numa: Extend CLI to provide initiator information for numa nodes
  acpi: introduce aml_build_runtime_buf for NFIT generalizations
  QMP: Add QMP interface to update HMAT at runtime
  tests/bios-tables-test: add test cases for ACPI HMAT

 exec.c                              |   5 +-
 hw/acpi/Kconfig                     |   5 +
 hw/acpi/Makefile.objs               |   1 +
 hw/acpi/acpi-stub.c                 |   7 +
 hw/acpi/aml-build.c                 |   9 +-
 hw/acpi/hmat.c                      | 552 ++++++++++++++++++++++++++++
 hw/acpi/hmat.h                      | 172 +++++++++
 hw/acpi/nvdimm.c                    |  49 ++-
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
 hw/arm/virt.c                       |  18 +-
 hw/arm/xilinx_zynq.c                |   8 +-
 hw/arm/xlnx-versal-virt.c           |   7 +-
 hw/arm/xlnx-zcu102.c                |   5 +-
 hw/arm/z2.c                         |   8 +-
 hw/core/machine.c                   |  42 ++-
 hw/i386/acpi-build.c                |  11 +-
 hw/i386/pc.c                        |  14 +-
 hw/i386/pc_piix.c                   |   6 +
 hw/i386/pc_q35.c                    |   6 +
 hw/mem/pc-dimm.c                    |   2 +
 hw/pci-bridge/pci_expander_bridge.c |   3 +-
 hw/ppc/spapr.c                      |  36 +-
 hw/ppc/spapr_pci.c                  |   4 +-
 include/hw/acpi/aml-build.h         |   2 +-
 include/hw/arm/boot.h               |   4 +-
 include/hw/boards.h                 |   2 +
 include/hw/mem/nvdimm.h             |   6 +
 include/qemu/typedefs.h             |   2 +
 include/sysemu/numa.h               |  32 +-
 include/sysemu/sysemu.h             |  24 ++
 monitor/misc.c                      |  12 +-
 numa.c                              | 341 +++++++++++++++--
 qapi/misc.json                      | 235 +++++++++++-
 qemu-options.hx                     |  84 ++++-
 tests/bios-tables-test.c            |  43 +++
 59 files changed, 1677 insertions(+), 264 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

-- 
2.20.1


