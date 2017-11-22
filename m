Received: from eggs.gnu.org ([2001:4830:134:3::10]:33967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8c-0001Ny-57
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8U-0004mD-7p
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:14 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:19090 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eHS8T-0004k0-MW
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 22 Nov 2017 13:19:58 +0300
Message-Id: <20171122101958.17065-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-1-vsementsov@virtuozzo.com>
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/5] nbd/server: structurize option reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 79b937d88f..975fe8efe9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -152,43 +152,29 @@ static inline int nbd_opt_drop(NBDClient *client, size_t size, Error **errp)
     return nbd_drop(client->ioc, size, errp);
 }
 
+static inline void set_be_option_rep(NBDOptionReply *rep, uint32_t option,
+                                     uint32_t type, uint32_t length)
+{
+    stq_be_p(&rep->magic, NBD_REP_MAGIC);
+    stl_be_p(&rep->option, option);
+    stl_be_p(&rep->type, type);
+    stl_be_p(&rep->length, length);
+}
+
 /* Send a reply header, including length, but no payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type,
                                       uint32_t len, Error **errp)
 {
-    uint64_t magic;
-    QIOChannel *ioc = client->ioc;
-    uint32_t opt = client->opt;
+    NBDOptionReply rep;
 
-    trace_nbd_negotiate_send_rep_len(opt, nbd_opt_lookup(opt),
+    trace_nbd_negotiate_send_rep_len(client->opt, nbd_opt_lookup(client->opt),
                                      type, nbd_rep_lookup(type), len);
 
     assert(len < NBD_MAX_BUFFER_SIZE);
-    magic = cpu_to_be64(NBD_REP_MAGIC);
-    if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
-        error_prepend(errp, "write failed (rep magic): ");
-        return -EINVAL;
-    }
-
-    opt = cpu_to_be32(opt);
-    if (nbd_write(ioc, &opt, sizeof(opt), errp) < 0) {
-        error_prepend(errp, "write failed (rep opt): ");
-        return -EINVAL;
-    }
-
-    type = cpu_to_be32(type);
-    if (nbd_write(ioc, &type, sizeof(type), errp) < 0) {
-        error_prepend(errp, "write failed (rep type): ");
-        return -EINVAL;
-    }
 
-    len = cpu_to_be32(len);
-    if (nbd_write(ioc, &len, sizeof(len), errp) < 0) {
-        error_prepend(errp, "write failed (rep data length): ");
-        return -EINVAL;
-    }
-    return 0;
+    set_be_option_rep(&rep, client->opt, type, len);
+    return nbd_write(client->ioc, &rep, sizeof(rep), errp);
 }
 
 /* Send a reply header with default 0 length.
-- 
2.11.1
