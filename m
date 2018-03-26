Received: from eggs.gnu.org ([2001:4830:134:3::10]:45392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEN-0002yB-Ja
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEM-0003vj-IP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:43 +0200
Message-Id: <20180326143600.7724-3-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/19] block/replication: Remove protocol_name
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fabiano Rosas <farosas@linux.vnet.ibm.com>

The protocol_name field is used when selecting a driver via protocol
syntax (i.e. <protocol_name>:<filename:options:...>). Drivers that are
only selected explicitly (e.g. driver=replication,mode=primary,...)
should not have a protocol_name.

This patch removes the protocol_name field from the brdv_replication
structure so that attempts to invoke this driver using protocol syntax
will fail gracefully:

  $ qemu-img info replication:foo
  qemu-img: Could not open 'replication:': Unknown protocol 'replication'

Buglink: https://bugs.launchpad.net/qemu/+bug/1726733
Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 replication.h       | 1 -
 block/replication.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/replication.h b/replication.h
index 8faefe005f..4c8354de23 100644
--- a/replication.h
+++ b/replication.h
@@ -67,7 +67,6 @@ typedef struct ReplicationState ReplicationState;
  *
  * BlockDriver bdrv_replication = {
  *     .format_name                = "replication",
- *     .protocol_name              = "replication",
  *     .instance_size              = sizeof(BDRVReplicationState),
  *
  *     .bdrv_open                  = replication_open,
diff --git a/block/replication.c b/block/replication.c
index f98ef094b9..6c0c7186d9 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -703,7 +703,6 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
 
 BlockDriver bdrv_replication = {
     .format_name                = "replication",
-    .protocol_name              = "replication",
     .instance_size              = sizeof(BDRVReplicationState),
 
     .bdrv_open                  = replication_open,
-- 
2.13.6
