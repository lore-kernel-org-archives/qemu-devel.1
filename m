Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345D8206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjaCPzP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345D8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJwF-0000v8-Dx
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnJul-0007Nk-A8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:42:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnJui-0005Lm-UD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592822575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iOVxpfcO+/OuIso1Dc0gnyV2uTKirBBj9qsICQtse10=;
 b=cjaCPzP6QOMN/qRyvRA5s7SuoDnQ5bMSdTAh7zH6EJqymex4rXsiQ7xt1uGwvr9lPqddL7
 TtY5uAO6ILkH128CIHIKcUC5eMZXOkgp4uRqEYJO+LKgKb3Qu1Gq1/jpLV8kRgO3rBHNMn
 Z40W+o59o1jZvNypg/baBcwZfaj+axo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Ew__yFToPz-2c5c5YIAkNg-1; Mon, 22 Jun 2020 06:42:53 -0400
X-MC-Unique: Ew__yFToPz-2c5c5YIAkNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D49835B45
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:42:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 987147C1FC
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:42:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02240113846D; Mon, 22 Jun 2020 12:42:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/22] Error handling fixes & cleanups
Date: Mon, 22 Jun 2020 12:42:28 +0200
Message-Id: <20200622104250.1404835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This series addresses a number of error handling issues I found while
working on error handling improvements.  It's based on my "[PATCH v2
00/16] Crazy shit around -global (pardon my french)".

Based-on: <20200622094227.1271650-1-armbru@redhat.com>

Markus Armbruster (22):
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
  tests/qom-proplist: Delete a superfluous error_free()
  aspeed: Clean up roundabout error propagation
  qdev: Drop qbus_set_bus_hotplug_handler() parameter @errp
  qdev: Drop qbus_set_hotplug_handler() parameter @errp
  hw: Fix error API violation around object_property_set_link()
  hw/arm: Drop useless object_property_set_link() error handling
  riscv/sifive_u: Fix sifive_u_soc_realize() error API violations
  riscv_hart: Fix riscv_harts_realize() error API violations
  mips/cps: Fix mips_cps_realize() error API violations
  x86: Fix x86_cpu_new() error API violations
  amd_iommu: Fix amdvi_realize() error API violation

 include/hw/qdev-core.h             |   5 +-
 chardev/char-socket.c              |   6 +-
 hw/9pfs/9p.c                       |   6 +-
 hw/acpi/pcihp.c                    |   3 +-
 hw/acpi/piix4.c                    |   2 +-
 hw/arm/armsse.c                    |  53 ++++----------
 hw/arm/armv7m.c                    |   7 +-
 hw/arm/aspeed_ast2600.c            |  30 +++-----
 hw/arm/aspeed_soc.c                |  24 +++----
 hw/arm/nrf51_soc.c                 |   6 +-
 hw/arm/virt.c                      |   4 +-
 hw/char/virtio-serial-bus.c        |   4 +-
 hw/core/bus.c                      |   8 +--
 hw/display/virtio-gpu-pci.c        |   2 +-
 hw/display/virtio-vga.c            |   2 +-
 hw/dma/sparc32_dma.c               |   6 +-
 hw/dma/xilinx_axidma.c             |  12 +---
 hw/i386/amd_iommu.c                |   6 +-
 hw/i386/x86.c                      |  12 +---
 hw/mips/cps.c                      |  35 +++++----
 hw/misc/macio/macio.c              |   3 +-
 hw/net/virtio-net.c                |   2 +-
 hw/net/xilinx_axienet.c            |  12 +---
 hw/pci/pci.c                       |   3 -
 hw/pci/pcie.c                      |   2 +-
 hw/pci/shpc.c                      |   2 +-
 hw/ppc/spapr.c                     |   4 +-
 hw/ppc/spapr_drc.c                 |   4 +-
 hw/ppc/spapr_pci.c                 |   4 +-
 hw/riscv/riscv_hart.c              |  14 ++--
 hw/riscv/sifive_u.c                |   8 ++-
 hw/s390x/ap-bridge.c               |   2 +-
 hw/s390x/css-bridge.c              |   2 +-
 hw/s390x/s390-pci-bus.c            |  14 +---
 hw/scsi/scsi-bus.c                 |   2 +-
 hw/scsi/virtio-scsi.c              |   4 +-
 hw/scsi/vmw_pvscsi.c               |   2 +-
 hw/sd/milkymist-memcard.c          |   5 +-
 hw/usb/bus.c                       |   2 +-
 hw/usb/dev-mtp.c                   |   2 -
 hw/usb/dev-smartcard-reader.c      |   2 +-
 hw/virtio/virtio-iommu-pci.c       |   2 +-
 hw/xen/xen-bus.c                   |   2 +-
 hw/xen/xen-legacy-backend.c        |   2 +-
 qga/commands-posix.c               |   1 +
 tests/check-block-qdict.c          |  24 ++-----
 tests/check-qobject.c              |   5 +-
 tests/check-qom-proplist.c         |   8 +--
 tests/test-base64.c                |   3 +-
 tests/test-bdrv-graph-mod.c        |   4 +-
 tests/test-block-iothread.c        |   3 +-
 tests/test-crypto-cipher.c         |   8 +--
 tests/test-io-task.c               |   4 +-
 tests/test-logging.c               |  12 +---
 tests/test-qemu-opts.c             |  22 ++----
 tests/test-replication.c           | 109 +++++++++--------------------
 tests/test-string-input-visitor.c  |  33 +++------
 tests/test-string-output-visitor.c |  16 ++---
 tests/test-util-filemonitor.c      |   1 +
 ui/vnc.c                           |   6 +-
 60 files changed, 198 insertions(+), 395 deletions(-)

-- 
2.26.2


