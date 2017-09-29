Received: from eggs.gnu.org ([2001:4830:134:3::10]:53502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFA-00060K-FV
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF9-0007oK-Of
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:08 -0400
Received: from mifritscher.de ([188.40.170.105]:33020
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF9-0007ne-IP
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:21 +0200
Message-Id: <20170929111323.6308-17-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 16/18] Workaround for missing
 dent->d_type/d_off under Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f4ccb45f64..4e07bfc71b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1794,7 +1794,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         count += len;
         v9fs_stat_free(&v9stat);
         v9fs_path_free(&path);
+#ifdef _WIN32
+        saved_dir_pos = v9fs_co_telldir(pdu, fidp);
+#else
         saved_dir_pos = dent->d_off;
+#endif
     }
 
     v9fs_readdir_unlock(&fidp->fs.dir);
@@ -1946,9 +1950,15 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         qid.version = 0;
 
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
+#ifdef _WIN32
+        len = pdu_marshal(pdu, 11 + count, "Qqbs",
+                          &qid, v9fs_co_telldir(pdu, fidp),
+                          DT_UNKNOWN, &name);
+#else
         len = pdu_marshal(pdu, 11 + count, "Qqbs",
                           &qid, dent->d_off,
                           dent->d_type, &name);
+#endif
 
         v9fs_readdir_unlock(&fidp->fs.dir);
 
@@ -1959,7 +1969,11 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         count += len;
         v9fs_string_free(&name);
+#ifdef _WIN32
+        saved_dir_pos = v9fs_co_telldir(pdu, fidp);
+#else
         saved_dir_pos = dent->d_off;
+#endif
     }
 
     v9fs_readdir_unlock(&fidp->fs.dir);
-- 
2.13.2.windows.1
