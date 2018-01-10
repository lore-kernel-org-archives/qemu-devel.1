Received: from eggs.gnu.org ([2001:4830:134:3::10]:50484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUD-0006Kk-PB
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUC-0006CZ-N3
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:25 -0600
Message-Id: <20180110230825.18321-7-eblake@redhat.com>
In-Reply-To: <20180110230825.18321-1-eblake@redhat.com>
References: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] nbd/server: structurize option reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171122101958.17065-6-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index ec8c3be019..9019ad28f4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -137,43 +137,29 @@ static void nbd_client_receive_next_request(NBDClient *client);

 */

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
-
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
2.14.3
