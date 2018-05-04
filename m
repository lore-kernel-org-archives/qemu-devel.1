Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanN-0006v3-GO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanM-0003Lq-Fr
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  4 May 2018 08:30:33 -0500
Message-Id: <20180504133034.1328397-4-eblake@redhat.com>
In-Reply-To: <20180504133034.1328397-1-eblake@redhat.com>
References: <20180504133034.1328397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] nbd/client: Fix error messages during
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
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

A missing space makes for poor error messages, and sizes can't
go negative.  Also, we missed diagnosing a server that sends
a maximum block size less than the minimum.

Fixes: 081dd1fe
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180501154654.943782-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 7f35b5c3232..232ff4f46da 100644
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
2.14.3
