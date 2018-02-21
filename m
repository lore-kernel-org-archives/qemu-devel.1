Received: from eggs.gnu.org ([2001:4830:134:3::10]:38335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrg-0001C0-4o
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUra-0002tj-M3
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:46 +0100
Message-Id: <20180221135404.27598-19-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-1-kwolf@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/36] rbd: Fix use after free in
 qemu_rbd_set_keypairs() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

If we want to include the invalid option name in the error message, we
can't free the string earlier than that.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/rbd.c b/block/rbd.c
index 8474b0ba11..27fa11b473 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -268,13 +268,14 @@ static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
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
2.13.6
