Received: from eggs.gnu.org ([2001:4830:134:3::10]:40827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q2-0005ZY-P8
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q1-0003XG-6z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:10 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:45 -0600
Message-Id: <20170221024248.11027-6-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/8] nbd: Implement NBD_OPT_GO on server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

NBD_OPT_EXPORT_NAME is lousy: per the NBD protocol, any failure
requires us to close the connection rather than report an error.
Therefore, upstream NBD recently added NBD_OPT_GO as the improved
version of the option that does what we want [1], along with
NBD_OPT_INFO that returns the same information but does not
transition to transmission phase.

[1] https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md

This is a first cut at the information types, and only passes the
same information already available through NBD_OPT_LIST and
NBD_OPT_EXPORT_NAME; items like NBD_INFO_BLOCK_SIZE (and thus any
use of NBD_REP_ERR_BLOCK_SIZE_REQD) are intentionally left for
later patches.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: revamp to another round of NBD protocol changes
v3: revamp to match latest version of NBD protocol
---
 nbd/server.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 195 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 767ca0f..3b1a4a5 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -209,6 +209,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
     TRACE("Reply opt=%" PRIx32 " (%s), type=%" PRIx32 " (%s), len=%" PRIu32,
           opt, nbd_opt_lookup(opt), type, nbd_rep_lookup(type), len);

+    assert(len < NBD_MAX_BUFFER_SIZE);
     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_negotiate_write(ioc, &magic, sizeof(magic)) != sizeof(magic)) {
         LOG("write failed (rep magic)");
@@ -331,6 +332,8 @@ static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
     return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, NBD_OPT_LIST);
 }

+/* Send a reply to NBD_OPT_EXPORT_NAME.
+ * Return -errno on error, 0 on success. */
 static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 {
     int rc = -EINVAL;
@@ -365,6 +368,171 @@ fail:
     return rc;
 }

+/* Send a single NBD_REP_INFO, with a buffer @buf of @length bytes.
+ * The buffer does NOT include the info type prefix.
+ * Return -errno on error, 0 if ready to send more. */
+static int nbd_negotiate_send_info(NBDClient *client, uint32_t opt,
+                                   uint16_t info, uint32_t length, void *buf)
+{
+    int rc;
+
+    TRACE("Sending NBD_REP_INFO type %" PRIu16 " (%s) with remaining length %"
+          PRIu32, info, nbd_info_lookup(info), length);
+    rc = nbd_negotiate_send_rep_len(client->ioc, NBD_REP_INFO, opt,
+                                    sizeof(info) + length);
+    if (rc < 0) {
+        return rc;
+    }
+    cpu_to_be16s(&info);
+    if (nbd_negotiate_write(client->ioc, &info, sizeof(info)) !=
+        sizeof(info)) {
+        LOG("write failed");
+        return -EIO;
+    }
+    if (nbd_negotiate_write(client->ioc, buf, length) != length) {
+        LOG("write failed");
+        return -EIO;
+    }
+    return 0;
+}
+
+/* Handle NBD_OPT_INFO and NBD_OPT_GO.
+ * Return -errno on error, 0 if ready for next option, and 1 to move
+ * into transmission phase.  */
+static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
+                                     uint32_t opt, uint16_t myflags)
+{
+    int rc;
+    char name[NBD_MAX_NAME_SIZE + 1];
+    NBDExport *exp;
+    uint16_t requests;
+    uint16_t request;
+    uint32_t namelen;
+    bool sendname = false;
+    char buf[sizeof(uint64_t) + sizeof(uint16_t)];
+    const char *msg;
+
+    /* Client sends:
+        2 bytes: N, number of requests (can be 0)
+        N * 2 bytes: N requests
+        4 bytes: L, name length (can be 0)
+        L bytes: export name
+    */
+    if (length < sizeof(requests) + sizeof(namelen)) {
+        msg = "overall request too short";
+        goto invalid;
+    }
+    if (nbd_negotiate_read(client->ioc, &requests, sizeof(requests)) !=
+        sizeof(requests)) {
+        LOG("read failed");
+        return -EIO;
+    }
+    be16_to_cpus(&requests);
+    length -= sizeof(requests);
+    TRACE("Client requested %d items of info", requests);
+    if (requests > (length - sizeof(namelen)) / sizeof(request)) {
+        msg = "too many requests for overall length";
+        goto invalid;
+    }
+    while (requests--) {
+        if (nbd_negotiate_read(client->ioc, &request, sizeof(request)) !=
+            sizeof(request)) {
+            LOG("read failed");
+            return -EIO;
+        }
+        be16_to_cpus(&request);
+        length -= sizeof(request);
+        TRACE("Client requested info %d (%s)", request,
+              nbd_info_lookup(request));
+        /* For now, we only care about NBD_INFO_NAME; everything else
+         * is either a request we don't know or something we send
+         * regardless of request. */
+        if (request == NBD_INFO_NAME) {
+            sendname = true;
+        }
+    }
+
+    if (nbd_negotiate_read(client->ioc, &namelen, sizeof(namelen)) !=
+        sizeof(namelen)) {
+        LOG("read failed");
+        return -EIO;
+    }
+    be32_to_cpus(&namelen);
+    length -= sizeof(namelen);
+    TRACE("Client requested namelen %u", namelen);
+    if (length != namelen || namelen > sizeof(name)) {
+        msg = "name too long";
+        goto invalid;
+    }
+    if (nbd_negotiate_read(client->ioc, name, length) != length) {
+        LOG("read failed");
+        return -EIO;
+    }
+    name[length] = '\0';
+
+    TRACE("Client requested info on export '%s'", name);
+
+    exp = nbd_export_find(name);
+    if (!exp) {
+        return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_UNKNOWN,
+                                          opt, "export '%s' not present",
+                                          name);
+    }
+
+    /* Don't bother sending NBD_INFO_NAME unless client requested it */
+    if (sendname) {
+        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, length, name);
+        if (rc < 0) {
+            return rc;
+        }
+    }
+
+    /* Send NBD_INFO_DESCRIPTION only if available, regardless of
+     * client request */
+    if (exp->description) {
+        size_t len = strlen(exp->description);
+
+        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_DESCRIPTION,
+                                     len, exp->description);
+        if (rc < 0) {
+            return rc;
+        }
+    }
+
+    /* Send NBD_INFO_EXPORT always */
+    TRACE("advertising size %" PRIu64 " and flags %" PRIx16,
+          exp->size, exp->nbdflags | myflags);
+    stq_be_p(buf, exp->size);
+    stw_be_p(buf + 8, exp->nbdflags | myflags);
+    rc = nbd_negotiate_send_info(client, opt, NBD_INFO_EXPORT,
+                                 sizeof(buf), buf);
+    if (rc < 0) {
+        return rc;
+    }
+
+    /* Final reply */
+    rc = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, opt);
+    if (rc < 0) {
+        return rc;
+    }
+
+    if (opt == NBD_OPT_GO) {
+        client->exp = exp;
+        QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
+        nbd_export_get(client->exp);
+        rc = 1;
+    }
+    return rc;
+
+ invalid:
+    if (nbd_negotiate_drop_sync(client->ioc, length) != length) {
+        return -EIO;
+    }
+    return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
+                                      "%s", msg);
+}
+
+
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
 static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
@@ -420,9 +588,10 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 }


-/* Process all NBD_OPT_* client option commands.
- * Return -errno on error, 0 on success. */
-static int nbd_negotiate_options(NBDClient *client)
+/* Process all NBD_OPT_* client option commands, during fixed newstyle
+ * negotiation. Return -errno on error, 0 on successful NBD_OPT_EXPORT_NAME,
+ * and 1 on successful NBD_OPT_GO. */
+static int nbd_negotiate_options(NBDClient *client, uint16_t myflags)
 {
     uint32_t flags;
     bool fixedNewstyle = false;
@@ -555,6 +724,16 @@ static int nbd_negotiate_options(NBDClient *client)
             case NBD_OPT_EXPORT_NAME:
                 return nbd_negotiate_handle_export_name(client, length);

+            case NBD_OPT_INFO:
+            case NBD_OPT_GO:
+                ret = nbd_negotiate_handle_info(client, length, clientflags,
+                                                myflags);
+                if (ret) {
+                    assert(ret < 0 || clientflags == NBD_OPT_GO);
+                    return ret;
+                }
+                break;
+
             case NBD_OPT_STARTTLS:
                 if (nbd_negotiate_drop_sync(client->ioc, length) != length) {
                     return -EIO;
@@ -675,20 +854,23 @@ static coroutine_fn int nbd_negotiate(NBDClientNewData *data)
             LOG("write failed");
             goto fail;
         }
-        rc = nbd_negotiate_options(client);
-        if (rc != 0) {
+        rc = nbd_negotiate_options(client, myflags);
+        if (rc < 0) {
             LOG("option negotiation failed");
             goto fail;
         }

-        TRACE("advertising size %" PRIu64 " and flags %x",
-              client->exp->size, client->exp->nbdflags | myflags);
-        stq_be_p(buf + 18, client->exp->size);
-        stw_be_p(buf + 26, client->exp->nbdflags | myflags);
-        len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        if (nbd_negotiate_write(client->ioc, buf + 18, len) != len) {
-            LOG("write failed");
-            goto fail;
+        if (!rc) {
+            /* If options ended with NBD_OPT_GO, we already sent this. */
+            TRACE("advertising size %" PRIu64 " and flags %x",
+                  client->exp->size, client->exp->nbdflags | myflags);
+            stq_be_p(buf + 18, client->exp->size);
+            stw_be_p(buf + 26, client->exp->nbdflags | myflags);
+            len = client->no_zeroes ? 10 : sizeof(buf) - 18;
+            if (nbd_negotiate_write(client->ioc, buf + 18, len) != len) {
+                LOG("write failed");
+                goto fail;
+            }
         }
     }

-- 
2.9.3
