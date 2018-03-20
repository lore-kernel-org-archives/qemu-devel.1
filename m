Received: from eggs.gnu.org ([2001:4830:134:3::10]:33429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey6WG-0007zM-DS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey6Vy-0007yM-J8
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:56:56 -0400
Date: Tue, 20 Mar 2018 03:54:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521510562-529051-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] qemu: include generated files with <> and not
 ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org, sheepdog@lists.wpkg.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

QEMU coding style at the moment asks for all non-system
include files to be used with #include "foo.h".
However this rule actually does not make sense and
creates issues for when the included file is generated.

In C, include "file" means look in current directory,
then on include search path. Current directory here
means the source file directory.
By comparison include <file> means look on include search path.

As generated files are not in the search directory (unless the build
directory happens to match the source directory), it does not make sense
to include them with "" - doing so is merely more work for preprocessor
and a source or errors if a stale file happens to exist in the source
directory.

This changes include directives for all generated files, across the
tree. The idea is to avoid sending a huge amount of email.  But when
merging, the changes will be split with one commit per file, e.g. for
ease of bisect in case of build failures, and to ease merging.

Note that should some generated files be missed by this tree-wide
refactoring, it isn't a big deal - this merely maintains the status quo,
and this can be addressed by a separate patch on top.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/devel/tracing.txt                    |  6 +++---
 crypto/cipherpriv.h                       |  2 +-
 include/block/block.h                     |  2 +-
 include/block/dirty-bitmap.h              |  2 +-
 include/block/nbd.h                       |  2 +-
 include/chardev/char.h                    |  2 +-
 include/crypto/cipher.h                   |  2 +-
 include/crypto/hash.h                     |  2 +-
 include/crypto/hmac.h                     |  2 +-
 include/crypto/secret.h                   |  2 +-
 include/crypto/tlscreds.h                 |  2 +-
 include/exec/cpu_ldst_template.h          |  2 +-
 include/exec/cpu_ldst_useronly_template.h |  2 +-
 include/exec/helper-gen.h                 |  4 ++--
 include/exec/helper-proto.h               |  2 +-
 include/exec/helper-tcg.h                 |  2 +-
 include/hw/block/block.h                  |  2 +-
 include/hw/block/fdc.h                    |  2 +-
 include/hw/ppc/spapr_drc.h                |  2 +-
 include/hw/qdev-properties.h              |  4 ++--
 include/hw/xen/xen_common.h               |  2 +-
 include/io/dns-resolver.h                 |  2 +-
 include/migration/colo.h                  |  2 +-
 include/migration/failover.h              |  2 +-
 include/migration/global_state.h          |  2 +-
 include/monitor/monitor.h                 |  2 +-
 include/net/filter.h                      |  2 +-
 include/net/net.h                         |  2 +-
 include/qapi/error.h                      |  2 +-
 include/qapi/qmp/qobject.h                |  2 +-
 include/qapi/visitor.h                    |  2 +-
 include/qemu/log.h                        |  2 +-
 include/qemu/osdep.h                      |  4 ++--
 include/qemu/sockets.h                    |  2 +-
 include/qemu/throttle.h                   |  2 +-
 include/qom/cpu.h                         |  2 +-
 include/qom/object.h                      |  2 +-
 include/sysemu/arch_init.h                |  2 +-
 include/sysemu/balloon.h                  |  2 +-
 include/sysemu/dump.h                     |  2 +-
 include/sysemu/hostmem.h                  |  2 +-
 include/sysemu/replay.h                   |  4 ++--
 include/sysemu/sysemu.h                   |  2 +-
 include/sysemu/tpm.h                      |  2 +-
 include/sysemu/watchdog.h                 |  2 +-
 include/sysemu/whpx.h                     |  2 +-
 include/trace-tcg.h                       |  2 +-
 include/ui/console.h                      |  2 +-
 include/ui/input.h                        |  2 +-
 migration/migration.h                     |  2 +-
 migration/ram.h                           |  2 +-
 net/tap_int.h                             |  2 +-
 qemu-options-wrapper.h                    |  2 +-
 replication.h                             |  2 +-
 target/s390x/cpu_models.h                 |  2 +-
 ui/vnc.h                                  |  2 +-
 accel/kvm/kvm-all.c                       |  2 +-
 accel/tcg/cpu-exec.c                      |  2 +-
 accel/tcg/translate-all.c                 |  2 +-
 arch_init.c                               |  2 +-
 audio/alsaaudio.c                         |  2 +-
 audio/ossaudio.c                          |  2 +-
 backends/hostmem.c                        |  2 +-
 balloon.c                                 |  4 ++--
 block.c                                   |  6 +++---
 block/backup.c                            |  2 +-
 block/block-backend.c                     |  4 ++--
 block/commit.c                            |  2 +-
 block/create.c                            |  2 +-
 block/crypto.c                            |  2 +-
 block/dirty-bitmap.c                      |  2 +-
 block/file-posix.c                        |  2 +-
 block/file-win32.c                        |  2 +-
 block/io.c                                |  2 +-
 block/iscsi.c                             |  2 +-
 block/mirror.c                            |  2 +-
 block/nbd.c                               |  2 +-
 block/nfs.c                               |  4 ++--
 block/nvme.c                              |  2 +-
 block/qapi.c                              |  4 ++--
 block/qcow2-cache.c                       |  2 +-
 block/qcow2-cluster.c                     |  2 +-
 block/qcow2.c                             |  6 +++---
 block/qed-l2-cache.c                      |  2 +-
 block/qed-table.c                         |  2 +-
 block/qed.c                               |  2 +-
 block/quorum.c                            |  2 +-
 block/rbd.c                               |  2 +-
 block/sheepdog.c                          |  4 ++--
 block/ssh.c                               |  4 ++--
 block/stream.c                            |  2 +-
 block/throttle-groups.c                   |  2 +-
 block/vxhs.c                              |  2 +-
 block/write-threshold.c                   |  4 ++--
 blockdev-nbd.c                            |  2 +-
 blockdev.c                                |  8 ++++----
 blockjob.c                                |  2 +-
 bsd-user/main.c                           |  2 +-
 chardev/char-ringbuf.c                    |  2 +-
 chardev/char-socket.c                     |  2 +-
 chardev/char.c                            |  2 +-
 chardev/spice.c                           |  2 +-
 chardev/wctablet.c                        |  2 +-
 cpus.c                                    |  4 ++--
 crypto/secret.c                           |  2 +-
 crypto/tlscreds.c                         |  2 +-
 crypto/tlscredsanon.c                     |  2 +-
 crypto/tlscredsx509.c                     |  2 +-
 crypto/tlssession.c                       |  2 +-
 dma-helpers.c                             |  2 +-
 dump.c                                    |  4 ++--
 exec.c                                    |  2 +-
 gdbstub.c                                 |  2 +-
 hmp.c                                     | 20 +++++++++----------
 hw/9pfs/9p.c                              |  2 +-
 hw/acpi/core.c                            |  4 ++--
 hw/acpi/cpu.c                             |  4 ++--
 hw/acpi/memory_hotplug.c                  |  4 ++--
 hw/acpi/tco.c                             |  2 +-
 hw/acpi/vmgenid.c                         |  2 +-
 hw/alpha/pci.c                            |  2 +-
 hw/arm/iotkit.c                           |  2 +-
 hw/arm/virt-acpi-build.c                  |  2 +-
 hw/audio/cs4231.c                         |  2 +-
 hw/audio/milkymist-ac97.c                 |  2 +-
 hw/block/block.c                          |  2 +-
 hw/block/dataplane/virtio-blk.c           |  2 +-
 hw/block/hd-geometry.c                    |  4 ++--
 hw/block/nvme.c                           |  2 +-
 hw/block/virtio-blk.c                     |  2 +-
 hw/block/xen_disk.c                       |  2 +-
 hw/char/cmsdk-apb-uart.c                  |  2 +-
 hw/char/escc.c                            |  2 +-
 hw/char/grlib_apbuart.c                   |  2 +-
 hw/char/lm32_juart.c                      |  2 +-
 hw/char/lm32_uart.c                       |  2 +-
 hw/char/milkymist-uart.c                  |  2 +-
 hw/char/pl011.c                           |  2 +-
 hw/char/virtio-console.c                  |  4 ++--
 hw/char/virtio-serial-bus.c               |  2 +-
 hw/core/machine.c                         |  2 +-
 hw/core/qdev.c                            |  2 +-
 hw/display/cirrus_vga.c                   |  2 +-
 hw/display/g364fb.c                       |  2 +-
 hw/display/jazz_led.c                     |  2 +-
 hw/display/milkymist-tmu2.c               |  2 +-
 hw/display/milkymist-vgafb.c              |  2 +-
 hw/display/qxl-render.c                   |  2 +-
 hw/display/qxl.c                          |  2 +-
 hw/display/sii9022.c                      |  2 +-
 hw/display/vga.c                          |  2 +-
 hw/display/virtio-gpu-3d.c                |  2 +-
 hw/display/virtio-gpu.c                   |  2 +-
 hw/display/vmware_vga.c                   |  2 +-
 hw/display/xenfb.c                        |  2 +-
 hw/dma/i8257.c                            |  2 +-
 hw/dma/rc4030.c                           |  2 +-
 hw/dma/sparc32_dma.c                      |  2 +-
 hw/hppa/pci.c                             |  2 +-
 hw/i386/amd_iommu.c                       |  2 +-
 hw/i386/intel_iommu.c                     |  2 +-
 hw/i386/pc.c                              |  2 +-
 hw/i386/vmport.c                          |  2 +-
 hw/i386/x86-iommu.c                       |  2 +-
 hw/i386/xen/xen-hvm.c                     |  4 ++--
 hw/i386/xen/xen-mapcache.c                |  2 +-
 hw/i386/xen/xen_platform.c                |  2 +-
 hw/i386/xen/xen_pvdevice.c                |  2 +-
 hw/ide/ahci-allwinner.c                   |  2 +-
 hw/ide/ahci.c                             |  2 +-
 hw/ide/atapi.c                            |  2 +-
 hw/ide/cmd646.c                           |  2 +-
 hw/ide/core.c                             |  2 +-
 hw/ide/pci.c                              |  2 +-
 hw/ide/piix.c                             |  2 +-
 hw/ide/sii3112.c                          |  2 +-
 hw/ide/via.c                              |  2 +-
 hw/input/adb-kbd.c                        |  2 +-
 hw/input/adb-mouse.c                      |  2 +-
 hw/input/hid.c                            |  2 +-
 hw/input/milkymist-softusb.c              |  2 +-
 hw/input/ps2.c                            |  2 +-
 hw/input/virtio-input.c                   |  2 +-
 hw/intc/apic.c                            |  2 +-
 hw/intc/apic_common.c                     |  2 +-
 hw/intc/arm_gic.c                         |  2 +-
 hw/intc/arm_gicv3_cpuif.c                 |  2 +-
 hw/intc/arm_gicv3_dist.c                  |  2 +-
 hw/intc/arm_gicv3_redist.c                |  2 +-
 hw/intc/armv7m_nvic.c                     |  2 +-
 hw/intc/aspeed_vic.c                      |  2 +-
 hw/intc/grlib_irqmp.c                     |  2 +-
 hw/intc/heathrow_pic.c                    |  2 +-
 hw/intc/i8259.c                           |  2 +-
 hw/intc/ioapic.c                          |  2 +-
 hw/intc/lm32_pic.c                        |  2 +-
 hw/intc/s390_flic.c                       |  2 +-
 hw/intc/s390_flic_kvm.c                   |  2 +-
 hw/intc/slavio_intctl.c                   |  2 +-
 hw/intc/xics.c                            |  2 +-
 hw/intc/xics_kvm.c                        |  2 +-
 hw/intc/xics_spapr.c                      |  2 +-
 hw/ipmi/ipmi.c                            |  2 +-
 hw/isa/pc87312.c                          |  2 +-
 hw/mem/pc-dimm.c                          |  2 +-
 hw/misc/aspeed_scu.c                      |  2 +-
 hw/misc/aspeed_sdmc.c                     |  2 +-
 hw/misc/eccmemctl.c                       |  2 +-
 hw/misc/imx7_gpr.c                        |  2 +-
 hw/misc/iotkit-secctl.c                   |  2 +-
 hw/misc/macio/cuda.c                      |  2 +-
 hw/misc/milkymist-hpdmc.c                 |  2 +-
 hw/misc/milkymist-pfpu.c                  |  2 +-
 hw/misc/mmio_interface.c                  |  2 +-
 hw/misc/mos6522.c                         |  2 +-
 hw/misc/mps2-fpgaio.c                     |  2 +-
 hw/misc/mps2-scc.c                        |  2 +-
 hw/misc/msf2-sysreg.c                     |  2 +-
 hw/misc/slavio_misc.c                     |  2 +-
 hw/misc/tz-ppc.c                          |  2 +-
 hw/net/e1000e.c                           |  2 +-
 hw/net/e1000e_core.c                      |  2 +-
 hw/net/e1000x_common.c                    |  2 +-
 hw/net/lance.c                            |  2 +-
 hw/net/milkymist-minimac2.c               |  2 +-
 hw/net/mipsnet.c                          |  2 +-
 hw/net/net_rx_pkt.c                       |  2 +-
 hw/net/opencores_eth.c                    |  2 +-
 hw/net/pcnet-pci.c                        |  2 +-
 hw/net/pcnet.c                            |  2 +-
 hw/net/rocker/qmp-norocker.c              |  2 +-
 hw/net/rocker/rocker.c                    |  2 +-
 hw/net/rocker/rocker_fp.c                 |  2 +-
 hw/net/rocker/rocker_of_dpa.c             |  2 +-
 hw/net/spapr_llan.c                       |  2 +-
 hw/net/sungem.c                           |  2 +-
 hw/net/sunhme.c                           |  2 +-
 hw/net/virtio-net.c                       |  2 +-
 hw/nvram/ds1225y.c                        |  2 +-
 hw/nvram/fw_cfg.c                         |  2 +-
 hw/pci-host/grackle.c                     |  2 +-
 hw/pci-host/sabre.c                       |  2 +-
 hw/pci-host/uninorth.c                    |  2 +-
 hw/pci/msix.c                             |  2 +-
 hw/pci/pci-stub.c                         |  2 +-
 hw/pci/pci.c                              |  4 ++--
 hw/pci/pci_host.c                         |  2 +-
 hw/ppc/mac_newworld.c                     |  2 +-
 hw/ppc/ppc.c                              |  2 +-
 hw/ppc/ppc440_pcix.c                      |  2 +-
 hw/ppc/ppc4xx_pci.c                       |  2 +-
 hw/ppc/prep.c                             |  2 +-
 hw/ppc/prep_systemio.c                    |  2 +-
 hw/ppc/rs6000_mc.c                        |  2 +-
 hw/ppc/spapr.c                            |  2 +-
 hw/ppc/spapr_drc.c                        |  2 +-
 hw/ppc/spapr_hcall.c                      |  2 +-
 hw/ppc/spapr_iommu.c                      |  2 +-
 hw/ppc/spapr_ovec.c                       |  2 +-
 hw/ppc/spapr_pci.c                        |  2 +-
 hw/ppc/spapr_rtas.c                       |  2 +-
 hw/ppc/spapr_rtas_ddw.c                   |  2 +-
 hw/ppc/spapr_rtc.c                        |  2 +-
 hw/ppc/spapr_vio.c                        |  2 +-
 hw/rdma/rdma_backend.c                    |  2 +-
 hw/rdma/vmw/pvrdma_main.c                 |  2 +-
 hw/s390x/css.c                            |  2 +-
 hw/s390x/s390-skeys.c                     |  2 +-
 hw/s390x/virtio-ccw.c                     |  2 +-
 hw/scsi/esp-pci.c                         |  2 +-
 hw/scsi/esp.c                             |  2 +-
 hw/scsi/megasas.c                         |  2 +-
 hw/scsi/mptconfig.c                       |  2 +-
 hw/scsi/mptendian.c                       |  2 +-
 hw/scsi/mptsas.c                          |  2 +-
 hw/scsi/scsi-bus.c                        |  2 +-
 hw/scsi/spapr_vscsi.c                     |  2 +-
 hw/scsi/vmw_pvscsi.c                      |  2 +-
 hw/sd/core.c                              |  2 +-
 hw/sd/milkymist-memcard.c                 |  2 +-
 hw/sd/pxa2xx_mmci.c                       |  2 +-
 hw/sd/sd.c                                |  2 +-
 hw/sd/sdhci.c                             |  2 +-
 hw/sparc/leon3.c                          |  2 +-
 hw/sparc/sun4m.c                          |  2 +-
 hw/sparc/sun4m_iommu.c                    |  2 +-
 hw/sparc64/sparc64.c                      |  2 +-
 hw/sparc64/sun4u.c                        |  2 +-
 hw/sparc64/sun4u_iommu.c                  |  2 +-
 hw/timer/armv7m_systick.c                 |  2 +-
 hw/timer/aspeed_timer.c                   |  2 +-
 hw/timer/cmsdk-apb-timer.c                |  2 +-
 hw/timer/grlib_gptimer.c                  |  2 +-
 hw/timer/lm32_timer.c                     |  2 +-
 hw/timer/mc146818rtc.c                    |  4 ++--
 hw/timer/milkymist-sysctl.c               |  2 +-
 hw/timer/slavio_timer.c                   |  2 +-
 hw/timer/xlnx-zynqmp-rtc.c                |  2 +-
 hw/tpm/tpm_crb.c                          |  2 +-
 hw/tpm/tpm_emulator.c                     |  4 ++--
 hw/tpm/tpm_passthrough.c                  |  4 ++--
 hw/tpm/tpm_tis.c                          |  2 +-
 hw/tpm/tpm_util.c                         |  2 +-
 hw/usb/bus.c                              |  2 +-
 hw/usb/combined-packet.c                  |  2 +-
 hw/usb/core.c                             |  2 +-
 hw/usb/desc.c                             |  2 +-
 hw/usb/dev-hub.c                          |  2 +-
 hw/usb/dev-mtp.c                          |  2 +-
 hw/usb/dev-uas.c                          |  2 +-
 hw/usb/hcd-ehci.c                         |  2 +-
 hw/usb/hcd-ohci.c                         |  2 +-
 hw/usb/hcd-uhci.c                         |  2 +-
 hw/usb/hcd-xhci.c                         |  2 +-
 hw/usb/host-libusb.c                      |  2 +-
 hw/vfio/common.c                          |  2 +-
 hw/vfio/pci-quirks.c                      |  2 +-
 hw/vfio/pci.c                             |  2 +-
 hw/vfio/platform.c                        |  2 +-
 hw/vfio/spapr.c                           |  2 +-
 hw/virtio/vhost.c                         |  2 +-
 hw/virtio/virtio-balloon.c                |  4 ++--
 hw/virtio/virtio-rng.c                    |  2 +-
 hw/virtio/virtio.c                        |  2 +-
 hw/watchdog/watchdog.c                    |  4 ++--
 io/channel-buffer.c                       |  2 +-
 io/channel-command.c                      |  2 +-
 io/channel-file.c                         |  2 +-
 io/channel-socket.c                       |  4 ++--
 io/channel-tls.c                          |  2 +-
 io/channel-websock.c                      |  2 +-
 io/dns-resolver.c                         |  2 +-
 io/task.c                                 |  2 +-
 ioport.c                                  |  2 +-
 iothread.c                                |  2 +-
 linux-user/main.c                         |  2 +-
 linux-user/signal.c                       |  2 +-
 memory.c                                  |  2 +-
 migration/channel.c                       |  2 +-
 migration/colo-comm.c                     |  2 +-
 migration/colo-failover.c                 |  4 ++--
 migration/colo.c                          |  4 ++--
 migration/exec.c                          |  2 +-
 migration/fd.c                            |  2 +-
 migration/global_state.c                  |  2 +-
 migration/migration.c                     |  6 +++---
 migration/postcopy-ram.c                  |  2 +-
 migration/qemu-file.c                     |  2 +-
 migration/ram.c                           |  4 ++--
 migration/rdma.c                          |  2 +-
 migration/savevm.c                        |  6 +++---
 migration/socket.c                        |  2 +-
 migration/tls.c                           |  2 +-
 migration/vmstate-types.c                 |  2 +-
 migration/vmstate.c                       |  2 +-
 monitor.c                                 | 12 ++++++------
 nbd/client.c                              |  2 +-
 nbd/common.c                              |  2 +-
 nbd/server.c                              |  2 +-
 net/colo-compare.c                        |  2 +-
 net/colo.c                                |  2 +-
 net/filter-buffer.c                       |  2 +-
 net/filter-mirror.c                       |  2 +-
 net/filter-rewriter.c                     |  2 +-
 net/net.c                                 |  4 ++--
 net/vhost-user.c                          |  4 ++--
 numa.c                                    |  4 ++--
 qapi/qapi-visit-core.c                    |  2 +-
 qdev-monitor.c                            |  2 +-
 qemu-img.c                                |  8 ++++----
 qemu-io.c                                 |  2 +-
 qemu-nbd.c                                |  2 +-
 qga/main.c                                |  2 +-
 qmp.c                                     |  8 ++++----
 qom/cpu.c                                 |  2 +-
 qom/object.c                              |  4 ++--
 replay/replay-input.c                     |  2 +-
 scsi/pr-manager.c                         |  2 +-
 scsi/qemu-pr-helper.c                     |  2 +-
 stubs/tpm.c                               |  2 +-
 stubs/uuid.c                              |  2 +-
 stubs/vmgenid.c                           |  2 +-
 stubs/xen-hvm.c                           |  2 +-
 target/arm/helper.c                       |  2 +-
 target/arm/monitor.c                      |  2 +-
 target/i386/cpu.c                         |  4 ++--
 target/i386/kvm.c                         |  2 +-
 target/mips/translate.c                   |  2 +-
 target/ppc/kvm.c                          |  2 +-
 target/s390x/cpu.c                        |  6 +++---
 target/s390x/cpu_features.c               |  2 +-
 target/s390x/ioinst.c                     |  2 +-
 target/s390x/kvm.c                        |  2 +-
 target/s390x/mmu_helper.c                 |  2 +-
 target/s390x/sigp.c                       |  4 ++--
 target/sparc/int32_helper.c               |  2 +-
 target/sparc/int64_helper.c               |  2 +-
 target/sparc/mmu_helper.c                 |  2 +-
 target/sparc/win_helper.c                 |  2 +-
 tests/qmp-test.c                          |  4 ++--
 tests/tcg/test_path.c                     |  2 +-
 tests/test-char.c                         |  2 +-
 tests/test-qmp-cmds.c                     |  6 +++---
 tests/test-qmp-event.c                    |  2 +-
 tests/test-qobject-input-visitor.c        |  6 +++---
 tpm.c                                     |  2 +-
 trace/control-target.c                    |  2 +-
 trace/control.c                           |  4 ++--
 trace/ftrace.c                            |  2 +-
 trace/qmp.c                               |  2 +-
 ui/console.c                              |  4 ++--
 ui/gtk-egl.c                              |  2 +-
 ui/gtk-gl-area.c                          |  2 +-
 ui/gtk.c                                  |  4 ++--
 ui/input-keymap.c                         | 32 +++++++++++++++----------------
 ui/input-legacy.c                         |  2 +-
 ui/input.c                                |  4 ++--
 ui/keymaps.c                              |  2 +-
 ui/spice-core.c                           |  4 ++--
 ui/spice-display.c                        |  2 +-
 ui/vnc-auth-sasl.c                        |  2 +-
 ui/vnc-auth-vencrypt.c                    |  2 +-
 ui/vnc-ws.c                               |  2 +-
 ui/vnc.c                                  |  6 +++---
 ui/x_keymap.c                             |  2 +-
 util/aio-posix.c                          |  2 +-
 util/async.c                              |  2 +-
 util/buffer.c                             |  2 +-
 util/hbitmap.c                            |  2 +-
 util/lockcnt.c                            |  2 +-
 util/oslib-posix.c                        |  2 +-
 util/oslib-win32.c                        |  2 +-
 util/qemu-config.c                        |  2 +-
 util/qemu-coroutine-lock.c                |  2 +-
 util/qemu-coroutine.c                     |  2 +-
 util/qemu-sockets.c                       |  2 +-
 util/qemu-thread-posix.c                  |  2 +-
 util/qemu-thread-win32.c                  |  2 +-
 util/thread-pool.c                        |  2 +-
 util/vfio-helpers.c                       |  4 ++--
 vl.c                                      | 14 +++++++-------
 scripts/qapi/types.py                     |  6 +++---
 scripts/qapi/visit.py                     |  6 +++---
 scripts/tracetool/backend/ftrace.py       |  2 +-
 scripts/tracetool/backend/log.py          |  2 +-
 trace-events                              |  2 +-
 ui/cocoa.m                                |  4 ++--
 version.rc                                |  2 +-
 448 files changed, 557 insertions(+), 557 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 07abbb3..1372d75 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -52,7 +52,7 @@ In the sub-directory the following files will be automatically generated
 Source files in the sub-directory should #include the local 'trace.h' file,
 without any sub-directory path prefix. eg io/channel-buffer.c would do
 
-  #include "trace.h"
+  #include <trace.h>
 
 To access the 'io/trace.h' file. While it is possible to include a trace.h
 file from outside a source files' own sub-directory, this is discouraged in
@@ -67,7 +67,7 @@ a trace.h in the current directory, vs the top level directory.
 
 Trace events are invoked directly from source code like this:
 
-    #include "trace.h"  /* needed for trace event prototype */
+    #include <trace.h>  /* needed for trace event prototype */
     
     void *qemu_vmalloc(size_t size)
     {
@@ -333,7 +333,7 @@ performed to generate values that are only used as arguments for a trace
 function. In these cases you can use the macro 'TRACE_${EVENT_NAME}_ENABLED' to
 guard such computations and avoid its compilation when the event is disabled:
 
-    #include "trace.h"  /* needed for trace event prototype */
+    #include <trace.h>  /* needed for trace event prototype */
     
     void *qemu_vmalloc(size_t size)
     {
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 0823239..2e910a4 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -15,7 +15,7 @@
 #ifndef QCRYPTO_CIPHERPRIV_H
 #define QCRYPTO_CIPHERPRIV_H
 
-#include "qapi/qapi-types-crypto.h"
+#include <qapi/qapi-types-crypto.h>
 
 typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 
diff --git a/include/block/block.h b/include/block/block.h
index cdec363..dd15de3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -2,7 +2,7 @@
 #define BLOCK_H
 
 #include "block/aio.h"
-#include "qapi/qapi-types-block-core.h"
+#include <qapi/qapi-types-block-core.h>
 #include "block/aio-wait.h"
 #include "qemu/iov.h"
 #include "qemu/coroutine.h"
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 09efec6..0329e80 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -2,7 +2,7 @@
 #define BLOCK_DIRTY_BITMAP_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block-core.h"
+#include <qapi/qapi-types-block-core.h>
 #include "qemu/hbitmap.h"
 
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 2285637..215083f 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -20,7 +20,7 @@
 #ifndef NBD_H
 #define NBD_H
 
-#include "qapi/qapi-types-block.h"
+#include <qapi/qapi-types-block.h>
 #include "io/channel-socket.h"
 #include "crypto/tlscreds.h"
 
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ebf1e0b..1d29d31 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_CHAR_H
 #define QEMU_CHAR_H
 
-#include "qapi/qapi-types-char.h"
+#include <qapi/qapi-types-char.h>
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index bce2d4c..8ff860e 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_CIPHER_H
 #define QCRYPTO_CIPHER_H
 
-#include "qapi/qapi-types-crypto.h"
+#include <qapi/qapi-types-crypto.h>
 
 typedef struct QCryptoCipher QCryptoCipher;
 
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 077ac7b..4bb2103 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_HASH_H
 #define QCRYPTO_HASH_H
 
-#include "qapi/qapi-types-crypto.h"
+#include <qapi/qapi-types-crypto.h>
 
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index aa3c97a..51ca1ec 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -12,7 +12,7 @@
 #ifndef QCRYPTO_HMAC_H
 #define QCRYPTO_HMAC_H
 
-#include "qapi/qapi-types-crypto.h"
+#include <qapi/qapi-types-crypto.h>
 
 typedef struct QCryptoHmac QCryptoHmac;
 struct QCryptoHmac {
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index edd0e13..94e6f98 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_SECRET_H
 #define QCRYPTO_SECRET_H
 
-#include "qapi/qapi-types-crypto.h"
+#include <qapi/qapi-types-crypto.h>
 #include "qom/object.h"
 
 #define TYPE_QCRYPTO_SECRET "secret"
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index 6b011e1..ebeca42 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_TLSCREDS_H
 #define QCRYPTO_TLSCREDS_H
 
-#include "qapi/qapi-types-crypto.h"
+#include <qapi/qapi-types-crypto.h>
 #include "qom/object.h"
 
 #ifdef CONFIG_GNUTLS
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 4db2302..66f45a2 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -25,7 +25,7 @@
  */
 
 #if !defined(SOFTMMU_CODE_ACCESS)
-#include "trace-root.h"
+#include <trace-root.h>
 #endif
 
 #include "trace/mem.h"
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index c168f31..6dd855a 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -24,7 +24,7 @@
  */
 
 #if !defined(CODE_ACCESS)
-#include "trace-root.h"
+#include <trace-root.h>
 #endif
 
 #include "trace/mem.h"
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 22381a1..f1e9dd9 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -67,8 +67,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 }
 
 #include "helper.h"
-#include "trace/generated-helpers.h"
-#include "trace/generated-helpers-wrappers.h"
+#include <trace/generated-helpers.h>
+#include <trace/generated-helpers-wrappers.h>
 #include "tcg-runtime.h"
 
 #undef DEF_HELPER_FLAGS_0
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 74943ed..e96398e 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -31,7 +31,7 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5), dh_ctype(t6));
 
 #include "helper.h"
-#include "trace/generated-helpers.h"
+#include <trace/generated-helpers.h>
 #include "tcg-runtime.h"
 
 #undef DEF_HELPER_FLAGS_0
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index b3bdb0c..5592810 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -46,7 +46,7 @@
     | dh_sizemask(t5, 5) | dh_sizemask(t6, 6) },
 
 #include "helper.h"
-#include "trace/generated-helpers.h"
+#include <trace/generated-helpers.h>
 #include "tcg-runtime.h"
 
 #undef str
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d4f4dff..e85b5b8 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -12,7 +12,7 @@
 #define HW_BLOCK_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block-core.h"
+#include <qapi/qapi-types-block-core.h>
 
 /* Configuration */
 
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 3b813c7..918f96e 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -2,7 +2,7 @@
 #define HW_FDC_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block.h"
+#include <qapi/qapi-types-block.h>
 
 /* fdc.c */
 #define MAX_FD 2
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f6ff32e..4ffc665 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -14,7 +14,7 @@
 #define HW_SPAPR_DRC_H
 
 #include <libfdt.h>
-#include "qapi/qapi-types-run-state.h"
+#include <qapi/qapi-types-run-state.h>
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev.h"
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b2ad8e9..b42b581 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -1,8 +1,8 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
-#include "qapi/qapi-types-block.h"
-#include "qapi/qapi-types-misc.h"
+#include <qapi/qapi-types-block.h>
+#include <qapi/qapi-types-misc.h>
 #include "hw/qdev-core.h"
 
 /*** qdev-properties.c ***/
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 64a978e..0446b77 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -18,7 +18,7 @@
 #include "hw/xen/xen.h"
 #include "hw/pci/pci.h"
 #include "qemu/queue.h"
-#include "hw/xen/trace.h"
+#include <hw/xen/trace.h>
 
 extern xc_interface *xen_xc;
 
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 1a16218..e28d305 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -22,7 +22,7 @@
 #define QIO_DNS_RESOLVER_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-sockets.h"
+#include <qapi/qapi-types-sockets.h>
 #include "qom/object.h"
 #include "io/task.h"
 
diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2fe48ad..dea2a67 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -14,7 +14,7 @@
 #define QEMU_COLO_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include <qapi/qapi-types-migration.h>
 
 void colo_info_init(void);
 
diff --git a/include/migration/failover.h b/include/migration/failover.h
index 4c37218..7be1006 100644
--- a/include/migration/failover.h
+++ b/include/migration/failover.h
@@ -14,7 +14,7 @@
 #define QEMU_FAILOVER_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include <qapi/qapi-types-migration.h>
 
 void failover_init_state(void);
 FailoverStatus failover_set_state(FailoverStatus old_state,
diff --git a/include/migration/global_state.h b/include/migration/global_state.h
index fd22dd3..1b21e52 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_GLOBAL_STATE_H
 #define QEMU_MIGRATION_GLOBAL_STATE_H
 
-#include "qapi/qapi-types-run-state.h"
+#include <qapi/qapi-types-run-state.h>
 #include "sysemu/sysemu.h"
 
 void register_global_state(void);
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d1024d4..ed7b259 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,7 +3,7 @@
 
 #include "qemu-common.h"
 #include "block/block.h"
-#include "qapi/qapi-types-misc.h"
+#include <qapi/qapi-types-misc.h>
 #include "qemu/readline.h"
 
 extern Monitor *cur_mon;
diff --git a/include/net/filter.h b/include/net/filter.h
index 435acd6..9f9447d 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_NET_FILTER_H
 #define QEMU_NET_FILTER_H
 
-#include "qapi/qapi-types-net.h"
+#include <qapi/qapi-types-net.h>
 #include "qom/object.h"
 #include "qemu-common.h"
 #include "net/queue.h"
diff --git a/include/net/net.h b/include/net/net.h
index a943e96..3f3e1d2 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -2,7 +2,7 @@
 #define QEMU_NET_H
 
 #include "qemu/queue.h"
-#include "qapi/qapi-types-net.h"
+#include <qapi/qapi-types-net.h>
 #include "net/queue.h"
 #include "migration/vmstate.h"
 
diff --git a/include/qapi/error.h b/include/qapi/error.h
index bcb86a7..9e5ff82 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -115,7 +115,7 @@
 #ifndef ERROR_H
 #define ERROR_H
 
-#include "qapi/qapi-types-common.h"
+#include <qapi/qapi-types-common.h>
 
 /*
  * Overall category of an error.
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 012439a..ff1bbe6 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -32,7 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H
 
-#include "qapi/qapi-builtin-types.h"
+#include <qapi/qapi-builtin-types.h>
 
 struct QObject {
     QType type;
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 5b2ed3f..9e17280 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -15,7 +15,7 @@
 #ifndef QAPI_VISITOR_H
 #define QAPI_VISITOR_H
 
-#include "qapi/qapi-builtin-types.h"
+#include <qapi/qapi-builtin-types.h>
 
 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
diff --git a/include/qemu/log.h b/include/qemu/log.h
index ff92a8b..604292b 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -2,7 +2,7 @@
 #define QEMU_LOG_H
 
 /* A small part of this API is split into its own header */
-#include "qemu/log-for-trace.h"
+#include <qemu/log-for-trace.h>
 
 /* Private global variable, don't use */
 extern FILE *qemu_logfile;
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4165806..7332452 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -27,9 +27,9 @@
 #ifndef QEMU_OSDEP_H
 #define QEMU_OSDEP_H
 
-#include "config-host.h"
+#include <config-host.h>
 #ifdef NEED_CPU_H
-#include "config-target.h"
+#include <config-target.h>
 #else
 #include "exec/poison.h"
 #endif
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index e88d4c3..9a5e29e 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -9,7 +9,7 @@ int inet_aton(const char *cp, struct in_addr *ia);
 
 #endif /* !_WIN32 */
 
-#include "qapi/qapi-types-sockets.h"
+#include <qapi/qapi-types-sockets.h>
 
 /* misc helpers */
 int qemu_socket(int domain, int type, int protocol);
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index abeb886..16ae14e 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -26,7 +26,7 @@
 #define THROTTLE_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block-core.h"
+#include <qapi/qapi-types-block-core.h>
 #include "qemu/timer.h"
 
 #define THROTTLE_VALUE_MAX 1000000000000000LL
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc6d495..229f214 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -24,7 +24,7 @@
 #include "disas/bfd.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
-#include "qapi/qapi-types-run-state.h"
+#include <qapi/qapi-types-run-state.h>
 #include "qemu/bitmap.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
diff --git a/include/qom/object.h b/include/qom/object.h
index 4f07090..52d7e55 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_OBJECT_H
 #define QEMU_OBJECT_H
 
-#include "qapi/qapi-builtin-types.h"
+#include <qapi/qapi-builtin-types.h>
 #include "qemu/queue.h"
 
 struct TypeImpl;
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 32abdfe..763ff16 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
 
-#include "qapi/qapi-types-misc.h"
+#include <qapi/qapi-types-misc.h>
 
 enum {
     QEMU_ARCH_ALL = -1,
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index 66543ae..65ed3d0 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
 
-#include "qapi/qapi-types-misc.h"
+#include <qapi/qapi-types-misc.h>
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index d824bc0..a8dff2e 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -14,7 +14,7 @@
 #ifndef DUMP_H
 #define DUMP_H
 
-#include "qapi/qapi-types-misc.h"
+#include <qapi/qapi-types-misc.h>
 
 #define MAKEDUMPFILE_SIGNATURE      "makedumpfile"
 #define MAX_SIZE_MDF_HEADER         (4096) /* max size of makedumpfile_header */
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 47bc984..cccd2fa 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -14,7 +14,7 @@
 #define SYSEMU_HOSTMEM_H
 
 #include "sysemu/sysemu.h" /* for MAX_NODES */
-#include "qapi/qapi-types-misc.h"
+#include <qapi/qapi-types-misc.h>
 #include "qom/object.h"
 #include "exec/memory.h"
 #include "qemu/bitmap.h"
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index c0204e6..760e2d8 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -13,8 +13,8 @@
  */
 
 #include "sysemu.h"
-#include "qapi/qapi-types-misc.h"
-#include "qapi/qapi-types-ui.h"
+#include <qapi/qapi-types-misc.h>
+#include <qapi/qapi-types-ui.h>
 
 /* replay clock kinds */
 enum ReplayClockKind {
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 356bfdc..51c5997 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -2,7 +2,7 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */
 
-#include "qapi/qapi-types-run-state.h"
+#include <qapi/qapi-types-run-state.h>
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "qemu/notify.h"
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 9ae1ab6..def08d8 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H
 
-#include "qapi/qapi-types-tpm.h"
+#include <qapi/qapi-types-tpm.h>
 #include "qom/object.h"
 
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
diff --git a/include/sysemu/watchdog.h b/include/sysemu/watchdog.h
index a08d163..2d019a1 100644
--- a/include/sysemu/watchdog.h
+++ b/include/sysemu/watchdog.h
@@ -23,7 +23,7 @@
 #define QEMU_WATCHDOG_H
 
 #include "qemu/queue.h"
-#include "qapi/qapi-types-run-state.h"
+#include <qapi/qapi-types-run-state.h>
 
 struct WatchdogTimerModel {
     QLIST_ENTRY(WatchdogTimerModel) entry;
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index 89592ae..8bcc22d 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
 
-#include "config-host.h"
+#include <config-host.h>
 #include "qemu-common.h"
 
 int whpx_init_vcpu(CPUState *cpu);
diff --git a/include/trace-tcg.h b/include/trace-tcg.h
index da68608..23202d5 100644
--- a/include/trace-tcg.h
+++ b/include/trace-tcg.h
@@ -1,6 +1,6 @@
 #ifndef TRACE_TCG_H
 #define TRACE_TCG_H
 
-#include "trace/generated-tcg-tracers.h"
+#include <trace/generated-tcg-tracers.h>
 
 #endif /* TRACE_TCG_H */
diff --git a/include/ui/console.h b/include/ui/console.h
index 5fca9af..71a7388 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,7 +5,7 @@
 #include "qom/object.h"
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-types-ui.h"
+#include <qapi/qapi-types-ui.h>
 
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
diff --git a/include/ui/input.h b/include/ui/input.h
index 16395ab..31a9205 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -1,7 +1,7 @@
 #ifndef INPUT_H
 #define INPUT_H
 
-#include "qapi/qapi-types-ui.h"
+#include <qapi/qapi-types-ui.h>
 
 #define INPUT_EVENT_MASK_KEY   (1<<INPUT_EVENT_KIND_KEY)
 #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
diff --git a/migration/migration.h b/migration/migration.h
index 08c5d2d..e97fa5a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -15,7 +15,7 @@
 #define QEMU_MIGRATION_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include <qapi/qapi-types-migration.h>
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
diff --git a/migration/ram.h b/migration/ram.h
index 53f0021..2cd955b 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -30,7 +30,7 @@
 #define QEMU_MIGRATION_RAM_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include <qapi/qapi-types-migration.h>
 #include "exec/cpu-common.h"
 
 extern MigrationStats ram_counters;
diff --git a/net/tap_int.h b/net/tap_int.h
index 9f931d5..17753d7 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,7 +27,7 @@
 #define NET_TAP_INT_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-net.h"
+#include <qapi/qapi-types-net.h>
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 13bfea0..ec4cb8c 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -29,7 +29,7 @@
 #error "qemu-options-wrapper.h included with no option defined"
 #endif
 
-#include "qemu-options.def"
+#include <qemu-options.def>
 
 #undef DEF
 #undef DEFHEADING
diff --git a/replication.h b/replication.h
index 8faefe0..764bb9e 100644
--- a/replication.h
+++ b/replication.h
@@ -15,7 +15,7 @@
 #ifndef REPLICATION_H
 #define REPLICATION_H
 
-#include "qapi/qapi-types-block-core.h"
+#include <qapi/qapi-types-block-core.h>
 #include "qemu/queue.h"
 
 typedef struct ReplicationOps ReplicationOps;
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 11cf538..0a3c43f 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -14,7 +14,7 @@
 #define TARGET_S390X_CPU_MODELS_H
 
 #include "cpu_features.h"
-#include "gen-features.h"
+#include <gen-features.h>
 #include "qom/cpu.h"
 
 /* static CPU definition */
diff --git a/ui/vnc.h b/ui/vnc.h
index 7b29def..02f67ba 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -28,7 +28,7 @@
 #define QEMU_VNC_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-ui.h"
+#include <qapi/qapi-types-ui.h>
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "ui/console.h"
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b91fcb7..692a3b0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,7 +36,7 @@
 #include "exec/ram_addr.h"
 #include "exec/address-spaces.h"
 #include "qemu/event_notifier.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/irq.h"
 
 #include "hw/boards.h"
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 280200f..b7d9a37 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include <trace.h>
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 67795cd..8db385a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
-#include "trace.h"
+#include <trace.h>
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/arch_init.c b/arch_init.c
index 6ee0747..86743f5 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -28,7 +28,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #include "hw/audio/soundhw.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 362a227..385487a 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/main-loop.h"
 #include "audio.h"
-#include "trace.h"
+#include <trace.h>
 
 #if QEMU_GNUC_PREREQ(4, 3)
 #pragma GCC diagnostic ignored "-Waddress"
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 6c69622..34ab6eb 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/host-utils.h"
 #include "audio.h"
-#include "trace.h"
+#include <trace.h>
 
 #define AUDIO_CAP "oss"
 #include "audio_int.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index f610936..fad0dad 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -14,7 +14,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-builtin-visit.h"
+#include <qapi/qapi-builtin-visit.h>
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
diff --git a/balloon.c b/balloon.c
index 6bf0a96..af6952f 100644
--- a/balloon.c
+++ b/balloon.c
@@ -29,9 +29,9 @@
 #include "exec/cpu-common.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
-#include "trace-root.h"
+#include <trace-root.h>
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qerror.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/block.c b/block.c
index 75a9fd4..ad550c7 100644
--- a/block.c
+++ b/block.c
@@ -23,19 +23,19 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/trace.h"
+#include <block/trace.h>
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/nbd.h"
 #include "qemu/error-report.h"
-#include "module_block.h"
+#include <module_block.h>
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
diff --git a/block/backup.c b/block/backup.c
index 4a16a37..43350e9 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "trace.h"
+#include <trace.h>
 #include "block/block.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
diff --git a/block/block-backend.c b/block/block-backend.c
index f2e0a85..910ea31 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -18,10 +18,10 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block.h"
+#include <qapi/qapi-events-block.h>
 #include "qemu/id.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include <trace.h>
 #include "migration/misc.h"
 
 /* Number of coroutines to reserve per attached device model */
diff --git a/block/commit.c b/block/commit.c
index 1943c9c..4fb7960 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
diff --git a/block/create.c b/block/create.c
index 8bd8a03..26db81b 100644
--- a/block/create.c
+++ b/block/create.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
-#include "qapi/qapi-commands-block-core.h"
+#include <qapi/qapi-commands-block-core.h>
 #include "qapi/error.h"
 
 typedef struct BlockdevCreateCo {
diff --git a/block/crypto.c b/block/crypto.c
index e6095e7..b73be3e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -24,7 +24,7 @@
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-visit-crypto.h"
+#include <qapi/qapi-visit-crypto.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 909f051..01b18cc 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/block_int.h"
 #include "block/blockjob.h"
 
diff --git a/block/file-posix.c b/block/file-posix.c
index d7fb772..197d904 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -29,7 +29,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
diff --git a/block/file-win32.c b/block/file-win32.c
index 2e2f746..bf6a314 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -29,7 +29,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/raw-aio.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/io.c b/block/io.c
index 2b09c65..ff77c7d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/block-backend.h"
 #include "block/aio-wait.h"
 #include "block/blockjob.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index a82170f..f133962 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -38,7 +38,7 @@
 #include "qemu/option.h"
 #include "qemu/uuid.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/block/mirror.c b/block/mirror.c
index f5bf620..781db39 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
diff --git a/block/nbd.c b/block/nbd.c
index d4e4172..4f4c6e7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -33,7 +33,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qapi/qapi-visit-sockets.h"
+#include <qapi/qapi-visit-sockets.h>
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/nfs.c b/block/nfs.c
index 2577df4..261c6cd 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -29,13 +29,13 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/iov.h"
 #include "qemu/option.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/block/nvme.c b/block/nvme.c
index 8bca57a..f7c170d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -21,7 +21,7 @@
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
 #include "block/block_int.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "block/nvme.h"
 
diff --git a/block/qapi.c b/block/qapi.c
index 4c9923d..e479276 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -28,9 +28,9 @@
 #include "block/throttle-groups.h"
 #include "block/write-threshold.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
+#include <qapi/qapi-commands-block-core.h>
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d9dafa3..af1fcee 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -26,7 +26,7 @@
 #include "block/block_int.h"
 #include "qemu-common.h"
 #include "qcow2.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct Qcow2CachedTable {
     int64_t  offset;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1aee726..cb33eea 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "block/qcow2.h"
 #include "qemu/bswap.h"
-#include "trace.h"
+#include <trace.h>
 
 int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 7472af6..7a3e8ce 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -30,15 +30,15 @@
 #include "block/qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block-core.h"
+#include <qapi/qapi-events-block-core.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 #include "block/crypto.h"
 
 /*
diff --git a/block/qed-l2-cache.c b/block/qed-l2-cache.c
index b548362..01e211a 100644
--- a/block/qed-l2-cache.c
+++ b/block/qed-l2-cache.c
@@ -51,7 +51,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "qed.h"
 
 /* Each L2 holds 2GB so this let's us fully cache a 100GB disk */
diff --git a/block/qed-table.c b/block/qed-table.c
index 7df5680..e373e28 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "qed.h"
 #include "qemu/bswap.h"
diff --git a/block/qed.c b/block/qed.c
index 5e6a6bf..df987f4 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -17,7 +17,7 @@
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include <trace.h>
 #include "qed.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/quorum.c b/block/quorum.c
index 14333c1..6054f3c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -18,7 +18,7 @@
 #include "qemu/option.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block.h"
+#include <qapi/qapi-events-block.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
diff --git a/block/rbd.c b/block/rbd.c
index 294ed07..246f068 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -25,7 +25,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 
 /*
  * When specifying the image filename use:
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 8680b29..2e51e7f 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -14,8 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-sockets.h>
+#include <qapi/qapi-visit-block-core.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/block/ssh.c b/block/ssh.c
index ab3acf0..396ac4a 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -34,8 +34,8 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-sockets.h>
+#include <qapi/qapi-visit-block-core.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/block/stream.c b/block/stream.c
index 499cdac..7817b12 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 36cc043..71240e7 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -30,7 +30,7 @@
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 
diff --git a/block/vxhs.c b/block/vxhs.c
index 75cc6c8..e47e7c0 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -15,7 +15,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/uri.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 1d48fc2..f86b39d 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -16,8 +16,8 @@
 #include "block/write-threshold.h"
 #include "qemu/notify.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-events-block-core.h"
+#include <qapi/qapi-commands-block-core.h>
+#include <qapi/qapi-events-block-core.h>
 
 uint64_t bdrv_write_threshold_get(const BlockDriverState *bs)
 {
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 65a8473..ede5abc 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -14,7 +14,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block.h"
+#include <qapi/qapi-commands-block.h>
 #include "sysemu/sysemu.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
diff --git a/blockdev.c b/blockdev.c
index 1fbfd3a..e22113a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,9 +40,9 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "qapi/qapi-commands-block.h"
-#include "qapi/qapi-commands-transaction.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-commands-block.h>
+#include <qapi/qapi-commands-transaction.h>
+#include <qapi/qapi-visit-block-core.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
@@ -53,7 +53,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/iothread.h"
 #include "block/block_int.h"
-#include "block/trace.h"
+#include <block/trace.h>
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
diff --git a/blockjob.c b/blockjob.c
index 801d29d..a03bd92 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block-core.h"
+#include <qapi/qapi-events-block-core.h>
 #include "qapi/qmp/qerror.h"
 #include "qemu/coroutine.h"
 #include "qemu/id.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index efef5ff..e743a19 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 #include <machine/trap.h>
 
 #include "qapi/error.h"
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 87832e2..397cd68 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-char.h"
+#include <qapi/qapi-commands-char.h>
 #include "qemu/base64.h"
 #include "qemu/option.h"
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a220803..6dcf4bd 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,7 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-sockets.h"
+#include <qapi/qapi-visit-sockets.h>
 
 #include "chardev/char-io.h"
 
diff --git a/chardev/char.c b/chardev/char.c
index 5d7b079..d6201ff 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -30,7 +30,7 @@
 #include "qemu/error-report.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-char.h"
+#include <qapi/qapi-commands-char.h>
 #include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
diff --git a/chardev/spice.c b/chardev/spice.c
index e66e3ad..eb9ad77 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "ui/qemu-spice.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 969d014..4cf594c 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -31,7 +31,7 @@
 #include "chardev/char-serial.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #define WC_OUTPUT_BUF_MAX_LEN 512
diff --git a/cpus.c b/cpus.c
index c652da8..2d000fa 100644
--- a/cpus.c
+++ b/cpus.c
@@ -27,8 +27,8 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-run-state.h"
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-events-run-state.h>
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
diff --git a/crypto/secret.c b/crypto/secret.c
index 388abd7..0c7034b 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
-#include "trace.h"
+#include <trace.h>
 
 
 static void
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 3cd4103..2643c72 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/tlscredspriv.h"
-#include "trace.h"
+#include <trace.h>
 
 #define DH_BITS 2048
 
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1464220..e946708 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -23,7 +23,7 @@
 #include "crypto/tlscredspriv.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #ifdef CONFIG_GNUTLS
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 50eb54f..a32571a 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -24,7 +24,7 @@
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #ifdef CONFIG_GNUTLS
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 96a02de..359050e 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -24,7 +24,7 @@
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
 #include "qemu/acl.h"
-#include "trace.h"
+#include <trace.h>
 
 #ifdef CONFIG_GNUTLS
 
diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d..0c3e1db 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace-root.h"
+#include <trace-root.h>
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 
diff --git a/dump.c b/dump.c
index 097e60b..3f3aef4 100644
--- a/dump.c
+++ b/dump.c
@@ -23,8 +23,8 @@
 #include "sysemu/memory_mapping.h"
 #include "sysemu/cpus.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-misc.h"
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-events-misc.h>
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "hw/misc/vmcoreinfo.h"
diff --git a/exec.c b/exec.c
index a9181e6..07ee7e6 100644
--- a/exec.c
+++ b/exec.c
@@ -46,7 +46,7 @@
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
+#include <trace-root.h>
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
diff --git a/gdbstub.c b/gdbstub.c
index f1d5148..4d1bfd8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include <trace-root.h>
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
diff --git a/hmp.c b/hmp.c
index a277517..461436b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -28,16 +28,16 @@
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-builtin-visit.h"
-#include "qapi/qapi-commands-block.h"
-#include "qapi/qapi-commands-char.h"
-#include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-net.h"
-#include "qapi/qapi-commands-rocker.h"
-#include "qapi/qapi-commands-run-state.h"
-#include "qapi/qapi-commands-tpm.h"
-#include "qapi/qapi-commands-ui.h"
+#include <qapi/qapi-builtin-visit.h>
+#include <qapi/qapi-commands-block.h>
+#include <qapi/qapi-commands-char.h>
+#include <qapi/qapi-commands-migration.h>
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-commands-net.h>
+#include <qapi/qapi-commands-rocker.h>
+#include <qapi/qapi-commands-run-state.h>
+#include <qapi/qapi-commands-tpm.h>
+#include <qapi/qapi-commands-ui.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48fa48e..6337ea7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -22,7 +22,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "9p-xattr.h"
 #include "coth.h"
-#include "trace.h"
+#include <trace.h>
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
 
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index b8d3901..0a60445 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -27,8 +27,8 @@
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-events-run-state.h"
-#include "qapi/qapi-visit-misc.h"
+#include <qapi/qapi-events-run-state.h>
+#include <qapi/qapi-visit-misc.h>
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595e..9e5dabb 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -2,8 +2,8 @@
 #include "hw/boards.h"
 #include "hw/acpi/cpu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
-#include "trace.h"
+#include <qapi/qapi-events-misc.h>
+#include <trace.h>
 #include "sysemu/numa.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 0ff1712..b1c0934 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -4,9 +4,9 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include <qapi/qapi-events-misc.h>
 
 #define MEMORY_SLOTS_NUMBER          "MDNR"
 #define MEMORY_HOTPLUG_IO_REGION     "HPMR"
diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index a914396..9f3bdcd 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -12,7 +12,7 @@
 #include "hw/i386/ich9.h"
 
 #include "hw/acpi/tco.h"
-#include "trace.h"
+#include <trace.h>
 
 //#define DEBUG
 
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index d78b579..b84c109 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637..b6e7333 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -11,7 +11,7 @@
 #include "alpha_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 
 /* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index c5f0a5b..1d9e2f9 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/arm/iotkit.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c7c6a57..4c34884 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/bitmap.h"
-#include "trace.h"
+#include <trace.h>
 #include "qom/cpu.h"
 #include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 30690f9..7e69d44 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 
 /*
  * In addition to Crystal CS4231 there is a DMA controller on Sparc.
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index bc8db71..d98b862 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "audio/audio.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/block/block.c b/hw/block/block.c
index b91e2b6..9bd7d8f 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -12,7 +12,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-types-block.h"
+#include <qapi/qapi-types-block.h>
 #include "qemu/error-report.h"
 
 void blkconf_serial(BlockConf *conf, char **serial)
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 101f32c..ab2b088 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/iov.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 79384a2..2c732ee 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -32,10 +32,10 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qapi-types-block.h"
+#include <qapi/qapi-types-block.h>
 #include "qemu/bswap.h"
 #include "hw/block/block.h"
-#include "trace.h"
+#include <trace.h>
 
 struct partition {
         uint8_t boot_ind;           /* 0x80 - active */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 85d2406..f48b1b9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -35,7 +35,7 @@
 #include "sysemu/block-backend.h"
 
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 #include "nvme.h"
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b1532e4..4f6dda3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -16,7 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index f74fcd4..5fcd119 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -32,7 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "trace.h"
+#include <trace.h>
 
 /* ------------------------------------------------------------- */
 
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 1ad1e14..b252129 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f8..bb7dd14 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -27,7 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/escc.h"
 #include "ui/console.h"
-#include "trace.h"
+#include <trace.h>
 
 /*
  * Chipset docs:
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index bac11be..c27c344 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 
-#include "trace.h"
+#include <trace.h>
 
 #define UART_REG_SIZE 20     /* Size of memory mapped registers */
 
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index d75c835..ca59c87 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "chardev/char-fe.h"
 
 #include "hw/char/lm32_juart.h"
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index c4a3b9b..91b175a 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 548ee27..19e4072 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 2aa277f..950adc5 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -11,7 +11,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_PL011 "pl011"
 #define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 679a824..b738a71 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -13,10 +13,10 @@
 #include "qemu/osdep.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-char.h"
+#include <qapi/qapi-events-char.h>
 
 #define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
 #define VIRTIO_CONSOLE(obj) \
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..0fffd55 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -25,7 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-access.h"
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5e2bbcd..d998c0c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
+#include <qapi/qapi-visit-common.h>
 #include "qapi/visitor.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f6f9247..63561a4 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -29,7 +29,7 @@
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include <qapi/qapi-events-misc.h>
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 138ae96..bcbffa5 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -28,7 +28,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 3d75394..3b269d5 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 
 typedef struct G364State {
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 3c97d56..3fd5d25 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 
 typedef enum {
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 3ce44fd..4c35c6c 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 177fdac..150aab8 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8..6717f74 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qxl.h"
-#include "trace.h"
+#include <trace.h>
 
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
 {
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index a71714c..86fbacc 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -28,7 +28,7 @@
 #include "qemu/atomic.h"
 #include "sysemu/sysemu.h"
 #include "migration/blocker.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "qxl.h"
 
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index eaf11a6..62d6645 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -17,7 +17,7 @@
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c-ddc.h"
-#include "trace.h"
+#include <trace.h>
 
 #define SII9022_SYS_CTRL_DATA 0x1a
 #define SII9022_SYS_CTRL_PWR_DWN 0x10
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 7218133..295d62d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -31,7 +31,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "hw/xen/xen.h"
-#include "trace.h"
+#include <trace.h>
 
 //#define DEBUG_VGA_MEM
 //#define DEBUG_VGA_REG
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 3558f38..9c24f4b 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2dd3c34..d4f0792 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -15,7 +15,7 @@
 #include "qemu-common.h"
 #include "qemu/iov.h"
 #include "ui/console.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bd3e8b3..66814b4 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
-#include "trace.h"
+#include <trace.h>
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
 
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index f5afcc0..2e89a6e 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -36,7 +36,7 @@
 #include <xen/io/kbdif.h>
 #include <xen/io/protocols.h>
 
-#include "trace.h"
+#include <trace.h>
 
 #ifndef BTN_LEFT
 #define BTN_LEFT 0x110 /* from <linux/input.h> */
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bd23e89..316beae 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -26,7 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/isa/i8257.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include <trace.h>
 
 #define I8257(obj) \
     OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5d4833e..02c2924 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -29,7 +29,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 
 /********************************************************/
 /* rc4030 emulation                                     */
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 7b00a27..9ef6c23 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -32,7 +32,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 
 /*
  * This is the DMA controller part of chip STP2000 (Master I/O), also
diff --git a/hw/hppa/pci.c b/hw/hppa/pci.c
index 7664202..268ed95 100644
--- a/hw/hppa/pci.c
+++ b/hw/hppa/pci.c
@@ -8,7 +8,7 @@
 #include "hppa_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 
 /* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 63d46ff..60418f3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -26,7 +26,7 @@
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fb31de9..7409bf6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,7 +35,7 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm_i386.h"
-#include "trace.h"
+#include <trace.h>
 
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 35fcb6e..65d78e4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -67,7 +67,7 @@
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
+#include <qapi/qapi-visit-common.h>
 #include "qapi/visitor.h"
 #include "qom/cpu.h"
 #include "hw/nmi.h"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 116aa09..8c101c7 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -28,7 +28,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define VMPORT_CMD_GETVERSION 0x0a
 #define VMPORT_CMD_GETRAMSIZE 0x14
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 8a01a2d..6ea86db 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -24,7 +24,7 @@
 #include "hw/i386/pc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f24b7d4..c163874 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -17,11 +17,11 @@
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/address-spaces.h"
 
 #include <xen/hvm/ioreq.h>
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index efa35dc..c71a23d 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -20,7 +20,7 @@
 #include <xen/hvm/params.h>
 
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include <trace.h>
 
 
 //#define MAPCACHE_DEBUG
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index deb7a0c..2a8ffc5 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -31,7 +31,7 @@
 #include "hw/irq.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index f748823..e36df94 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_XEN_PV_DEVICE  "xen-pvdevice"
 
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index c3f1604..3d7ad33 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -23,7 +23,7 @@
 #include "hw/ide/internal.h"
 #include "hw/ide/ahci_internal.h"
 
-#include "trace.h"
+#include <trace.h>
 
 #define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
 #define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be..aeb2e60 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -33,7 +33,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci_internal.h"
 
-#include "trace.h"
+#include <trace.h>
 
 static void check_cmd(AHCIState *s, int port);
 static int handle_cmd(AHCIState *s, int port, uint8_t slot);
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index c0509c8..de901b1 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -27,7 +27,7 @@
 #include "hw/ide/internal.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
-#include "trace.h"
+#include <trace.h>
 
 #define ATAPI_SECTOR_BITS (2 + BDRV_SECTOR_BITS)
 #define ATAPI_SECTOR_SIZE (1 << ATAPI_SECTOR_BITS)
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 65aff51..fbbf287 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -31,7 +31,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 /* CMD646 specific */
 #define CFR		0x50
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 139c843..93fbefa 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -38,7 +38,7 @@
 #include "qemu/cutils.h"
 
 #include "hw/ide/internal.h"
-#include "trace.h"
+#include <trace.h>
 
 /* These values were based on a Seagate ST3500418AS but have been modified
    to make more sense in QEMU */
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 1ab0a89..5dc2e05 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -30,7 +30,7 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 #define BMDMA_PAGE_SIZE 4096
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a3afe1f..bb672f3 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -33,7 +33,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned size)
 {
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index e3896c6..858f1eb 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_SII3112_PCI "sii3112"
 #define SII3112_PCI(obj) OBJECT_CHECK(SiI3112PCIState, (obj), \
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 117ac4d..ecc469f 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -32,7 +32,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr,
                            unsigned size)
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 50b6271..6925bca 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -27,7 +27,7 @@
 #include "hw/input/adb-keys.h"
 #include "sysemu/sysemu.h"
 #include "adb-internal.h"
-#include "trace.h"
+#include <trace.h>
 
 #define ADB_KEYBOARD(obj) OBJECT_CHECK(KBDState, (obj), TYPE_ADB_KEYBOARD)
 
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 3ba6027..efea461 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -25,7 +25,7 @@
 #include "ui/console.h"
 #include "hw/input/adb.h"
 #include "adb-internal.h"
-#include "trace.h"
+#include <trace.h>
 
 #define ADB_MOUSE(obj) OBJECT_CHECK(MouseState, (obj), TYPE_ADB_MOUSE)
 
diff --git a/hw/input/hid.c b/hw/input/hid.c
index aa4fb82..aa8e3c9 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -27,7 +27,7 @@
 #include "ui/console.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
-#include "trace.h"
+#include <trace.h>
 
 #define HID_USAGE_ERROR_ROLLOVER        0x01
 #define HID_USAGE_POSTFAIL              0x02
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index ef8f47c..0542a5b 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "ui/console.h"
 #include "hw/input/hid.h"
 #include "qemu/error-report.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 06f5d2a..951e60f 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -29,7 +29,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
-#include "trace.h"
+#include <trace.h>
 
 /* debug PC keyboard */
 //#define DEBUG_KBD
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d..e908555 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6fda52b..7f3fbf1 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -25,7 +25,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/pci/msi.h"
 #include "qemu/host-utils.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "qapi/error.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 78903ea..b1d790c 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -25,7 +25,7 @@
 #include "qapi/visitor.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index ea0323f..d50f86a 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qom/cpu.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/kvm.h"
 
 /* #define DEBUG_GIC */
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 5cbafaf..bf864df 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include <trace.h>
 #include "gicv3_internal.h"
 #include "cpu.h"
 
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 93fe936..4068ede 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 #include "gicv3_internal.h"
 
 /* The GICD_NSACR registers contain a two bit field for each interrupt which
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 8a8684d..b68ce70 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 #include "gicv3_internal.h"
 
 static uint32_t mask_group(GICv3CPUState *cs, MemTxAttrs attrs)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index c51151f..d8bebba 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -21,7 +21,7 @@
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 /* IRQ number counting:
  *
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 2370e74..0fa8972 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -31,7 +31,7 @@
 #include "hw/intc/aspeed_vic.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define AVIC_NEW_BASE_OFFSET 0x80
 
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index d6f9cb3..724dfbf 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -30,7 +30,7 @@
 
 #include "hw/sparc/grlib.h"
 
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 
 #define IRQMP_MAX_CPU 16
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 393fdd7..4045601 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/intc/heathrow_pic.h"
-#include "trace.h"
+#include <trace.h>
 
 static inline int heathrow_check_irq(HeathrowPICState *pic)
 {
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 76f3d87..da6388a 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -28,7 +28,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
-#include "trace.h"
+#include <trace.h>
 
 /* debug PIC */
 //#define DEBUG_PIC
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 36139a4..a7b2f54 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -33,7 +33,7 @@
 #include "target/i386/cpu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
-#include "trace.h"
+#include <trace.h>
 
 #define APIC_DELIVERY_MODE_SHIFT 8
 #define APIC_POLARITY_SHIFT 14
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index db6c7af..5d09c42 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -22,7 +22,7 @@
 #include "hw/hw.h"
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/lm32/lm32_pic.h"
 #include "hw/intc/intc.h"
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5f8168f..5ff864b 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include <trace.h>
 #include "cpu.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 3f804ad..4cf7be2 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -22,7 +22,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include <trace.h>
 
 #define FLIC_SAVE_INITIAL_SIZE getpagesize()
 #define FLIC_FAILED (-1UL)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 817e026..042a1fa 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -26,7 +26,7 @@
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
-#include "trace.h"
+#include <trace.h>
 
 //#define DEBUG_IRQ_COUNT
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e73e623..a249817 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 89fb20e..4976b43 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e27b92..60e27a2 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/timer.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 9be281f..fbb4e03 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -28,7 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/visitor.h"
 
 static uint32_t ipmi_current_uuid = 1;
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 48b29e3..baad85f 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -31,7 +31,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #define REG_FER 0
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 51350d9..7df17e5 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -27,7 +27,7 @@
 #include "qemu/range.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/virtio/vhost.h"
 
 typedef struct pc_dimms_capacity {
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 5e6d574..1d76c59 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TO_REG(offset) ((offset) >> 2)
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0df008e..2f8d953 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -14,7 +14,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 
 /* Protection Key Register */
 #define R_PROT            (0x00 / 4)
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index bb7cc52..0661d93 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 
 /* There are 3 versions of this chip used in SMP sun4m systems:
  * MCC (version 0, implementation 0) SS-600MP
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index c2a9df2..73e5013 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 
-#include "trace.h"
+#include <trace.h>
 
 enum IMX7GPRRegisters {
     IOMUXC_GPR0  = 0x00,
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index ddd1584..5dfd605 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-secctl.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index bd9b862..2320d66 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -32,7 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 /* Bits in B data register: all active low */
 #define TREQ            0x08    /* Transfer request (input) */
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e6140ee..d6fed5e 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 
 enum {
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 86f5e38..d14d9af 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include <math.h>
diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
index 3b0e203..a45c971 100644
--- a/hw/misc/mmio_interface.c
+++ b/hw/misc/mmio_interface.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/qdev-properties.h"
 #include "hw/misc/mmio_interface.h"
 #include "qapi/error.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 8ad9fc8..37ed1ea 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 /* XXX: implement all timer modes */
 
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 7394a05..56c89ac 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6a9d251..663f841 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 6eb5011..992282d 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "hw/misc/msf2-sysreg.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 
 static inline int msf2_divbits(uint32_t div)
 {
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 0b33cdc..b7e6d26 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 
 /*
  * This is the auxio port, chip control and system control part of
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 3dd045c..e28ccbf 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/tz-ppc.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 16a9417..866a8ae 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -46,7 +46,7 @@
 #include "e1000x_common.h"
 #include "e1000e_core.h"
 
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 
 #define TYPE_E1000E "e1000e"
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c93c466..e6226e0 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -46,7 +46,7 @@
 #include "e1000x_common.h"
 #include "e1000e_core.h"
 
-#include "trace.h"
+#include <trace.h>
 
 #define E1000E_MIN_XITR     (500) /* No more then 7813 interrupts per
                                      second according to spec 10.2.4.2 */
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index eb0e097..ad5b54d 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -29,7 +29,7 @@
 
 #include "e1000x_common.h"
 
-#include "trace.h"
+#include <trace.h>
 
 bool e1000x_rx_ready(PCIDevice *d, uint32_t *mac)
 {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index a08d5ac..cc48b23 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -39,7 +39,7 @@
 #include "qemu/timer.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/net/lance.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/sysemu.h"
 
 
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 3eaa19d..9d89e5b 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -28,7 +28,7 @@
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "net/net.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 5a63df7..2c767ad 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "net/net.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 
 /* MIPSnet register offsets */
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 98a5030..02f5dff 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "net_rx_pkt.h"
 #include "net/checksum.h"
 #include "net/tap.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index d42b79c..93b347b 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -38,7 +38,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 /* RECSMALL is not used because it breaks tap networking in linux:
  * incoming ARP responses are too short
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 70dc8b3..e86c4d3 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -33,7 +33,7 @@
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "pcnet.h"
 
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 0c44554..3ef2607 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -41,7 +41,7 @@
 #include "net/eth.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "pcnet.h"
 
diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/qmp-norocker.c
index 0d60513..0ca6a1a 100644
--- a/hw/net/rocker/qmp-norocker.c
+++ b/hw/net/rocker/qmp-norocker.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-rocker.h"
+#include <qapi/qapi-commands-rocker.h>
 #include "qapi/qmp/qerror.h"
 
 RockerSwitch *qmp_query_rocker(const char *name, Error **errp)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index c02cbef..30391ca 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -22,7 +22,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-rocker.h"
+#include <qapi/qapi-commands-rocker.h>
 #include "qemu/iov.h"
 #include "qemu/bitops.h"
 
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 27b17c8..a8030fc 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "net/clients.h"
-#include "qapi/qapi-types-rocker.h"
+#include <qapi/qapi-types-rocker.h>
 #include "rocker.h"
 #include "rocker_hw.h"
 #include "rocker_fp.h"
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 6004672..7ee02aa 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-rocker.h"
+#include <qapi/qapi-commands-rocker.h>
 #include "qemu/iov.h"
 #include "qemu/timer.h"
 
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index d239e4b..e126198 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -34,7 +34,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #include <libfdt.h>
 
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 60f1e47..c07da11 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -15,7 +15,7 @@
 #include "net/checksum.h"
 #include "hw/net/mii.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_SUNGEM "sungem"
 
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 7558fca..c43397d 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -30,7 +30,7 @@
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #define HME_REG_SIZE                   0x8000
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 67ad38c..1ef0d97 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -23,7 +23,7 @@
 #include "net/vhost_net.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-net.h"
+#include <qapi/qapi-events-net.h>
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index ad7345f..4dca86d 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct {
     MemoryRegion iomem;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2a0739d..003d3c2 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -30,7 +30,7 @@
 #include "hw/isa/isa.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 033588b..d42d973 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
-#include "trace.h"
+#include <trace.h>
 
 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(GrackleState, (obj), TYPE_GRACKLE_PCI_HOST_BRIDGE)
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index e2f4ee4..14778a5 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -35,7 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 /*
  * Chipset docs:
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 66991da..f6d1d7d 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -26,7 +26,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-#include "trace.h"
+#include <trace.h>
 
 static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c944c02..afb6adf 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -22,7 +22,7 @@
 #include "hw/xen/xen.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 
 #define MSIX_CAP_LENGTH 12
 
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index b941a0e..bc4ab9c 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -22,7 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f98efdc..803cc9d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -34,14 +34,14 @@
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "exec/address-spaces.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qemu/cutils.h"
 
 //#define DEBUG_PCI
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935..e12b003 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
-#include "trace.h"
+#include <trace.h>
 
 /* debug PCI */
 //#define DEBUG_PCI
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a749e25..f13a1c4 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -73,7 +73,7 @@
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include <trace.h>
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ec4be25..7195afd 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -36,7 +36,7 @@
 #include "hw/loader.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
-#include "trace.h"
+#include <trace.h>
 
 //#define PPC_DEBUG_IRQ
 //#define PPC_DEBUG_TB
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ab2626a..2dfa815 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 
 struct PLBOutMap {
     uint64_t la;
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index b7642ba..7191c24 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 
 struct PCIMasterMap {
     uint32_t la;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 096d4d4..39abb9c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -48,7 +48,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 #include "elf.h"
 #include "qemu/cutils.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 50893ec..7477384 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -28,7 +28,7 @@
 #include "qemu/error-report.h" /* for error_report() */
 #include "sysemu/sysemu.h" /* for vm_stop() */
 #include "cpu.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_PREP_SYSTEMIO "prep-systemio"
 #define PREP_SYSTEMIO(obj) \
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index b613565..e4393af 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -22,7 +22,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_RS6000MC "rs6000-mc"
 #define RS6000MC_DEVICE(obj) \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 44a0670..1924466 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -67,7 +67,7 @@
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index aa25113..fddfd81 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callback */
-#include "trace.h"
+#include <trace.h>
 
 #define DRC_CONTAINER_PATH "/dr-connector"
 #define DRC_INDEX_TYPE_SHIFT 28
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 16bccdd..64fe7ba 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -10,7 +10,7 @@
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
-#include "trace.h"
+#include <trace.h>
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index aaa6010..272ffda 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -25,7 +25,7 @@
 #include "kvm_ppc.h"
 #include "sysemu/dma.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 41df4c3..0dcc38e 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,7 +16,7 @@
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include <libfdt.h>
 
 #define OV_MAXBYTES 256 /* not including length byte */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39a1498..4bb353a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -37,7 +37,7 @@
 #include "exec/address-spaces.h"
 #include "exec/ram_addr.h"
 #include <libfdt.h>
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0ec5fa4..2c9dc12 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -43,7 +43,7 @@
 #include <libfdt.h>
 #include "hw/ppc/spapr_drc.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/ppc/fdt.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 177dcff..ca8acc5 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "trace.h"
+#include <trace.h>
 
 static int spapr_phb_get_active_win_num_cb(Object *child, void *opaque)
 {
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index a373605..fa8400a 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include <qapi/qapi-events-misc.h>
 #include "qemu/cutils.h"
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 472dd6f..aea65e3 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -37,7 +37,7 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/fdt.h"
-#include "trace.h"
+#include <trace.h>
 
 #include <libfdt.h>
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index e306fba..5b268aa 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -19,7 +19,7 @@
 
 #include <infiniband/verbs.h>
 
-#include "trace.h"
+#include <trace.h>
 #include "rdma_utils.h"
 #include "rdma_rm.h"
 #include "rdma_backend.h"
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 9978781..e68b0f0 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -23,7 +23,7 @@
 #include <hw/qdev-core.h>
 #include <hw/qdev-properties.h>
 #include <cpu.h>
-#include "trace.h"
+#include <trace.h>
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 301bf17..7e92c96 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -19,7 +19,7 @@
 #include "cpu.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 76241c2..5053c93 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -13,7 +13,7 @@
 #include "hw/boards.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e51fbef..02a7f29 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -32,7 +32,7 @@
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 419fc66..df39551 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "hw/scsi/esp.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 45975c2..6f95854 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/scsi/esp.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/log.h"
 
 /*
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index ba1afa3..fed09be 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -28,7 +28,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 #include "mfi.h"
 
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 87a416a..d794d5e 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -22,7 +22,7 @@
 
 #include "mptsas.h"
 #include "mpi.h"
-#include "trace.h"
+#include <trace.h>
 
 /* Generic functions for marshaling and unmarshaling.  */
 
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index 3415229..0501649 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -29,7 +29,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "mptsas.h"
 #include "mpi.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 3f061f3..59608bb 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -31,7 +31,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 #include "mptsas.h"
 #include "mpi.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1eaeffc..0627ea4 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -8,7 +8,7 @@
 #include "hw/qdev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index a9e49c7..5f3870b 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -42,7 +42,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "viosrp.h"
-#include "trace.h"
+#include <trace.h>
 
 #include <libfdt.h>
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index a3a019e..274c305 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -31,7 +31,7 @@
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
 #include "vmw_pvscsi.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #define PVSCSI_USE_64BIT         (true)
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 3c6eae6..34ebccf 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -23,7 +23,7 @@
 #include "hw/qdev-core.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
-#include "trace.h"
+#include <trace.h>
 
 static inline const char *sdbus_name(SDBus *sdbus)
 {
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5570c1e..8f6b4ba 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 #include "include/qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82f8ec0..338064b 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -20,7 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
 #define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e051..59f92f3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -43,7 +43,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "sdmmc-internal.h"
-#include "trace.h"
+#include <trace.h>
 
 //#define DEBUG_SD 1
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1b828b1..2fe808e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -35,7 +35,7 @@
 #include "sdhci-internal.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
 #define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bba3aa3..53b6987 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -34,7 +34,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/address-spaces.h"
 
 #include "hw/sparc/grlib.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0f5804b..9dfc825 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -45,7 +45,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/block-backend.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/cutils.h"
 
 /*
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index b677601..48cab0f 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -26,7 +26,7 @@
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 
 /*
  * I/O MMU used by Sun4m systems
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4083889..fa985dd 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -28,7 +28,7 @@
 #include "hw/char/serial.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #define TICK_MAX             0x7fffffffffffffffULL
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index da28ab9..5ed362e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -49,7 +49,7 @@
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/cutils.h"
 
 #define KERNEL_LOAD_ADDR     0x00404000
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index eb3aaa8..90dc404 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -29,7 +29,7 @@
 #include "hw/sparc/sun4u_iommu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 
 #define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index df8d280..cd88f67 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -15,7 +15,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 /* qemu timers run at 1GHz.   We want something closer to 1MHz.  */
 #define SYSTICK_SCALE 1000ULL
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 50acbf5..a296082 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -16,7 +16,7 @@
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TIMER_NR_REGS 4
 
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 9878746..480f11e 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -31,7 +31,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-timer.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e9..0c5f99a 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -28,7 +28,7 @@
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
 
-#include "trace.h"
+#include <trace.h>
 
 #define UNIT_REG_SIZE    16     /* Size of memory mapped regs for the unit */
 #define GPTIMER_REG_SIZE 16     /* Size of memory mapped regs for a GPTimer */
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 2a07b59..6f8a358 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6f1f723..cb9319f 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -31,8 +31,8 @@
 #include "sysemu/replay.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-misc.h"
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-events-misc.h>
 #include "qapi/visitor.h"
 
 #ifdef TARGET_I386
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 93bc6e17..7ab12bb 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 4694b65..52b9e96 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -26,7 +26,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/main-loop.h"
 
 /*
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index c98dc3d..66472dd 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -32,7 +32,7 @@
 #include "hw/ptimer.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/timer/xlnx-zynqmp-rtc.h"
 
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index d8917cb..6603512 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -29,7 +29,7 @@
 #include "sysemu/reset.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct CRBState {
     DeviceState parent_obj;
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 6418ef0..7450668 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -38,9 +38,9 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-tpm.h"
+#include <qapi/qapi-visit-tpm.h>
 #include "chardev/char-fe.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_TPM_EMULATOR "tpm-emulator"
 #define TPM_EMULATOR(obj) \
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 479317e..f43fe12 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -30,9 +30,9 @@
 #include "tpm_int.h"
 #include "hw/hw.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-tpm.h"
+#include <qapi/qapi-visit-tpm.h>
 #include "tpm_util.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
 #define TPM_PASSTHROUGH(obj) \
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 2ac7e74..4e16734 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -31,7 +31,7 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
-#include "trace.h"
+#include <trace.h>
 
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index ee41757..672ffa0 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -28,7 +28,7 @@
 #include "exec/memory.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/qdev.h"
-#include "trace.h"
+#include <trace.h>
 
 /* tpm backend property */
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 11f7720..dc4a6bb7 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -6,7 +6,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/cutils.h"
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index 48cac87..e1168dd 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -23,7 +23,7 @@
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include <trace.h>
 
 static void usb_combined_packet_add(USBCombinedPacket *combined, USBPacket *p)
 {
diff --git a/hw/usb/core.c b/hw/usb/core.c
index 241ae66..a2c320c 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -27,7 +27,7 @@
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include <trace.h>
 
 void usb_pick_speed(USBPort *port)
 {
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 85c15ad..7994523 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -2,7 +2,7 @@
 
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
-#include "trace.h"
+#include <trace.h>
 
 /* ------------------------------------------------------------------ */
 
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 752e30c..5288ff1 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6ecf70a..c861ef9 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -22,7 +22,7 @@
 
 #include "qemu-common.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index c218b53..5812b52 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 
 #include "hw/usb.h"
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 01342326..6719c06 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "hw/usb/ehci-regs.h"
 #include "hw/usb/hcd-ehci.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 
 #define FRAME_TIMER_FREQ 1000
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d4c0293..cf9d20f 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -33,7 +33,7 @@
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
-#include "trace.h"
+#include <trace.h>
 
 /* This causes frames to occur 1000x slower */
 //#define OHCI_TIME_WARP 1
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 836b11f..b08c5ec 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -34,7 +34,7 @@
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "sysemu/dma.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/main-loop.h"
 
 #define FRAME_TIMER_FREQ 1000
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 721beb5..f8d4448 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 
 #include "hcd-xhci.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 1b0be07..3f99184 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -44,7 +44,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "hw/usb.h"
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f895e3c..f6b7de5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 
 struct vfio_group_head vfio_group_list =
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e5779a7..e366c5b 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -17,7 +17,7 @@
 #include "qapi/visitor.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
-#include "trace.h"
+#include <trace.h>
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3ba3cbc..6723b94 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -31,7 +31,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "pci.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 
 #define MSIX_CAP_LENGTH 12
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5c921c2..fa200e6 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -26,7 +26,7 @@
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/platform-bus.h"
 #include "sysemu/kvm.h"
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 259397c..fddf654 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,7 +16,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d8d0ef9..b554016 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,7 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
-#include "trace.h"
+#include <trace.h>
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index f456cea..88f2cd5 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -24,9 +24,9 @@
 #include "sysemu/kvm.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include <qapi/qapi-events-misc.h>
 #include "qapi/visitor.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 289bbca..c813bdf 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -17,7 +17,7 @@
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include <trace.h>
 
 static bool is_guest_ready(VirtIORNG *vrng)
 {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 006d3d1..631da76 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 6e8ba06..06077bb 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -24,8 +24,8 @@
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-run-state.h"
-#include "qapi/qapi-events-run-state.h"
+#include <qapi/qapi-commands-run-state.h>
+#include <qapi/qapi-events-run-state.h>
 #include "sysemu/sysemu.h"
 #include "sysemu/watchdog.h"
 #include "hw/nmi.h"
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 43d7959..0fce761 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -22,7 +22,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-watch.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include <trace.h>
 
 QIOChannelBuffer *
 qio_channel_buffer_new(size_t capacity)
diff --git a/io/channel-command.c b/io/channel-command.c
index 3e7eb17..3c12c56 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -23,7 +23,7 @@
 #include "io/channel-watch.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include <trace.h>
 
 
 QIOChannelCommand *
diff --git a/io/channel-file.c b/io/channel-file.c
index db948ab..86a0bb6 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -23,7 +23,7 @@
 #include "io/channel-watch.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include <trace.h>
 
 QIOChannelFile *
 qio_channel_file_new_fd(int fd)
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 57cfb4d..5aeeb13 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -20,10 +20,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-sockets.h"
+#include <qapi/qapi-visit-sockets.h>
 #include "io/channel-socket.h"
 #include "io/channel-watch.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/clone-visitor.h"
 
 #define SOCKET_MAX_FDS 16
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 9628e6f..a5867a3 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
-#include "trace.h"
+#include <trace.h>
 
 
 static ssize_t qio_channel_tls_write_handler(const char *buf,
diff --git a/io/channel-websock.c b/io/channel-websock.c
index ec48a30..645c657 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -23,7 +23,7 @@
 #include "qemu/bswap.h"
 #include "io/channel-websock.h"
 #include "crypto/hash.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/iov.h"
 
 /* Max amount to allow in rawinput/encoutput buffers */
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 187f725..2fa1cb8 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "io/dns-resolver.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-sockets.h"
+#include <qapi/qapi-visit-sockets.h>
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/io/task.c b/io/task.c
index 2886a2c..524892d 100644
--- a/io/task.c
+++ b/io/task.c
@@ -22,7 +22,7 @@
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
-#include "trace.h"
+#include <trace.h>
 
 struct QIOTask {
     Object *source;
diff --git a/ioport.c b/ioport.c
index 1a65add..84137a6 100644
--- a/ioport.c
+++ b/ioport.c
@@ -29,7 +29,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/ioport.h"
-#include "trace-root.h"
+#include <trace-root.h>
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 
diff --git a/iothread.c b/iothread.c
index 1b3463c..2f3e639 100644
--- a/iothread.c
+++ b/iothread.c
@@ -19,7 +19,7 @@
 #include "block/block.h"
 #include "sysemu/iothread.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 7bc9bc7..4f86b8f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 #include <sys/syscall.h>
 #include <sys/resource.h>
 
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ce5d7a..00a12ae 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -24,7 +24,7 @@
 #include "qemu.h"
 #include "qemu-common.h"
 #include "target_signal.h"
-#include "trace.h"
+#include <trace.h>
 
 static struct target_sigaltstack target_sigaltstack_used = {
     .ss_sp = 0,
diff --git a/memory.c b/memory.c
index e70b64b..1cc8ead 100644
--- a/memory.c
+++ b/memory.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
-#include "trace-root.h"
+#include <trace-root.h>
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/migration/channel.c b/migration/channel.c
index c5eaf0f..7d48f04 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -15,7 +15,7 @@
 #include "tls.h"
 #include "migration.h"
 #include "qemu-file-channel.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 #include "io/channel-tls.h"
 
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index df26e4d..bcbc6f3 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -15,7 +15,7 @@
 #include "migration.h"
 #include "migration/colo.h"
 #include "migration/vmstate.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct {
      bool colo_requested;
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 0ae0c41..e00362f 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -16,10 +16,10 @@
 #include "qemu/main-loop.h"
 #include "migration.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
+#include <qapi/qapi-commands-migration.h>
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 
 static QEMUBH *failover_bh;
 static FailoverStatus failover_state;
diff --git a/migration/colo.c b/migration/colo.c
index 4381067..b0aca63 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
+#include <qapi/qapi-commands-migration.h>
 #include "qemu-file-channel.h"
 #include "migration.h"
 #include "qemu-file.h"
@@ -21,7 +21,7 @@
 #include "migration/colo.h"
 #include "block.h"
 #include "io/channel-buffer.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 #include "migration/failover.h"
 #include "replication.h"
diff --git a/migration/exec.c b/migration/exec.c
index 0bc5a42..34f6e1a 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -21,7 +21,7 @@
 #include "channel.h"
 #include "exec.h"
 #include "io/channel-command.h"
-#include "trace.h"
+#include <trace.h>
 
 
 void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
diff --git a/migration/fd.c b/migration/fd.c
index cd06182..59d4e1d 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -19,7 +19,7 @@
 #include "fd.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
-#include "trace.h"
+#include <trace.h>
 
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
diff --git a/migration/global_state.c b/migration/global_state.c
index 8e8ab5c..71f311e 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -17,7 +17,7 @@
 #include "migration.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct {
     uint32_t size;
diff --git a/migration/migration.c b/migration/migration.c
index 6a4780e..66e8c82 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,15 +31,15 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-events-migration.h"
+#include <qapi/qapi-commands-migration.h>
+#include <qapi/qapi-events-migration.h>
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
 #include "block.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/target_page.h"
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 032abfb..ad9182d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -26,7 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 
 /* Arbitrary limit on size of each discard command,
  * keeps them around ~200 bytes
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2ab2bf3..1fedf61 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -28,7 +28,7 @@
 #include "qemu/iov.h"
 #include "migration.h"
 #include "qemu-file.h"
-#include "trace.h"
+#include <trace.h>
 
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
diff --git a/migration/ram.c b/migration/ram.c
index 7266351..7a54437 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -43,9 +43,9 @@
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-migration.h"
+#include <qapi/qapi-events-migration.h>
 #include "qapi/qmp/qerror.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/ram_addr.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index da474fc..e33e139 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -31,7 +31,7 @@
 #include <netdb.h>
 #include <arpa/inet.h>
 #include <rdma/rdma_cma.h>
-#include "trace.h"
+#include <trace.h>
 
 /*
  * Print and error on both the Monitor and the Log file.
diff --git a/migration/savevm.c b/migration/savevm.c
index 358c5b5..3f51184 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -41,14 +41,14 @@
 #include "savevm.h"
 #include "postcopy-ram.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-migration.h>
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
 #include "exec/target_page.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/iov.h"
 #include "block/snapshot.h"
 #include "qemu/cutils.h"
diff --git a/migration/socket.c b/migration/socket.c
index 8a93fb1..f35afff 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,7 +24,7 @@
 #include "migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
-#include "trace.h"
+#include <trace.h>
 
 
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
diff --git a/migration/tls.c b/migration/tls.c
index 3b9e8c9..548afc3 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -26,7 +26,7 @@
 #include "crypto/tlscreds.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 
 static QCryptoTLSCreds *
 migration_tls_get_creds(MigrationState *s,
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 48184c3..a3fa8a5 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -18,7 +18,7 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-#include "trace.h"
+#include <trace.h>
 
 /* bool */
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0b3282c..d92b673 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -18,7 +18,7 @@
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "qjson.h"
 
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/monitor.c b/monitor.c
index a4417f2..a4b3bcc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -59,7 +59,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qom/object_interfaces.h"
-#include "trace-root.h"
+#include <trace-root.h>
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
 #ifdef CONFIG_TRACE_SIMPLE
@@ -72,11 +72,11 @@
 #include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
-#include "qapi/qapi-commands.h"
-#include "qapi/qapi-events.h"
+#include <qapi/qapi-commands.h>
+#include <qapi/qapi-events.h>
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
-#include "qapi/qapi-introspect.h"
+#include <qapi/qapi-introspect.h>
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
@@ -2320,13 +2320,13 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
 
 /* Please update hmp-commands.hx when adding or changing commands */
 static mon_cmd_t info_cmds[] = {
-#include "hmp-commands-info.h"
+#include <hmp-commands-info.h>
     { NULL, NULL, },
 };
 
 /* mon_cmds and info_cmds would be sorted at runtime */
 static mon_cmd_t mon_cmds[] = {
-#include "hmp-commands.h"
+#include <hmp-commands.h>
     { NULL, NULL, },
 };
 
diff --git a/nbd/client.c b/nbd/client.c
index dcad23a..cbd304f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "nbd-internal.h"
 
 /* Definitions for opaque data types */
diff --git a/nbd/common.c b/nbd/common.c
index 8c95c1d..b172777 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "nbd-internal.h"
 
 /* Discard length bytes from channel.  Return -errno on failure and 0 on
diff --git a/nbd/server.c b/nbd/server.c
index e714bfe..dff47dc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include <trace.h>
 #include "nbd-internal.h"
 
 static int system_errno_to_nbd_errno(int err)
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 23b2d2c..f945ab4 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "net/net.h"
diff --git a/net/colo.c b/net/colo.c
index 8426265..424f8a4 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "net/colo.h"
 
 uint32_t connection_key_hash(const void *opaque)
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index f7265c5..51f3b80 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
-#include "qapi/qapi-builtin-visit.h"
+#include <qapi/qapi-builtin-visit.h>
 #include "qapi/qmp/qerror.h"
 #include "qom/object.h"
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 3a61cf2..4e9aec0 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -17,7 +17,7 @@
 #include "qom/object.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "chardev/char-fe.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 62dad2d..bb5e35a 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "net/colo.h"
 #include "net/filter.h"
 #include "net/net.h"
diff --git a/net/net.c b/net/net.c
index 5222e45..0f65ee2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -33,8 +33,8 @@
 
 #include "monitor/monitor.h"
 #include "qemu/help_option.h"
-#include "qapi/qapi-commands-net.h"
-#include "qapi/qapi-visit-net.h"
+#include <qapi/qapi-commands-net.h>
+#include <qapi/qapi-visit-net.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index e0f16c8..6e78b4c 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -14,11 +14,11 @@
 #include "net/vhost-user.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-net.h"
+#include <qapi/qapi-commands-net.h>
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct VhostUserState {
     NetClientState nc;
diff --git a/numa.c b/numa.c
index 1116c90..2794bea 100644
--- a/numa.c
+++ b/numa.c
@@ -31,8 +31,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-visit-misc.h"
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-visit-misc.h>
 #include "hw/boards.h"
 #include "sysemu/hostmem.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index d9a1137..02288ca 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -18,7 +18,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
-#include "trace.h"
+#include <trace.h>
 
 void visit_complete(Visitor *v, void *opaque)
 {
diff --git a/qdev-monitor.c b/qdev-monitor.c
index b7e3291..db20513 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -24,7 +24,7 @@
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
diff --git a/qemu-img.c b/qemu-img.c
index 088d890..7c0a4d7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -25,9 +25,9 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 
-#include "qemu-version.h"
+#include <qemu-version.h>
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block-core.h"
+#include <qapi/qapi-visit-block-core.h>
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qdict.h"
@@ -121,7 +121,7 @@ static void QEMU_NORETURN help(void)
            "Command syntax:\n"
 #define DEF(option, callback, arg_string)        \
            "  " arg_string "\n"
-#include "qemu-img-cmds.h"
+#include <qemu-img-cmds.h>
 #undef DEF
 #undef GEN_DOCS
            "\n"
@@ -4683,7 +4683,7 @@ out:
 static const img_cmd_t img_cmds[] = {
 #define DEF(option, callback, arg_string)        \
     { option, callback },
-#include "qemu-img-cmds.h"
+#include <qemu-img-cmds.h>
 #undef DEF
 #undef GEN_DOCS
     { NULL, NULL, },
diff --git a/qemu-io.c b/qemu-io.c
index 160fb2a..2698e80 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "trace/control.h"
 #include "crypto/init.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 
 #define CMD_NOFILE_OK   0x01
 
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ed5d9b5..ecf172e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -41,7 +41,7 @@
 #include "io/net-listener.h"
 #include "crypto/init.h"
 #include "trace/control.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 
 #define SOCKET_PATH                "/var/lock/qemu-nbd-%s"
 #define QEMU_NBD_OPT_CACHE         256
diff --git a/qga/main.c b/qga/main.c
index f9c8305..b070621 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -33,7 +33,7 @@
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 #ifdef _WIN32
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
diff --git a/qmp.c b/qmp.c
index 4b2517d..1122ceb 100644
--- a/qmp.c
+++ b/qmp.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "monitor/monitor.h"
@@ -31,9 +31,9 @@
 #include "sysemu/block-backend.h"
 #include "qom/qom-qobject.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-ui.h"
+#include <qapi/qapi-commands-block-core.h>
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-commands-ui.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index e42d9a7..53a5719 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "trace-root.h"
+#include <trace-root.h>
 
 CPUInterruptHandler cpu_interrupt_handler;
 
diff --git a/qom/object.c b/qom/object.c
index 755ad03..804b7da 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -18,9 +18,9 @@
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi/qapi-builtin-visit.h"
+#include <qapi/qapi-builtin-visit.h>
 #include "qapi/qmp/qerror.h"
-#include "trace.h"
+#include <trace.h>
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
  * of the QOM core on QObject?  */
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 6ee8b5f..bc2bfca 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -16,7 +16,7 @@
 #include "qemu/notify.h"
 #include "ui/input.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-ui.h"
+#include <qapi/qapi-visit-ui.h>
 
 void replay_save_input_event(InputEvent *evt)
 {
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 87c45db..176286a 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -16,7 +16,7 @@
 #include "block/aio.h"
 #include "block/thread-pool.h"
 #include "scsi/pr-manager.h"
-#include "trace.h"
+#include <trace.h>
 
 typedef struct PRManagerData {
     PRManager *pr_mgr;
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9fe615c..5e2b70b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -49,7 +49,7 @@
 #include "qapi/qmp/qstring.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 
 #include "block/aio.h"
 #include "block/thread-pool.h"
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 6729bc8..c1657c4 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-tpm.h"
+#include <qapi/qapi-commands-tpm.h>
 #include "sysemu/tpm.h"
 
 int tpm_init(void)
diff --git a/stubs/uuid.c b/stubs/uuid.c
index a802e98..1167269 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qemu/uuid.h"
 
 UuidInfo *qmp_query_uuid(Error **errp)
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index 568e42b..fee4fe1 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qerror.h"
 
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 0067bcc..a812402 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -12,7 +12,7 @@
 #include "qemu-common.h"
 #include "hw/xen/xen.h"
 #include "exec/memory.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 09893e3..41759d3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "target/arm/idau.h"
-#include "trace.h"
+#include <trace.h>
 #include "cpu.h"
 #include "internals.h"
 #include "exec/gdbstub.h"
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 4cdd267..93d34e1 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 
 static GICCapability *gic_cap_new(int version)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec1efd3..8b70413 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -31,8 +31,8 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-misc.h"
-#include "qapi/qapi-visit-run-state.h"
+#include <qapi/qapi-visit-misc.h>
+#include <qapi/qapi-visit-run-state.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d996cca..5d79011 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -46,7 +46,7 @@
 #include "hw/pci/msix.h"
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
-#include "trace.h"
+#include <trace.h>
 
 //#define DEBUG_KVM
 
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d05ee67..dc3c4af 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -34,7 +34,7 @@
 #include "exec/helper-gen.h"
 #include "exec/semihost.h"
 
-#include "target/mips/trace.h"
+#include <target/mips/trace.h>
 #include "trace-tcg.h"
 #include "exec/log.h"
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 79a436a..0ba3480 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -40,7 +40,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 #include "sysemu/watchdog.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/gdbstub.h"
 #include "exec/memattrs.h"
 #include "exec/ram_addr.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c2b775f..73329be 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -33,10 +33,10 @@
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-misc.h"
-#include "qapi/qapi-visit-run-state.h"
+#include <qapi/qapi-visit-misc.h>
+#include <qapi/qapi-visit-run-state.h>
 #include "sysemu/hw_accel.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 3b9e274..b5d6327 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu_features.h"
-#include "gen-features.h"
+#include <gen-features.h>
 
 #define FEAT_INIT(_name, _type, _bit, _desc) \
     {                                                \
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 83c164a..a0b58fb 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -14,7 +14,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "hw/s390x/ioinst.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/s390x/s390-pci-bus.h"
 
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f570896..24da3ec 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -40,7 +40,7 @@
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 1deeb6e..93858b0 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,7 +23,7 @@
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
-#include "trace.h"
+#include <trace.h>
 #include "hw/s390x/storage-keys.h"
 
 /* #define DEBUG_S390 */
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index aff1530..c5940ab 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -16,8 +16,8 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
-#include "qapi/qapi-types-misc.h"
+#include <trace.h>
+#include <qapi/qapi-types-misc.h>
 
 QemuMutex qemu_sigp_mutex;
 
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index c772492..bb4c1fb 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/sysemu.h"
 #include "exec/log.h"
 
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f3e7f32..a3d53ac 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
-#include "trace.h"
+#include <trace.h>
 
 #define DEBUG_PCALL
 
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index f8886ae..c7fbc26 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/address-spaces.h"
 
 /* Sparc MMU emulation */
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 8290a21..0c9626f 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "trace.h"
+#include <trace.h>
 
 static inline void memcpy32(target_ulong *dst, const target_ulong *src)
 {
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 22445d9..f19a283 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -13,8 +13,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-introspect.h"
-#include "qapi/qapi-visit-misc.h"
+#include <qapi/qapi-visit-introspect.h>
+#include <qapi/qapi-visit-misc.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
index 1c29bce..159cf5a 100644
--- a/tests/tcg/test_path.c
+++ b/tests/tcg/test_path.c
@@ -1,5 +1,5 @@
 /* Test path override code */
-#include "config-host.h"
+#include <config-host.h>
 #include "util/cutils.c"
 #include "util/hexdump.c"
 #include "util/iov.c"
diff --git a/tests/test-char.c b/tests/test-char.c
index b3a77af..c748fb8 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -8,7 +8,7 @@
 #include "chardev/char-mux.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-char.h"
+#include <qapi/qapi-commands-char.h>
 #include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
 
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 5b1cee6..307117a 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -6,9 +6,9 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
-#include "tests/test-qapi-types.h"
-#include "tests/test-qapi-visit.h"
-#include "test-qapi-commands.h"
+#include <tests/test-qapi-types.h>
+#include <tests/test-qapi-visit.h>
+#include <test-qapi-commands.h>
 
 static QmpCommandList qmp_commands;
 
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 31f35b3..8398587 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -20,7 +20,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
-#include "test-qapi-events.h"
+#include <test-qapi-events.h>
 
 typedef struct TestEventData {
     QDict *expect;
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 79b1a8c..875dd8e 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -15,7 +15,7 @@
 
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-introspect.h"
+#include <qapi/qapi-visit-introspect.h>
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
@@ -24,8 +24,8 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "test-qapi-introspect.h"
-#include "qapi/qapi-introspect.h"
+#include <test-qapi-introspect.h>
+#include <qapi/qapi-introspect.h>
 
 typedef struct TestInputVisitorData {
     QObject *obj;
diff --git a/tpm.c b/tpm.c
index 9303172..6b159d0 100644
--- a/tpm.c
+++ b/tpm.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qapi-commands-tpm.h"
+#include <qapi/qapi-commands-tpm.h>
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
diff --git a/trace/control-target.c b/trace/control-target.c
index 706b2ce..cc784f1 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include <trace-root.h>
 #include "trace/control.h"
 #include "translate-all.h"
 
diff --git a/trace/control.c b/trace/control.c
index e40cfca..6f839e6 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -15,7 +15,7 @@
 #include "trace/simple.h"
 #endif
 #ifdef CONFIG_TRACE_FTRACE
-#include "trace/ftrace.h"
+#include <trace/ftrace.h>
 #endif
 #ifdef CONFIG_TRACE_LOG
 #include "qemu/log.h"
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace-root.h"
+#include <trace-root.h>
 
 int trace_events_enabled_count;
 
diff --git a/trace/ftrace.c b/trace/ftrace.c
index 61692a8..5e8cedf 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "trace/control.h"
-#include "trace/ftrace.h"
+#include <trace/ftrace.h>
 
 int trace_marker_fd;
 
diff --git a/trace/qmp.c b/trace/qmp.c
index 756086c..cbb8c48 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-trace.h"
+#include <qapi/qapi-commands-trace.h>
 #include "trace/control.h"
 
 
diff --git a/ui/console.c b/ui/console.c
index a8868fc..fc05eb5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -26,11 +26,11 @@
 #include "ui/console.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
+#include <qapi/qapi-commands-ui.h>
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
-#include "trace.h"
+#include <trace.h>
 #include "exec/memory.h"
 
 #define DEFAULT_BACKSCROLL 512
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 9390c67..2c4fb0b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#include "trace.h"
+#include <trace.h>
 
 #include "ui/console.h"
 #include "ui/gtk.h"
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 147ad6f..6a3147e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#include "trace.h"
+#include <trace.h>
 
 #include "ui/console.h"
 #include "ui/gtk.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index ef5bc42..289f316 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -37,7 +37,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qemu/cutils.h"
 
 #include "ui/console.h"
@@ -50,7 +50,7 @@
 #endif
 #include <math.h>
 
-#include "trace.h"
+#include <trace.h>
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "keymaps.h"
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 3d4e66b..92e04ec 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -5,22 +5,22 @@
 
 #include "standard-headers/linux/input.h"
 
-#include "ui/input-keymap-atset1-to-qcode.c"
-#include "ui/input-keymap-linux-to-qcode.c"
-#include "ui/input-keymap-qcode-to-atset1.c"
-#include "ui/input-keymap-qcode-to-atset2.c"
-#include "ui/input-keymap-qcode-to-atset3.c"
-#include "ui/input-keymap-qcode-to-linux.c"
-#include "ui/input-keymap-qcode-to-qnum.c"
-#include "ui/input-keymap-qcode-to-sun.c"
-#include "ui/input-keymap-qnum-to-qcode.c"
-#include "ui/input-keymap-usb-to-qcode.c"
-#include "ui/input-keymap-win32-to-qcode.c"
-#include "ui/input-keymap-x11-to-qcode.c"
-#include "ui/input-keymap-xorgevdev-to-qcode.c"
-#include "ui/input-keymap-xorgkbd-to-qcode.c"
-#include "ui/input-keymap-xorgxquartz-to-qcode.c"
-#include "ui/input-keymap-xorgxwin-to-qcode.c"
+#include <ui/input-keymap-atset1-to-qcode.c>
+#include <ui/input-keymap-linux-to-qcode.c>
+#include <ui/input-keymap-qcode-to-atset1.c>
+#include <ui/input-keymap-qcode-to-atset2.c>
+#include <ui/input-keymap-qcode-to-atset3.c>
+#include <ui/input-keymap-qcode-to-linux.c>
+#include <ui/input-keymap-qcode-to-qnum.c>
+#include <ui/input-keymap-qcode-to-sun.c>
+#include <ui/input-keymap-qnum-to-qcode.c>
+#include <ui/input-keymap-usb-to-qcode.c>
+#include <ui/input-keymap-win32-to-qcode.c>
+#include <ui/input-keymap-x11-to-qcode.c>
+#include <ui/input-keymap-xorgevdev-to-qcode.c>
+#include <ui/input-keymap-xorgkbd-to-qcode.c>
+#include <ui/input-keymap-xorgxquartz-to-qcode.c>
+#include <ui/input-keymap-xorgxwin-to-qcode.c>
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index e5d4db1..ba2971b 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-ui.h"
+#include <qapi/qapi-commands-ui.h>
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "ui/keymaps.h"
diff --git a/ui/input.c b/ui/input.c
index 51b1019..ce1f1bf 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,10 +1,10 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
+#include <qapi/qapi-commands-ui.h>
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include <trace.h>
 #include "ui/input.h"
 #include "ui/console.h"
 #include "sysemu/replay.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 43fe604..2fe3550 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "keymaps.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/error-report.h"
 
 struct keysym2code {
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ae8921a..e019ef7 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -29,8 +29,8 @@
 #include "qemu-x509.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
-#include "qapi/qapi-events-ui.h"
+#include <qapi/qapi-commands-ui.h>
+#include <qapi/qapi-events-ui.h>
 #include "qemu/notify.h"
 #include "qemu/option.h"
 #include "migration/misc.h"
diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe73482..c95ec1f 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -22,7 +22,7 @@
 #include "qemu/queue.h"
 #include "ui/console.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 
 #include "ui/spice-display.h"
 
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 3751a77..a8a05bc 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "vnc.h"
-#include "trace.h"
+#include <trace.h>
 
 /* Max amount of data we send/recv for SASL steps to prevent DOS */
 #define SASL_DATA_MAX_LEN (1024 * 1024)
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index d99ea36..c1eae2d 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -28,7 +28,7 @@
 #include "vnc.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include <trace.h>
 
 static void start_auth_vencrypt_subauth(VncState *vs)
 {
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 950f1cd..ce87f01 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -23,7 +23,7 @@
 #include "vnc.h"
 #include "io/channel-websock.h"
 #include "qemu/bswap.h"
-#include "trace.h"
+#include <trace.h>
 
 static void vncws_tls_handshake_done(QIOTask *task,
                                      gpointer user_data)
diff --git a/ui/vnc.c b/ui/vnc.c
index e164eb7..5031c19 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
-#include "trace.h"
+#include <trace.h>
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -35,9 +35,9 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
-#include "qapi/qapi-events.h"
+#include <qapi/qapi-events.h>
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
+#include <qapi/qapi-commands-ui.h>
 #include "ui/input.h"
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 22e0e77..09152ba 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "x_keymap.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/notify.h"
 #include "ui/input.h"
 
diff --git a/util/aio-posix.c b/util/aio-posix.c
index d8f0cb4..6f6d16b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -19,7 +19,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include <trace.h>
 #ifdef CONFIG_EPOLL_CREATE1
 #include <sys/epoll.h>
 #endif
diff --git a/util/async.c b/util/async.c
index 4dd9d95..7f6e182 100644
--- a/util/async.c
+++ b/util/async.c
@@ -32,7 +32,7 @@
 #include "qemu/atomic.h"
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
-#include "trace.h"
+#include <trace.h>
 
 /***********************************************************/
 /* bottom halves (can be seen as timers which expire ASAP) */
diff --git a/util/buffer.c b/util/buffer.c
index d8bb874..d758af7 100644
--- a/util/buffer.c
+++ b/util/buffer.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/buffer.h"
-#include "trace.h"
+#include <trace.h>
 
 #define BUFFER_MIN_INIT_SIZE     4096
 #define BUFFER_MIN_SHRINK_SIZE  65536
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 58a2c93..a98c9c8 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/hbitmap.h"
 #include "qemu/host-utils.h"
-#include "trace.h"
+#include <trace.h>
 #include "crypto/hash.h"
 
 /* HBitmaps provides an array of bits.  The bits are stored as usual in an
diff --git a/util/lockcnt.c b/util/lockcnt.c
index 4f88dcf..79bed0d 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
-#include "trace.h"
+#include <trace.h>
 
 #ifdef CONFIG_LINUX
 #include "qemu/futex.h"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 13b6f8d..c0a81e2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -32,7 +32,7 @@
 #include <glib/gprintf.h>
 
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include <trace.h>
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include <libgen.h>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bb5ad28..82a5c5a 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -34,7 +34,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 
diff --git a/util/qemu-config.c b/util/qemu-config.c
index c651c48..96dd98a 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include <qapi/qapi-commands-misc.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu-common.h"
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 5a80c10..85a8c27 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -33,7 +33,7 @@
 #include "qemu/processor.h"
 #include "qemu/queue.h"
 #include "block/aio.h"
-#include "trace.h"
+#include <trace.h>
 
 void qemu_co_queue_init(CoQueue *queue)
 {
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 9eff7fd..ddd6efa 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 7f13e8a..3f43b40 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -24,7 +24,7 @@
 #include "monitor/monitor.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-sockets.h"
+#include <qapi/qapi-visit-sockets.h>
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b789cf3..fa9dded 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,7 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include <trace.h>
 
 static bool name_threads;
 
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index ab60c0d..07f938c 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,7 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include <trace.h>
 #include <process.h>
 
 static bool name_threads;
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d..38a28aa 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -19,7 +19,7 @@
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
-#include "trace.h"
+#include <trace.h>
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
 
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 006674c..5ac8c50 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -16,13 +16,13 @@
 #include "qapi/error.h"
 #include "exec/ramlist.h"
 #include "exec/cpu-common.h"
-#include "trace.h"
+#include <trace.h>
 #include "qemu/queue.h"
 #include "qemu/error-report.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "qemu/event_notifier.h"
 #include "qemu/vfio-helpers.h"
-#include "trace.h"
+#include <trace.h>
 
 #define QEMU_VFIO_DEBUG 0
 
diff --git a/vl.c b/vl.c
index 3ef04ce..31678ed 100644
--- a/vl.c
+++ b/vl.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
@@ -111,7 +111,7 @@ int main(int argc, char **argv)
 
 #include "slirp/libslirp.h"
 
-#include "trace-root.h"
+#include <trace-root.h>
 #include "trace/control.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
@@ -123,11 +123,11 @@ int main(int argc, char **argv)
 #include "exec/semihost.h"
 #include "crypto/init.h"
 #include "sysemu/replay.h"
-#include "qapi/qapi-events-run-state.h"
-#include "qapi/qapi-visit-block-core.h"
-#include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-run-state.h"
+#include <qapi/qapi-events-run-state.h>
+#include <qapi/qapi-visit-block-core.h>
+#include <qapi/qapi-commands-block-core.h>
+#include <qapi/qapi-commands-misc.h>
+#include <qapi/qapi-commands-run-state.h>
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 64d9c0f..35c206c 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -177,8 +177,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "qapi/qapi-builtin-types.h"
-#include "qapi/qapi-builtin-visit.h"
+#include <qapi/qapi-builtin-types.h>
+#include <qapi/qapi-builtin-visit.h>
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/util.h"
@@ -195,7 +195,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
 ''',
                                       types=types, visit=visit))
         self._genh.preamble_add(mcgen('''
-#include "qapi/qapi-builtin-types.h"
+#include <qapi/qapi-builtin-types.h>
 '''))
 
     def visit_begin(self, schema):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d89..1fdeabd 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -274,11 +274,11 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-builtin-visit.h"
+#include <qapi/qapi-builtin-visit.h>
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/visitor.h"
-#include "qapi/qapi-builtin-types.h"
+#include <qapi/qapi-builtin-types.h>
 
 ''',
                                       prefix=prefix))
@@ -295,7 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 ''',
                                       visit=visit, prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
-#include "qapi/qapi-builtin-visit.h"
+#include <qapi/qapi-builtin-visit.h>
 #include "%(types)s.h"
 
 ''',
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 92f71b2..4db92af 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -20,7 +20,7 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    out('#include "trace/ftrace.h"',
+    out('#include <trace/ftrace.h>',
         '')
 
 
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 78933d0..819299c 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -20,7 +20,7 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    out('#include "qemu/log-for-trace.h"',
+    out('#include <qemu/log-for-trace.h>',
         '')
 
 
diff --git a/trace-events b/trace-events
index 855b0ab..af0edf6 100644
--- a/trace-events
+++ b/trace-events
@@ -8,7 +8,7 @@
 #    string.
 #
 # 2. Call the trace event from code using trace_##name, e.g. multiwrite_cb() ->
-#    trace_multiwrite_cb().  The source file must #include "trace.h".
+#    trace_multiwrite_cb().  The source file must #include <trace.h>.
 #
 # Format of a trace event:
 #
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 18de0bb..96a96e3 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,9 +32,9 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands.h"
+#include <qapi/qapi-commands.h>
 #include "sysemu/blockdev.h"
-#include "qemu-version.h"
+#include <qemu-version.h>
 #include <Carbon/Carbon.h>
 #include "qom/cpu.h"
 
diff --git a/version.rc b/version.rc
index d8e1569..cbca012 100644
--- a/version.rc
+++ b/version.rc
@@ -1,5 +1,5 @@
 #include <winver.h>
-#include "config-host.h"
+#include <config-host.h>
 
 VS_VERSION_INFO VERSIONINFO
 FILEVERSION CONFIG_FILEVERSION
-- 
MST
