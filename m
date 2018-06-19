Received: from eggs.gnu.org ([2001:4830:134:3::10]:46580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ix-0002ZY-Q9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iw-0000Lx-SJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:23 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:27 -0500
Message-Id: <20180619014319.28272-62-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 061/113] nbd/client: Fix error messages during
 NBD_INFO_BLOCK_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

A missing space makes for poor error messages, and sizes can't
go negative.  Also, we missed diagnosing a server that sends
a maximum block size less than the minimum.

Fixes: 081dd1fe
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180501154654.943782-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit e475d108f1b3d3163f0affea67cdedbe5fc9752b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/client.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index eea236ca06..0906d7b2c5 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -435,8 +435,8 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             }
             be32_to_cpus(&info->min_block);
             if (!is_power_of_2(info->min_block)) {
-                error_setg(errp, "server minimum block size %" PRId32
-                           "is not a power of two", info->min_block);
+                error_setg(errp, "server minimum block size %" PRIu32
+                           " is not a power of two", info->min_block);
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -450,8 +450,8 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             be32_to_cpus(&info->opt_block);
             if (!is_power_of_2(info->opt_block) ||
                 info->opt_block < info->min_block) {
-                error_setg(errp, "server preferred block size %" PRId32
-                           "is not valid", info->opt_block);
+                error_setg(errp, "server preferred block size %" PRIu32
+                           " is not valid", info->opt_block);
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -462,6 +462,12 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                 return -1;
             }
             be32_to_cpus(&info->max_block);
+            if (info->max_block < info->min_block) {
+                error_setg(errp, "server maximum block size %" PRIu32
+                           " is not valid", info->max_block);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
             trace_nbd_opt_go_info_block_size(info->min_block, info->opt_block,
                                              info->max_block);
             break;
-- 
2.11.0
