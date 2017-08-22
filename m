Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9Cz-0002Ji-Oy
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9Cy-0002w0-Ke
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:27:05 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Aug 2017 15:18:22 +0200
Message-Id: <20170822131832.20191-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/10] scsi,
 block: introduce persistent reservation managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com

SCSI persistent Reservations allow restricting access to block devices
to specific initiators in a shared storage setup.  When implementing
clustering of virtual machines, it is a common requirement for virtual
machines to send persistent reservation SCSI commands.  However,
the operating system restricts sending these commands to unprivileged
programs because incorrect usage can disrupt regular operation of the
storage fabric.

With these patches, the scsi-block and scsi-generic SCSI passthrough
devices learn to delegate the implementation of persistent reservations to
a separate object, the "persistent reservation manager".  The persistent
reservation manager talks to a separate privileged program, with a very
simple protocol based on SCM_RIGHTS.  In addition to invoking PERSISTENT
RESERVATION OUT and PERSISTENT RESERVATION IN commands, the privileged
component can also use libmpathpersist so that persistent reservations
are applied to all paths in a multipath setting.

Patches 1-5 introduce a common scsi/ directory used by block/iscsi.c,
hw/scsi/* and now by the persistent reservation helper.

Patch 6 defines the abstract QOM class and plugs it into block/file-posix.c.

Patch 7 to 9 introduce the privileged helper program, while patch 10
defines the concrete QOM class that talks to it.

Paolo

Paolo Bonzini (10):
  scsi: rename scsi_convert_sense
  scsi: move non-emulation specific code to scsi/
  scsi: introduce scsi_build_sense
  scsi: introduce sg_io_sense_from_errno
  scsi: move block/scsi.h to include/scsi/constants.h
  scsi, file-posix: add support for persistent reservation management
  io: add qio_channel_read/write_all
  scsi: build qemu-pr-helper
  scsi: add multipath support to qemu-pr-helper
  scsi: add persistent reservation manager using qemu-pr-helper

 MAINTAINERS                                |   7 +
 Makefile                                   |  12 +-
 Makefile.objs                              |   3 +-
 block/file-posix.c                         |  30 +
 block/iscsi.c                              |   2 +-
 configure                                  |  59 +-
 docs/interop/pr-helper.rst                 |  78 +++
 docs/pr-manager.rst                        | 111 ++++
 hw/block/virtio-blk.c                      |   2 +-
 hw/scsi/megasas.c                          |   2 +-
 hw/scsi/mptendian.c                        |   2 +-
 hw/scsi/mptsas.c                           |   2 +-
 hw/scsi/scsi-bus.c                         | 411 +-----------
 hw/scsi/scsi-disk.c                        |   6 +-
 hw/scsi/scsi-generic.c                     |  50 +-
 hw/scsi/spapr_vscsi.c                      |   2 +-
 hw/scsi/virtio-scsi-dataplane.c            |   2 +-
 hw/scsi/virtio-scsi.c                      |   2 +-
 hw/scsi/vmw_pvscsi.c                       |   2 +-
 hw/usb/dev-uas.c                           |   2 +-
 include/hw/ide/internal.h                  |   2 +-
 include/hw/scsi/scsi.h                     |  94 +--
 include/io/channel.h                       |  36 +-
 include/{block/scsi.h => scsi/constants.h} |   2 -
 include/scsi/pr-manager.h                  |  57 ++
 include/scsi/utils.h                       | 127 ++++
 io/channel.c                               |  54 ++
 qapi/block-core.json                       |   4 +
 scsi/Makefile.objs                         |   3 +
 scsi/pr-helper.h                           |  13 +
 scsi/pr-manager-helper.c                   | 288 +++++++++
 scsi/pr-manager.c                          | 109 ++++
 scsi/qemu-pr-helper.c                      | 964 +++++++++++++++++++++++++++++
 scsi/utils.c                               | 464 ++++++++++++++
 tests/virtio-scsi-test.c                   |   2 +-
 vl.c                                       |   3 +-
 36 files changed, 2442 insertions(+), 567 deletions(-)
 create mode 100644 docs/interop/pr-helper.rst
 create mode 100644 docs/pr-manager.rst
 rename include/{block/scsi.h => scsi/constants.h} (99%)
 create mode 100644 include/scsi/pr-manager.h
 create mode 100644 include/scsi/utils.h
 create mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/pr-helper.h
 create mode 100644 scsi/pr-manager-helper.c
 create mode 100644 scsi/pr-manager.c
 create mode 100644 scsi/qemu-pr-helper.c
 create mode 100644 scsi/utils.c

-- 
2.13.5
