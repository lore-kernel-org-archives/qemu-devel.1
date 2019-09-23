Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ACDC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B059420882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B059420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRDm-0005IL-S3
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxQ-0002Sm-Dn
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxN-0003jr-64
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:13:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:39524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQxM-0003aC-JW; Mon, 23 Sep 2019 12:12:57 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQwx-0001Fp-QV; Mon, 23 Sep 2019 19:12:32 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 0/9] error: auto propagated local_err
Date: Mon, 23 Sep 2019 19:12:22 +0300
Message-Id: <20190923161231.22028-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
X-Mailman-Approved-At: Mon, 23 Sep 2019 12:26:10 -0400
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
Cc: stefanha@redhat.com, codyprime@gmail.com, jan.kiszka@siemens.com,
 berto@igalia.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, samuel.thibault@ens-lyon.org, philmd@redhat.com,
 green@moxielogic.com, lvivier@redhat.com, ehabkost@redhat.com,
 xiechanglong.d@gmail.com, pl@kamp.de, dgilbert@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, ronniesahlberg@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 andrew@aj.id.au, crwulff@gmail.com, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 david@redhat.com, palmer@sifive.com, thuth@redhat.com, jcmvbkbc@gmail.com,
 den@openvz.org, hare@suse.com, sstabellini@kernel.org, arei.gonglei@huawei.com,
 namei.unix@gmail.com, atar4qemu@gmail.com, farman@linux.ibm.com,
 amit@kernel.org, sw@weilnetz.de, groug@kaod.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, cohuck@redhat.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, pburton@wavecomp.com, sagark@eecs.berkeley.edu,
 jasowang@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 gxt@mprc.pku.edu.cn, ari@tuxera.com, quintela@redhat.com,
 mdroth@linux.vnet.ibm.com, lersek@redhat.com, borntraeger@de.ibm.com,
 antonynpavlov@gmail.com, dillaman@redhat.com, joel@jms.id.au,
 xen-devel@lists.xenproject.org, integration@gluster.org, rjones@redhat.com,
 Andrew.Baumann@microsoft.com, mreitz@redhat.com, walling@linux.ibm.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, v.maffione@gmail.com,
 marex@denx.de, armbru@redhat.com, marcandre.lureau@redhat.com,
 alistair@alistair23.me, paul.durrant@citrix.com, pavel.dovgaluk@ispras.ru,
 g.lettieri@iet.unipi.it, rizzo@iet.unipi.it, david@gibson.dropbear.id.au,
 akrowiak@linux.ibm.com, berrange@redhat.com, xiaoguangrong.eric@gmail.com,
 pmorel@linux.ibm.com, wencongyang2@huawei.com, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is a proposal of auto propagation for local_err, to not call
error_propagate on every exit point, when we deal with local_err.

It also fixes two issues:
1. Fix issue with error_fatal & error_append_hint: user can't see these
hints, because exit() happens in error_setg earlier than hint is
appended. [Reported by Greg Kurz]

2. Fix issue with error_abort & error_propagate: when we wrap
error_abort by local_err+error_propagate, resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself don't fix the issue, but it allows to [3.] drop all
local_err+error_propagate pattern, which will definitely fix the issue)
[Reported by Kevin Wolf]

It's still an RFC, due to the following reasons:

1. I'm new to coccinella, so I failed to do the following pattern:

 <...
- goto out;
+ return;
 ...>
- out:
- error_propagate(errp, local_err)

So, here is compilation fix 08.. Who can help with it? If nobody, 08 is
to be merged to 07 by hand.

2. Question about using new macro in empty stub functions - see 09

3. What to do with huge auto-generated commit 07? Should I split it
per-maintainer or per-subsystem, or leave it as-is?

4. Also, checkpatch has some complains about 07 patch:
  - using tabs.. (hmm exactly stubs functions..)
  - empty ifs
  Again, I don't see any ways to fix it other that by hand and merge to
  07..

==================

Also, if we decide, that this all is too huge, here is plan B:

1. apply 01
2. fix only functions that don't use local_err and use
error_append_hint, by just invocation of new macro at function start -
it will substitute Greg's series with no pain.
3[optional]. Do full update for some subsystems, for example, only for
block* and nbd*

Vladimir Sementsov-Ogievskiy (9):
  error: auto propagated local_err
  qapi/error: add (Error **errp) cleaning APIs
  errp: rename errp to errp_in where it is IN-argument
  hw/core/loader-fit: fix freeing errp in fit_load_fdt
  net/net: fix local variable shadowing in net_client_init
  scripts: add coccinelle script to use auto propagated errp
  Use auto-propagated errp
  fix-compilation: empty goto
  fix-compilation: includes

 include/hw/pci-host/spapr.h                   |   2 +
 include/monitor/hmp.h                         |   2 +-
 include/qapi/error.h                          |  61 ++++-
 target/ppc/kvm_ppc.h                          |   3 +
 target/s390x/cpu_models.h                     |   3 +
 ui/vnc.h                                      |   2 +-
 audio/audio.c                                 |  12 +-
 authz/pamacct.c                               |   1 +
 backends/cryptodev-vhost-user.c               |   9 +-
 backends/cryptodev.c                          |  24 +-
 backends/hostmem-file.c                       |  19 +-
 backends/hostmem-memfd.c                      |  17 +-
 backends/hostmem.c                            |  38 ++-
 backends/rng.c                                |   6 +-
 block.c                                       | 208 +++++++----------
 block/blkdebug.c                              |  33 +--
 block/blklogwrites.c                          |  21 +-
 block/blkreplay.c                             |   6 +-
 block/blkverify.c                             |  16 +-
 block/block-backend.c                         |  17 +-
 block/commit.c                                |   6 +-
 block/crypto.c                                |  12 +-
 block/curl.c                                  |   6 +-
 block/file-posix.c                            |  71 +++---
 block/file-win32.c                            |  27 +--
 block/gluster.c                               |  64 +++--
 block/io.c                                    |  11 +-
 block/iscsi.c                                 |  33 +--
 block/mirror.c                                |  17 +-
 block/nbd.c                                   |  44 ++--
 block/nfs.c                                   |   6 +-
 block/nvme.c                                  |  17 +-
 block/parallels.c                             |  28 +--
 block/qapi.c                                  |  23 +-
 block/qcow.c                                  |  15 +-
 block/qcow2-bitmap.c                          |   6 +-
 block/qcow2.c                                 |  90 +++----
 block/qed.c                                   |  16 +-
 block/quorum.c                                |  22 +-
 block/raw-format.c                            |   6 +-
 block/rbd.c                                   |  25 +-
 block/replication.c                           |  36 ++-
 block/sheepdog.c                              |  66 +++---
 block/snapshot.c                              |  14 +-
 block/ssh.c                                   |  11 +-
 block/throttle-groups.c                       |  22 +-
 block/throttle.c                              |   6 +-
 block/vdi.c                                   |  12 +-
 block/vhdx.c                                  |  20 +-
 block/vmdk.c                                  |  36 +--
 block/vpc.c                                   |  25 +-
 block/vvfat.c                                 |  11 +-
 block/vxhs.c                                  |  22 +-
 blockdev.c                                    | 220 +++++++-----------
 blockjob.c                                    |   7 +-
 bootdevice.c                                  |  29 +--
 chardev/char-socket.c                         |   6 +-
 chardev/char.c                                |  18 +-
 crypto/block-luks.c                           |  31 +--
 crypto/secret.c                               |  16 +-
 crypto/tlssession.c                           |   6 +-
 dump/dump.c                                   | 142 +++++------
 dump/win_dump.c                               |  27 +--
 exec.c                                        |  12 +-
 hw/9pfs/9p-local.c                            |   7 +-
 hw/acpi/core.c                                |  17 +-
 hw/acpi/ich9.c                                |  27 +--
 hw/acpi/memory_hotplug.c                      |   6 +-
 hw/arm/allwinner-a10.c                        |  26 +--
 hw/arm/armv7m.c                               |  51 ++--
 hw/arm/bcm2835_peripherals.c                  |  84 +++----
 hw/arm/bcm2836.c                              |  40 ++--
 hw/arm/digic.c                                |  21 +-
 hw/arm/fsl-imx25.c                            |  61 ++---
 hw/arm/fsl-imx31.c                            |  56 ++---
 hw/arm/fsl-imx6.c                             |  80 +++----
 hw/arm/integratorcp.c                         |   6 +-
 hw/arm/msf2-soc.c                             |  21 +-
 hw/arm/nrf51_soc.c                            |  46 ++--
 hw/arm/smmu-common.c                          |   6 +-
 hw/arm/smmuv3.c                               |   6 +-
 hw/arm/stm32f205_soc.c                        |  38 ++-
 hw/arm/tosa.c                                 |   1 +
 hw/arm/xlnx-versal-virt.c                     |   6 +-
 hw/arm/xlnx-zynqmp.c                          |  84 +++----
 hw/audio/intel-hda.c                          |  12 +-
 hw/block/dataplane/xen-block.c                |  16 +-
 hw/block/fdc.c                                |  17 +-
 hw/block/onenand.c                            |   6 +-
 hw/block/pflash_cfi01.c                       |   6 +-
 hw/block/pflash_cfi02.c                       |   6 +-
 hw/block/vhost-user-blk.c                     |   5 +-
 hw/block/virtio-blk.c                         |   6 +-
 hw/block/xen-block.c                          | 114 ++++-----
 hw/char/debugcon.c                            |   6 +-
 hw/char/serial-pci-multi.c                    |   6 +-
 hw/char/serial-pci.c                          |   6 +-
 hw/char/virtio-serial-bus.c                   |   6 +-
 hw/core/bus.c                                 |  14 +-
 hw/core/loader-fit.c                          |   2 +-
 hw/core/machine.c                             |  18 +-
 hw/core/numa.c                                |  48 ++--
 hw/core/qdev-properties-system.c              |  24 +-
 hw/core/qdev-properties.c                     |  78 +++----
 hw/core/qdev.c                                |  36 ++-
 hw/core/sysbus.c                              |   1 +
 hw/cpu/a15mpcore.c                            |   6 +-
 hw/cpu/a9mpcore.c                             |  26 +--
 hw/cpu/arm11mpcore.c                          |  21 +-
 hw/cpu/core.c                                 |  12 +-
 hw/cpu/realview_mpcore.c                      |  11 +-
 hw/display/bcm2835_fb.c                       |   5 +-
 hw/display/qxl.c                              |   6 +-
 hw/display/virtio-gpu-base.c                  |   6 +-
 hw/display/virtio-gpu-pci.c                   |   6 +-
 hw/display/virtio-vga.c                       |   6 +-
 hw/dma/bcm2835_dma.c                          |   5 +-
 hw/dma/xilinx_axidma.c                        |  21 +-
 hw/gpio/aspeed_gpio.c                         |   6 +-
 hw/gpio/bcm2835_gpio.c                        |   9 +-
 hw/i386/kvm/apic.c                            |   2 +
 hw/i386/pc.c                                  | 109 ++++-----
 hw/ide/qdev.c                                 |  15 +-
 hw/input/virtio-input.c                       |  12 +-
 hw/intc/apic_common.c                         |   6 +-
 hw/intc/arm_gic.c                             |   6 +-
 hw/intc/arm_gic_kvm.c                         |  11 +-
 hw/intc/arm_gicv3.c                           |  11 +-
 hw/intc/arm_gicv3_its_kvm.c                   |   6 +-
 hw/intc/arm_gicv3_kvm.c                       |  16 +-
 hw/intc/armv7m_nvic.c                         |  11 +-
 hw/intc/nios2_iic.c                           |   5 +-
 hw/intc/pnv_xive.c                            |  14 +-
 hw/intc/realview_gic.c                        |   6 +-
 hw/intc/s390_flic_kvm.c                       |  10 +-
 hw/intc/spapr_xive.c                          |  11 +-
 hw/intc/spapr_xive_kvm.c                      |  49 ++--
 hw/intc/xics.c                                |  31 +--
 hw/intc/xics_kvm.c                            |  28 +--
 hw/intc/xics_pnv.c                            |   6 +-
 hw/intc/xive.c                                |  23 +-
 hw/ipack/ipack.c                              |   4 +-
 hw/isa/pc87312.c                              |   6 +-
 hw/mem/memory-device.c                        |  19 +-
 hw/mem/nvdimm.c                               |  23 +-
 hw/mem/pc-dimm.c                              |  21 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |  11 +-
 hw/mips/cps.c                                 |  45 ++--
 hw/misc/arm11scu.c                            |   2 +
 hw/misc/bcm2835_mbox.c                        |   5 +-
 hw/misc/bcm2835_property.c                    |   9 +-
 hw/misc/ivshmem.c                             |  33 +--
 hw/misc/macio/macio.c                         |  65 ++----
 hw/misc/mps2-scc.c                            |   2 +
 hw/misc/tmp105.c                              |   6 +-
 hw/misc/tmp421.c                              |   6 +-
 hw/net/dp8393x.c                              |   6 +-
 hw/net/eepro100.c                             |   6 +-
 hw/net/ne2000-isa.c                           |  16 +-
 hw/net/xilinx_axienet.c                       |  21 +-
 hw/nvram/fw_cfg.c                             |  12 +-
 hw/nvram/nrf51_nvm.c                          |   6 +-
 hw/pci-bridge/dec.c                           |   2 +
 hw/pci-bridge/gen_pcie_root_port.c            |   6 +-
 hw/pci-bridge/pci_bridge_dev.c                |  12 +-
 hw/pci-bridge/pci_expander_bridge.c           |   6 +-
 hw/pci-bridge/pcie_pci_bridge.c               |   7 +-
 hw/pci-host/piix.c                            |   6 +-
 hw/pci/pci.c                                  |  17 +-
 hw/pci/pcie.c                                 |   6 +-
 hw/pci/shpc.c                                 |  12 +-
 hw/ppc/e500.c                                 |   6 +-
 hw/ppc/pnv.c                                  |  92 +++-----
 hw/ppc/pnv_core.c                             |  21 +-
 hw/ppc/pnv_lpc.c                              |  22 +-
 hw/ppc/pnv_occ.c                              |   4 +-
 hw/ppc/pnv_psi.c                              |  21 +-
 hw/ppc/spapr.c                                | 124 ++++------
 hw/ppc/spapr_caps.c                           |  50 ++--
 hw/ppc/spapr_cpu_core.c                       |  33 ++-
 hw/ppc/spapr_drc.c                            |  44 ++--
 hw/ppc/spapr_irq.c                            |  95 +++-----
 hw/ppc/spapr_pci.c                            |  88 +++----
 hw/ppc/spapr_vio.c                            |  11 +-
 hw/riscv/riscv_hart.c                         |   7 +-
 hw/riscv/sifive_e.c                           |   6 +-
 hw/riscv/sifive_u.c                           |  10 +-
 hw/s390x/3270-ccw.c                           |  12 +-
 hw/s390x/css-bridge.c                         |   6 +-
 hw/s390x/css.c                                |   6 +-
 hw/s390x/ipl.c                                |  23 +-
 hw/s390x/s390-ccw.c                           |  17 +-
 hw/s390x/s390-pci-bus.c                       |  34 ++-
 hw/s390x/s390-skeys.c                         |   6 +-
 hw/s390x/s390-virtio-ccw.c                    |  10 +-
 hw/s390x/sclp.c                               |  14 +-
 hw/s390x/tod-kvm.c                            |  13 +-
 hw/s390x/virtio-ccw-crypto.c                  |   6 +-
 hw/s390x/virtio-ccw-rng.c                     |   6 +-
 hw/s390x/virtio-ccw.c                         |  12 +-
 hw/scsi/esp-pci.c                             |   6 +-
 hw/scsi/megasas.c                             |  10 +-
 hw/scsi/mptsas.c                              |  12 +-
 hw/scsi/scsi-bus.c                            |  22 +-
 hw/scsi/scsi-disk.c                           |   6 +-
 hw/scsi/vhost-scsi.c                          |  11 +-
 hw/scsi/vhost-user-scsi.c                     |   6 +-
 hw/scsi/virtio-scsi.c                         |   6 +-
 hw/sd/milkymist-memcard.c                     |  10 +-
 hw/sd/sdhci-pci.c                             |   6 +-
 hw/sd/sdhci.c                                 |  20 +-
 hw/sd/ssi-sd.c                                |  13 +-
 hw/smbios/smbios.c                            |  41 ++--
 hw/sparc/sun4m.c                              |  18 +-
 hw/sparc64/sun4u.c                            |   6 +-
 hw/timer/aspeed_timer.c                       |   6 +-
 hw/tpm/tpm_util.c                             |   6 +-
 hw/usb/bus.c                                  |  33 +--
 hw/usb/dev-serial.c                           |   6 +-
 hw/usb/dev-smartcard-reader.c                 |  12 +-
 hw/usb/dev-storage.c                          |  16 +-
 hw/usb/hcd-ohci-pci.c                         |   6 +-
 hw/usb/hcd-ohci.c                             |  12 +-
 hw/usb/hcd-uhci.c                             |   6 +-
 hw/usb/hcd-xhci.c                             |  12 +-
 hw/vfio/ap.c                                  |   9 +-
 hw/vfio/ccw.c                                 |  23 +-
 hw/vfio/pci-quirks.c                          |   6 +-
 hw/vfio/pci.c                                 |  36 ++-
 hw/virtio/virtio-balloon.c                    |  33 ++-
 hw/virtio/virtio-bus.c                        |  16 +-
 hw/virtio/virtio-rng-pci.c                    |   6 +-
 hw/virtio/virtio-rng.c                        |   6 +-
 hw/virtio/virtio.c                            |  17 +-
 hw/watchdog/wdt_aspeed.c                      |   4 +-
 hw/xen/xen-backend.c                          |   6 +-
 hw/xen/xen-bus.c                              |  85 +++----
 hw/xen/xen-host-pci-device.c                  |  26 +--
 hw/xen/xen_pt.c                               |  24 +-
 hw/xen/xen_pt_config_init.c                   |  19 +-
 io/dns-resolver.c                             |   6 +-
 io/net-listener.c                             |   6 +-
 iothread.c                                    |  25 +-
 job.c                                         |   6 +-
 memory.c                                      |  54 ++---
 memory_mapping.c                              |   6 +-
 migration/colo.c                              |  33 +--
 migration/migration.c                         |  35 ++-
 migration/ram.c                               |  12 +-
 migration/rdma.c                              |  11 +-
 migration/socket.c                            |  16 +-
 monitor/hmp-cmds.c                            |   8 +-
 monitor/misc.c                                |   8 +-
 monitor/qmp-cmds.c                            |   6 +-
 net/can/can_host.c                            |   6 +-
 net/dump.c                                    |  14 +-
 net/filter-buffer.c                           |  14 +-
 net/filter.c                                  |   6 +-
 net/net.c                                     |  44 ++--
 net/netmap.c                                  |   6 +-
 net/slirp.c                                   |   6 +-
 net/tap-bsd.c                                 |   1 +
 net/tap-solaris.c                             |   1 +
 net/tap-stub.c                                |   1 +
 net/tap.c                                     |  44 ++--
 qapi/opts-visitor.c                           |   1 +
 qapi/qapi-dealloc-visitor.c                   |   8 +
 qapi/qapi-visit-core.c                        |  53 ++---
 qapi/qmp-dispatch.c                           |   6 +-
 qapi/string-input-visitor.c                   |   6 +-
 qdev-monitor.c                                |  37 ++-
 qga/commands-posix.c                          | 197 ++++++----------
 qga/commands-win32.c                          | 127 ++++------
 qom/object.c                                  | 187 ++++++---------
 qom/object_interfaces.c                       |  26 +--
 qom/qom-qobject.c                             |   6 +-
 replication.c                                 |  24 +-
 scsi/pr-manager-helper.c                      |   6 +-
 stubs/xen-hvm.c                               |   3 +
 target/alpha/cpu.c                            |   6 +-
 target/arm/cpu.c                              |   6 +-
 target/arm/cpu64.c                            |  10 +-
 target/cris/cpu.c                             |   6 +-
 target/hppa/cpu.c                             |   6 +-
 target/i386/cpu.c                             | 107 ++++-----
 target/lm32/cpu.c                             |   6 +-
 target/m68k/cpu.c                             |   6 +-
 target/microblaze/cpu.c                       |   6 +-
 target/mips/cpu.c                             |   6 +-
 target/moxie/cpu.c                            |   6 +-
 target/nios2/cpu.c                            |   6 +-
 target/openrisc/cpu.c                         |   6 +-
 target/ppc/compat.c                           |  18 +-
 target/ppc/kvm.c                              |   6 +-
 target/ppc/translate_init.inc.c               |  23 +-
 target/riscv/cpu.c                            |   6 +-
 target/s390x/cpu.c                            |  25 +-
 target/s390x/kvm-stub.c                       |   1 +
 target/sh4/cpu.c                              |   6 +-
 target/sparc/cpu.c                            |  12 +-
 target/tilegx/cpu.c                           |   6 +-
 target/tricore/cpu.c                          |   6 +-
 target/unicore32/cpu.c                        |   6 +-
 target/xtensa/cpu.c                           |   6 +-
 tests/test-image-locking.c                    |   6 +-
 tests/test-qmp-cmds.c                         |   7 +
 tpm.c                                         |   6 +-
 trace/qmp.c                                   |  12 +-
 ui/input-barrier.c                            |   6 +-
 ui/input.c                                    |  12 +-
 ui/vnc.c                                      |  27 +--
 util/error.c                                  |   8 +-
 util/main-loop.c                              |   4 +-
 util/oslib-posix.c                            |   5 +-
 util/qemu-config.c                            |  27 +--
 util/qemu-option.c                            |  50 ++--
 util/qemu-sockets.c                           |  25 +-
 vl.c                                          |  13 +-
 scripts/coccinelle/auto-propagated-errp.cocci |  82 +++++++
 319 files changed, 2729 insertions(+), 4245 deletions(-)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

-- 
2.21.0


