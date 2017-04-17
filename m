Received: from eggs.gnu.org ([2001:4830:134:3::10]:52073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpP-0005yM-J2
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpM-0004Lu-JL
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpM-0004L4-AH
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ECA84AEA8
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:22 +0200
Message-Id: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/19] Migration cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi

This is a cleanup on top of my previous series.  It does:
- create one .h file for each migration/* file
- export with meaningful include names the migration functions that we export
- untangle the includes mess (migration.h in8cluded vmstate.h who
  included qemu-file.h).  Fixed all callers.
- once there, old MigrationParams are gone.  Now block migration can be configured
  with migration capabilities like everything else in migration (old command line
  parameters  are maintained, but on top of this)
- start moving hmp* functions to monitor.c

ToDo:
- move the two remaining hmp commands to monitor.c

  really I should move them to block/* something, because they all use
  block functions, nothing from migration.c.

- savevm.c/vmstate.c/migration.c: they are still tangled, but I wanted
  to send the easy parts for review.

- half of the savevm.c functions are still exported from
  sysemu/sysemu.h moving that to a different file, have to think about
  it to make patches easier to understand.

- split capabilities/qmp commands/... from migration.c they don't
  belong there, and once they are out it would be easier to untangle
  the remaining bits.

- goal is still untangle normal migration/xbzrle/compression and rdma,
  they are still too untangled together.

- I can still remove some includes that are not needed, but with the
  current code, it gets really complicated until there is more cleanup there.

Please, comment.

Juan Quintela (19):
  migration: to_dst_file at that point is NULL
  migration: They are called vmstate_foo, move them to vmstate.c
  migration: Split migration/channel.c for channel operations
  migration: Remove MigrationState from migration_channel_incomming()
  migration: Export exec.c functions in its own file
  migration: Export fd.c functions in its own file
  migration: Export socket.c functions in its own file
  migration: Export tls.c functions in its own file
  migration: Create block capabilities for shared and enable
  migration: Remove use of old MigrationParams
  migration: Remove old MigrationParams
  migration: Remove unneeded includes
  migration: Remove qemu-file.h from vmstate.h
  migration: Remove vmstate.h from migration.h
  migration: Export qemu-file-channel.c functions in its own file
  migration: Export ram.c functions in its own file
  migration: Export rdma.c functions in its own file
  monitor: move hmp_savevm() to monitor.c
  monitor: remove monitor parameter from save_vmstate

 include/hw/hw.h                       |   1 +
 include/migration/channel.h           |  24 +++++++
 include/migration/colo.h              |   3 -
 include/migration/exec.h              |  20 ++++++
 include/migration/fd.h                |  20 ++++++
 include/migration/migration.h         |  86 ++-----------------------
 include/migration/qemu-file-channel.h |  22 +++++++
 include/migration/qemu-file.h         |   3 -
 include/migration/ram.h               |  54 ++++++++++++++++
 include/migration/rdma.h              |  22 +++++++
 include/migration/socket.h            |  25 ++++++++
 include/migration/tls.h               |  27 ++++++++
 include/migration/vmstate.h           |   4 --
 include/qemu/typedefs.h               |   1 -
 include/sysemu/sysemu.h               |   6 +-
 migration/Makefile.objs               |   2 +-
 migration/block.c                     |  26 ++------
 migration/channel.c                   |  72 +++++++++++++++++++++
 migration/colo-comm.c                 |   2 +-
 migration/colo-failover.c             |   1 +
 migration/colo.c                      |   8 +--
 migration/exec.c                      |   6 +-
 migration/fd.c                        |   6 +-
 migration/migration.c                 | 116 +++++++++++++++-------------------
 migration/postcopy-ram.c              |   4 +-
 migration/qemu-file-channel.c         |   2 +-
 migration/qemu-file.c                 |   4 +-
 migration/ram.c                       |   5 +-
 migration/rdma.c                      |   5 +-
 migration/savevm.c                    |  63 ++++--------------
 migration/socket.c                    |   6 +-
 migration/tls.c                       |   5 +-
 migration/vmstate.c                   |  16 +++++
 monitor.c                             |   5 ++
 qapi-schema.json                      |   7 +-
 replay/replay-snapshot.c              |   2 +-
 36 files changed, 417 insertions(+), 264 deletions(-)
 create mode 100644 include/migration/channel.h
 create mode 100644 include/migration/exec.h
 create mode 100644 include/migration/fd.h
 create mode 100644 include/migration/qemu-file-channel.h
 create mode 100644 include/migration/ram.h
 create mode 100644 include/migration/rdma.h
 create mode 100644 include/migration/socket.h
 create mode 100644 include/migration/tls.h
 create mode 100644 migration/channel.c

-- 
2.9.3
