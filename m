Received: from eggs.gnu.org ([2001:4830:134:3::10]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cOfX7-0001DM-F2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cOfX1-0005pz-FA
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:58:49 -0500
Received: from [59.151.112.132] (port=45229 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cOfWz-0005lj-GH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:58:43 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 4 Jan 2017 14:58:09 +0800
Message-ID: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v3 0/2] block/qapi: refactor and optimize
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
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Change log v2 -> v3:
 1. Remove the unnecessary code for the bdrv_next_node().
 2. Remove the change of the locking rules.
    Even if this change can improve the performance, but it may
    effect the consistency.

For the multi-disks guest, we can use the dataplane feature to
hold performance does not drop, if we execute some slow monitor
commands, such as "info blockstats". But, without this feature, 
How to reduce the decline in performance?

These patches aim to refactor the qmp_query_blockstats() and
improve the performance by reducing the running time of it.

There are the two jobs:

1 For the performance:

1.1 the time it takes(ns) in each time:
the disk numbers     | 10    | 500
-------------------------------------
before these patches | 19429 | 667722 
after these patches  | 18536 | 627945

1.2 the I/O performance is degraded(%) during the monitor:

the disk numbers     | 10    | 500
-------------------------------------
before these patches | 1.3   | 14.2
after these patches  | 1.0   | 11.3

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

Dou Liyang (2):
  block/qapi: reduce the coupling between the bdrv_query_stats and
    bdrv_query_bds_stats
  block/qapi: reduce the execution time of qmp_query_blockstats

 block/qapi.c | 94 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 54 deletions(-)

-- 
2.5.5
