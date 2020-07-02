Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE270C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BEA2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiYGAnXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BEA2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxD8-0002gj-Km
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx6C-0006gz-5A
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx65-0000zK-PU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fHDbD496i155aUBdlfJv4JB1CbE3D1wszlCITg4iZ3s=;
 b=YiYGAnXIl2s6/lk5YVpmexiVFkWUZpXMXcMF0lK3A1PUUMjJO964xyh0pQx2d6E3anw5am
 P6CM499zUA0kkjqZa8xYAawkKyzSktPYnU8aa91JBaMfejJ1bb4/qc8ygNTsgl6Rjwvppo
 E51Fhh+DuII495tRDeUfyrtCoioPitw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-g5LPcbpuOlyrUA7cUK3iXw-1; Thu, 02 Jul 2020 07:09:34 -0400
X-MC-Unique: g5LPcbpuOlyrUA7cUK3iXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55613107ACCA
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 11:09:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01FFC77892
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 11:09:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 801D711384A6; Thu,  2 Jul 2020 13:09:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] Error reporting patches patches for 2020-07-02
Date: Thu,  2 Jul 2020 13:09:03 +0200
Message-Id: <20200702110931.2953148-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:

  hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-07-02

for you to fetch changes up to 9cde9caa04beac25cef32a8a9d0bd26d6b91a41a:

  migration/rdma: Plug memory leaks in qemu_rdma_registration_stop() (2020-07-02 11:54:48 +0200)

----------------------------------------------------------------
Error reporting patches patches for 2020-07-02

----------------------------------------------------------------
Markus Armbruster (26):
      net/virtio: Fix failover_replug_primary() return value regression
      pci: Delete useless error_propagate()
      Clean up some calls to ignore Error objects the right way
      tests: Use &error_abort where appropriate
      tests: Use error_free_or_abort() where appropriate
      usb/dev-mtp: Fix Error double free after inotify failure
      spapr: Plug minor memory leak in spapr_machine_init()
      qga: Plug unlikely memory leak in guest-set-memory-blocks
      sd/milkymist-memcard: Plug minor memory leak in realize
      test-util-filemonitor: Plug unlikely memory leak
      vnc: Plug minor memory leak in vnc_display_open()
      aspeed: Clean up roundabout error propagation
      qdev: Drop qbus_set_bus_hotplug_handler() parameter @errp
      qdev: Drop qbus_set_hotplug_handler() parameter @errp
      hw: Fix error API violation around object_property_set_link()
      hw/arm: Drop useless object_property_set_link() error handling
      riscv/sifive_u: Fix sifive_u_soc_realize() error API violations
      riscv_hart: Fix riscv_harts_realize() error API violations
      mips/cps: Fix mips_cps_realize() error API violations
      x86: Fix x86_cpu_new() error handling
      amd_iommu: Fix amdvi_realize() error API violation
      arm/stm32f205 arm/stm32f405: Fix realize error API violation
      aspeed: Fix realize error API violation
      hw/arm/armsse: Fix armsse_realize() error API violation
      arm/{bcm2835,fsl-imx25,fsl-imx6}: Fix realize error API violations
      migration/rdma: Plug memory leaks in qemu_rdma_registration_stop()

Peter Maydell (1):
      hw/virtio/virtio-iommu-pci.c: Fix typo in error message

lichun (1):
      chardev/tcp: Fix error message double free error

 include/hw/qdev-core.h             |   5 +-
 chardev/char-socket.c              |   9 ++-
 hw/9pfs/9p.c                       |   6 +-
 hw/acpi/pcihp.c                    |   3 +-
 hw/acpi/piix4.c                    |   2 +-
 hw/arm/armsse.c                    |  61 ++++++---------------
 hw/arm/armv7m.c                    |   7 +--
 hw/arm/aspeed_ast2600.c            |  35 ++++--------
 hw/arm/aspeed_soc.c                |  29 ++++------
 hw/arm/bcm2835_peripherals.c       |  12 ++--
 hw/arm/fsl-imx25.c                 |  12 ++--
 hw/arm/fsl-imx6.c                  |  12 ++--
 hw/arm/nrf51_soc.c                 |   6 +-
 hw/arm/stm32f205_soc.c             |   2 +-
 hw/arm/stm32f405_soc.c             |   2 +-
 hw/arm/virt.c                      |   4 +-
 hw/char/virtio-serial-bus.c        |   4 +-
 hw/core/bus.c                      |   8 +--
 hw/display/virtio-gpu-pci.c        |   2 +-
 hw/display/virtio-vga.c            |   2 +-
 hw/dma/sparc32_dma.c               |   6 +-
 hw/dma/xilinx_axidma.c             |  12 +---
 hw/i386/amd_iommu.c                |   6 +-
 hw/i386/x86.c                      |   8 ++-
 hw/mips/cps.c                      |  35 ++++++++----
 hw/misc/macio/macio.c              |   3 +-
 hw/net/virtio-net.c                |   2 +-
 hw/net/xilinx_axienet.c            |  12 +---
 hw/pci/pci.c                       |   3 -
 hw/pci/pcie.c                      |   2 +-
 hw/pci/shpc.c                      |   2 +-
 hw/ppc/spapr.c                     |   4 +-
 hw/ppc/spapr_drc.c                 |   4 +-
 hw/ppc/spapr_pci.c                 |   4 +-
 hw/riscv/riscv_hart.c              |  14 ++---
 hw/riscv/sifive_u.c                |  12 +++-
 hw/s390x/ap-bridge.c               |   2 +-
 hw/s390x/css-bridge.c              |   2 +-
 hw/s390x/s390-pci-bus.c            |  14 +----
 hw/scsi/scsi-bus.c                 |   2 +-
 hw/scsi/virtio-scsi.c              |   4 +-
 hw/scsi/vmw_pvscsi.c               |   2 +-
 hw/sd/milkymist-memcard.c          |   5 +-
 hw/usb/bus.c                       |   2 +-
 hw/usb/dev-mtp.c                   |   2 -
 hw/usb/dev-smartcard-reader.c      |   2 +-
 hw/virtio/virtio-iommu-pci.c       |   4 +-
 hw/xen/xen-bus.c                   |   2 +-
 hw/xen/xen-legacy-backend.c        |   2 +-
 migration/rdma.c                   |  19 +++----
 qga/commands-posix.c               |   1 +
 tests/check-block-qdict.c          |  24 ++------
 tests/check-qobject.c              |   5 +-
 tests/check-qom-proplist.c         |  14 ++---
 tests/test-base64.c                |   3 +-
 tests/test-bdrv-graph-mod.c        |   4 +-
 tests/test-block-iothread.c        |   3 +-
 tests/test-crypto-cipher.c         |   8 +--
 tests/test-io-task.c               |   4 +-
 tests/test-logging.c               |  12 +---
 tests/test-qemu-opts.c             |  22 ++------
 tests/test-replication.c           | 109 +++++++++++--------------------------
 tests/test-string-input-visitor.c  |  33 ++++-------
 tests/test-string-output-visitor.c |  16 ++----
 tests/test-util-filemonitor.c      |   1 +
 ui/vnc.c                           |   6 +-
 66 files changed, 243 insertions(+), 438 deletions(-)

-- 
2.26.2


