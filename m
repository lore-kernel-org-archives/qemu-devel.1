Received: from eggs.gnu.org ([2001:4830:134:3::10]:57014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiTy-00012c-IL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiTv-0003II-Eo
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiTv-0003Hr-6w
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D054680F5
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:06 +0200
Message-Id: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Migration PULL request
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

This pull request includes:
- don't set errp directly (eduardo)
- isolate return path (peter)
- rest of consistent output series
- 10 first patches of the misc cleanup series

Please, apply.

Thanks, Juan.

The following changes since commit 9bba618f18b1a60a3f2668db82b453f6cd9467=
c0:

  Merge remote-tracking branch 'remotes/elmarco/tags/char-pull-request' i=
nto staging (2017-06-12 19:26:49 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170613

for you to fetch changes up to 6666c96aac9151568736226dec99aa8acb14d07c:

  migration: Move migration.h to migration/ (2017-06-13 11:00:45 +0200)

----------------------------------------------------------------
migration/next for 20170613

----------------------------------------------------------------
Eduardo Habkost (1):
      migration: Don't try to set *errp directly

Juan Quintela (12):
      ram: Print block stats also in the complete case
      ram: Now POSTCOPY_ACTIVE is the same that STATUS_ACTIVE
      migration: Remove MigrationState from migration_channel_incomming()
      migration: Move self_announce_delay() to misc.h
      migration: Split registration functions from vmstate.h
      migration: Move dump_vmsate_json_to_file() to misc.h
      migration: Move constants to savevm.h
      migration: Commands are only used inside migration.c
      migration: ram_control_* are implemented in qemu_file
      migration: create global_state.c
      migration: Move remaining exported functions to migration/misc.h
      migration: Move migration.h to migration/

Peter Xu (1):
      migration: isolate return path on src

 hw/i386/pc_piix.c                            |   3 +-
 hw/net/virtio-net.c                          |   1 +
 hw/net/vmxnet3.c                             |   1 +
 hw/ppc/spapr.c                               |   4 +-
 hw/s390x/s390-skeys.c                        |   1 +
 hw/s390x/s390-virtio-ccw.c                   |   1 +
 hw/xen/xen-common.c                          |   3 +-
 include/migration/global_state.h             |  25 +++
 include/migration/misc.h                     |  26 +++
 include/migration/register.h                 |  56 +++++++
 include/migration/vmstate.h                  |  50 ------
 migration/Makefile.objs                      |   2 +-
 migration/block.c                            |   3 +-
 migration/channel.c                          |   7 +-
 migration/channel.h                          |   3 +-
 migration/colo-comm.c                        |   2 +-
 migration/colo.c                             |   2 +-
 migration/exec.c                             |   4 +-
 migration/fd.c                               |   4 +-
 migration/global_state.c                     | 140 +++++++++++++++++
 migration/migration.c                        | 226 ++++++---------------=
------
 {include/migration =3D> migration}/migration.h |  65 --------
 migration/postcopy-ram.c                     |   2 +-
 migration/qemu-file.c                        |   2 +-
 migration/qemu-file.h                        |  17 ++
 migration/ram.c                              |   3 +-
 migration/rdma.c                             |   2 +-
 migration/savevm.c                           |   5 +-
 migration/savevm.h                           |  15 ++
 migration/socket.c                           |   5 +-
 migration/tls.c                              |   4 +-
 migration/trace-events                       |   4 +-
 migration/vmstate-types.c                    |   2 +-
 migration/vmstate.c                          |   3 +-
 qdev-monitor.c                               |   2 +-
 slirp/slirp.c                                |   1 +
 tests/test-vmstate.c                         |   3 +-
 ui/spice-core.c                              |   2 +-
 vl.c                                         |   2 +-
 39 files changed, 380 insertions(+), 323 deletions(-)
 create mode 100644 include/migration/global_state.h
 create mode 100644 include/migration/register.h
 create mode 100644 migration/global_state.c
 rename {include/migration =3D> migration}/migration.h (63%)
