Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2ze-0003CH-4y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2zY-00011C-Nu
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV2zY-0000sN-EJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 646CB81F0B
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:35 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-16.ams2.redhat.com
	[10.36.112.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0EBC6155E
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  7 Dec 2018 00:23:27 +0100
Message-Id: <20181206232333.22408-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 0/6] qemu/queue.h usage cleanup,
 improved QTAILQ API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This series includes two changes that are a bit intertwined.

The main one is to reimplement QTAILQ in a way that simplifies
backwards walking of the list.  The in-memory layout actually
stays the same, but the C description of it changes so that
(also thanks to typeof) you don't have to specify a name for
the "head" struct in QTAILQ_{LAST,PREV,FOREACH_REVERSE}.
This is done in patches 1, 4 and 5.

Once you do this, you actually almost never need to define
a named head struct.  Therefore, the series also cleans up
other cases where the struct was given a name unnecessarily,
and ensures that those queue.h structs are given a typedef
and a camel case name, similar to all other structs in QEMU.
This is done in patches 2 and 3, and at the end of the series
we can add a checkpatch test for it in patch 6.

Paolo Bonzini (6):
  qemu/queue.h: do not access tqe_prev directly
  qemu/queue.h: leave head structs anonymous unless necessary
  qemu/queue.h: typedef QTAILQ heads
  qemu/queue.h: reimplement QTAILQ without pointer-to-pointers
  qemu/queue.h: simplify reverse access to QTAILQ
  checkpatch: warn about queue/queue.h head structs that are not
    typedef-ed

 accel/kvm/kvm-all.c                     |   4 +-
 block/gluster.c                         |   2 +-
 block/mirror.c                          |   2 +-
 block/qcow2-bitmap.c                    |   4 +-
 block/qcow2.h                           |   2 +-
 block/sheepdog.c                        |   6 +-
 block/vhdx.h                            |   2 +-
 blockdev.c                              |   4 +-
 contrib/ivshmem-client/ivshmem-client.h |   4 +-
 contrib/ivshmem-server/ivshmem-server.h |   5 +-
 cpus-common.c                           |   2 +-
 dump.c                                  |   2 +-
 exec.c                                  |   5 +-
 fsdev/qemu-fsdev.c                      |   2 +-
 hw/block/nvme.h                         |   8 +-
 hw/block/xen_disk.c                     |   6 +-
 hw/core/qdev.c                          |   4 +-
 hw/core/reset.c                         |   2 +-
 hw/i386/xen/xen-mapcache.c              |   2 +-
 hw/ppc/spapr_iommu.c                    |   2 +-
 hw/scsi/scsi-bus.c                      |   2 +-
 hw/usb/ccid-card-emulated.c             |   4 +-
 hw/usb/combined-packet.c                |   2 +-
 hw/usb/dev-mtp.c                        |   4 +-
 hw/usb/dev-network.c                    |   2 +-
 hw/usb/hcd-ehci.c                       |   2 +-
 hw/usb/hcd-ehci.h                       |   2 +-
 hw/usb/hcd-uhci.c                       |   4 +-
 hw/usb/xen-usb.c                        |   6 +-
 hw/vfio/common.c                        |   4 +-
 hw/watchdog/watchdog.c                  |   2 +-
 hw/xen/xen_pvdev.c                      |   4 +-
 include/exec/memory.h                   |   6 +-
 include/hw/qdev-core.h                  |   2 +-
 include/hw/usb.h                        |   2 +-
 include/hw/vfio/vfio-common.h           |   4 +-
 include/hw/vfio/vfio-platform.h         |   2 +-
 include/net/net.h                       |   2 +-
 include/qemu/option_int.h               |   2 +-
 include/qemu/queue.h                    | 151 +++++++++++-------------
 include/qemu/rcu_queue.h                |  45 +++----
 include/qom/cpu.h                       |   9 +-
 include/sysemu/kvm.h                    |   2 -
 include/sysemu/memory_mapping.h         |   2 +-
 include/sysemu/rng.h                    |   2 +-
 linux-user/elfload.c                    |   2 +-
 memory.c                                |  19 ++-
 memory_mapping.c                        |   2 +-
 migration/block-dirty-bitmap.c          |   2 +-
 migration/block.c                       |   4 +-
 migration/ram.c                         |   2 +-
 monitor.c                               |   4 +-
 net/filter.c                            |   2 +-
 net/net.c                               |   2 +-
 net/queue.c                             |   2 +-
 net/slirp.c                             |   2 +-
 qga/commands-posix.c                    |   2 +-
 scripts/checkpatch.pl                   |   5 +
 scripts/cocci-macro-file.h              |  24 ++--
 slirp/slirp.c                           |   2 +-
 target/arm/kvm.c                        |   2 +-
 target/i386/hax-mem.c                   |   2 +-
 tcg/tcg.c                               |   2 +-
 tcg/tcg.h                               |   6 +-
 tests/libqos/malloc.c                   |   2 +-
 tests/test-rcu-list.c                   |   2 +-
 tests/test-vmstate.c                    |   8 +-
 ui/console.c                            |   4 +-
 ui/input.c                              |  14 ++-
 util/qemu-option.c                      |   4 +-
 vl.c                                    |   2 +-
 71 files changed, 216 insertions(+), 247 deletions(-)

--=20
2.19.2
