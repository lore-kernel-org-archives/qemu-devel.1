Received: from eggs.gnu.org ([2001:4830:134:3::10]:45856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhX4q-0007IU-EJ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhX4p-0001mo-JV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:19:52 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 15 Aug 2017 11:18:52 +0300
Message-Id: <20170815081854.14568-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 0/2] add internal backup job and
 write-threshold filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is part of my GSOC project, which is refactoring hardcoded block layer
features into filter drivers. Block filter drivers are inserted into the graph
only when a feature is needed. This makes the block layer more modular and
reuses the block driver abstraction that is already present.

Before write notifiers currently have two users:

block/backup.c uses before write notifiers to intercept write requests. This
can be refactored to use the filter driver interface by injecting an implicit
filter node to intercept the write requests and call backup_do_cow().

block/write-threshold.c checks that write requests do not pass a user set
offset and issue an event when they do. A new write-threshold driver can
perform the same function and be added by the user when
block-{insert,remove}-node are introduced. It is not trivial to convert the
existing interface (block-set-write-threshold) to using the filter driver.

v2:
  add motivation in commit messages
  dropped hunk that removed before-write notifiers

Manos Pitsidianakis (2):
  block: use internal filter node in backup
  block: add filter driver to block/write-threshold.c

 block.c                         |  89 ++++++++++++--
 block/backup.c                  | 207 +++++++++++++++++++++++++++----
 block/mirror.c                  |   7 +-
 block/qapi.c                    |   2 +-
 block/write-threshold.c         | 264 +++++++++++++++++++++++++++++++++++-----
 blockdev.c                      |   2 +-
 include/block/block.h           |   8 +-
 include/block/write-threshold.h |  22 ++--
 qapi/block-core.json            |  19 ++-
 tests/qemu-iotests/141.out      |   2 +-
 tests/test-write-threshold.c    |  40 +++---
 11 files changed, 557 insertions(+), 105 deletions(-)

-- 
2.11.0
