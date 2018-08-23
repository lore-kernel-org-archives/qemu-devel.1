Received: from eggs.gnu.org ([2001:4830:134:3::10]:40824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fsrp9-0002jp-Sm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fsrp6-0007SK-LP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 23 Aug 2018 18:46:52 +0300
Message-Id: <20180823154655.40188-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/3] block nodes graph visualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

Hi all!

On the way of backup schemes development (and in general any complicated
developments in Qemu block layer) it would be good to have an ability to print
out graph of block nodes with their permissions. Just look at attached picture.

v3: again, major rework, after long discussion with Max:
   - start creating graph looping through blk's and block jobs, don't use opaque
   - don't export pointers, generate ids instead
   (graphical representation didn't significantly changed, you can look at the
    picture, attached to v2 cover-letter)

v2: major rework: Identifying non-bds nodes by their description was a bad idea,
descriptions are not guaranteed to be different for different nodes. So, the only
way is use pointer to identify them. And to be unique, let's use pointers to
identify all the nodes in the graph. As additional benefit, we have pointers for
each node, which is good for debugging (imagine a gdb session).

Vladimir Sementsov-Ogievskiy (3):
  qapi: add x-debug-query-block-graph
  scripts: add render_block_graph function for QEMUMachine
  not-for-commit: example of new command usage for debugging

 qapi/block-core.json           |  91 +++++++++++++++++++++++
 include/block/block.h          |   1 +
 include/sysemu/block-backend.h |   2 +
 block.c                        | 129 +++++++++++++++++++++++++++++++++
 block/block-backend.c          |   5 ++
 blockdev.c                     |   5 ++
 scripts/render_block_graph.py  | 120 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/222         |   2 +
 8 files changed, 355 insertions(+)
 create mode 100755 scripts/render_block_graph.py

-- 
2.18.0
