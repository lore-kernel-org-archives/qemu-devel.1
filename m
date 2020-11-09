Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3682DC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B276A206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B276A206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbxWa-0003pS-Q5
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 22:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUs-0001az-DL; Sun, 08 Nov 2020 22:05:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUo-0006ai-0Z; Sun, 08 Nov 2020 22:05:34 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CTwpY6Kx2z15SjR;
 Mon,  9 Nov 2020 11:05:09 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 11:05:08 +0800
From: Ying Fang <fangying1@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [RFC PATCH v3 00/13] hw/arm/virt: Introduce cpu and cache topology
 support
Date: Mon, 9 Nov 2020 11:04:39 +0800
Message-ID: <20201109030452.2197-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 22:05:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: drjones@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 Ying Fang <fangying1@huawei.com>, imammedo@redhat.com, salil.mehta@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An accurate cpu topology may help improve the cpu scheduler's decision
making when dealing with multi-core system. So cpu topology description
is helpful to provide guest with the right view. Cpu cache information may
also have slight impact on the sched domain, and even userspace software
may check the cpu cache information to do some optimizations. Dario Faggioli's
talk in [0] also shows the virtual topology may has impact on sched performace.
Thus this patch series is posted to provide cpu and cache topology support
for arm platform.

Both fdt and ACPI are introduced to present the cpu and cache topology.
To describe the cpu topology via ACPI, a PPTT table is introduced according
to the processor hierarchy node structure. To describe the cpu cache
information, a default cache hierarchy is given and built according to the
cache type structure defined by ACPI, it can be made configurable later.

The RFC v1 was posted at [1], we tried to map the MPIDR register into cpu
topology, however it is totally wrong. Andrew points it out that Linux kernel
is goint to stop using MPIDR for topology information [2]. The root cause is
the MPIDR register has been abused by ARM OEM manufactures. It is only used as
an identifer for a specific cpu, not representation of the topology. Moreover
this v2 is rebased on Andrew's latest branch shared [4].

This patch series was initially based on the patches posted by Andrew Jones [3].
I jumped in on it since some OS vendor cooperative partner are eager for it.
Thanks for Andrew's contribution.

After applying this patch series, launch a guest with virt-5.3 and cpu
topology configured with sockets:cores:threads = 2:4:2, you will get the
bellow messages with the lscpu command.

-----------------------------------------
Architecture:                    aarch64
CPU op-mode(s):                  64-bit
Byte Order:                      Little Endian
CPU(s):                          16
On-line CPU(s) list:             0-15
Thread(s) per core:              2
Core(s) per socket:              4
Socket(s):                       2
NUMA node(s):                    2
Vendor ID:                       HiSilicon
Model:                           0
Model name:                      Kunpeng-920
Stepping:                        0x1
BogoMIPS:                        200.00
L1d cache:                       512 KiB
L1i cache:                       512 KiB
L2 cache:                        4 MiB
L3 cache:                        128 MiB
NUMA node0 CPU(s):               0-7
NUMA node1 CPU(s):               8-15


changelog
v2 -> v3:
- Make use of possible_cpus->cpus[i].cpu to check against current online cpus

v1 -> v2:
- Rebased to the latest branch shared by Andrew Jones [4]
- Stop mapping MPIDR into vcpu topology

[0] https://kvmforum2020.sched.com/event/eE1y/virtual-topology-for-virtual-machines-friend-or-foe-dario-faggioli-suse
[1] https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06027.html
[2] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200829130016.26106-1-valentin.schneider@arm.com/
[3] https://patchwork.ozlabs.org/project/qemu-devel/cover/20180704124923.32483-1-drjones@redhat.com
[4] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology-refresh 

Andrew Jones (5):
  hw/arm/virt: Spell out smp.cpus and smp.max_cpus
  hw/arm/virt: Remove unused variable
  hw/arm/virt: Replace smp_parse with one that prefers cores
  device_tree: Add qemu_fdt_add_path
  hw/arm/virt: DT: add cpu-map

Ying Fang (8):
  hw: add compat machines for 5.3
  hw/arm/virt-acpi-build: distinguish possible and present cpus
  hw/acpi/aml-build: add processor hierarchy node structure
  hw/arm/virt-acpi-build: add PPTT table
  target/arm/cpu: Add cpu cache description for arm
  hw/arm/virt: add fdt cache information
  hw/acpi/aml-build: Build ACPI cpu cache hierarchy information
  hw/arm/virt-acpi-build: Enable cpu and cache topology

 device_tree.c                |  45 +++++-
 hw/acpi/aml-build.c          |  68 +++++++++
 hw/arm/virt-acpi-build.c     |  99 ++++++++++++-
 hw/arm/virt.c                | 273 +++++++++++++++++++++++++++++++----
 hw/core/machine.c            |   3 +
 hw/i386/pc.c                 |   3 +
 hw/i386/pc_piix.c            |  15 +-
 hw/i386/pc_q35.c             |  14 +-
 hw/ppc/spapr.c               |  15 +-
 hw/s390x/s390-virtio-ccw.c   |  14 +-
 include/hw/acpi/acpi-defs.h  |  14 ++
 include/hw/acpi/aml-build.h  |  11 ++
 include/hw/arm/virt.h        |   4 +-
 include/hw/boards.h          |   3 +
 include/hw/i386/pc.h         |   3 +
 include/sysemu/device_tree.h |   1 +
 target/arm/cpu.c             |  42 ++++++
 target/arm/cpu.h             |  27 ++++
 18 files changed, 609 insertions(+), 45 deletions(-)

-- 
2.23.0


