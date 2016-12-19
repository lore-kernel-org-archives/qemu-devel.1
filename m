Received: from eggs.gnu.org ([2001:4830:134:3::10]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgD-0004B5-7b
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItg8-0007yT-DO
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:21 -0500
Received: from [59.151.112.132] (port=17864 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItg6-0007mf-PI
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:16 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Mon, 19 Dec 2016 16:51:22 +0800
Message-ID: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and optimize
 the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com

These patches aim to refactor the qmp_query_blockstats() and
improve the performance by reducing the running time of it.

qmp_query_blockstats() is used to monitor the blockstats, it
querys all the graph_bdrv_states or monitor_block_backends.

There are the two jobs:

1 For the performance:

1.1 the time it takes(ns) in each time:
the disk numbers     | 10    | 500
-------------------------------------
before these patches | 19429 | 667722 
after these patches  | 17516 | 557044

1.2 the I/O performance is degraded(%) during the monitor:

the disk numbers     | 10    | 500
-------------------------------------
before these patches | 1.3   | 14.2
after these patches  | 0.8   | 9.1

used the dd command likes this to test: 
dd if=date_1.dat of=date_2.dat conv=fsync oflag=direct bs=1k count=100k.

2 refactor qmp_query_blockstats():

From:

+--------------+      +---------------------+
 | 1            |      | 4.                  |
 |next_query_bds|      |bdrv_query_bds_stats +---+
 |              |      |                     |   |
 +--------^-----+      +-------------^-------+   |
          |                          |           |
+---------+----------+      +--------+-------+   |
| 0.                 |      | 2.             |   |
|qmp_query_blockstats+------>bdrv_query_stats<----
|                    |      |                |
+--------------------+      +--------+-------+
                                     |
                       +-------------v-------+
                       | 3.                  |
                       |bdrv_query_blk_stats |
                       |                     |
                       +---------------------+

To:

                                    +--------------+
                                    |              |
                           +--------v-----------+  |
                       +--->  3.                |  |
+-------------------+  |   |bdrv_query_bds_stats+--+
| 1.                +--+   |                    |
|                   +      +--------------------+
|qmp_query_blockstats--+
|                   |  |
+-------------------+  |   +--------------------+
                       |   | 2.                 |
                       +--->                    |
                           |bdrv_query_blk_stats|
                           |                    |
                           +--------------------+


Dou Liyang (4):
  block: refactor the bdrv_next_node and add some comments
  block/qapi: reduce the coupling between the bdrv_query_stats and
    bdrv_query_bds_stats
  block/qapi: acquire a reference instead of a lock during querying
    blockstats
  block/qapi: optimize the query function of the blockstats

 block.c      | 16 ++++++++---
 block/qapi.c | 92 +++++++++++++++++++++++++-----------------------------------
 2 files changed, 50 insertions(+), 58 deletions(-)

-- 
2.5.5
