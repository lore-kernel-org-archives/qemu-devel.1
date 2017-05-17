Received: from eggs.gnu.org ([2001:4830:134:3::10]:42673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1BI-0008VX-HD
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1BD-0000iQ-HT
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB1BD-0000iG-8F
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 327ED796E5
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:48:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 17:47:47 +0200
Message-Id: <20170517154756.22079-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/9] Migration mini-cleanup
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

Changes from v3

- dropped movement of colo*h headers
  they are used in other palaces in patches outside the tree
- Change the license of vmstate*c files to GPL v2+
  Dave noted that I was using the wrong text
- page_cache.c movement was already reviewd and it has no conflicts,
  moved to pull request.

Please, review

Thanks, Juan.


[v3]
Due to popular demand, and to make reviews easier, I just split the
big cleanup series (41 patches) in small chunks.  This chunk just
include the easy patches:

- create several include files foo.h for functcions exported from foo.c
- split channel operations in channel.c
- move colo headers to migration/
- split vmstate-types.c from vmstate.c (now it only contains the interpre=
ter)
- untangle qemu-file.h, vmstate.h and migration.h.  Now none include the =
other
  fix all callers.
- Remove uses of migration.h that are not needed


Juan Quintela (9):
  migration: Create migration/xbzrle.h
  migration: Split migration/channel.c for channel operations
  migration: Export qemu-file-channel.c functions in its own file
  migration: Remove migration.h from colo.h
  migration: Move qjson.h to migration/
  migration: Split vmstate-types.c from vmstate.c
  migration: Remove qemu-file.h from vmstate.h
  migration: Remove vmstate.h from migration.h
  migration: migration.h was not needed

 block/qed.c                              |   1 -
 hw/i386/pc_q35.c                         |   1 -
 hw/virtio/vhost-user.c                   |   1 -
 hw/virtio/vhost-vsock.c                  |   1 -
 hw/virtio/virtio.c                       |   1 -
 include/hw/hw.h                          |   1 +
 include/migration/colo.h                 |   1 -
 include/migration/migration.h            |  13 +-
 include/migration/qemu-file.h            |   4 -
 include/migration/vmstate.h              |   3 -
 migration/Makefile.objs                  |   4 +-
 migration/block.c                        |   2 +
 migration/channel.c                      |  70 ++++
 migration/channel.h                      |  25 ++
 migration/colo-comm.c                    |   4 +-
 migration/colo.c                         |   3 +
 migration/exec.c                         |   1 +
 migration/fd.c                           |   1 +
 migration/migration.c                    |  52 +--
 migration/postcopy-ram.c                 |   1 +
 migration/qemu-file-channel.c            |   1 +
 migration/qemu-file-channel.h            |  21 +
 migration/qjson.c                        |   2 +-
 {include/migration =3D> migration}/qjson.h |   0
 migration/ram.c                          |   3 +
 migration/rdma.c                         |   1 +
 migration/savevm.c                       |   1 +
 migration/socket.c                       |   1 +
 migration/tls.c                          |   1 +
 migration/vmstate-types.c                | 661 +++++++++++++++++++++++++=
++++++
 migration/vmstate.c                      | 656 +------------------------=
-----
 migration/xbzrle.c                       |   2 +-
 migration/xbzrle.h                       |  21 +
 monitor.c                                |   1 -
 tests/Makefile.include                   |   2 +-
 tests/test-vmstate.c                     |   2 +
 tests/test-xbzrle.c                      |   2 +-
 37 files changed, 842 insertions(+), 726 deletions(-)
 create mode 100644 migration/channel.c
 create mode 100644 migration/channel.h
 create mode 100644 migration/qemu-file-channel.h
 rename {include/migration =3D> migration}/qjson.h (100%)
 create mode 100644 migration/vmstate-types.c
 create mode 100644 migration/xbzrle.h

--=20
2.9.3
