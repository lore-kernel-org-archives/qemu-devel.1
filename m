Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B13C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4422087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4422087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GUa-0002JW-3o
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwT-0004HG-BL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwP-0001FM-Vo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwP-00016Z-A4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9091488304;
 Tue,  3 Sep 2019 21:02:03 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 269AB608C2;
 Tue,  3 Sep 2019 21:02:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:48 -0300
Message-Id: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 03 Sep 2019 21:02:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/13] Machine + x86 queue, 2019-09-03
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes v1 -> v2:
* (v1 was incorrectly tagged "v6" on the subject line)
* Removed patch that caused spurious warnings ("numa: Introduce
  MachineClass::auto_enable_numa for implicit NUMA node")
* New patches:
  * Keep query-hotpluggable-cpus output compatible with older
    QEMU if '-smp dies' is not set
  * migration: Do not re-read the clock on pre_save in case of
    paused guest


The following changes since commit cc6613e244e86c66f83467eab5284825d7057c=
ea:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2019-09-03 11:06:09 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 417332494602e3edadfae3b759a29fa0bb96223f:

  migration: Do not re-read the clock on pre_save in case of paused guest=
 (2019-09-03 14:39:46 -0300)

----------------------------------------------------------------
Machine + x86 queue, 2019-09-03

Bug fixes:
* Fix die-id validation regression (Eduardo Habkost)
* vmmouse: Properly reset state (Jan Kiszka)
* hostmem-file: fix pmem file size check (Stefan Hajnoczi)
* Keep query-hotpluggable-cpus output compatible with older QEMU
  if '-smp dies' is not set (Igor Mammedov)
* migration: Do not re-read the clock on pre_save in case of paused guest
  (Maxiwell S. Garcia)

Cleanups:
* NUMA code cleanups (Tao Xu)
* Remove stale externs from includes (Alex Benn=C3=A9e)

Features:
* qapi: report the default CPU type for each machine (Daniel P. Berrang=C3=
=A9)

----------------------------------------------------------------

Queue for Machine Core patches


Alex Benn=C3=A9e (1):
  includes: remove stale [smp|max]_cpus externs

Daniel P. Berrang=C3=A9 (1):
  qapi: report the default CPU type for each machine

Eduardo Habkost (3):
  pc: Fix error message on die-id validation
  pc: Improve error message when die-id is omitted
  pc: Don't make die-id mandatory unless necessary

Igor Mammedov (1):
  x86: do not advertise die-id in query-hotpluggbale-cpus if '-smp dies'
    is not set

Jan Kiszka (1):
  i386/vmmouse: Properly reset state

Maxiwell S. Garcia (1):
  migration: Do not re-read the clock on pre_save in case of paused
    guest

Stefan Hajnoczi (1):
  hostmem-file: fix pmem file size check

Tao Xu (4):
  hw/arm: simplify arm_load_dtb
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState

 qapi/machine.json                        |  5 +-
 include/hw/acpi/aml-build.h              |  2 +-
 include/hw/arm/boot.h                    |  4 +-
 include/hw/boards.h                      |  1 +
 include/sysemu/numa.h                    | 17 +++--
 include/sysemu/sysemu.h                  |  2 -
 backends/hostmem-file.c                  |  4 +-
 exec.c                                   |  5 +-
 hw/acpi/aml-build.c                      | 10 ++-
 hw/arm/aspeed.c                          |  5 +-
 hw/arm/boot.c                            | 21 ++++---
 hw/arm/collie.c                          |  8 +--
 hw/arm/cubieboard.c                      |  5 +-
 hw/arm/exynos4_boards.c                  |  7 +--
 hw/arm/highbank.c                        |  8 +--
 hw/arm/imx25_pdk.c                       |  5 +-
 hw/arm/integratorcp.c                    |  8 +--
 hw/arm/kzm.c                             |  5 +-
 hw/arm/mainstone.c                       |  5 +-
 hw/arm/mcimx6ul-evk.c                    |  5 +-
 hw/arm/mcimx7d-sabre.c                   |  5 +-
 hw/arm/musicpal.c                        |  8 +--
 hw/arm/nseries.c                         |  5 +-
 hw/arm/omap_sx1.c                        |  5 +-
 hw/arm/palm.c                            | 10 +--
 hw/arm/raspi.c                           |  6 +-
 hw/arm/realview.c                        |  5 +-
 hw/arm/sabrelite.c                       |  5 +-
 hw/arm/sbsa-ref.c                        | 12 ++--
 hw/arm/spitz.c                           |  5 +-
 hw/arm/tosa.c                            |  8 +--
 hw/arm/versatilepb.c                     |  5 +-
 hw/arm/vexpress.c                        |  5 +-
 hw/arm/virt-acpi-build.c                 | 19 +++---
 hw/arm/virt.c                            | 17 ++---
 hw/arm/xilinx_zynq.c                     |  8 +--
 hw/arm/xlnx-versal-virt.c                |  7 +--
 hw/arm/xlnx-zcu102.c                     |  5 +-
 hw/arm/z2.c                              |  8 +--
 hw/core/machine-hmp-cmds.c               | 13 +++-
 hw/core/machine-qmp-cmds.c               |  4 ++
 hw/core/machine.c                        | 14 +++--
 hw/core/numa.c                           | 80 ++++++++++++++----------
 hw/i386/acpi-build.c                     |  4 +-
 hw/i386/kvm/clock.c                      | 15 +++--
 hw/i386/pc.c                             | 33 +++++++---
 hw/i386/vmmouse.c                        |  1 +
 hw/mem/pc-dimm.c                         |  2 +
 hw/pci-bridge/pci_expander_bridge.c      |  9 ++-
 hw/ppc/spapr.c                           | 29 ++++-----
 hw/ppc/spapr_pci.c                       |  4 +-
 tests/acceptance/pc_cpu_hotplug_props.py | 35 +++++++++++
 52 files changed, 273 insertions(+), 250 deletions(-)
 create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py

--=20
2.21.0


