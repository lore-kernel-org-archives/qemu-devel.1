Received: from eggs.gnu.org ([2001:4830:134:3::10]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9tV4-00085d-GU
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9tUs-0006yg-2k
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:37 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  9 Oct 2018 18:00:03 +0300
Message-Id: <20181009150006.10712-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/3] block nodes graph visualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

On the way of backup schemes development (and in general any complicated
developments in Qemu block layer) it would be good to have an ability to print
out graph of block nodes with their permissions.

v4:
01: - improve documentation and graph node type names
    - parentheses in macro
    - s/hash/graph_nodes
    - add dbg_ prefix to graph functions
    - free leaked gr in dbg_graph_finalize()
    - use uintptr_t and "!= 0" for hash keys, add comment
      about reserved 0 key
    - add const specifier for permissions array and iterator,
      add static on permissions array size
    - fall back to blk_get_attached_dev_id() for block-backend
      nodes if blk_name() returns NULL 
02: - add a-b by Eduardo and r-b by Max
    - change graph node type names (rebase on 01 change)

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

 qapi/block-core.json           | 108 ++++++++++++++++++++++++
 include/block/block.h          |   1 +
 include/sysemu/block-backend.h |   2 +
 block.c                        | 146 +++++++++++++++++++++++++++++++++
 block/block-backend.c          |   5 ++
 blockdev.c                     |   5 ++
 scripts/render_block_graph.py  | 120 +++++++++++++++++++++++++++
 tests/qemu-iotests/222         |   2 +
 8 files changed, 389 insertions(+)
 create mode 100755 scripts/render_block_graph.py

-- 
2.18.0
