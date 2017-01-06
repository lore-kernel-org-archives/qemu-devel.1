Received: from eggs.gnu.org ([2001:4830:134:3::10]:46830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWry-0003jj-Kt
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWru-0004mQ-Bg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWru-0004lj-2I
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0BD98124B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:55:49 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:54:56 +0000
Message-Id: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/47] Switch all subdirs over to modular
 trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is the final part of my trace events refactoring.

Previously we merged code that split trace-events up
into one file per sub-directory. We also merged code
to the code-generator that enables us to generate
and use multiple independant sets of trace events.

This is the final glue that makes use of these two
earlier changes, so that we actually generate a
separate trace.h & trace.c file per sub-directory.

The result is that when adding a new trace event to
a file, only files in that sub-directory get rebuilt.
Theoretically the build is faster too, since each
source file includes a much smaller trace.h that
only contains probes relevant to it. In reality this
speed benefit is probably marginal & lost in the noise.

The first patch introduces the new Makefile rules to
handle modular building.

The next 43 patches convert over each sub-directory.
They are totally boring and repetative. The only
exception is the patch for target/s390x which hit
a bit of makefile pain, explained in its commit msg.

The 45th patch removes the old, now unused, Makefile
rules for non-modular trace building.

The 46th patch documents the new approach

The final patch is just a small tweak to error
reporting, unrelated to the refactoring.

Daniel P. Berrange (47):
  trace: introduce some Makefile rules for module code gen
  trace: switch io/ directory to modular trace.h file
  trace: switch util/ directory to modular trace.h file
  trace: switch crypto/ directory to modular trace.h file
  trace: switch migration/ directory to modular trace.h file
  trace: switch block/ directory to modular trace.h file
  trace: switch hw/block/ directory to modular trace.h file
  trace: switch hw/char/ directory to modular trace.h file
  trace: switch hw/intc/ directory to modular trace.h file
  trace: switch hw/net/ directory to modular trace.h file
  trace: switch hw/virtio/ directory to modular trace.h file
  trace: switch hw/audio/ directory to modular trace.h file
  trace: switch hw/misc/ directory to modular trace.h file
  trace: switch hw/usb/ directory to modular trace.h file
  trace: switch hw/scsi/ directory to modular trace.h file
  trace: switch hw/nvram/ directory to modular trace.h file
  trace: switch hw/display/ directory to modular trace.h file
  trace: switch hw/input/ directory to modular trace.h file
  trace: switch hw/timer/ directory to modular trace.h file
  trace: switch hw/dma/ directory to modular trace.h file
  trace: switch hw/sparc/ directory to modular trace.h file
  trace: switch hw/sd/ directory to modular trace.h file
  trace: switch hw/isa/ directory to modular trace.h file
  trace: switch hw/mem/ directory to modular trace.h file
  trace: switch hw/i386/ directory to modular trace.h file
  trace: switch hw/9pfs/ directory to modular trace.h file
  trace: switch hw/ppc/ directory to modular trace.h file
  trace: switch hw/pci/ directory to modular trace.h file
  trace: switch hw/s390x/ directory to modular trace.h file
  trace: switch hw/vfio/ directory to modular trace.h file
  trace: switch hw/acpi/ directory to modular trace.h file
  trace: switch hw/arm/ directory to modular trace.h file
  trace: switch hw/alpha/ directory to modular trace.h file
  trace: switch ui/ directory to modular trace.h file
  trace: switch audio/ directory to modular trace.h file
  trace: switch net/ directory to modular trace.h file
  trace: switch target/arm/ directory to modular trace.h file
  trace: switch target/i386/ directory to modular trace.h file
  trace: switch target/sparc/ directory to modular trace.h file
  trace: switch target/s390x/ directory to modular trace.h file
  trace: switch target/ppc/ directory to modular trace.h file
  trace: switch qom/ directory to modular trace.h file
  trace: switch linux-user/ directory to modular trace.h file
  trace: switch qapi/ directory to modular trace.h file
  trace: remove the global include/trace.h file
  trace: update docs to reflect new code generation approach
  trace: improve error reporting when parsing simpletrace header

 .gitignore                               |  14 ++--
 Makefile                                 | 117 ++++++++++++++++++++++++++-----
 Makefile.objs                            |  95 +++++++++++++------------
 Makefile.target                          |  30 +++++++-
 audio/Makefile.objs                      |   2 +
 audio/alsaaudio.c                        |   2 +-
 audio/ossaudio.c                         |   2 +-
 block.c                                  |   2 +-
 block/Makefile.objs                      |   2 +
 block/backup.c                           |   2 +-
 block/block-backend.c                    |   2 +-
 block/commit.c                           |   2 +-
 block/dirty-bitmap.c                     |   2 +-
 block/io.c                               |   2 +-
 block/mirror.c                           |   2 +-
 block/nfs.c                              |   2 +-
 block/qcow2-cache.c                      |   2 +-
 block/qcow2-cluster.c                    |   2 +-
 block/qcow2.c                            |   2 +-
 block/qed-l2-cache.c                     |   2 +-
 block/qed-table.c                        |   2 +-
 block/qed.c                              |   2 +-
 block/raw-posix.c                        |   2 +-
 block/raw-win32.c                        |   2 +-
 block/stream.c                           |   2 +-
 blockdev.c                               |   2 +-
 crypto/Makefile.objs                     |   2 +
 crypto/secret.c                          |   2 +-
 crypto/tlscreds.c                        |   2 +-
 crypto/tlscredsanon.c                    |   2 +-
 crypto/tlscredsx509.c                    |   2 +-
 crypto/tlssession.c                      |   2 +-
 docs/tracing.txt                         |  61 +++++++++++++---
 hw/9pfs/9p.c                             |   2 +-
 hw/9pfs/Makefile.objs                    |   2 +
 hw/acpi/Makefile.objs                    |   2 +
 hw/acpi/cpu.c                            |   2 +-
 hw/acpi/memory_hotplug.c                 |   2 +-
 hw/alpha/Makefile.objs                   |   2 +
 hw/alpha/pci.c                           |   2 +-
 hw/arm/Makefile.objs                     |   2 +
 hw/arm/virt-acpi-build.c                 |   2 +-
 hw/audio/Makefile.objs                   |   3 +
 hw/audio/cs4231.c                        |   2 +-
 hw/audio/milkymist-ac97.c                |   2 +-
 hw/block/Makefile.objs                   |   2 +
 hw/block/dataplane/virtio-blk.c          |   2 +-
 hw/block/hd-geometry.c                   |   2 +-
 hw/block/virtio-blk.c                    |   2 +-
 hw/char/Makefile.objs                    |   2 +
 hw/char/escc.c                           |   2 +-
 hw/char/grlib_apbuart.c                  |   2 +-
 hw/char/lm32_juart.c                     |   2 +-
 hw/char/lm32_uart.c                      |   2 +-
 hw/char/milkymist-uart.c                 |   2 +-
 hw/char/virtio-console.c                 |   2 +-
 hw/char/virtio-serial-bus.c              |   2 +-
 hw/display/Makefile.objs                 |   3 +
 hw/display/g364fb.c                      |   2 +-
 hw/display/jazz_led.c                    |   2 +-
 hw/display/milkymist-tmu2.c              |   2 +-
 hw/display/milkymist-vgafb.c             |   2 +-
 hw/display/qxl-render.c                  |   2 +-
 hw/display/qxl.c                         |   2 +-
 hw/display/vga.c                         |   2 +-
 hw/display/virtio-gpu-3d.c               |   2 +-
 hw/display/virtio-gpu.c                  |   2 +-
 hw/display/vmware_vga.c                  |   2 +-
 hw/display/xenfb.c                       |   2 +-
 hw/dma/Makefile.objs                     |   2 +
 hw/dma/i8257.c                           |   2 +-
 hw/dma/rc4030.c                          |   2 +-
 hw/dma/sparc32_dma.c                     |   2 +-
 hw/dma/sun4m_iommu.c                     |   2 +-
 hw/i386/Makefile.objs                    |   2 +
 hw/i386/x86-iommu.c                      |   2 +-
 hw/i386/xen/xen_platform.c               |   1 +
 hw/i386/xen/xen_pvdevice.c               |   1 +
 hw/input/Makefile.objs                   |   3 +
 hw/input/hid.c                           |   2 +-
 hw/input/milkymist-softusb.c             |   2 +-
 hw/input/ps2.c                           |   2 +-
 hw/input/virtio-input.c                  |   2 +-
 hw/intc/Makefile.objs                    |   2 +
 hw/intc/apic.c                           |   2 +-
 hw/intc/apic_common.c                    |   2 +-
 hw/intc/arm_gic.c                        |   2 +-
 hw/intc/arm_gicv3_cpuif.c                |   2 +-
 hw/intc/arm_gicv3_dist.c                 |   2 +-
 hw/intc/arm_gicv3_redist.c               |   2 +-
 hw/intc/aspeed_vic.c                     |   2 +-
 hw/intc/grlib_irqmp.c                    |   2 +-
 hw/intc/lm32_pic.c                       |   2 +-
 hw/intc/s390_flic.c                      |   2 +-
 hw/intc/s390_flic_kvm.c                  |   2 +-
 hw/intc/slavio_intctl.c                  |   2 +-
 hw/intc/xics.c                           |   2 +-
 hw/intc/xics_kvm.c                       |   2 +-
 hw/intc/xics_spapr.c                     |   2 +-
 hw/isa/Makefile.objs                     |   2 +
 hw/isa/pc87312.c                         |   2 +-
 hw/mem/Makefile.objs                     |   3 +
 hw/mem/pc-dimm.c                         |   2 +-
 hw/misc/Makefile.objs                    |   3 +
 hw/misc/aspeed_scu.c                     |   2 +-
 hw/misc/eccmemctl.c                      |   2 +-
 hw/misc/milkymist-hpdmc.c                |   2 +-
 hw/misc/milkymist-pfpu.c                 |   2 +-
 hw/misc/slavio_misc.c                    |   2 +-
 hw/net/Makefile.objs                     |   3 +
 hw/net/e1000e.c                          |   2 +-
 hw/net/e1000e_core.c                     |   2 +-
 hw/net/e1000x_common.c                   |   2 +-
 hw/net/lance.c                           |   2 +-
 hw/net/milkymist-minimac2.c              |   2 +-
 hw/net/mipsnet.c                         |   2 +-
 hw/net/net_rx_pkt.c                      |   2 +-
 hw/net/opencores_eth.c                   |   2 +-
 hw/net/pcnet-pci.c                       |   2 +-
 hw/net/pcnet.c                           |   2 +-
 hw/nvram/Makefile.objs                   |   2 +
 hw/nvram/ds1225y.c                       |   2 +-
 hw/nvram/fw_cfg.c                        |   2 +-
 hw/pci/Makefile.objs                     |   2 +
 hw/pci/pci.c                             |   2 +-
 hw/pci/pci_host.c                        |   2 +-
 hw/ppc/Makefile.objs                     |   3 +
 hw/ppc/ppc.c                             |   2 +-
 hw/ppc/prep.c                            |   2 +-
 hw/ppc/spapr.c                           |   2 +-
 hw/ppc/spapr_hcall.c                     |   2 +-
 hw/ppc/spapr_iommu.c                     |   2 +-
 hw/ppc/spapr_pci.c                       |   2 +-
 hw/ppc/spapr_rtas_ddw.c                  |   2 +-
 hw/s390x/Makefile.objs                   |   3 +
 hw/s390x/css.c                           |   2 +-
 hw/s390x/virtio-ccw.c                    |   2 +-
 hw/scsi/Makefile.objs                    |   3 +
 hw/scsi/esp-pci.c                        |   2 +-
 hw/scsi/esp.c                            |   2 +-
 hw/scsi/megasas.c                        |   2 +-
 hw/scsi/mptconfig.c                      |   2 +-
 hw/scsi/mptendian.c                      |   2 +-
 hw/scsi/mptsas.c                         |   2 +-
 hw/scsi/scsi-bus.c                       |   2 +-
 hw/scsi/vmw_pvscsi.c                     |   2 +-
 hw/sd/Makefile.objs                      |   2 +
 hw/sd/milkymist-memcard.c                |   2 +-
 hw/sparc/Makefile.objs                   |   2 +
 hw/sparc/leon3.c                         |   2 +-
 hw/sparc/sun4m.c                         |   2 +-
 hw/timer/Makefile.objs                   |   2 +
 hw/timer/aspeed_timer.c                  |   2 +-
 hw/timer/grlib_gptimer.c                 |   2 +-
 hw/timer/lm32_timer.c                    |   2 +-
 hw/timer/milkymist-sysctl.c              |   2 +-
 hw/timer/slavio_timer.c                  |   2 +-
 hw/usb/Makefile.objs                     |   3 +
 hw/usb/bus.c                             |   2 +-
 hw/usb/combined-packet.c                 |   2 +-
 hw/usb/core.c                            |   2 +-
 hw/usb/desc.c                            |   2 +-
 hw/usb/dev-hub.c                         |   2 +-
 hw/usb/dev-mtp.c                         |   2 +-
 hw/usb/dev-uas.c                         |   2 +-
 hw/usb/hcd-ehci.c                        |   2 +-
 hw/usb/hcd-ohci.c                        |   2 +-
 hw/usb/hcd-uhci.c                        |   2 +-
 hw/usb/hcd-xhci.c                        |   2 +-
 hw/usb/host-libusb.c                     |   2 +-
 hw/vfio/Makefile.objs                    |   2 +
 hw/vfio/common.c                         |   2 +-
 hw/vfio/pci-quirks.c                     |   2 +-
 hw/vfio/pci.c                            |   2 +-
 hw/vfio/platform.c                       |   2 +-
 hw/vfio/spapr.c                          |   2 +-
 hw/virtio/Makefile.objs                  |   2 +
 hw/virtio/virtio-balloon.c               |   2 +-
 hw/virtio/virtio-rng.c                   |   2 +-
 hw/virtio/virtio.c                       |   2 +-
 include/trace.h                          |   6 --
 io/Makefile.objs                         |   2 +
 io/channel-buffer.c                      |   2 +-
 io/channel-command.c                     |   2 +-
 io/channel-file.c                        |   2 +-
 io/channel-socket.c                      |   2 +-
 io/channel-tls.c                         |   2 +-
 io/channel-websock.c                     |   2 +-
 io/task.c                                |   2 +-
 linux-user/Makefile.objs                 |   2 +
 linux-user/signal.c                      |   2 +-
 migration/Makefile.objs                  |   2 +
 migration/exec.c                         |   2 +-
 migration/fd.c                           |   2 +-
 migration/migration.c                    |   2 +-
 migration/postcopy-ram.c                 |   2 +-
 migration/qemu-file.c                    |   2 +-
 migration/ram.c                          |   2 +-
 migration/rdma.c                         |   2 +-
 migration/savevm.c                       |   2 +-
 migration/socket.c                       |   2 +-
 migration/tls.c                          |   2 +-
 migration/vmstate.c                      |   2 +-
 net/Makefile.objs                        |   2 +
 net/filter-mirror.c                      |   2 +-
 net/vhost-user.c                         |   2 +-
 qapi/Makefile.objs                       |   2 +
 qapi/qapi-visit-core.c                   |   2 +-
 qom/Makefile.objs                        |   2 +
 qom/object.c                             |   2 +-
 qom/trace-events                         |   7 ++
 scripts/simpletrace.py                   |  10 ++-
 scripts/tracetool/backend/dtrace.py      |   2 +-
 scripts/tracetool/backend/ust.py         |   2 +-
 scripts/tracetool/format/ust_events_c.py |   2 +-
 scripts/tracetool/format/ust_events_h.py |   7 +-
 target/arm/Makefile.objs                 |   2 +
 target/arm/helper.c                      |   2 +-
 target/i386/Makefile.objs                |   2 +
 target/i386/kvm.c                        |   2 +-
 target/ppc/Makefile.objs                 |   2 +
 target/ppc/kvm.c                         |   2 +-
 target/s390x/Makefile.objs               |  21 +-----
 target/s390x/cpu.c                       |   2 +-
 target/s390x/ioinst.c                    |   2 +-
 target/s390x/kvm.c                       |   2 +-
 target/s390x/mmu_helper.c                |   2 +-
 target/sparc/Makefile.objs               |   2 +
 target/sparc/int32_helper.c              |   2 +-
 target/sparc/int64_helper.c              |   2 +-
 target/sparc/mmu_helper.c                |   2 +-
 target/sparc/win_helper.c                |   2 +-
 tests/Makefile.include                   |   2 +-
 trace-events                             |   6 --
 trace/Makefile.objs                      |  81 +--------------------
 ui/Makefile.objs                         |   3 +
 ui/console.c                             |   2 +-
 ui/gtk-egl.c                             |   2 +-
 ui/gtk-gl-area.c                         |   2 +-
 ui/gtk.c                                 |   2 +-
 ui/input.c                               |   2 +-
 ui/spice-display.c                       |   2 +-
 ui/vnc.c                                 |   2 +-
 util/Makefile.objs                       |   2 +
 util/buffer.c                            |   2 +-
 util/hbitmap.c                           |   2 +-
 util/oslib-posix.c                       |   2 +-
 util/oslib-win32.c                       |   2 +-
 util/qemu-coroutine-lock.c               |   2 +-
 util/qemu-coroutine.c                    |   2 +-
 250 files changed, 552 insertions(+), 388 deletions(-)
 delete mode 100644 include/trace.h

-- 
2.9.3
