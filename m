Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BFA2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BFA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIyWm-0007TS-Do
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxRo-0007ps-6X
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxRk-0005F9-8m
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:07:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:48098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxRj-0004GJ-N0; Fri, 11 Oct 2019 12:07:16 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQR-0003XG-F1; Fri, 11 Oct 2019 19:05:55 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 000/126] error: auto propagated local_err
Date: Fri, 11 Oct 2019 19:03:46 +0300
Message-Id: <20191011160552.22907-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <codyprime@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Alberto Garcia <berto@igalia.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Anthony Green <green@moxielogic.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Andrew Jeffery <andrew@aj.id.au>,
 Chris Wulff <crwulff@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, sheepdog@lists.wpkg.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>, Thomas Huth <thuth@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Liu Yuan <namei.unix@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Jason Dillaman <dillaman@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 xen-devel@lists.xenproject.org, integration@gluster.org,
 Laszlo Ersek <lersek@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

At the request of Markus: full version of errp propagation. Let's look
at it. Cover as much as possible, except inserting macro invocation
where it's not necessary.

It's huge, and so it's an RFC.

In v5 I've added a lot more preparation cleanups:
01-23 are preparation cleanups
  01: not changed, keep Eric's r-b
  02: improve commit msg [Markus], keep Eric's r-b
  03: changed, only error API here, drop r-b
24 is core macro
  - improve cover letter, wording and macro code style
  - keep Eric's r-b
25-26: automation scripts
   - commit-per-subsystem changed a lot. it's a draft, don't bother too
     much with it
   - coccinelle: add support of error_propagate_prepend

27-126: generated patches

====

Here is a proposal of auto propagation for local_err, to not call
error_propagate on every exit point, when we deal with local_err.

There are also two issues with errp:

1. error_fatal & error_append_hint/error_prepend: user can't see this
additional info, because exit() happens in error_setg earlier than info
is added. [Reported by Greg Kurz]

2. error_abort & error_propagate: when we wrap
error_abort by local_err+error_propagate, resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself don't fix the issue, but it allows to [3.] drop all
local_err+error_propagate pattern, which will definitely fix the issue)
[Reported by Kevin Wolf]

====

Generated patches split:

misc
   hw/misc/ivshmem.c
   hw/misc/tmp105.c
   hw/misc/tmp421.c
s390x
   hw/intc/s390_flic_kvm.c
   hw/s390x/3270-ccw.c
   hw/s390x/css-bridge.c
   hw/s390x/css.c
   hw/s390x/s390-skeys.c
   hw/s390x/s390-virtio-ccw.c
   hw/s390x/sclp.c
   hw/s390x/tod-kvm.c
   hw/vfio/ccw.c
   target/s390x/cpu.c
tcg
   exec.c
   hw/arm/armv7m.c
   hw/arm/smmu-common.c
   hw/arm/smmuv3.c
   hw/cpu/a15mpcore.c
   hw/cpu/a9mpcore.c
   hw/cpu/arm11mpcore.c
   hw/i386/pc.c
   hw/intc/nios2_iic.c
   hw/mips/cps.c
   hw/riscv/riscv_hart.c
   hw/riscv/sifive_e.c
   hw/riscv/sifive_u.c
   hw/sd/milkymist-memcard.c
   target/alpha/cpu.c
   target/arm/cpu.c
   target/arm/cpu64.c
   target/cris/cpu.c
   target/hppa/cpu.c
   target/i386/cpu.c
   target/lm32/cpu.c
   target/m68k/cpu.c
   target/microblaze/cpu.c
   target/mips/cpu.c
   target/moxie/cpu.c
   target/nios2/cpu.c
   target/openrisc/cpu.c
   target/ppc/compat.c
   target/ppc/translate_init.inc.c
   target/riscv/cpu.c
   target/sh4/cpu.c
   target/sparc/cpu.c
   target/tricore/cpu.c
   target/unicore32/cpu.c
   target/xtensa/cpu.c
kvm
   target/ppc/kvm.c
   target/s390x/cpu_models.c
xen
   hw/block/dataplane/xen-block.c
   hw/block/xen-block.c
   hw/xen/xen-backend.c
   hw/xen/xen-bus.c
   hw/xen/xen-host-pci-device.c
   hw/xen/xen_pt.c
   hw/xen/xen_pt_config_init.c
Hosts
   qga/commands-win32.c
   util/oslib-posix.c
ARM Machines
   hw/arm/allwinner-a10.c
   hw/arm/aspeed_soc.c
   hw/arm/bcm2835_peripherals.c
   hw/arm/bcm2836.c
   hw/arm/digic.c
   hw/arm/fsl-imx25.c
   hw/arm/fsl-imx31.c
   hw/arm/fsl-imx6.c
   hw/arm/integratorcp.c
   hw/arm/msf2-soc.c
   hw/arm/nrf51_soc.c
   hw/arm/stm32f205_soc.c
   hw/arm/virt.c
   hw/arm/xlnx-versal-virt.c
   hw/arm/xlnx-zynqmp.c
   hw/cpu/realview_mpcore.c
   hw/display/bcm2835_fb.c
   hw/dma/bcm2835_dma.c
   hw/dma/xilinx_axidma.c
   hw/gpio/aspeed_gpio.c
   hw/gpio/bcm2835_gpio.c
   hw/intc/arm_gic.c
   hw/intc/arm_gic_kvm.c
   hw/intc/arm_gicv3.c
   hw/intc/arm_gicv3_its_kvm.c
   hw/intc/arm_gicv3_kvm.c
   hw/intc/armv7m_nvic.c
   hw/intc/realview_gic.c
   hw/microblaze/xlnx-zynqmp-pmu.c
   hw/misc/bcm2835_mbox.c
   hw/misc/bcm2835_property.c
   hw/misc/msf2-sysreg.c
   hw/net/xilinx_axienet.c
   hw/nvram/nrf51_nvm.c
   hw/timer/aspeed_timer.c
   hw/watchdog/wdt_aspeed.c
MIPS Machines
   hw/core/loader-fit.c
PowerPC Machines
   hw/intc/pnv_xive.c
   hw/intc/xics.c
   hw/intc/xics_kvm.c
   hw/intc/xics_pnv.c
   hw/intc/xics_spapr.c
   hw/isa/pc87312.c
   hw/misc/macio/macio.c
   hw/ppc/e500.c
   hw/ppc/mac_newworld.c
   hw/ppc/pnv.c
   hw/ppc/pnv_core.c
   hw/ppc/pnv_homer.c
   hw/ppc/pnv_lpc.c
   hw/ppc/pnv_occ.c
   hw/ppc/pnv_psi.c
   hw/ppc/spapr.c
   hw/ppc/spapr_caps.c
   hw/ppc/spapr_cpu_core.c
   hw/ppc/spapr_drc.c
   hw/ppc/spapr_irq.c
   hw/ppc/spapr_pci.c
   hw/ppc/spapr_vio.c
SPARC Machines
   hw/sparc/sun4m.c
   hw/sparc64/sun4u.c
S390 Machines
   hw/s390x/ipl.c
   hw/s390x/s390-pci-bus.c
X86 Machines
   hw/acpi/ich9.c
   hw/char/debugcon.c
   hw/char/serial-pci-multi.c
   hw/char/serial-pci.c
   hw/core/machine.c
   hw/core/numa.c
   hw/intc/apic_common.c
   hw/pci-host/piix.c
IDE
   hw/ide/qdev.c
Floppy
   hw/block/fdc.c
IPack
   hw/ipack/ipack.c
PCI
   hw/pci-bridge/gen_pcie_root_port.c
   hw/pci-bridge/pci_bridge_dev.c
   hw/pci-bridge/pci_expander_bridge.c
   hw/pci-bridge/pcie_pci_bridge.c
   hw/pci-bridge/pcie_root_port.c
   hw/pci/pci.c
   hw/pci/pcie.c
   hw/pci/shpc.c
ACPI/SMBIOS
   hw/acpi/core.c
   hw/acpi/cpu_hotplug.c
   hw/acpi/memory_hotplug.c
   hw/mem/memory-device.c
   hw/mem/pc-dimm.c
   hw/smbios/smbios.c
Network devices
   hw/net/dp8393x.c
   hw/net/ne2000-isa.c
pflash
   hw/block/pflash_cfi01.c
   hw/block/pflash_cfi02.c
SCSI
   hw/scsi/esp-pci.c
   hw/scsi/mptsas.c
   hw/scsi/scsi-bus.c
   hw/scsi/scsi-disk.c
   hw/scsi/scsi-generic.c
   hw/scsi/virtio-scsi.c
SD (Secure Card)
   hw/sd/sdhci-pci.c
   hw/sd/sdhci.c
USB
   hw/usb/bus.c
   hw/usb/ccid-card-emulated.c
   hw/usb/dev-smartcard-reader.c
   hw/usb/dev-storage.c
   hw/usb/hcd-ohci-pci.c
   hw/usb/hcd-ohci.c
   hw/usb/hcd-uhci.c
   hw/usb/hcd-xhci.c
USB (serial adapter)
   hw/usb/dev-serial.c
VFIO
   hw/vfio/common.c
   hw/vfio/pci-quirks.c
   hw/vfio/pci.c
   hw/vfio/platform.c
vfio-ccw
   hw/s390x/s390-ccw.c
vhost
   hw/block/vhost-user-blk.c
   hw/scsi/vhost-scsi.c
   hw/scsi/vhost-user-scsi.c
   hw/virtio/vhost-vsock.c
virtio
   hw/virtio/virtio-balloon.c
   hw/virtio/virtio-bus.c
   hw/virtio/virtio-pci.c
   hw/virtio/virtio-rng-pci.c
   hw/virtio/virtio.c
virtio-9p
   hw/9pfs/9p-local.c
   hw/9pfs/9p.c
virtio-blk
   hw/block/dataplane/virtio-blk.c
   hw/block/virtio-blk.c
virtio-ccw
   hw/s390x/virtio-ccw-crypto.c
   hw/s390x/virtio-ccw-rng.c
   hw/s390x/virtio-ccw.c
virtio-input
   hw/input/virtio-input.c
virtio-serial
   hw/char/virtio-serial-bus.c
virtio-rng
   backends/rng.c
   hw/virtio/virtio-rng.c
megasas
   hw/scsi/megasas.c
NVDIMM
   hw/mem/nvdimm.c
eepro100
   hw/net/eepro100.c
virtio-gpu
   hw/display/virtio-gpu-base.c
   hw/display/virtio-gpu-pci.c
   hw/display/virtio-vga.c
fw_cfg
   hw/nvram/fw_cfg.c
XIVE
   hw/intc/spapr_xive.c
   hw/intc/spapr_xive_kvm.c
   hw/intc/xive.c
Audio
   audio/audio.c
   hw/audio/intel-hda.c
block
   block.c
   block/backup.c
   block/block-backend.c
   block/commit.c
   block/crypto.c
   block/dirty-bitmap.c
   block/io.c
   block/mirror.c
   block/qapi.c
   block/snapshot.c
   block/throttle-groups.c
   block/throttle.c
   block/vxhs.c
   blockdev.c
   blockjob.c
   hw/block/onenand.c
   job.c
scsi
   scsi/pr-manager-helper.c
chardev
   chardev/char-socket.c
   chardev/char.c
   chardev/spice.c
cmdline
   util/qemu-option.c
Dump
   dump/dump.c
   dump/win_dump.c
Memory API
   memory.c
SPICE
   hw/display/qxl.c
Graphics
   ui/input-barrier.c
   ui/input.c
   ui/vnc.c
Main loop
   util/main-loop.c
   vl.c
Human Monitor (HMP)
   monitor/misc.c
net
   net/can/can_host.c
   net/dump.c
   net/filter-buffer.c
   net/filter.c
   net/net.c
   net/netmap.c
   net/tap.c
hostmem
   backends/hostmem-file.c
   backends/hostmem-memfd.c
   backends/hostmem.c
cryptodev
   backends/cryptodev-vhost-user.c
   backends/cryptodev.c
QAPI
   qapi/qapi-visit-core.c
   qapi/qmp-dispatch.c
   qapi/string-input-visitor.c
qga
   qga/commands-posix.c
QOM
   hw/core/qdev-properties-system.c
   hw/core/qdev-properties.c
   hw/core/qdev.c
   qdev-monitor.c
   qom/object.c
   qom/object_interfaces.c
   qom/qom-qobject.c
QMP
   monitor/qmp-cmds.c
SLIRP
   net/slirp.c
Tracing
   trace/qmp.c
TPM
   hw/tpm/tpm_util.c
   tpm.c
Migration
   migration/migration.c
   migration/ram.c
   migration/rdma.c
   migration/savevm.c
   migration/socket.c
Cryptography
   crypto/block-luks.c
   crypto/secret.c
   crypto/tlssession.c
I/O Channels
   io/dns-resolver.c
   io/net-listener.c
Sockets
   util/qemu-sockets.c
colo
   migration/colo.c
Record/replay
   block/blkreplay.c
VMDK
   block/vmdk.c
RBD
   block/rbd.c
Sheepdog
   block/sheepdog.c
VHDX
   block/vhdx-log.c
   block/vhdx.c
VDI
   block/vdi.c
iSCSI
   block/iscsi.c
nbd
   include/block/nbd.h
   block/nbd.c
   nbd/client.c
   nbd/server.c
NFS
   block/nfs.c
SSH
   block/ssh.c
CURL
   block/curl.c
GLUSTER
   block/gluster.c
NVMe Block Driver
   block/nvme.c
Bootdevice
   bootdevice.c
Quorum
   block/quorum.c
blklogwrites
   block/blklogwrites.c
blkverify
   block/blkverify.c
parallels
   block/parallels.c
qed
   block/qed.c
raw
   block/file-posix.c
   block/file-win32.c
   block/raw-format.c
qcow2
   block/qcow2-bitmap.c
   block/qcow2.c
qcow
   block/qcow.c
blkdebug
   block/blkdebug.c
vpc
   block/vpc.c
vvfat
   block/vvfat.c
Replication
   block/replication.c
   replication.c
PVRDMA
   hw/rdma/vmw/pvrdma_main.c
hw/core/bus.c
   hw/core/bus.c
hw/cpu/core.c
   hw/cpu/core.c
hw/sd/ssi-sd.c
   hw/sd/ssi-sd.c
iothread.c
   iothread.c
memory_mapping.c
   memory_mapping.c
target/tilegx/cpu.c
   target/tilegx/cpu.c
tests/test-image-locking.c
   tests/test-image-locking.c
util/qemu-config.c
   util/qemu-config.c


Vladimir Sementsov-Ogievskiy (126):
  hw/core/loader-fit: fix freeing errp in fit_load_fdt
  net/net: Clean up variable shadowing in net_client_init()
  error: rename errp to errp_in where it is IN-argument
  hmp: drop Error pointer indirection in hmp_handle_error
  vnc: drop Error pointer indirection in vnc_client_io_error
  qdev-monitor: well form error hint helpers
  nbd: well form nbd_iter_channel_error errp handler
  ppc: well form kvmppc_hint_smt_possible error hint helper
  9pfs: well form error hint helpers
  hw/core/qdev: cleanup Error ** variables
  block/snapshot: rename Error ** parameter to more common errp
  hw/i386/amd_iommu: rename Error ** parameter to more common errp
  qga: rename Error ** parameter to more common errp
  monitor/qmp-cmds: rename Error ** parameter to more common errp
  hw/s390x: rename Error ** parameter to more common errp
  hw/sd: rename Error ** parameter to more common errp
  hw/tpm: rename Error ** parameter to more common errp
  hw/usb: rename Error ** parameter to more common errp
  include/block/snapshot.h: rename Error ** parameter to more common
    errp
  include/qom/object.h: rename Error ** parameter to more common errp
  qapi/error: add (Error **errp) cleaning APIs
  backends/cryptodev: drop local_err from cryptodev_backend_complete()
  hw/vfio/ap: drop local_err from vfio_ap_realize
  error: auto propagated local_err
  scripts: add coccinelle script to use auto propagated errp
  python: add commit-per-subsystem.py
  misc: introduce ERRP_AUTO_PROPAGATE
  s390x: introduce ERRP_AUTO_PROPAGATE
  tcg: introduce ERRP_AUTO_PROPAGATE
  kvm: introduce ERRP_AUTO_PROPAGATE
  xen: introduce ERRP_AUTO_PROPAGATE
  Hosts: introduce ERRP_AUTO_PROPAGATE
  ARM Machines: introduce ERRP_AUTO_PROPAGATE
  MIPS Machines: introduce ERRP_AUTO_PROPAGATE
  PowerPC Machines: introduce ERRP_AUTO_PROPAGATE
  SPARC Machines: introduce ERRP_AUTO_PROPAGATE
  S390 Machines: introduce ERRP_AUTO_PROPAGATE
  X86 Machines: introduce ERRP_AUTO_PROPAGATE
  IDE: introduce ERRP_AUTO_PROPAGATE
  Floppy: introduce ERRP_AUTO_PROPAGATE
  IPack: introduce ERRP_AUTO_PROPAGATE
  PCI: introduce ERRP_AUTO_PROPAGATE
  ACPI/SMBIOS: introduce ERRP_AUTO_PROPAGATE
  Network devices: introduce ERRP_AUTO_PROPAGATE
  pflash: introduce ERRP_AUTO_PROPAGATE
  SCSI: introduce ERRP_AUTO_PROPAGATE
  SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
  USB: introduce ERRP_AUTO_PROPAGATE
  USB (serial adapter): introduce ERRP_AUTO_PROPAGATE
  VFIO: introduce ERRP_AUTO_PROPAGATE
  vfio-ccw: introduce ERRP_AUTO_PROPAGATE
  vhost: introduce ERRP_AUTO_PROPAGATE
  virtio: introduce ERRP_AUTO_PROPAGATE
  virtio-9p: introduce ERRP_AUTO_PROPAGATE
  virtio-blk: introduce ERRP_AUTO_PROPAGATE
  virtio-ccw: introduce ERRP_AUTO_PROPAGATE
  virtio-input: introduce ERRP_AUTO_PROPAGATE
  virtio-serial: introduce ERRP_AUTO_PROPAGATE
  virtio-rng: introduce ERRP_AUTO_PROPAGATE
  megasas: introduce ERRP_AUTO_PROPAGATE
  NVDIMM: introduce ERRP_AUTO_PROPAGATE
  eepro100: introduce ERRP_AUTO_PROPAGATE
  virtio-gpu: introduce ERRP_AUTO_PROPAGATE
  fw_cfg: introduce ERRP_AUTO_PROPAGATE
  XIVE: introduce ERRP_AUTO_PROPAGATE
  Audio: introduce ERRP_AUTO_PROPAGATE
  block: introduce ERRP_AUTO_PROPAGATE
  scsi: introduce ERRP_AUTO_PROPAGATE
  chardev: introduce ERRP_AUTO_PROPAGATE
  cmdline: introduce ERRP_AUTO_PROPAGATE
  Dump: introduce ERRP_AUTO_PROPAGATE
  Memory API: introduce ERRP_AUTO_PROPAGATE
  SPICE: introduce ERRP_AUTO_PROPAGATE
  Graphics: introduce ERRP_AUTO_PROPAGATE
  Main loop: introduce ERRP_AUTO_PROPAGATE
  Human Monitor (HMP): introduce ERRP_AUTO_PROPAGATE
  net: introduce ERRP_AUTO_PROPAGATE
  hostmem: introduce ERRP_AUTO_PROPAGATE
  cryptodev: introduce ERRP_AUTO_PROPAGATE
  QAPI: introduce ERRP_AUTO_PROPAGATE
  qga: introduce ERRP_AUTO_PROPAGATE
  QOM: introduce ERRP_AUTO_PROPAGATE
  QMP: introduce ERRP_AUTO_PROPAGATE
  SLIRP: introduce ERRP_AUTO_PROPAGATE
  Tracing: introduce ERRP_AUTO_PROPAGATE
  TPM: introduce ERRP_AUTO_PROPAGATE
  Migration: introduce ERRP_AUTO_PROPAGATE
  Cryptography: introduce ERRP_AUTO_PROPAGATE
  I/O Channels: introduce ERRP_AUTO_PROPAGATE
  Sockets: introduce ERRP_AUTO_PROPAGATE
  colo: introduce ERRP_AUTO_PROPAGATE
  Record/replay: introduce ERRP_AUTO_PROPAGATE
  VMDK: introduce ERRP_AUTO_PROPAGATE
  RBD: introduce ERRP_AUTO_PROPAGATE
  Sheepdog: introduce ERRP_AUTO_PROPAGATE
  VHDX: introduce ERRP_AUTO_PROPAGATE
  VDI: introduce ERRP_AUTO_PROPAGATE
  iSCSI: introduce ERRP_AUTO_PROPAGATE
  nbd: introduce ERRP_AUTO_PROPAGATE
  NFS: introduce ERRP_AUTO_PROPAGATE
  SSH: introduce ERRP_AUTO_PROPAGATE
  CURL: introduce ERRP_AUTO_PROPAGATE
  GLUSTER: introduce ERRP_AUTO_PROPAGATE
  NVMe Block Driver: introduce ERRP_AUTO_PROPAGATE
  Bootdevice: introduce ERRP_AUTO_PROPAGATE
  Quorum: introduce ERRP_AUTO_PROPAGATE
  blklogwrites: introduce ERRP_AUTO_PROPAGATE
  blkverify: introduce ERRP_AUTO_PROPAGATE
  parallels: introduce ERRP_AUTO_PROPAGATE
  qed: introduce ERRP_AUTO_PROPAGATE
  raw: introduce ERRP_AUTO_PROPAGATE
  qcow2: introduce ERRP_AUTO_PROPAGATE
  qcow: introduce ERRP_AUTO_PROPAGATE
  blkdebug: introduce ERRP_AUTO_PROPAGATE
  vpc: introduce ERRP_AUTO_PROPAGATE
  vvfat: introduce ERRP_AUTO_PROPAGATE
  Replication: introduce ERRP_AUTO_PROPAGATE
  PVRDMA: introduce ERRP_AUTO_PROPAGATE
  hw/core/bus.c: introduce ERRP_AUTO_PROPAGATE
  hw/cpu/core.c: introduce ERRP_AUTO_PROPAGATE
  hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
  iothread.c: introduce ERRP_AUTO_PROPAGATE
  memory_mapping.c: introduce ERRP_AUTO_PROPAGATE
  target/tilegx/cpu.c: introduce ERRP_AUTO_PROPAGATE
  tests/test-image-locking.c: introduce ERRP_AUTO_PROPAGATE
  util/qemu-config.c: introduce ERRP_AUTO_PROPAGATE


CC: Gerd Hoffmann <kraxel@redhat.com>
CC: "Gonglei (Arei)" <arei.gonglei@huawei.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>
CC: Laurent Vivier <lvivier@redhat.com>
CC: Amit Shah <amit@kernel.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: John Snow <jsnow@redhat.com>
CC: Ari Sundholm <ari@tuxera.com>
CC: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Stefan Weil <sw@weilnetz.de>
CC: Ronnie Sahlberg <ronniesahlberg@gmail.com>
CC: Peter Lieven <pl@kamp.de>
CC: Eric Blake <eblake@redhat.com>
CC: "Denis V. Lunev" <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Alberto Garcia <berto@igalia.com>
CC: Jason Dillaman <dillaman@redhat.com>
CC: Wen Congyang <wencongyang2@huawei.com>
CC: Xie Changlong <xiechanglong.d@gmail.com>
CC: Liu Yuan <namei.unix@gmail.com>
CC: "Richard W.M. Jones" <rjones@redhat.com>
CC: Jeff Cody <codyprime@gmail.com>
CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
CC: "Daniel P. Berrangé" <berrange@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Greg Kurz <groug@kaod.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: Beniamino Galvani <b.galvani@gmail.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: "Cédric Le Goater" <clg@kaod.org>
CC: Andrew Jeffery <andrew@aj.id.au>
CC: Joel Stanley <joel@jms.id.au>
CC: Andrew Baumann <Andrew.Baumann@microsoft.com>
CC: "Philippe Mathieu-Daudé" <philmd@redhat.com>
CC: Antony Pavlov <antonynpavlov@gmail.com>
CC: Jean-Christophe Dubois <jcd@tribudubois.net>
CC: Peter Chubb <peter.chubb@nicta.com.au>
CC: Subbaraya Sundeep <sundeep.lkml@gmail.com>
CC: Eric Auger <eric.auger@redhat.com>
CC: Alistair Francis <alistair@alistair23.me>
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Anthony Perard <anthony.perard@citrix.com>
CC: Paul Durrant <paul@xen.org>
CC: Paul Burton <pburton@wavecomp.com>
CC: Aleksandar Rikalo <arikalo@wavecomp.com>
CC: Chris Wulff <crwulff@gmail.com>
CC: Marek Vasut <marex@denx.de>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Cornelia Huck <cohuck@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: "Hervé Poussineau" <hpoussin@reactos.org>
CC: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Aleksandar Markovic <amarkovic@wavecomp.com>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
CC: Laszlo Ersek <lersek@redhat.com>
CC: Yuval Shaia <yuval.shaia@oracle.com>
CC: Palmer Dabbelt <palmer@sifive.com>
CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
CC: David Hildenbrand <david@redhat.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Eric Farman <farman@linux.ibm.com>
CC: Matthew Rosato <mjrosato@linux.ibm.com>
CC: Hannes Reinecke <hare@suse.com>
CC: Michael Walle <michael@walle.cc>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
CC: Stefan Berger <stefanb@linux.ibm.com>
CC: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Tony Krowiak <akrowiak@linux.ibm.com>
CC: Pierre Morel <pmorel@linux.ibm.com>
CC: Michael Roth <mdroth@linux.vnet.ibm.com>
CC: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Luigi Rizzo <rizzo@iet.unipi.it>
CC: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
CC: Vincenzo Maffione <v.maffione@gmail.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Anthony Green <green@moxielogic.com>
CC: Stafford Horne <shorne@gmail.com>
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: qemu-block@nongnu.org
CC: integration@gluster.org
CC: sheepdog@lists.wpkg.org
CC: qemu-arm@nongnu.org
CC: xen-devel@lists.xenproject.org
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org
CC: qemu-riscv@nongnu.org

 include/block/nbd.h                           |   1 +
 include/block/snapshot.h                      |   2 +-
 include/monitor/hmp.h                         |   2 +-
 include/qapi/error.h                          |  69 ++++-
 include/qom/object.h                          |   4 +-
 target/ppc/kvm_ppc.h                          |   4 +-
 ui/vnc.h                                      |   2 +-
 audio/audio.c                                 |  12 +-
 backends/cryptodev-vhost-user.c               |  10 +-
 backends/cryptodev.c                          |  25 +-
 backends/hostmem-file.c                       |  21 +-
 backends/hostmem-memfd.c                      |  18 +-
 backends/hostmem.c                            |  41 ++-
 backends/rng.c                                |   7 +-
 block.c                                       | 225 +++++++---------
 block/backup.c                                |   1 +
 block/blkdebug.c                              |  36 ++-
 block/blklogwrites.c                          |  22 +-
 block/blkreplay.c                             |   7 +-
 block/blkverify.c                             |  17 +-
 block/block-backend.c                         |  19 +-
 block/commit.c                                |   7 +-
 block/crypto.c                                |  14 +-
 block/curl.c                                  |   7 +-
 block/dirty-bitmap.c                          |   1 +
 block/file-posix.c                            |  79 +++---
 block/file-win32.c                            |  29 +-
 block/gluster.c                               |  69 +++--
 block/io.c                                    |  12 +-
 block/iscsi.c                                 |  36 ++-
 block/mirror.c                                |  19 +-
 block/nbd.c                                   |  59 ++--
 block/nfs.c                                   |   7 +-
 block/nvme.c                                  |  19 +-
 block/parallels.c                             |  30 +--
 block/qapi.c                                  |  26 +-
 block/qcow.c                                  |  17 +-
 block/qcow2-bitmap.c                          |   9 +-
 block/qcow2.c                                 |  98 +++----
 block/qed.c                                   |  18 +-
 block/quorum.c                                |  23 +-
 block/raw-format.c                            |   7 +-
 block/rbd.c                                   |  29 +-
 block/replication.c                           |  40 ++-
 block/sheepdog.c                              |  73 +++--
 block/snapshot.c                              |  20 +-
 block/ssh.c                                   |  12 +-
 block/throttle-groups.c                       |  24 +-
 block/throttle.c                              |   7 +-
 block/vdi.c                                   |  15 +-
 block/vhdx-log.c                              |   1 +
 block/vhdx.c                                  |  22 +-
 block/vmdk.c                                  |  41 ++-
 block/vpc.c                                   |  28 +-
 block/vvfat.c                                 |  12 +-
 block/vxhs.c                                  |  23 +-
 blockdev.c                                    | 252 ++++++++----------
 blockjob.c                                    |   8 +-
 bootdevice.c                                  |  31 +--
 chardev/char-socket.c                         |   7 +-
 chardev/char.c                                |  20 +-
 chardev/spice.c                               |   1 +
 crypto/block-luks.c                           |  56 ++--
 crypto/secret.c                               |  17 +-
 crypto/tlssession.c                           |   7 +-
 dump/dump-hmp-cmds.c                          |   4 +-
 dump/dump.c                                   | 151 +++++------
 dump/win_dump.c                               |  29 +-
 exec.c                                        |  21 +-
 hw/9pfs/9p-local.c                            |  12 +-
 hw/9pfs/9p-proxy.c                            |   5 +-
 hw/9pfs/9p.c                                  |   1 +
 hw/acpi/core.c                                |  18 +-
 hw/acpi/cpu_hotplug.c                         |   2 +-
 hw/acpi/ich9.c                                |  30 +--
 hw/acpi/memory_hotplug.c                      |   7 +-
 hw/arm/allwinner-a10.c                        |  27 +-
 hw/arm/armv7m.c                               |  52 ++--
 hw/arm/aspeed_soc.c                           |   1 +
 hw/arm/bcm2835_peripherals.c                  |  85 +++---
 hw/arm/bcm2836.c                              |  41 ++-
 hw/arm/digic.c                                |  22 +-
 hw/arm/fsl-imx25.c                            |  62 ++---
 hw/arm/fsl-imx31.c                            |  57 ++--
 hw/arm/fsl-imx6.c                             |  81 +++---
 hw/arm/integratorcp.c                         |   7 +-
 hw/arm/msf2-soc.c                             |  22 +-
 hw/arm/nrf51_soc.c                            |  47 ++--
 hw/arm/smmu-common.c                          |   7 +-
 hw/arm/smmuv3.c                               |   7 +-
 hw/arm/stm32f205_soc.c                        |  39 ++-
 hw/arm/virt.c                                 |   2 +
 hw/arm/xlnx-versal-virt.c                     |   7 +-
 hw/arm/xlnx-zynqmp.c                          |  86 +++---
 hw/audio/intel-hda.c                          |  13 +-
 hw/block/dataplane/virtio-blk.c               |   1 +
 hw/block/dataplane/xen-block.c                |  17 +-
 hw/block/fdc.c                                |  19 +-
 hw/block/onenand.c                            |   7 +-
 hw/block/pflash_cfi01.c                       |   7 +-
 hw/block/pflash_cfi02.c                       |   7 +-
 hw/block/vhost-user-blk.c                     |   6 +-
 hw/block/virtio-blk.c                         |   7 +-
 hw/block/xen-block.c                          | 119 ++++-----
 hw/char/debugcon.c                            |   7 +-
 hw/char/serial-pci-multi.c                    |   7 +-
 hw/char/serial-pci.c                          |   7 +-
 hw/char/virtio-serial-bus.c                   |   7 +-
 hw/core/bus.c                                 |  15 +-
 hw/core/loader-fit.c                          |   7 +-
 hw/core/machine-hmp-cmds.c                    |   6 +-
 hw/core/machine.c                             |  21 +-
 hw/core/numa.c                                |  51 ++--
 hw/core/qdev-properties-system.c              |  28 +-
 hw/core/qdev-properties.c                     |  89 +++----
 hw/core/qdev.c                                |  58 ++--
 hw/cpu/a15mpcore.c                            |   7 +-
 hw/cpu/a9mpcore.c                             |  27 +-
 hw/cpu/arm11mpcore.c                          |  22 +-
 hw/cpu/core.c                                 |  14 +-
 hw/cpu/realview_mpcore.c                      |  12 +-
 hw/display/bcm2835_fb.c                       |   6 +-
 hw/display/qxl.c                              |   7 +-
 hw/display/virtio-gpu-base.c                  |   7 +-
 hw/display/virtio-gpu-pci.c                   |   7 +-
 hw/display/virtio-vga.c                       |   7 +-
 hw/dma/bcm2835_dma.c                          |   6 +-
 hw/dma/xilinx_axidma.c                        |  22 +-
 hw/gpio/aspeed_gpio.c                         |   7 +-
 hw/gpio/bcm2835_gpio.c                        |  10 +-
 hw/i386/amd_iommu.c                           |  14 +-
 hw/i386/pc.c                                  | 120 ++++-----
 hw/ide/qdev.c                                 |  16 +-
 hw/input/virtio-input.c                       |  14 +-
 hw/intc/apic_common.c                         |   7 +-
 hw/intc/arm_gic.c                             |   7 +-
 hw/intc/arm_gic_kvm.c                         |  12 +-
 hw/intc/arm_gicv3.c                           |  12 +-
 hw/intc/arm_gicv3_its_kvm.c                   |   7 +-
 hw/intc/arm_gicv3_kvm.c                       |  17 +-
 hw/intc/armv7m_nvic.c                         |  12 +-
 hw/intc/nios2_iic.c                           |   6 +-
 hw/intc/pnv_xive.c                            |  15 +-
 hw/intc/realview_gic.c                        |   7 +-
 hw/intc/s390_flic_kvm.c                       |   9 +-
 hw/intc/spapr_xive.c                          |  12 +-
 hw/intc/spapr_xive_kvm.c                      |  55 ++--
 hw/intc/xics.c                                |  28 +-
 hw/intc/xics_kvm.c                            |  30 +--
 hw/intc/xics_pnv.c                            |   7 +-
 hw/intc/xics_spapr.c                          |   7 +-
 hw/intc/xive.c                                |  27 +-
 hw/ipack/ipack.c                              |   5 +-
 hw/isa/pc87312.c                              |   7 +-
 hw/mem/memory-device.c                        |  20 +-
 hw/mem/nvdimm.c                               |  25 +-
 hw/mem/pc-dimm.c                              |  23 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |  12 +-
 hw/mips/cps.c                                 |  46 ++--
 hw/misc/bcm2835_mbox.c                        |   6 +-
 hw/misc/bcm2835_property.c                    |  10 +-
 hw/misc/ivshmem.c                             |  37 ++-
 hw/misc/macio/macio.c                         |  68 ++---
 hw/misc/msf2-sysreg.c                         |   1 +
 hw/misc/tmp105.c                              |   7 +-
 hw/misc/tmp421.c                              |   7 +-
 hw/net/dp8393x.c                              |   7 +-
 hw/net/eepro100.c                             |   7 +-
 hw/net/ne2000-isa.c                           |  17 +-
 hw/net/xilinx_axienet.c                       |  22 +-
 hw/nvram/fw_cfg.c                             |  14 +-
 hw/nvram/nrf51_nvm.c                          |   7 +-
 hw/pci-bridge/gen_pcie_root_port.c            |   7 +-
 hw/pci-bridge/pci_bridge_dev.c                |  13 +-
 hw/pci-bridge/pci_expander_bridge.c           |   7 +-
 hw/pci-bridge/pcie_pci_bridge.c               |   8 +-
 hw/pci-bridge/pcie_root_port.c                |   1 +
 hw/pci-host/piix.c                            |   7 +-
 hw/pci/pci.c                                  |  19 +-
 hw/pci/pcie.c                                 |   7 +-
 hw/pci/shpc.c                                 |  14 +-
 hw/ppc/e500.c                                 |   7 +-
 hw/ppc/mac_newworld.c                         |   1 +
 hw/ppc/pnv.c                                  | 109 ++++----
 hw/ppc/pnv_core.c                             |  23 +-
 hw/ppc/pnv_homer.c                            |   5 +-
 hw/ppc/pnv_lpc.c                              |  26 +-
 hw/ppc/pnv_occ.c                              |   5 +-
 hw/ppc/pnv_psi.c                              |  23 +-
 hw/ppc/spapr.c                                | 133 ++++-----
 hw/ppc/spapr_caps.c                           |  57 ++--
 hw/ppc/spapr_cpu_core.c                       |  36 ++-
 hw/ppc/spapr_drc.c                            |  48 ++--
 hw/ppc/spapr_irq.c                            |  98 +++----
 hw/ppc/spapr_pci.c                            |  97 +++----
 hw/ppc/spapr_vio.c                            |  12 +-
 hw/rdma/vmw/pvrdma_main.c                     |   1 +
 hw/riscv/riscv_hart.c                         |   7 +-
 hw/riscv/sifive_e.c                           |   7 +-
 hw/riscv/sifive_u.c                           |  11 +-
 hw/s390x/3270-ccw.c                           |  13 +-
 hw/s390x/css-bridge.c                         |   7 +-
 hw/s390x/css.c                                |   7 +-
 hw/s390x/event-facility.c                     |   2 +-
 hw/s390x/ipl.c                                |  24 +-
 hw/s390x/s390-ccw.c                           |  19 +-
 hw/s390x/s390-pci-bus.c                       |  37 ++-
 hw/s390x/s390-skeys.c                         |   7 +-
 hw/s390x/s390-stattrib.c                      |   3 +-
 hw/s390x/s390-virtio-ccw.c                    |  11 +-
 hw/s390x/sclp.c                               |  15 +-
 hw/s390x/tod-kvm.c                            |  14 +-
 hw/s390x/virtio-ccw-crypto.c                  |   7 +-
 hw/s390x/virtio-ccw-rng.c                     |   7 +-
 hw/s390x/virtio-ccw.c                         |  13 +-
 hw/scsi/esp-pci.c                             |   7 +-
 hw/scsi/megasas.c                             |  11 +-
 hw/scsi/mptsas.c                              |  13 +-
 hw/scsi/scsi-bus.c                            |  24 +-
 hw/scsi/scsi-disk.c                           |   8 +-
 hw/scsi/scsi-generic.c                        |   1 +
 hw/scsi/vhost-scsi.c                          |  12 +-
 hw/scsi/vhost-user-scsi.c                     |   7 +-
 hw/scsi/virtio-scsi.c                         |   7 +-
 hw/sd/milkymist-memcard.c                     |  11 +-
 hw/sd/sdhci-pci.c                             |   7 +-
 hw/sd/sdhci.c                                 |  23 +-
 hw/sd/ssi-sd.c                                |  14 +-
 hw/smbios/smbios.c                            |  42 ++-
 hw/sparc/sun4m.c                              |  21 +-
 hw/sparc64/sun4u.c                            |   7 +-
 hw/timer/aspeed_timer.c                       |   6 +-
 hw/tpm/tpm_emulator.c                         |   8 +-
 hw/tpm/tpm_util.c                             |   7 +-
 hw/usb/bus.c                                  |  37 ++-
 hw/usb/ccid-card-emulated.c                   |   1 +
 hw/usb/dev-network.c                          |   2 +-
 hw/usb/dev-serial.c                           |   7 +-
 hw/usb/dev-smartcard-reader.c                 |  14 +-
 hw/usb/dev-storage.c                          |  17 +-
 hw/usb/hcd-ohci-pci.c                         |   7 +-
 hw/usb/hcd-ohci.c                             |  14 +-
 hw/usb/hcd-uhci.c                             |   7 +-
 hw/usb/hcd-xhci.c                             |  13 +-
 hw/vfio/ap.c                                  |  16 +-
 hw/vfio/ccw.c                                 |  24 +-
 hw/vfio/common.c                              |   3 +
 hw/vfio/pci-quirks.c                          |   8 +-
 hw/vfio/pci.c                                 |  42 ++-
 hw/vfio/platform.c                            |   1 +
 hw/virtio/vhost-vsock.c                       |   1 +
 hw/virtio/virtio-balloon.c                    |  35 ++-
 hw/virtio/virtio-bus.c                        |  17 +-
 hw/virtio/virtio-pci.c                        |   2 +
 hw/virtio/virtio-rng-pci.c                    |   7 +-
 hw/virtio/virtio-rng.c                        |   7 +-
 hw/virtio/virtio.c                            |  19 +-
 hw/watchdog/wdt_aspeed.c                      |   5 +-
 hw/xen/xen-backend.c                          |   7 +-
 hw/xen/xen-bus.c                              |  92 +++----
 hw/xen/xen-host-pci-device.c                  |  27 +-
 hw/xen/xen_pt.c                               |  25 +-
 hw/xen/xen_pt_config_init.c                   |  20 +-
 io/dns-resolver.c                             |   7 +-
 io/net-listener.c                             |   7 +-
 iothread.c                                    |  27 +-
 job.c                                         |   7 +-
 memory.c                                      |  63 ++---
 memory_mapping.c                              |   7 +-
 migration/colo.c                              |  38 ++-
 migration/migration.c                         |  39 ++-
 migration/ram.c                               |  13 +-
 migration/rdma.c                              |  13 +-
 migration/savevm.c                            |   2 +
 migration/socket.c                            |  18 +-
 monitor/hmp-cmds.c                            | 155 ++++++-----
 monitor/misc.c                                |   9 +-
 monitor/qmp-cmds.c                            |   9 +-
 nbd/client.c                                  |   5 +
 nbd/server.c                                  |   5 +
 net/can/can_host.c                            |   7 +-
 net/dump.c                                    |  15 +-
 net/filter-buffer.c                           |  15 +-
 net/filter.c                                  |   7 +-
 net/net.c                                     |  58 ++--
 net/netmap.c                                  |   7 +-
 net/slirp.c                                   |   7 +-
 net/tap.c                                     |  47 ++--
 qapi/qapi-visit-core.c                        |  56 ++--
 qapi/qmp-dispatch.c                           |   7 +-
 qapi/string-input-visitor.c                   |   7 +-
 qdev-monitor.c                                |  69 +++--
 qga/commands-posix.c                          | 222 +++++++--------
 qga/commands-win32.c                          | 141 +++++-----
 qga/commands.c                                |  12 +-
 qom/object.c                                  | 246 ++++++++---------
 qom/object_interfaces.c                       |  27 +-
 qom/qom-hmp-cmds.c                            |   4 +-
 qom/qom-qobject.c                             |   7 +-
 replication.c                                 |  28 +-
 scsi/pr-manager-helper.c                      |   7 +-
 target/alpha/cpu.c                            |   7 +-
 target/arm/cpu.c                              |   7 +-
 target/arm/cpu64.c                            |  11 +-
 target/cris/cpu.c                             |   7 +-
 target/hppa/cpu.c                             |   7 +-
 target/i386/cpu.c                             | 117 ++++----
 target/lm32/cpu.c                             |   7 +-
 target/m68k/cpu.c                             |   7 +-
 target/microblaze/cpu.c                       |   7 +-
 target/mips/cpu.c                             |   7 +-
 target/moxie/cpu.c                            |   7 +-
 target/nios2/cpu.c                            |   7 +-
 target/openrisc/cpu.c                         |   7 +-
 target/ppc/compat.c                           |  20 +-
 target/ppc/kvm.c                              |  14 +-
 target/ppc/translate_init.inc.c               |  26 +-
 target/riscv/cpu.c                            |   7 +-
 target/s390x/cpu.c                            |  26 +-
 target/s390x/cpu_models.c                     |   2 +
 target/sh4/cpu.c                              |   7 +-
 target/sparc/cpu.c                            |  14 +-
 target/tilegx/cpu.c                           |   7 +-
 target/tricore/cpu.c                          |   7 +-
 target/unicore32/cpu.c                        |   7 +-
 target/xtensa/cpu.c                           |   7 +-
 tests/test-image-locking.c                    |   7 +-
 tpm.c                                         |   7 +-
 trace/qmp.c                                   |  14 +-
 ui/input-barrier.c                            |   7 +-
 ui/input.c                                    |  14 +-
 ui/vnc.c                                      |  39 ++-
 util/error.c                                  |  30 +--
 util/main-loop.c                              |   5 +-
 util/oslib-posix.c                            |   6 +-
 util/qemu-config.c                            |  29 +-
 util/qemu-option.c                            |  59 ++--
 util/qemu-sockets.c                           |  31 +--
 vl.c                                          |  14 +-
 python/commit-per-subsystem.py                | 204 ++++++++++++++
 scripts/coccinelle/auto-propagated-errp.cocci | 118 ++++++++
 341 files changed, 3851 insertions(+), 4455 deletions(-)
 create mode 100755 python/commit-per-subsystem.py
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

-- 
2.21.0


