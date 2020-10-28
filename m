Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4676C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A2D247F1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSWJx8g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A2D247F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXoWM-0006g1-Sq
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoUA-0004z6-I8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoU8-0000oQ-9C
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mwEzbIbMG5RMS2dytDdB4floW28mUw+hAw6aue/FJJs=;
 b=YSWJx8g6dSx/YR/5ie6reujVK59FNcvjNuHwJv6gbzP9iNw+tuIqlB7I/2Qsqz049tZh1f
 +49iDeEVtbjh2fP4eOrk8rgC9zppDm5py/cWDPrqxoSqULjueh5SDJ3bXu5fEnWsLSCC6A
 hril9lzc4TfkDXDys5Fesi5SgjiRLUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-LhZXxbnTNQe1reqsJfvvgg-1; Wed, 28 Oct 2020 12:39:35 -0400
X-MC-Unique: LhZXxbnTNQe1reqsJfvvgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46B981030984;
 Wed, 28 Oct 2020 16:39:33 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 693D05B4BA;
 Wed, 28 Oct 2020 16:39:26 +0000 (UTC)
Subject: [PULL v2 00/32] VFIO updates 2020-10-28 (for QEMU 5.2 soft-freeze)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 10:39:25 -0600
Message-ID: <160390309510.12234.8858324597971641979.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 33dc9914eac581dea9bdea35dcda4d542531d66a:

  Revert series: virtiofsd: Announce submounts to the guest (2020-10-28 13:17:32 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201028.0

for you to fetch changes up to 83d64f2efe383f1f70e180cf1579d3bbe2fbcdf5:

  vfio: fix incorrect print type (2020-10-28 10:30:37 -0600)

----------------------------------------------------------------
VFIO update 2020-10-28

 * Migration support (Kirti Wankhede)
 * s390 DMA limiting (Matthew Rosato)
 * zPCI hardware info (Matthew Rosato)
 * Lock guard (Amey Narkhede)
 * Print fixes (Zhengui li)
 * Warning/build fixes

----------------------------------------------------------------
Amey Narkhede (1):
      hw/vfio: Use lock guard macros

Kirti Wankhede (17):
      vfio: Add function to unmap VFIO region
      vfio: Add vfio_get_object callback to VFIODeviceOps
      vfio: Add save and load functions for VFIO PCI devices
      vfio: Add migration region initialization and finalize function
      vfio: Add VM state change handler to know state of VM
      vfio: Add migration state change notifier
      vfio: Register SaveVMHandlers for VFIO device
      vfio: Add save state functions to SaveVMHandlers
      vfio: Add load state functions to SaveVMHandlers
      memory: Set DIRTY_MEMORY_MIGRATION when IOMMU is enabled
      vfio: Get migration capability flags for container
      vfio: Add function to start and stop dirty pages tracking
      vfio: Add vfio_listener_log_sync to mark dirty pages
      vfio: Dirty page tracking when vIOMMU is enabled
      vfio: Add ioctl to get dirty pages bitmap during dma unmap
      vfio: Make vfio-pci device migration capable
      qapi: Add VFIO devices migration stats in Migration stats

Matthew Rosato (10):
      update-linux-headers: Add vfio_zdev.h
      linux-headers: update against 5.10-rc1
      s390x/pci: Move header files to include/hw/s390x
      vfio: Create shared routine for scanning info capabilities
      vfio: Find DMA available capability
      s390x/pci: Add routine to get the vfio dma available count
      s390x/pci: Honor DMA limits set by vfio
      s390x/pci: clean up s390 PCI groups
      vfio: Add routine for finding VFIO_DEVICE_GET_INFO capabilities
      s390x/pci: get zPCI function info from host

Pierre Morel (3):
      s390x/pci: create a header dedicated to PCI CLP
      s390x/pci: use a PCI Group structure
      s390x/pci: use a PCI Function structure

Zhengui Li (1):
      vfio: fix incorrect print type

 MAINTAINERS                                        |   1 +
 hw/s390x/meson.build                               |   1 +
 hw/s390x/s390-pci-bus.c                            |  91 +-
 hw/s390x/s390-pci-inst.c                           |  78 +-
 hw/s390x/s390-pci-vfio.c                           | 276 ++++++
 hw/s390x/s390-virtio-ccw.c                         |   2 +-
 hw/s390x/trace-events                              |   6 +
 hw/vfio/common.c                                   | 508 ++++++++++-
 hw/vfio/meson.build                                |   1 +
 hw/vfio/migration.c                                | 933 +++++++++++++++++++++
 hw/vfio/pci.c                                      |  87 +-
 hw/vfio/pci.h                                      |   1 -
 hw/vfio/platform.c                                 |   7 +-
 hw/vfio/trace-events                               |  21 +
 {hw => include/hw}/s390x/s390-pci-bus.h            |  22 +
 .../hw/s390x/s390-pci-clp.h                        | 123 +--
 include/hw/s390x/s390-pci-inst.h                   | 119 +++
 include/hw/s390x/s390-pci-vfio.h                   |  23 +
 include/hw/vfio/vfio-common.h                      |  30 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |   2 +-
 include/standard-headers/linux/ethtool.h           |   2 +
 include/standard-headers/linux/fuse.h              |  50 +-
 include/standard-headers/linux/input-event-codes.h |   4 +
 include/standard-headers/linux/pci_regs.h          |   6 +-
 include/standard-headers/linux/virtio_fs.h         |   3 +
 include/standard-headers/linux/virtio_gpu.h        |  19 +
 include/standard-headers/linux/virtio_mmio.h       |  11 +
 include/standard-headers/linux/virtio_pci.h        |  11 +-
 linux-headers/asm-arm64/kvm.h                      |  25 +
 linux-headers/asm-arm64/mman.h                     |   1 +
 linux-headers/asm-generic/hugetlb_encode.h         |   1 +
 linux-headers/asm-generic/unistd.h                 |  18 +-
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-s390/unistd_32.h                 |   1 +
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/kvm.h                        |  20 +
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/kvm.h                          |  19 +
 linux-headers/linux/mman.h                         |   1 +
 linux-headers/linux/vfio.h                         |  29 +-
 linux-headers/linux/vfio_zdev.h                    |  78 ++
 migration/migration.c                              |  17 +
 monitor/hmp-cmds.c                                 |   6 +
 qapi/migration.json                                |  17 +
 scripts/update-linux-headers.sh                    |   2 +-
 softmmu/memory.c                                   |   2 +-
 52 files changed, 2467 insertions(+), 217 deletions(-)
 create mode 100644 hw/s390x/s390-pci-vfio.c
 create mode 100644 hw/vfio/migration.c
 rename {hw => include/hw}/s390x/s390-pci-bus.h (94%)
 rename hw/s390x/s390-pci-inst.h => include/hw/s390x/s390-pci-clp.h (59%)
 create mode 100644 include/hw/s390x/s390-pci-inst.h
 create mode 100644 include/hw/s390x/s390-pci-vfio.h
 create mode 100644 linux-headers/linux/vfio_zdev.h


