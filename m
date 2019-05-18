Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 12:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AAF21872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 12:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AAF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSLPC-0001aQ-Ja
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 08:59:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hSLMd-0007s8-Ry
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hSLMc-0002Hm-4U
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:56:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:2555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hSLMY-0002DD-Am; Sun, 19 May 2019 08:56:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 05:56:17 -0700
X-ExtLoop1: 1
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.98])
	by fmsmga001.fm.intel.com with ESMTP; 19 May 2019 05:56:16 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-trivial@nongnu.org
Date: Sun, 19 May 2019 04:54:18 +0800
Message-Id: <20190518205428.90532-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v3 00/10] Refactor cpu topo into machine
 properties
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series make existing cores/threads/sockets into machine
properties and get rid of global smp_* variables they use currently.

The purpose of getting rid of globals is disentangle layer violations and
let's do it one step at a time by replacing the smp_foo with qdev_get_machine()
as few calls as possible and delay other related refactoring efforts.

==changelog==

v3:

- rephrase commit messages
- s/of/of present/ for CpuTopology comment
- drop reduanct arguments such as cpu_type
- use ms instead of macs in migration context
- rebase to commit 1b46b4daa6

v2: https://patchwork.ozlabs.org/cover/1095727/

- pass MachineState via call chain with trivial fixups
- replace smp_cpus directly at places if it's only used once
- s/topo/smp/ and drop smp_ prefix inside CpuTopology structure
- add more commit messages to explaining what patch does
- fix Patchew build failure for xen usage
- use macs rather than ms in migration context for MigrationState
- cleanup unrelated and redundant changes
- spilt OpenRISC and RISC-V related patches

v1: https://patchwork.kernel.org/cover/10876667/

Like Xu (10):
  hw/boards: Add struct CpuTopology to MachineState
  machine: Refactor smp-related call chains to pass MachineState
  general: Replace global smp variables with smp machine properties
  hw/ppc: Replace global smp variables with machine smp properties
  hw/riscv: Replace global smp variables with machine smp properties
  hw/s390x: Replace global smp variables with machine smp properties
  hw/i386: Replace global smp variables with machine smp properties
  hw/arm: Replace global smp variables with machine smp properties
  hw: Replace global smp variables with MachineState for all remaining archs
  vl.c: Replace smp global variables with smp machine properties

 accel/kvm/kvm-all.c          |  4 +--
 backends/hostmem.c           |  6 +++--
 cpus.c                       |  6 +++--
 exec.c                       |  3 ++-
 gdbstub.c                    |  4 +++
 hw/alpha/dp264.c             |  1 +
 hw/arm/fsl-imx6.c            |  6 ++++-
 hw/arm/fsl-imx6ul.c          |  6 ++++-
 hw/arm/fsl-imx7.c            |  7 +++--
 hw/arm/highbank.c            |  1 +
 hw/arm/mcimx6ul-evk.c        |  2 +-
 hw/arm/mcimx7d-sabre.c       |  2 +-
 hw/arm/raspi.c               |  4 +--
 hw/arm/realview.c            |  1 +
 hw/arm/sabrelite.c           |  2 +-
 hw/arm/vexpress.c            | 16 +++++++-----
 hw/arm/virt.c                | 10 ++++++--
 hw/arm/xlnx-zynqmp.c         | 16 +++++++-----
 hw/cpu/core.c                |  4 ++-
 hw/hppa/machine.c            |  4 ++-
 hw/i386/acpi-build.c         | 13 ++++++----
 hw/i386/kvmvapic.c           |  7 +++--
 hw/i386/pc.c                 | 33 ++++++++++++++----------
 hw/i386/xen/xen-hvm.c        |  4 +++
 hw/mips/boston.c             |  2 +-
 hw/mips/mips_malta.c         | 24 +++++++++--------
 hw/openrisc/openrisc_sim.c   |  1 +
 hw/ppc/e500.c                |  3 +++
 hw/ppc/mac_newworld.c        |  3 ++-
 hw/ppc/mac_oldworld.c        |  3 ++-
 hw/ppc/pnv.c                 |  9 ++++---
 hw/ppc/prep.c                |  4 +--
 hw/ppc/spapr.c               | 37 ++++++++++++++++++--------
 hw/ppc/spapr_rtas.c          |  4 ++-
 hw/riscv/sifive_e.c          |  6 +++--
 hw/riscv/sifive_plic.c       |  3 +++
 hw/riscv/sifive_u.c          |  6 +++--
 hw/riscv/spike.c             |  2 ++
 hw/riscv/virt.c              |  1 +
 hw/s390x/s390-virtio-ccw.c   |  9 ++++---
 hw/s390x/sclp.c              |  2 +-
 hw/smbios/smbios.c           | 26 +++++++++++--------
 hw/sparc/sun4m.c             |  2 ++
 hw/sparc64/sun4u.c           |  4 +--
 hw/xtensa/sim.c              |  2 +-
 hw/xtensa/xtfpga.c           |  1 +
 include/hw/boards.h          | 19 ++++++++++++--
 include/hw/firmware/smbios.h |  5 ++--
 include/hw/i386/pc.h         |  2 +-
 migration/postcopy-ram.c     |  8 +++++-
 numa.c                       |  1 +
 qmp.c                        |  2 +-
 target/arm/cpu.c             |  8 +++++-
 target/i386/cpu.c            |  4 ++-
 target/openrisc/sys_helper.c |  6 ++++-
 target/s390x/cpu.c           |  3 +++
 target/s390x/excp_helper.c   |  5 ++++
 tcg/tcg.c                    | 13 +++++++++-
 vl.c                         | 50 +++++++++++++++++++-----------------
 59 files changed, 301 insertions(+), 141 deletions(-)

-- 
2.21.0


