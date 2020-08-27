Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79E122D01
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cneGR4gM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79E122D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNf1-0004pC-0f
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNSk-0005hP-Hl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:21:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNSh-0000LN-NH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=abTxD+Bbl6UDa5elTG/b/G2VJHBLxiqmoikWHWiH5lg=;
 b=cneGR4gMzWZ8tXCko4KtSlr8JdJpKpnBljK1QXeDkabyol+cBfBunpvTduQANvXhMDOPI0
 NqKmoc49Vv9ha9EtBsyN0OWP0/eoEHAXxVRJZ9by13HhfnsmZaWKs/PUBVSZ6c5G2B0xVf
 PxZeRuTHN5umrYGY244xPJ076q9F1Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-OJC0ForNP9yV9bhj6w4piA-1; Thu, 27 Aug 2020 15:21:24 -0400
X-MC-Unique: OJC0ForNP9yV9bhj6w4piA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37DD6107464F;
 Thu, 27 Aug 2020 19:21:23 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB3286115F;
 Thu, 27 Aug 2020 19:21:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/53] Machine queue + QOM fixes and cleanups
Date: Thu, 27 Aug 2020 15:20:29 -0400
Message-Id: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3af90d=
:=0D
=0D
  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' into st=
aging (2020-08-27 13:48:12 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request=0D
=0D
for you to fetch changes up to 92951316dc0b66a41b04edb5dcf3f4a7a2470a61:=0D
=0D
  dc390: Use TYPE_DC390_DEVICE constant (2020-08-27 14:21:48 -0400)=0D
=0D
----------------------------------------------------------------=0D
Machine queue + QOM fixes and cleanups=0D
=0D
Bug fix:=0D
* numa: hmat: fix cache size check (Igor Mammedov)=0D
=0D
QOM fixes and cleanups:=0D
* Move QOM macros and typedefs to header files=0D
* Use TYPE_* constants on TypeInfo structs=0D
* Rename QOM type checking macros for consistency=0D
* Rename enum values and typedefs that conflict with QOM=0D
  type checking amcros=0D
* Fix typos on QOM type checking macros=0D
* Delete unused QOM type checking macros that use=0D
  non-existing typedefs=0D
* hvf: Add missing include=0D
* xen-legacy-backend: Add missing typedef XenLegacyDevice=0D
=0D
----------------------------------------------------------------=0D
=0D
Eduardo Habkost (52):=0D
  e1000: Rename QOM class cast macros=0D
  megasas: Rename QOM class cast macros=0D
  vmw_pvscsi: Rename QOM class cast macros=0D
  pl110: Rename pl110_version enum values=0D
  allwinner-h3: Rename memmap enum constants=0D
  aspeed_soc: Rename memmap/irqmap enum constants=0D
  opentitan: Rename memmap enum constants=0D
  aspeed_timer: Fix ASPEED_TIMER macro definition=0D
  versatile: Fix typo in PCI_VPB_HOST definition=0D
  virtio-ccw: Fix definition of VIRTIO_CCW_BUS_GET_CLASS=0D
  hvf: Add missing include=0D
  hcd-dwc2: Rename USB_*CLASS macros for consistency=0D
  tulip: Move TulipState typedef to header=0D
  throttle-groups: Move ThrottleGroup typedef to header=0D
  pci: Move PCIBusClass typedef to pci.h=0D
  i8254: Move PITCommonState/PITCommonClass typedefs to i8254.h=0D
  hvf: Move HVFState typedef to hvf.h=0D
  mcf_fec: Move mcf_fec_state typedef to header=0D
  s390_flic: Move KVMS390FLICState typedef to header=0D
  can_emu: Delete macros for non-existing typedef=0D
  nubus: Delete unused NUBUS_BRIDGE macro=0D
  platform-bus: Delete macros for non-existing typedef=0D
  armsse: Rename QOM macros to avoid conflicts=0D
  xen-legacy-backend: Add missing typedef XenLegacyDevice=0D
  spapr: Move typedef SpaprMachineState to spapr.h=0D
  s390x: Move typedef SCLPEventFacility to event-facility.h=0D
  vhost-user-gpu: Move QOM macro to header=0D
  ahci: Move QOM macros to header=0D
  i8257: Move QOM macro to header=0D
  ahci: Move QOM macro to header=0D
  pckbd: Move QOM macro to header=0D
  vmbus: Move QOM macros to vmbus.h=0D
  virtio-serial-bus: Move QOM macros to header=0D
  piix: Move QOM macros to header=0D
  auxbus: Move QOM macros to header=0D
  rocker: Move QOM macros to header=0D
  pxa2xx: Move QOM macros to header=0D
  mptsas: Move QOM macros to header=0D
  kvm: Move QOM macros to kvm.h=0D
  vfio/pci: Move QOM macros to header=0D
  nubus: Rename class type checking macros=0D
  s390-virtio-ccw: Rename S390_MACHINE_CLASS macro=0D
  swim: Rename struct SWIM to Swim=0D
  migration: Rename class type checking macros=0D
  etsec: Use TYPE_ETSEC_COMMON constant=0D
  nios2_iic: Use TYPE_ALTERA_IIC constant=0D
  amd_iommu: Use TYPE_AMD_IOMMU_PCI constant=0D
  sclpconsole: Use TYPE_* constants=0D
  xlnx-zcu102: Use TYPE_ZCU102_MACHINE constant=0D
  tosa: Use TYPE_TOSA_MISC_GPIO constant=0D
  ppce500: Use TYPE_PPC_E500_PCI_BRIDGE constant=0D
  dc390: Use TYPE_DC390_DEVICE constant=0D
=0D
Igor Mammedov (1):=0D
  numa: hmat: fix cache size check=0D
=0D
 hw/ide/ahci_internal.h              |   5 -=0D
 hw/net/rocker/rocker.h              |   6 +-=0D
 hw/net/tulip.h                      |   1 +=0D
 hw/s390x/virtio-ccw.h               |   4 +-=0D
 hw/scsi/mptsas.h                    |   6 +-=0D
 hw/usb/hcd-dwc2.h                   |   4 +-=0D
 hw/vfio/pci.h                       |   3 +=0D
 include/block/throttle-groups.h     |   1 +=0D
 include/hw/arm/allwinner-h3.h       |  62 ++++----=0D
 include/hw/arm/armsse.h             |  12 +-=0D
 include/hw/arm/aspeed_soc.h         |  92 +++++------=0D
 include/hw/arm/pxa.h                |  13 ++=0D
 include/hw/block/swim.h             |   6 +-=0D
 include/hw/display/macfb.h          |   4 +-=0D
 include/hw/dma/i8257.h              |   2 +=0D
 include/hw/hyperv/vmbus-bridge.h    |   3 +-=0D
 include/hw/hyperv/vmbus.h           |   4 +=0D
 include/hw/ide/ahci.h               |   5 +=0D
 include/hw/input/i8042.h            |   1 +=0D
 include/hw/m68k/mcf_fec.h           |   1 +=0D
 include/hw/misc/auxbus.h            |   3 +=0D
 include/hw/nubus/nubus.h            |   1 -=0D
 include/hw/pci/pci.h                |   1 +=0D
 include/hw/pci/pci_bus.h            |   4 +-=0D
 include/hw/platform-bus.h           |   4 -=0D
 include/hw/ppc/spapr.h              |   1 +=0D
 include/hw/ppc/spapr_irq.h          |  36 ++---=0D
 include/hw/ppc/spapr_xive.h         |   3 +-=0D
 include/hw/riscv/opentitan.h        |  38 ++---=0D
 include/hw/s390x/event-facility.h   |   1 +=0D
 include/hw/s390x/s390-virtio-ccw.h  |   2 +-=0D
 include/hw/s390x/s390_flic.h        |   1 +=0D
 include/hw/s390x/sclp.h             |   4 +-=0D
 include/hw/southbridge/piix.h       |   4 +=0D
 include/hw/timer/aspeed_timer.h     |   2 +-=0D
 include/hw/timer/i8254.h            |   2 +=0D
 include/hw/timer/i8254_internal.h   |   8 +-=0D
 include/hw/virtio/virtio-gpu.h      |   2 +=0D
 include/hw/virtio/virtio-serial.h   |   5 +=0D
 include/hw/xen/xen-legacy-backend.h |   1 +=0D
 include/net/can_emu.h               |   4 -=0D
 include/sysemu/hvf.h                |   3 +=0D
 include/sysemu/kvm.h                |   6 +=0D
 include/sysemu/kvm_int.h            |   5 -=0D
 migration/migration.h               |   4 +-=0D
 target/i386/hvf/hvf-i386.h          |   4 +-=0D
 block/throttle-groups.c             |   4 +-=0D
 hw/arm/allwinner-h3.c               | 124 +++++++--------=0D
 hw/arm/armsse.c                     |  24 +--=0D
 hw/arm/aspeed.c                     |   4 +-=0D
 hw/arm/aspeed_ast2600.c             | 208 ++++++++++++-------------=0D
 hw/arm/aspeed_soc.c                 | 228 ++++++++++++++--------------=0D
 hw/arm/orangepi.c                   |   6 +-=0D
 hw/arm/pxa2xx.c                     |   7 -=0D
 hw/arm/tosa.c                       |   2 +-=0D
 hw/arm/xlnx-zcu102.c                |   2 +-=0D
 hw/block/swim.c                     |  10 +-=0D
 hw/char/sclpconsole-lm.c            |   2 +-=0D
 hw/char/sclpconsole.c               |   2 +-=0D
 hw/char/virtio-serial-bus.c         |   4 -=0D
 hw/core/numa.c                      |   8 +-=0D
 hw/display/macfb.c                  |   4 +-=0D
 hw/display/pl110.c                  |  22 +--=0D
 hw/display/vhost-user-gpu.c         |   3 -=0D
 hw/dma/i8257.c                      |   2 -=0D
 hw/hyperv/vmbus.c                   |   3 -=0D
 hw/i386/amd_iommu.c                 |   2 +-=0D
 hw/ide/ahci-allwinner.c             |   3 -=0D
 hw/input/pckbd.c                    |   2 -=0D
 hw/intc/nios2_iic.c                 |   2 +-=0D
 hw/intc/s390_flic_kvm.c             |   4 +-=0D
 hw/isa/piix3.c                      |   4 -=0D
 hw/misc/auxbus.c                    |   2 -=0D
 hw/net/e1000.c                      |   8 +-=0D
 hw/net/fsl_etsec/etsec.c            |   2 +-=0D
 hw/net/mcf_fec.c                    |   4 +-=0D
 hw/net/rocker/rocker.c              |   5 -=0D
 hw/net/tulip.c                      |   4 +-=0D
 hw/pci-host/ppce500.c               |   2 +-=0D
 hw/pci-host/versatile.c             |   2 +-=0D
 hw/pcmcia/pxa2xx.c                  |   4 -=0D
 hw/riscv/opentitan.c                |  84 +++++-----=0D
 hw/s390x/s390-virtio-ccw.c          |  14 +-=0D
 hw/scsi/esp-pci.c                   |   2 +-=0D
 hw/scsi/megasas.c                   |  12 +-=0D
 hw/scsi/mptsas.c                    |   5 -=0D
 hw/scsi/vmw_pvscsi.c                |   8 +-=0D
 hw/sd/pxa2xx_mmci.c                 |   3 -=0D
 hw/usb/hcd-dwc2.c                   |   8 +-=0D
 hw/vfio/pci.c                       |   3 -=0D
 90 files changed, 621 insertions(+), 621 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


