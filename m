Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC483C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9063921479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9063921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lQb-00040i-Jn
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i7lLm-0008Pp-Ia
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i7lLi-00069l-Nv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i7lLi-00068o-Ez
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F00ACC058CBD;
 Tue, 10 Sep 2019 18:58:44 +0000 (UTC)
Received: from thuth.com (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 307FC196AE;
 Tue, 10 Sep 2019 18:58:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 20:58:32 +0200
Message-Id: <20190910185839.19682-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 18:58:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/7] Move qtests to a separate folder
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our "tests" directory is very overcrowded - we store the qtests,
unit test and other files there. That makes it difficult to
determine which file belongs to each test subsystem, and the
wildcards in the MAINTAINERS file are inaccurate, too.

Let's clean up this mess. The first patches disentangle some
dependencies, and the last three patches then move the qtests
and libqos (which is a subsystem of the qtests) to a new folder
called "tests/qtest/".

Thomas Huth (7):
  tests/Makefile: test-char does not need libqtest
  tests/ptimer: Remove unnecessary inclusion of libqtest.h
  tests/Makefile: Remove 'tests/' and '$(EXESUF)' from the check-qtest
    variables
  tests/Makefile: Separate unit test dependencies from qtest
    dependencies
  test: Move qtests to a separate directory
  tests/Makefile: Move qtest-related settings to a separate
    Makefile.include
  tests/libqos: Move the libqos files under tests/qtest/

 .gitlab-ci.yml                                |  11 +-
 MAINTAINERS                                   |  67 ++--
 configure                                     |   5 +-
 tests/Makefile.include                        | 331 +-----------------
 tests/ptimer-test.c                           |   1 -
 tests/qtest/Makefile.include                  | 305 ++++++++++++++++
 tests/{ => qtest}/ac97-test.c                 |   0
 tests/{ => qtest}/acpi-utils.c                |   0
 tests/{ => qtest}/acpi-utils.h                |   0
 tests/{ => qtest}/ahci-test.c                 |   0
 .../bios-tables-test-allowed-diff.h           |   0
 tests/{ => qtest}/bios-tables-test.c          |   0
 tests/{ => qtest}/boot-order-test.c           |   0
 tests/{ => qtest}/boot-sector.c               |   0
 tests/{ => qtest}/boot-sector.h               |   0
 tests/{ => qtest}/boot-serial-test.c          |   0
 tests/{ => qtest}/cdrom-test.c                |   0
 tests/{ => qtest}/cpu-plug-test.c             |   0
 tests/{ => qtest}/device-introspect-test.c    |   0
 tests/{ => qtest}/device-plug-test.c          |   0
 tests/{ => qtest}/display-vga-test.c          |   0
 tests/{ => qtest}/drive_del-test.c            |   0
 tests/{ => qtest}/ds1338-test.c               |   0
 tests/{ => qtest}/e1000-test.c                |   0
 tests/{ => qtest}/e1000e-test.c               |   0
 tests/{ => qtest}/eepro100-test.c             |   0
 tests/{ => qtest}/endianness-test.c           |   0
 tests/{ => qtest}/es1370-test.c               |   0
 tests/{ => qtest}/fdc-test.c                  |   0
 tests/{ => qtest}/fw_cfg-test.c               |   0
 tests/{ => qtest}/hd-geo-test.c               |   0
 tests/{ => qtest}/hexloader-test.c            |   0
 tests/{ => qtest}/i440fx-test.c               |   0
 tests/{ => qtest}/i82801b11-test.c            |   0
 tests/{ => qtest}/ide-test.c                  |   0
 tests/{ => qtest}/intel-hda-test.c            |   0
 tests/{ => qtest}/ioh3420-test.c              |   0
 tests/{ => qtest}/ipmi-bt-test.c              |   0
 tests/{ => qtest}/ipmi-kcs-test.c             |   0
 tests/{ => qtest}/ipoctal232-test.c           |   0
 tests/{ => qtest}/ivshmem-test.c              |   0
 .../libqos/aarch64-xlnx-zcu102-machine.c      |   0
 tests/{ => qtest}/libqos/ahci.c               |   0
 tests/{ => qtest}/libqos/ahci.h               |   0
 .../libqos/arm-imx25-pdk-machine.c            |   0
 tests/{ => qtest}/libqos/arm-n800-machine.c   |   0
 tests/{ => qtest}/libqos/arm-raspi2-machine.c |   0
 .../libqos/arm-sabrelite-machine.c            |   0
 .../{ => qtest}/libqos/arm-smdkc210-machine.c |   0
 tests/{ => qtest}/libqos/arm-virt-machine.c   |   0
 .../libqos/arm-xilinx-zynq-a9-machine.c       |   0
 tests/{ => qtest}/libqos/e1000e.c             |   0
 tests/{ => qtest}/libqos/e1000e.h             |   0
 tests/{ => qtest}/libqos/fw_cfg.c             |   0
 tests/{ => qtest}/libqos/fw_cfg.h             |   0
 tests/{ => qtest}/libqos/i2c-imx.c            |   0
 tests/{ => qtest}/libqos/i2c-omap.c           |   0
 tests/{ => qtest}/libqos/i2c.c                |   0
 tests/{ => qtest}/libqos/i2c.h                |   0
 tests/{ => qtest}/libqos/libqos-pc.c          |   0
 tests/{ => qtest}/libqos/libqos-pc.h          |   0
 tests/{ => qtest}/libqos/libqos-spapr.c       |   0
 tests/{ => qtest}/libqos/libqos-spapr.h       |   0
 tests/{ => qtest}/libqos/libqos.c             |   0
 tests/{ => qtest}/libqos/libqos.h             |   0
 tests/{ => qtest}/libqos/malloc-pc.c          |   0
 tests/{ => qtest}/libqos/malloc-pc.h          |   0
 tests/{ => qtest}/libqos/malloc-spapr.c       |   0
 tests/{ => qtest}/libqos/malloc-spapr.h       |   0
 tests/{ => qtest}/libqos/malloc.c             |   0
 tests/{ => qtest}/libqos/malloc.h             |   0
 tests/{ => qtest}/libqos/pci-pc.c             |   0
 tests/{ => qtest}/libqos/pci-pc.h             |   0
 tests/{ => qtest}/libqos/pci-spapr.c          |   0
 tests/{ => qtest}/libqos/pci-spapr.h          |   0
 tests/{ => qtest}/libqos/pci.c                |   0
 tests/{ => qtest}/libqos/pci.h                |   0
 .../libqos/ppc64_pseries-machine.c            |   0
 tests/{ => qtest}/libqos/qgraph.c             |   0
 tests/{ => qtest}/libqos/qgraph.h             |   0
 tests/{ => qtest}/libqos/qgraph_internal.h    |   0
 tests/{ => qtest}/libqos/rtas.c               |   0
 tests/{ => qtest}/libqos/rtas.h               |   0
 tests/{ => qtest}/libqos/sdhci.c              |   0
 tests/{ => qtest}/libqos/sdhci.h              |   0
 tests/{ => qtest}/libqos/tpci200.c            |   0
 tests/{ => qtest}/libqos/usb.c                |   0
 tests/{ => qtest}/libqos/usb.h                |   0
 tests/{ => qtest}/libqos/virtio-9p.c          |   0
 tests/{ => qtest}/libqos/virtio-9p.h          |   0
 tests/{ => qtest}/libqos/virtio-balloon.c     |   0
 tests/{ => qtest}/libqos/virtio-balloon.h     |   0
 tests/{ => qtest}/libqos/virtio-blk.c         |   0
 tests/{ => qtest}/libqos/virtio-blk.h         |   0
 tests/{ => qtest}/libqos/virtio-mmio.c        |   0
 tests/{ => qtest}/libqos/virtio-mmio.h        |   0
 tests/{ => qtest}/libqos/virtio-net.c         |   0
 tests/{ => qtest}/libqos/virtio-net.h         |   0
 tests/{ => qtest}/libqos/virtio-pci.c         |   0
 tests/{ => qtest}/libqos/virtio-pci.h         |   0
 tests/{ => qtest}/libqos/virtio-rng.c         |   0
 tests/{ => qtest}/libqos/virtio-rng.h         |   0
 tests/{ => qtest}/libqos/virtio-scsi.c        |   0
 tests/{ => qtest}/libqos/virtio-scsi.h        |   0
 tests/{ => qtest}/libqos/virtio-serial.c      |   0
 tests/{ => qtest}/libqos/virtio-serial.h      |   0
 tests/{ => qtest}/libqos/virtio.c             |   0
 tests/{ => qtest}/libqos/virtio.h             |   0
 tests/{ => qtest}/libqos/x86_64_pc-machine.c  |   0
 tests/{ => qtest}/libqtest-single.h           |   0
 tests/{ => qtest}/libqtest.c                  |   0
 tests/{ => qtest}/libqtest.h                  |   0
 tests/{ => qtest}/m25p80-test.c               |   0
 tests/{ => qtest}/m48t59-test.c               |   0
 tests/{ => qtest}/machine-none-test.c         |   0
 tests/{ => qtest}/megasas-test.c              |   0
 tests/{ => qtest}/microbit-test.c             |   0
 tests/{ => qtest}/migration-test.c            |   0
 tests/{ => qtest}/modules-test.c              |   0
 tests/{ => qtest}/ne2000-test.c               |   0
 tests/{ => qtest}/numa-test.c                 |   0
 tests/{ => qtest}/nvme-test.c                 |   0
 tests/{ => qtest}/pca9552-test.c              |   0
 tests/{ => qtest}/pci-test.c                  |   0
 tests/{ => qtest}/pcnet-test.c                |   0
 tests/{ => qtest}/pflash-cfi02-test.c         |   0
 tests/{ => qtest}/pnv-xscom-test.c            |   0
 tests/{ => qtest}/prom-env-test.c             |   0
 tests/{ => qtest}/pvpanic-test.c              |   0
 tests/{ => qtest}/pxe-test.c                  |   0
 tests/{ => qtest}/q35-test.c                  |   0
 tests/{ => qtest}/qmp-cmd-test.c              |   0
 tests/{ => qtest}/qmp-test.c                  |   0
 tests/{ => qtest}/qom-test.c                  |   0
 tests/{ => qtest}/qos-test.c                  |   0
 tests/{ => qtest}/rtas-test.c                 |   0
 tests/{ => qtest}/rtc-test.c                  |   0
 tests/{ => qtest}/rtl8139-test.c              |   0
 tests/{ => qtest}/sdhci-test.c                |   0
 tests/{ => qtest}/spapr-phb-test.c            |   0
 tests/{ => qtest}/tco-test.c                  |   0
 tests/{ => qtest}/test-arm-mptimer.c          |   0
 tests/{ => qtest}/test-filter-mirror.c        |   0
 tests/{ => qtest}/test-filter-redirector.c    |   0
 tests/{ => qtest}/test-hmp.c                  |   0
 tests/{ => qtest}/test-netfilter.c            |   0
 tests/{ => qtest}/test-x86-cpuid-compat.c     |   0
 tests/{ => qtest}/tmp105-test.c               |   0
 tests/{ => qtest}/tpm-crb-swtpm-test.c        |   0
 tests/{ => qtest}/tpm-crb-test.c              |   0
 tests/{ => qtest}/tpm-tests.c                 |   0
 tests/{ => qtest}/tpm-tis-swtpm-test.c        |   0
 tests/{ => qtest}/tpm-tis-test.c              |   0
 tests/{ => qtest}/tpm-util.c                  |   0
 tests/{ => qtest}/usb-hcd-ehci-test.c         |   0
 tests/{ => qtest}/usb-hcd-ohci-test.c         |   0
 tests/{ => qtest}/usb-hcd-uhci-test.c         |   0
 tests/{ => qtest}/usb-hcd-xhci-test.c         |   0
 tests/{ => qtest}/vhost-user-test.c           |   0
 tests/{ => qtest}/virtio-9p-test.c            |   0
 tests/{ => qtest}/virtio-blk-test.c           |   0
 tests/{ => qtest}/virtio-ccw-test.c           |   0
 tests/{ => qtest}/virtio-net-test.c           |   0
 tests/{ => qtest}/virtio-rng-test.c           |   0
 tests/{ => qtest}/virtio-scsi-test.c          |   0
 tests/{ => qtest}/virtio-serial-test.c        |   0
 tests/{ => qtest}/virtio-test.c               |   0
 tests/{ => qtest}/vmgenid-test.c              |   0
 tests/{ => qtest}/vmxnet3-test.c              |   0
 tests/{ => qtest}/wdt_ib700-test.c            |   0
 170 files changed, 360 insertions(+), 360 deletions(-)
 create mode 100644 tests/qtest/Makefile.include
 rename tests/{ => qtest}/ac97-test.c (100%)
 rename tests/{ => qtest}/acpi-utils.c (100%)
 rename tests/{ => qtest}/acpi-utils.h (100%)
 rename tests/{ => qtest}/ahci-test.c (100%)
 rename tests/{ => qtest}/bios-tables-test-allowed-diff.h (100%)
 rename tests/{ => qtest}/bios-tables-test.c (100%)
 rename tests/{ => qtest}/boot-order-test.c (100%)
 rename tests/{ => qtest}/boot-sector.c (100%)
 rename tests/{ => qtest}/boot-sector.h (100%)
 rename tests/{ => qtest}/boot-serial-test.c (100%)
 rename tests/{ => qtest}/cdrom-test.c (100%)
 rename tests/{ => qtest}/cpu-plug-test.c (100%)
 rename tests/{ => qtest}/device-introspect-test.c (100%)
 rename tests/{ => qtest}/device-plug-test.c (100%)
 rename tests/{ => qtest}/display-vga-test.c (100%)
 rename tests/{ => qtest}/drive_del-test.c (100%)
 rename tests/{ => qtest}/ds1338-test.c (100%)
 rename tests/{ => qtest}/e1000-test.c (100%)
 rename tests/{ => qtest}/e1000e-test.c (100%)
 rename tests/{ => qtest}/eepro100-test.c (100%)
 rename tests/{ => qtest}/endianness-test.c (100%)
 rename tests/{ => qtest}/es1370-test.c (100%)
 rename tests/{ => qtest}/fdc-test.c (100%)
 rename tests/{ => qtest}/fw_cfg-test.c (100%)
 rename tests/{ => qtest}/hd-geo-test.c (100%)
 rename tests/{ => qtest}/hexloader-test.c (100%)
 rename tests/{ => qtest}/i440fx-test.c (100%)
 rename tests/{ => qtest}/i82801b11-test.c (100%)
 rename tests/{ => qtest}/ide-test.c (100%)
 rename tests/{ => qtest}/intel-hda-test.c (100%)
 rename tests/{ => qtest}/ioh3420-test.c (100%)
 rename tests/{ => qtest}/ipmi-bt-test.c (100%)
 rename tests/{ => qtest}/ipmi-kcs-test.c (100%)
 rename tests/{ => qtest}/ipoctal232-test.c (100%)
 rename tests/{ => qtest}/ivshmem-test.c (100%)
 rename tests/{ => qtest}/libqos/aarch64-xlnx-zcu102-machine.c (100%)
 rename tests/{ => qtest}/libqos/ahci.c (100%)
 rename tests/{ => qtest}/libqos/ahci.h (100%)
 rename tests/{ => qtest}/libqos/arm-imx25-pdk-machine.c (100%)
 rename tests/{ => qtest}/libqos/arm-n800-machine.c (100%)
 rename tests/{ => qtest}/libqos/arm-raspi2-machine.c (100%)
 rename tests/{ => qtest}/libqos/arm-sabrelite-machine.c (100%)
 rename tests/{ => qtest}/libqos/arm-smdkc210-machine.c (100%)
 rename tests/{ => qtest}/libqos/arm-virt-machine.c (100%)
 rename tests/{ => qtest}/libqos/arm-xilinx-zynq-a9-machine.c (100%)
 rename tests/{ => qtest}/libqos/e1000e.c (100%)
 rename tests/{ => qtest}/libqos/e1000e.h (100%)
 rename tests/{ => qtest}/libqos/fw_cfg.c (100%)
 rename tests/{ => qtest}/libqos/fw_cfg.h (100%)
 rename tests/{ => qtest}/libqos/i2c-imx.c (100%)
 rename tests/{ => qtest}/libqos/i2c-omap.c (100%)
 rename tests/{ => qtest}/libqos/i2c.c (100%)
 rename tests/{ => qtest}/libqos/i2c.h (100%)
 rename tests/{ => qtest}/libqos/libqos-pc.c (100%)
 rename tests/{ => qtest}/libqos/libqos-pc.h (100%)
 rename tests/{ => qtest}/libqos/libqos-spapr.c (100%)
 rename tests/{ => qtest}/libqos/libqos-spapr.h (100%)
 rename tests/{ => qtest}/libqos/libqos.c (100%)
 rename tests/{ => qtest}/libqos/libqos.h (100%)
 rename tests/{ => qtest}/libqos/malloc-pc.c (100%)
 rename tests/{ => qtest}/libqos/malloc-pc.h (100%)
 rename tests/{ => qtest}/libqos/malloc-spapr.c (100%)
 rename tests/{ => qtest}/libqos/malloc-spapr.h (100%)
 rename tests/{ => qtest}/libqos/malloc.c (100%)
 rename tests/{ => qtest}/libqos/malloc.h (100%)
 rename tests/{ => qtest}/libqos/pci-pc.c (100%)
 rename tests/{ => qtest}/libqos/pci-pc.h (100%)
 rename tests/{ => qtest}/libqos/pci-spapr.c (100%)
 rename tests/{ => qtest}/libqos/pci-spapr.h (100%)
 rename tests/{ => qtest}/libqos/pci.c (100%)
 rename tests/{ => qtest}/libqos/pci.h (100%)
 rename tests/{ => qtest}/libqos/ppc64_pseries-machine.c (100%)
 rename tests/{ => qtest}/libqos/qgraph.c (100%)
 rename tests/{ => qtest}/libqos/qgraph.h (100%)
 rename tests/{ => qtest}/libqos/qgraph_internal.h (100%)
 rename tests/{ => qtest}/libqos/rtas.c (100%)
 rename tests/{ => qtest}/libqos/rtas.h (100%)
 rename tests/{ => qtest}/libqos/sdhci.c (100%)
 rename tests/{ => qtest}/libqos/sdhci.h (100%)
 rename tests/{ => qtest}/libqos/tpci200.c (100%)
 rename tests/{ => qtest}/libqos/usb.c (100%)
 rename tests/{ => qtest}/libqos/usb.h (100%)
 rename tests/{ => qtest}/libqos/virtio-9p.c (100%)
 rename tests/{ => qtest}/libqos/virtio-9p.h (100%)
 rename tests/{ => qtest}/libqos/virtio-balloon.c (100%)
 rename tests/{ => qtest}/libqos/virtio-balloon.h (100%)
 rename tests/{ => qtest}/libqos/virtio-blk.c (100%)
 rename tests/{ => qtest}/libqos/virtio-blk.h (100%)
 rename tests/{ => qtest}/libqos/virtio-mmio.c (100%)
 rename tests/{ => qtest}/libqos/virtio-mmio.h (100%)
 rename tests/{ => qtest}/libqos/virtio-net.c (100%)
 rename tests/{ => qtest}/libqos/virtio-net.h (100%)
 rename tests/{ => qtest}/libqos/virtio-pci.c (100%)
 rename tests/{ => qtest}/libqos/virtio-pci.h (100%)
 rename tests/{ => qtest}/libqos/virtio-rng.c (100%)
 rename tests/{ => qtest}/libqos/virtio-rng.h (100%)
 rename tests/{ => qtest}/libqos/virtio-scsi.c (100%)
 rename tests/{ => qtest}/libqos/virtio-scsi.h (100%)
 rename tests/{ => qtest}/libqos/virtio-serial.c (100%)
 rename tests/{ => qtest}/libqos/virtio-serial.h (100%)
 rename tests/{ => qtest}/libqos/virtio.c (100%)
 rename tests/{ => qtest}/libqos/virtio.h (100%)
 rename tests/{ => qtest}/libqos/x86_64_pc-machine.c (100%)
 rename tests/{ => qtest}/libqtest-single.h (100%)
 rename tests/{ => qtest}/libqtest.c (100%)
 rename tests/{ => qtest}/libqtest.h (100%)
 rename tests/{ => qtest}/m25p80-test.c (100%)
 rename tests/{ => qtest}/m48t59-test.c (100%)
 rename tests/{ => qtest}/machine-none-test.c (100%)
 rename tests/{ => qtest}/megasas-test.c (100%)
 rename tests/{ => qtest}/microbit-test.c (100%)
 rename tests/{ => qtest}/migration-test.c (100%)
 rename tests/{ => qtest}/modules-test.c (100%)
 rename tests/{ => qtest}/ne2000-test.c (100%)
 rename tests/{ => qtest}/numa-test.c (100%)
 rename tests/{ => qtest}/nvme-test.c (100%)
 rename tests/{ => qtest}/pca9552-test.c (100%)
 rename tests/{ => qtest}/pci-test.c (100%)
 rename tests/{ => qtest}/pcnet-test.c (100%)
 rename tests/{ => qtest}/pflash-cfi02-test.c (100%)
 rename tests/{ => qtest}/pnv-xscom-test.c (100%)
 rename tests/{ => qtest}/prom-env-test.c (100%)
 rename tests/{ => qtest}/pvpanic-test.c (100%)
 rename tests/{ => qtest}/pxe-test.c (100%)
 rename tests/{ => qtest}/q35-test.c (100%)
 rename tests/{ => qtest}/qmp-cmd-test.c (100%)
 rename tests/{ => qtest}/qmp-test.c (100%)
 rename tests/{ => qtest}/qom-test.c (100%)
 rename tests/{ => qtest}/qos-test.c (100%)
 rename tests/{ => qtest}/rtas-test.c (100%)
 rename tests/{ => qtest}/rtc-test.c (100%)
 rename tests/{ => qtest}/rtl8139-test.c (100%)
 rename tests/{ => qtest}/sdhci-test.c (100%)
 rename tests/{ => qtest}/spapr-phb-test.c (100%)
 rename tests/{ => qtest}/tco-test.c (100%)
 rename tests/{ => qtest}/test-arm-mptimer.c (100%)
 rename tests/{ => qtest}/test-filter-mirror.c (100%)
 rename tests/{ => qtest}/test-filter-redirector.c (100%)
 rename tests/{ => qtest}/test-hmp.c (100%)
 rename tests/{ => qtest}/test-netfilter.c (100%)
 rename tests/{ => qtest}/test-x86-cpuid-compat.c (100%)
 rename tests/{ => qtest}/tmp105-test.c (100%)
 rename tests/{ => qtest}/tpm-crb-swtpm-test.c (100%)
 rename tests/{ => qtest}/tpm-crb-test.c (100%)
 rename tests/{ => qtest}/tpm-tests.c (100%)
 rename tests/{ => qtest}/tpm-tis-swtpm-test.c (100%)
 rename tests/{ => qtest}/tpm-tis-test.c (100%)
 rename tests/{ => qtest}/tpm-util.c (100%)
 rename tests/{ => qtest}/usb-hcd-ehci-test.c (100%)
 rename tests/{ => qtest}/usb-hcd-ohci-test.c (100%)
 rename tests/{ => qtest}/usb-hcd-uhci-test.c (100%)
 rename tests/{ => qtest}/usb-hcd-xhci-test.c (100%)
 rename tests/{ => qtest}/vhost-user-test.c (100%)
 rename tests/{ => qtest}/virtio-9p-test.c (100%)
 rename tests/{ => qtest}/virtio-blk-test.c (100%)
 rename tests/{ => qtest}/virtio-ccw-test.c (100%)
 rename tests/{ => qtest}/virtio-net-test.c (100%)
 rename tests/{ => qtest}/virtio-rng-test.c (100%)
 rename tests/{ => qtest}/virtio-scsi-test.c (100%)
 rename tests/{ => qtest}/virtio-serial-test.c (100%)
 rename tests/{ => qtest}/virtio-test.c (100%)
 rename tests/{ => qtest}/vmgenid-test.c (100%)
 rename tests/{ => qtest}/vmxnet3-test.c (100%)
 rename tests/{ => qtest}/wdt_ib700-test.c (100%)

-- 
2.18.1


