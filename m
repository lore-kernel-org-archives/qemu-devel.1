Received: from eggs.gnu.org ([2001:4830:134:3::10]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tY-0000Q3-DE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tV-0002x0-1O
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:12 -0500
Received: from mail-eopbgr00138.outbound.protection.outlook.com
	([40.107.0.138]:58112
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9tU-0002u4-BA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:08 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:14 +0300
Message-Id: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 00/34] Hyper-V / VMBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

This is a work-in-progress series with Hyper-V / VMBus device emulation.
It's still very raw but it's testable so I'd appreciate feedback on
whether the design is sound.

This stuff can also be seen at https://src.openvz.org/scm/up/qemu.git.

Current status of the components included:

* Hyper-V infrastructure (SynIC, VP_INDEX, events & messages, etc):
  - works, mostly submission-ready but needs addressing some issues

* VMBus infrastructure (types, vmbus state machine, channel
  communication, etc):
  - works in main scenarios

* SCSI controller:
  - works in main scenarios
  - supports multiqueue
  - iothread-unaware
  - performance competitive to virtio-scsi [*]
  - can be used for booting [**]

* network interface:
  - basic operation only
  - no mac filtering
  - no offloads
  - no multiqueue
  - can be used for booting with limitations [***]

Overall, it's in bad need for documentation, tests, proper patch split.
Migration works but only tested very lightly.

[*] basic measurements with fio rw=randread bs=4k iodepth=256 using
    null-co backend give
    o Windows guests: hv-scsi 10%-30% better than virtio-scsi
    o Linux guests: hv-scsi 10%-20% worse than virtio-scsi
    No performance analysis has been done yet.

[**] patches for SeaBIOS and OVMF can be found at
     https://src.openvz.org/scm/up/seabios.git and
     https://src.openvz.org/scm/up/edk2.git

[***] patches for iPXE can be found at
      https://src.openvz.org/scm/up/ipxe.git, limitations:
      - OVMF is yet unsupported
      - iPXE takes over VMBus state management from SeaBIOS so after
        iPXE failure to boot off hv-net booting off hv-scsi doesn't work

Prerequisites:
 - KVM 4.14+
 - HYPERV_EVENTFD support (in kvm/queue) is optional but recommended for
   better performance

How to use:

# qemu \
    ... \
    -machine ...,accel=kvm,vmbus \
    -cpu ...,hv_vpindex,hv_synic,hv_stimer,(other hv_* recommended),kvm=off \
    -nodefaults \
    ...
    -device hv-scsi,(usual scsi props),(instanceid=<uuid> optional) \
    -drive ... \
    -device scsi-hd,... \
    ...
    -netdev ... \
    -device hv-net,(usual net props),(instanceid=<uuid> optional) \
    ...


Big kudos to Andrey Smetanin and Evgeny Yakovlev for their research and
prototyping.

Andrey Smetanin (1):
  i386: Hyper-V VMBus ACPI DSDT entry

Evgeny Yakovlev (1):
  vmbus: build configuration

Roman Kagan (32):
  hyperv: ensure VP index equal to QEMU cpu_index
  hyperv_testdev: refactor for readability
  hyperv: cosmetic: g_malloc -> g_new
  hyperv: synic: only setup ack notifier if there's a callback
  hyperv: allow passing arbitrary data to sint ack callback
  hyperv: address HvSintRoute by X86CPU pointer
  hyperv: make HvSintRoute reference-counted
  hyperv: qom-ify SynIC
  hyperv: block SynIC use in QEMU in incompatible configurations
  hyperv: make overlay pages for SynIC
  hyperv: add synic message delivery
  hyperv: add synic event flag signaling
  hyperv: process SIGNAL_EVENT hypercall
  hyperv: process POST_MESSAGE hypercall
  hyperv_testdev: add SynIC message and event testmodes
  hyperv: update copyright notices
  [not to commit] import HYPERV_EVENTFD stuff from kernel
  hyperv: add support for KVM_HYPERV_EVENTFD
  vmbus: add vmbus protocol definitions
  vmbus: vmbus implementation
  i386: en/disable vmbus by a machine property
  scsi: add Hyper-V/VMBus SCSI protocol definitions
  scsi: add Hyper-V/VMBus SCSI controller
  hv-scsi: limit the number of requests per notification
  tests: hv-scsi: add start-stop test
  net: add RNDIS definitions
  net: add Hyper-V/VMBus network protocol definitions
  net: add Hyper-V/VMBus net adapter
  hv-net: add .bootindex support
  loader: allow arbitrary basename for fw_cfg file roms
  vmbus: add support for rom files
  hv-net: define default rom file name

 configure                      |   11 +
 Makefile.objs                  |    1 +
 hw/net/hvnet-proto.h           | 1161 +++++++++++++++++++
 hw/net/rndis.h                 |  391 +++++++
 hw/scsi/hvscsi-proto.h         |  150 +++
 include/hw/i386/pc.h           |    8 +
 include/hw/loader.h            |    2 +-
 include/hw/vmbus/vmbus-proto.h |  222 ++++
 include/hw/vmbus/vmbus.h       |  109 ++
 include/sysemu/kvm.h           |    1 +
 linux-headers/linux/kvm.h      |   14 +
 target/i386/hyperv.h           |   40 +-
 accel/kvm/kvm-all.c            |   15 +
 hw/core/loader.c               |   43 +-
 hw/i386/acpi-build.c           |   42 +
 hw/i386/pc.c                   |   34 +
 hw/i386/pc_piix.c              |    5 +
 hw/i386/pc_q35.c               |    5 +
 hw/misc/hyperv_testdev.c       |  267 ++++-
 hw/net/hv-net.c                | 1450 +++++++++++++++++++++++
 hw/scsi/hv-scsi.c              |  403 +++++++
 hw/vmbus/vmbus.c               | 2475 ++++++++++++++++++++++++++++++++++++++++
 target/i386/hyperv.c           |  681 ++++++++++-
 target/i386/kvm.c              |   63 +-
 target/i386/machine.c          |    9 +
 tests/hv-scsi-test.c           |   57 +
 util/qemu-config.c             |    4 +
 hw/Makefile.objs               |    1 +
 hw/net/Makefile.objs           |    2 +
 hw/scsi/Makefile.objs          |    2 +
 hw/scsi/trace-events           |    6 +
 hw/vmbus/Makefile.objs         |    1 +
 hw/vmbus/trace-events          |    8 +
 tests/Makefile.include         |    3 +
 34 files changed, 7561 insertions(+), 125 deletions(-)
 create mode 100644 hw/net/hvnet-proto.h
 create mode 100644 hw/net/rndis.h
 create mode 100644 hw/scsi/hvscsi-proto.h
 create mode 100644 include/hw/vmbus/vmbus-proto.h
 create mode 100644 include/hw/vmbus/vmbus.h
 create mode 100644 hw/net/hv-net.c
 create mode 100644 hw/scsi/hv-scsi.c
 create mode 100644 hw/vmbus/vmbus.c
 create mode 100644 tests/hv-scsi-test.c
 create mode 100644 hw/vmbus/Makefile.objs
 create mode 100644 hw/vmbus/trace-events

-- 
2.14.3
