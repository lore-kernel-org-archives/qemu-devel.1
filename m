Received: from eggs.gnu.org ([2001:4830:134:3::10]:48101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D06-0002Ke-SR
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D03-0004rA-Gw
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D02-0004qG-U6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A62FBC05AA67
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:43 +0200
Message-Id: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/12] Migration mini-cleanup
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

Due to popular demand, and to make reviews easier, I just split the
big cleanup series (41 patches) in small chunks.  This chunk just
include the easy patches:

- create several include files foo.h for functcions exported from foo.c
- split channel operations in channel.c
- move colo headers to migration/
- split vmstate-types.c from vmstate.c (now it only contains the interpreter)
- untangle qemu-file.h, vmstate.h and migration.h.  Now none include the other
  fix all callers.
- Remove uses of migration.h that are not needed

Please, review.

Thanks, Juan.


Juan Quintela (12):
  migration: Create migration/xbzrle.h
  migration: Split migration/channel.c for channel operations
  migration: Export qemu-file-channel.c functions in its own file
  migration: Remove migration.h from colo.h
  migration: Move colo.h to migration/
  migration: Move failover.h to migration/colo-failover.h
  migration: Move page_cache.c to migration/
  migration: Move qjson.h to migration/
  migration: Split vmstate-types.c from vmstate.c
  migration: Remove qemu-file.h from vmstate.h
  migration: Remove vmstate.h from migration.h
  migration: migration.h was not needed

 MAINTAINERS                                        |   4 +-
 Makefile.objs                                      |   1 -
 block/qed.c                                        |   1 -
 hw/i386/pc_q35.c                                   |   1 -
 hw/virtio/vhost-user.c                             |   1 -
 hw/virtio/vhost-vsock.c                            |   1 -
 hw/virtio/virtio.c                                 |   1 -
 include/hw/hw.h                                    |   1 +
 include/migration/migration.h                      |  13 +-
 include/migration/qemu-file.h                      |   4 -
 include/migration/vmstate.h                        |   3 -
 migration/Makefile.objs                            |   4 +-
 migration/block.c                                  |   2 +
 migration/channel.c                                |  70 +++
 migration/channel.h                                |  25 +
 migration/colo-comm.c                              |   4 +-
 migration/colo-failover.c                          |   4 +-
 .../failover.h => migration/colo-failover.h        |   0
 migration/colo.c                                   |   5 +-
 {include/migration => migration}/colo.h            |   1 -
 migration/exec.c                                   |   1 +
 migration/fd.c                                     |   1 +
 migration/migration.c                              |  54 +-
 page_cache.c => migration/page_cache.c             |   0
 {include/migration => migration}/page_cache.h      |   0
 migration/postcopy-ram.c                           |   1 +
 migration/qemu-file-channel.c                      |   1 +
 migration/qemu-file-channel.h                      |  21 +
 migration/qjson.c                                  |   2 +-
 {include/migration => migration}/qjson.h           |   0
 migration/ram.c                                    |   5 +-
 migration/rdma.c                                   |   1 +
 migration/savevm.c                                 |   1 +
 migration/socket.c                                 |   1 +
 migration/tls.c                                    |   1 +
 migration/vmstate-types.c                          | 676 +++++++++++++++++++++
 migration/vmstate.c                                | 671 +-------------------
 migration/xbzrle.c                                 |   2 +-
 migration/xbzrle.h                                 |  21 +
 monitor.c                                          |   1 -
 tests/Makefile.include                             |   4 +-
 tests/test-vmstate.c                               |   2 +
 tests/test-xbzrle.c                                |   2 +-
 43 files changed, 880 insertions(+), 735 deletions(-)
 create mode 100644 migration/channel.c
 create mode 100644 migration/channel.h
 rename include/migration/failover.h => migration/colo-failover.h (100%)
 rename {include/migration => migration}/colo.h (96%)
 rename page_cache.c => migration/page_cache.c (100%)
 rename {include/migration => migration}/page_cache.h (100%)
 create mode 100644 migration/qemu-file-channel.h
 rename {include/migration => migration}/qjson.h (100%)
 create mode 100644 migration/vmstate-types.c
 create mode 100644 migration/xbzrle.h

-- 
2.9.3
