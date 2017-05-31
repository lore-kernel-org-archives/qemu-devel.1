Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG0yD-0004TQ-76
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG0yB-00022a-RJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dG0yB-00022S-Ir
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:35:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7137080F7B
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 10:35:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 31 May 2017 12:34:59 +0200
Message-Id: <20170531103509.22021-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/10] Another cleanup of includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

Changes from v1:
- patch 1 got reviewed on the pull request
- drop one change from patch2 as lvivier comments
- fix include of snapshot.h

Please review.

Thanks, Juan.


{v1}
- make all migration methods export its functions in its own header
- move block.h into migration/
- create migration/savevm.h for functions exported in savevm.c
- create migration/ram.h for functions from ram.c
- split qemu-file.h into it an qemu-file-types.h
  only the last one is used outside of migration/
- move migration.h to be private
- create include/migration/misc.h for misc exported functions that
  don't belong anywhere




Juan Quintela (10):
  migration: Remove unneeded includes of migration/vmstate.h
  migration: Split qemu-file.h
  migration: Export exec.c functions in its own file
  migration: Export fd.c functions in its own file
  migration: Export socket.c functions in its own file
  migration: Export tls.c functions in its own file
  migration: Export rdma.c functions in its own file
  migration: Create include for migration snapshots
  migration: Export ram.c functions in its own file
  migration: Move include/migration/block.h into migration/

 hmp.c                                        |   5 +-
 hw/core/qdev.c                               |   1 -
 hw/i2c/i2c-ddc.c                             |   1 +
 hw/intc/s390_flic.c                          |   1 -
 hw/intc/s390_flic_kvm.c                      |   1 -
 hw/s390x/s390-skeys.c                        |   1 -
 include/block/block_int.h                    |   4 +-
 include/hw/acpi/memory_hotplug.h             |   1 -
 include/hw/acpi/pcihp.h                      |   1 -
 include/hw/hw.h                              |   2 +-
 include/hw/pci/shpc.h                        |   1 -
 include/migration/migration.h                |  68 -----------
 include/migration/misc.h                     |  29 +++++
 include/migration/qemu-file-types.h          | 164 +++++++++++++++++++++=
++++++
 include/migration/snapshot.h                 |  21 ++++
 include/sysemu/sysemu.h                      |   3 -
 migration/block.c                            |   5 +-
 {include/migration =3D> migration}/block.h     |   2 -
 migration/channel.c                          |   1 +
 migration/colo.c                             |   4 +-
 migration/exec.c                             |   1 +
 migration/exec.h                             |  26 +++++
 migration/fd.c                               |   1 +
 migration/fd.h                               |  23 ++++
 migration/migration.c                        |  10 +-
 migration/postcopy-ram.c                     |   3 +-
 migration/qemu-file-channel.c                |   3 +-
 migration/qemu-file.c                        |   2 +-
 {include/migration =3D> migration}/qemu-file.h | 157 +------------------=
------
 migration/ram.c                              |   4 +-
 migration/ram.h                              |  70 ++++++++++++
 migration/rdma.c                             |   5 +-
 migration/rdma.h                             |  25 ++++
 migration/savevm.c                           |   7 +-
 migration/socket.c                           |   3 +-
 migration/socket.h                           |  28 +++++
 migration/tls.c                              |   1 +
 migration/tls.h                              |  34 ++++++
 migration/vmstate-types.c                    |   3 +-
 migration/vmstate.c                          |   2 +-
 replay/replay-snapshot.c                     |   5 +-
 target/alpha/cpu.c                           |   1 -
 target/hppa/cpu.c                            |   1 -
 target/s390x/cpu.c                           |   1 -
 target/tilegx/cpu.c                          |   1 -
 tests/test-vmstate.c                         |   3 +-
 vl.c                                         |   5 +-
 47 files changed, 476 insertions(+), 265 deletions(-)
 create mode 100644 include/migration/misc.h
 create mode 100644 include/migration/qemu-file-types.h
 create mode 100644 include/migration/snapshot.h
 rename {include/migration =3D> migration}/block.h (93%)
 create mode 100644 migration/exec.h
 create mode 100644 migration/fd.h
 rename {include/migration =3D> migration}/qemu-file.h (62%)
 create mode 100644 migration/ram.h
 create mode 100644 migration/rdma.h
 create mode 100644 migration/socket.h
 create mode 100644 migration/tls.h

--=20
2.9.4
