Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB3C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFF2206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeNjmGHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFF2206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzeV-0004Wc-JN
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVr-0003PQ-VC
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVm-0007R4-7b
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S8lcZPQkZ14VyQRehW2wIVdLkB89qkqwn3tBJx3UFHg=;
 b=eeNjmGHD7oViAVWcKJVSKgH+ljdrWHjU+0wwslhb8/tveXdcOiRdgp8xj7fk3ZVTIvPTde
 BZHZJ/mseGoKZIJCPZM3Ys2ZrYqQqoaW39Sv4//Er4kwmHTJImm8SUmJ1Vgg3GEoI4dKut
 K9bTdJSHxAOhLpRNbNnDYBLBOUCdG9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-dIJJmwsBPyGTKjc10sEcGA-1; Tue, 05 May 2020 11:29:29 -0400
X-MC-Unique: dIJJmwsBPyGTKjc10sEcGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 309CB835B41
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:29:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EFB010016DA;
 Tue,  5 May 2020 15:29:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E6D111358BC; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/18] qom: Spring cleaning
Date: Tue,  5 May 2020 17:29:08 +0200
Message-Id: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Includes one actual bug fix for s390x.

v2:
* Rebased, conflicts in PATCH 07+14 resolved
* New "[PATCH v2 04/18] qom: Simplify object_property_get_enum()"
* Old "[PATCH 04/17] qom: Change object_property_get_uint16List() to
  match its doc" replaced by new "[PATCH v2 05/18] qom: Drop convenience me=
thod
  object_property_get_uint16List()"
* PATCH 08: commit message improved [David]
* PATCH 18: commit message improved [Eric]

Markus Armbruster (18):
  qom: Clearer reference counting in object_initialize_childv()
  qom: Clean up inconsistent use of gchar * vs. char *
  qom: Drop object_property_del_child()'s unused parameter @errp
  qom: Simplify object_property_get_enum()
  qom: Drop convenience method object_property_get_uint16List()
  qom: Make all the object_property_add_FOO() return the property
  qom: Drop object_property_set_description() parameter @errp
  tests/check-qom-proplist: Improve iterator coverage
  s390x/cpumodel: Fix UI to CPU features pcc-cmac-{aes,eaes}-256
  hw/isa/superio: Make the components QOM children
  e1000: Don't run e1000_instance_init() twice
  hw/arm/bcm2835: Drop futile attempts at QOM-adopting memory
  qdev: Clean up qdev_connect_gpio_out_named()
  qom: Drop parameter @errp of object_property_add() & friends
  Drop more @errp parameters after previous commit
  qdev: Unrealize must not fail
  spapr_pci: Drop some dead error handling
  qom: Drop @errp parameter of object_property_del()

 hw/9pfs/9p.h                        |   2 +-
 hw/s390x/virtio-ccw.h               |   2 +-
 hw/sd/sdhci-internal.h              |   2 +-
 hw/usb/ccid.h                       |   2 +-
 hw/usb/hcd-ehci.h                   |   2 +-
 include/hw/acpi/ich9.h              |   2 +-
 include/hw/ppc/spapr.h              |   2 +-
 include/hw/qdev-core.h              |   6 +-
 include/hw/s390x/s390-ccw.h         |   2 +-
 include/hw/scsi/scsi.h              |   2 +-
 include/hw/usb.h                    |   2 +-
 include/hw/xen/xen-block.h          |   2 +-
 include/hw/xen/xen-bus.h            |   2 +-
 include/qom/object.h                | 163 ++++-----
 include/sysemu/sysemu.h             |   2 +-
 monitor/monitor-internal.h          |   2 +-
 target/ppc/cpu.h                    |   3 +-
 target/s390x/cpu_features_def.inc.h |   2 +-
 accel/kvm/kvm-all.c                 |   8 +-
 accel/tcg/tcg-all.c                 |   7 +-
 authz/list.c                        |   5 +-
 authz/listfile.c                    |   6 +-
 authz/pamacct.c                     |   3 +-
 authz/simple.c                      |   3 +-
 backends/cryptodev-vhost-user.c     |   3 +-
 backends/cryptodev.c                |   2 +-
 backends/dbus-vmstate.c             |   6 +-
 backends/hostmem-file.c             |  11 +-
 backends/hostmem-memfd.c            |  17 +-
 backends/hostmem.c                  |  35 +-
 backends/rng-egd.c                  |   3 +-
 backends/rng-random.c               |   3 +-
 backends/rng.c                      |   3 +-
 backends/vhost-user.c               |   2 +-
 block/throttle-groups.c             |   6 +-
 bootdevice.c                        |  10 +-
 chardev/char-socket.c               |   4 +-
 chardev/char.c                      |   7 +-
 crypto/secret.c                     |  18 +-
 crypto/tlscreds.c                   |  12 +-
 crypto/tlscredsanon.c               |   3 +-
 crypto/tlscredspsk.c                |   6 +-
 crypto/tlscredsx509.c               |   9 +-
 hw/9pfs/9p.c                        |   4 +-
 hw/9pfs/virtio-9p-device.c          |   4 +-
 hw/acpi/ich9.c                      |  25 +-
 hw/acpi/pcihp.c                     |   9 +-
 hw/acpi/piix4.c                     |  15 +-
 hw/arm/allwinner-a10.c              |   2 +-
 hw/arm/allwinner-h3.c               |  12 +-
 hw/arm/armv7m.c                     |   2 +-
 hw/arm/aspeed.c                     |   4 +-
 hw/arm/aspeed_ast2600.c             |  13 +-
 hw/arm/aspeed_soc.c                 |  13 +-
 hw/arm/bcm2835_peripherals.c        |  28 +-
 hw/arm/bcm2836.c                    |  16 +-
 hw/arm/cubieboard.c                 |   3 +-
 hw/arm/mcimx6ul-evk.c               |   2 +-
 hw/arm/mcimx7d-sabre.c              |   2 +-
 hw/arm/msf2-soc.c                   |   3 +-
 hw/arm/nrf51_soc.c                  |   3 +-
 hw/arm/orangepi.c                   |   3 +-
 hw/arm/raspi.c                      |   3 +-
 hw/arm/sabrelite.c                  |   2 +-
 hw/arm/sbsa-ref.c                   |   5 +-
 hw/arm/vexpress.c                   |  10 +-
 hw/arm/virt.c                       |  39 +--
 hw/arm/xilinx_zynq.c                |   2 +-
 hw/arm/xlnx-versal-virt.c           |   6 +-
 hw/arm/xlnx-versal.c                |   2 +-
 hw/arm/xlnx-zcu102.c                |  10 +-
 hw/arm/xlnx-zynqmp.c                |   9 +-
 hw/audio/intel-hda.c                |   2 +-
 hw/audio/marvell_88w8618.c          |   2 +-
 hw/audio/pcspk.c                    |   2 +-
 hw/block/fdc.c                      |   4 +-
 hw/block/nvme.c                     |   2 +-
 hw/block/pflash_cfi02.c             |   2 +-
 hw/block/vhost-user-blk.c           |   4 +-
 hw/block/virtio-blk.c               |   4 +-
 hw/block/xen-block.c                |   8 +-
 hw/char/serial-pci-multi.c          |   2 +-
 hw/char/serial-pci.c                |   2 +-
 hw/char/serial.c                    |   2 +-
 hw/char/virtio-console.c            |   2 +-
 hw/char/virtio-serial-bus.c         |   8 +-
 hw/core/bus.c                       |  24 +-
 hw/core/cpu.c                       |   2 +-
 hw/core/generic-loader.c            |   2 +-
 hw/core/machine-qmp-cmds.c          |  16 +-
 hw/core/machine.c                   |  87 ++---
 hw/core/qdev-clock.c                |   4 +-
 hw/core/qdev-properties.c           |  11 +-
 hw/core/qdev.c                      |  74 ++--
 hw/cpu/core.c                       |   4 +-
 hw/display/bochs-display.c          |   3 +-
 hw/display/sm501.c                  |   2 +-
 hw/display/vga-pci.c                |   4 +-
 hw/display/vhost-user-gpu-pci.c     |   3 +-
 hw/display/vhost-user-gpu.c         |   2 +-
 hw/display/vhost-user-vga.c         |   3 +-
 hw/display/virtio-gpu-base.c        |   2 +-
 hw/display/xlnx_dp.c                |   7 +-
 hw/dma/rc4030.c                     |   2 +-
 hw/dma/sparc32_dma.c                |  10 +-
 hw/dma/xilinx_axidma.c              |   9 +-
 hw/dma/xlnx-zdma.c                  |   7 +-
 hw/gpio/aspeed_gpio.c               |   2 +-
 hw/hyperv/hyperv.c                  |   2 +-
 hw/i386/kvm/apic.c                  |   2 +-
 hw/i386/microvm.c                   |  29 +-
 hw/i386/pc.c                        |  18 +-
 hw/i386/pc_piix.c                   |   2 +-
 hw/i386/pc_q35.c                    |   4 +-
 hw/i386/pc_sysfw.c                  |   7 +-
 hw/i386/x86.c                       |  14 +-
 hw/ide/macio.c                      |   2 +-
 hw/ide/qdev.c                       |   6 +-
 hw/input/vhost-user-input.c         |   2 +-
 hw/input/virtio-input-hid.c         |   2 +-
 hw/input/virtio-input-host.c        |   2 +-
 hw/input/virtio-input.c             |   9 +-
 hw/intc/apic.c                      |   2 +-
 hw/intc/apic_common.c               |   6 +-
 hw/intc/ioapic.c                    |   2 +-
 hw/intc/s390_flic.c                 |   4 +-
 hw/intc/xics.c                      |   4 +-
 hw/intc/xive.c                      |   2 +-
 hw/ipack/ipack.c                    |   6 +-
 hw/ipmi/ipmi.c                      |   3 +-
 hw/isa/isa-superio.c                |  13 +-
 hw/isa/lpc_ich9.c                   |   8 +-
 hw/mem/nvdimm.c                     |   4 +-
 hw/mem/pc-dimm.c                    |   4 +-
 hw/microblaze/petalogix_ml605_mmu.c |   6 +-
 hw/misc/aspeed_sdmc.c               |   2 +-
 hw/misc/edu.c                       |   3 +-
 hw/misc/mac_via.c                   |   4 +-
 hw/misc/macio/gpio.c                |   2 +-
 hw/misc/macio/macio.c               |   4 +-
 hw/misc/macio/pmu.c                 |   2 +-
 hw/misc/pca9552.c                   |   2 +-
 hw/misc/tmp105.c                    |   2 +-
 hw/misc/tmp421.c                    |   8 +-
 hw/net/cadence_gem.c                |   3 +-
 hw/net/can/can_kvaser_pci.c         |   2 +-
 hw/net/can/can_mioe3680_pci.c       |   4 +-
 hw/net/can/can_pcm3680_pci.c        |   4 +-
 hw/net/e1000.c                      |   3 +-
 hw/net/e1000e.c                     |   2 +-
 hw/net/eepro100.c                   |   2 +-
 hw/net/lance.c                      |   2 +-
 hw/net/lasi_i82596.c                |   2 +-
 hw/net/ne2000-isa.c                 |   2 +-
 hw/net/ne2000-pci.c                 |   2 +-
 hw/net/pcnet-pci.c                  |   2 +-
 hw/net/rtl8139.c                    |   2 +-
 hw/net/spapr_llan.c                 |   2 +-
 hw/net/sungem.c                     |   2 +-
 hw/net/sunhme.c                     |   2 +-
 hw/net/tulip.c                      |   2 +-
 hw/net/virtio-net.c                 |   6 +-
 hw/net/vmxnet3.c                    |   2 +-
 hw/net/xilinx_axienet.c             |   9 +-
 hw/nios2/10m50_devboard.c           |   3 +-
 hw/nvram/fw_cfg.c                   |   4 +-
 hw/nvram/mac_nvram.c                |   2 +-
 hw/pci-host/grackle.c               |   2 +-
 hw/pci-host/i440fx.c                |  12 +-
 hw/pci-host/pnv_phb3_msi.c          |   3 +-
 hw/pci-host/pnv_phb3_pbcq.c         |   3 +-
 hw/pci-host/q35.c                   |  20 +-
 hw/pci-host/sabre.c                 |   2 +-
 hw/pci-host/uninorth.c              |   8 +-
 hw/pci/pci.c                        |  14 +-
 hw/pci/pcie.c                       |   2 +-
 hw/pci/shpc.c                       |   2 +-
 hw/pcmcia/pxa2xx.c                  |   2 +-
 hw/ppc/e500.c                       |   8 +-
 hw/ppc/mac_newworld.c               |   7 +-
 hw/ppc/mac_oldworld.c               |   2 +-
 hw/ppc/pnv.c                        |  16 +-
 hw/ppc/pnv_bmc.c                    |   5 +-
 hw/ppc/pnv_core.c                   |   4 +-
 hw/ppc/pnv_psi.c                    |   2 +-
 hw/ppc/prep.c                       |   6 +-
 hw/ppc/spapr.c                      |  59 ++--
 hw/ppc/spapr_caps.c                 |  16 +-
 hw/ppc/spapr_cpu_core.c             |   7 +-
 hw/ppc/spapr_drc.c                  |  36 +-
 hw/ppc/spapr_iommu.c                |   4 +-
 hw/ppc/spapr_irq.c                  |   2 +-
 hw/ppc/spapr_pci.c                  |  98 ++----
 hw/ppc/spapr_rng.c                  |   3 +-
 hw/ppc/spapr_rtc.c                  |   2 +-
 hw/ppc/spapr_tpm_proxy.c            |   2 +-
 hw/riscv/sifive_u.c                 |  15 +-
 hw/riscv/virt.c                     |   5 +-
 hw/rtc/mc146818rtc.c                |   4 +-
 hw/s390x/ap-bridge.c                |   2 +-
 hw/s390x/css-bridge.c               |   9 +-
 hw/s390x/event-facility.c           |   6 +-
 hw/s390x/s390-ccw.c                 |   4 +-
 hw/s390x/s390-pci-bus.c             |   4 +-
 hw/s390x/s390-skeys.c               |   4 +-
 hw/s390x/s390-stattrib.c            |   4 +-
 hw/s390x/s390-virtio-ccw.c          |  19 +-
 hw/s390x/sclp.c                     |   5 +-
 hw/s390x/tod.c                      |   2 +-
 hw/s390x/virtio-ccw-balloon.c       |   4 +-
 hw/s390x/virtio-ccw-blk.c           |   2 +-
 hw/s390x/virtio-ccw-net.c           |   2 +-
 hw/s390x/virtio-ccw.c               |   8 +-
 hw/scsi/lsi53c895a.c                |   2 +-
 hw/scsi/scsi-bus.c                  |  17 +-
 hw/scsi/scsi-disk.c                 |   2 +-
 hw/scsi/vhost-scsi.c                |   4 +-
 hw/scsi/vhost-user-scsi.c           |   4 +-
 hw/scsi/virtio-scsi.c               |   2 +-
 hw/sd/sdhci-pci.c                   |   2 +-
 hw/sd/sdhci.c                       |   6 +-
 hw/sparc/sun4m.c                    |   7 +-
 hw/sparc64/sun4u.c                  |   2 +-
 hw/ssi/xilinx_spips.c               |   3 +-
 hw/usb/bus.c                        |  18 +-
 hw/usb/ccid-card-emulated.c         |   2 +-
 hw/usb/dev-audio.c                  |   2 +-
 hw/usb/dev-hid.c                    |   2 +-
 hw/usb/dev-hub.c                    |   2 +-
 hw/usb/dev-network.c                |   4 +-
 hw/usb/dev-smartcard-reader.c       |  11 +-
 hw/usb/dev-storage.c                |   2 +-
 hw/usb/dev-uas.c                    |   2 +-
 hw/usb/dev-wacom.c                  |   2 +-
 hw/usb/hcd-ehci-pci.c               |   2 +-
 hw/usb/hcd-ehci.c                   |   2 +-
 hw/usb/host-libusb.c                |   4 +-
 hw/usb/redirect.c                   |   4 +-
 hw/vfio/ap.c                        |   2 +-
 hw/vfio/ccw.c                       |   6 +-
 hw/vfio/pci-quirks.c                |   6 +-
 hw/vfio/pci.c                       |   2 +-
 hw/virtio/vhost-scsi-pci.c          |   2 +-
 hw/virtio/vhost-user-blk-pci.c      |   2 +-
 hw/virtio/vhost-user-fs.c           |   2 +-
 hw/virtio/vhost-user-input-pci.c    |   3 +-
 hw/virtio/vhost-user-scsi-pci.c     |   2 +-
 hw/virtio/vhost-vsock.c             |   2 +-
 hw/virtio/virtio-balloon-pci.c      |   4 +-
 hw/virtio/virtio-balloon.c          |   6 +-
 hw/virtio/virtio-blk-pci.c          |   2 +-
 hw/virtio/virtio-crypto.c           |   2 +-
 hw/virtio/virtio-iommu.c            |   2 +-
 hw/virtio/virtio-net-pci.c          |   2 +-
 hw/virtio/virtio-pmem.c             |   2 +-
 hw/virtio/virtio-rng.c              |   4 +-
 hw/virtio/virtio.c                  |  11 +-
 hw/watchdog/wdt_diag288.c           |   2 +-
 hw/xen/xen-bus.c                    |  12 +-
 hw/xen/xen-common.c                 |   5 +-
 iothread.c                          |   6 +-
 memory.c                            |  14 +-
 net/can/can_host.c                  |   3 +-
 net/can/can_socketcan.c             |   3 +-
 net/colo-compare.c                  |  20 +-
 net/dump.c                          |   4 +-
 net/filter-buffer.c                 |   2 +-
 net/filter-mirror.c                 |  10 +-
 net/filter-rewriter.c               |   2 +-
 net/filter.c                        |  15 +-
 qdev-monitor.c                      |   4 +-
 qom/container.c                     |   4 +-
 qom/object.c                        | 524 ++++++++++------------------
 qom/object_interfaces.c             |   8 +-
 scsi/pr-manager-helper.c            |   3 +-
 softmmu/vl.c                        |   7 +-
 target/arm/cpu.c                    |  11 +-
 target/arm/cpu64.c                  |  11 +-
 target/arm/kvm.c                    |   4 +-
 target/i386/cpu.c                   |  92 +++--
 target/i386/sev.c                   |  23 +-
 target/ppc/compat.c                 |  14 +-
 target/ppc/translate_init.inc.c     |   9 +-
 target/s390x/cpu.c                  |   2 +-
 target/s390x/cpu_models.c           |  15 +-
 tests/check-qom-proplist.c          |  70 ++--
 tests/test-qdev-global-props.c      |   4 +-
 ui/console.c                        |   7 +-
 ui/input-barrier.c                  |  14 +-
 ui/input-linux.c                    |   8 +-
 290 files changed, 1137 insertions(+), 1648 deletions(-)

--=20
2.21.1


