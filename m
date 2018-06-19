Received: from eggs.gnu.org ([2001:4830:134:3::10]:45212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hQ-00010S-SQ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hM-00082y-0b
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:48 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:45 -0500
Message-Id: <20180619014319.28272-20-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 019/113] rbd: Fix use after free in
 qemu_rbd_set_keypairs() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

If we want to include the invalid option name in the error message, we
can't free the string earlier than that.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 71c87815f9e0386b6f3e22942adc956fd603c82f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/rbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/rbd.c b/block/rbd.c
index a76a5e8755..2de434dfdd 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -265,13 +265,14 @@ static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
         key = qstring_get_str(name);
 
         ret = rados_conf_set(cluster, key, qstring_get_str(value));
-        QDECREF(name);
         QDECREF(value);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "invalid conf option %s", key);
+            QDECREF(name);
             ret = -EINVAL;
             break;
         }
+        QDECREF(name);
     }
 
     QDECREF(keypairs);
-- 
2.11.0
