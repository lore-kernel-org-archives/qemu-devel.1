Received: from eggs.gnu.org ([2001:4830:134:3::10]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTZuL-00034m-Vc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTZuK-00042Q-9l
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:31:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 15:30:46 -0500
Message-Id: <20170707203049.534-7-eblake@redhat.com>
In-Reply-To: <20170707203049.534-1-eblake@redhat.com>
References: <20170707203049.534-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 6/9] nbd: Implement NBD_OPT_GO on server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

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
v5: update to master, R-b dropped
v4: revamp to another round of NBD protocol changes
v3: revamp to match latest version of NBD protocol
---
 nbd/server.c     | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 nbd/trace-events |   3 +
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 841986d..e84d012 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -141,6 +141,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
     trace_nbd_negotiate_send_rep_len(opt, nbd_opt_lookup(opt),
                                      type, nbd_rep_lookup(type), len);

+    assert(len < NBD_MAX_BUFFER_SIZE);
     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
         error_prepend(errp, "write failed (rep magic): ");
@@ -275,6 +276,8 @@ static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length,
     return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, NBD_OPT_LIST, errp);
 }

+/* Send a reply to NBD_OPT_EXPORT_NAME.
+ * Return -errno on error, 0 on success. */
 static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
                                             uint16_t myflags, bool no_zeroes,
                                             Error **errp)
@@ -323,6 +326,162 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
     return 0;
 }

+/* Send a single NBD_REP_INFO, with a buffer @buf of @length bytes.
+ * The buffer does NOT include the info type prefix.
+ * Return -errno on error, 0 if ready to send more. */
+static int nbd_negotiate_send_info(NBDClient *client, uint32_t opt,
+                                   uint16_t info, uint32_t length, void *buf,
+                                   Error **errp)
+{
+    int rc;
+
+    trace_nbd_negotiate_send_info(info, nbd_info_lookup(info), length);
+    rc = nbd_negotiate_send_rep_len(client->ioc, NBD_REP_INFO, opt,
+                                    sizeof(info) + length, errp);
+    if (rc < 0) {
+        return rc;
+    }
+    cpu_to_be16s(&info);
+    if (nbd_write(client->ioc, &info, sizeof(info), errp) < 0) {
+        return -EIO;
+    }
+    if (nbd_write(client->ioc, buf, length, errp) < 0) {
+        return -EIO;
+    }
+    return 0;
+}
+
+/* Handle NBD_OPT_INFO and NBD_OPT_GO.
+ * Return -errno on error, 0 if ready for next option, and 1 to move
+ * into transmission phase.  */
+static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
+                                     uint32_t opt, uint16_t myflags,
+                                     Error **errp)
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
+        4 bytes: L, name length (can be 0)
+        L bytes: export name
+        2 bytes: N, number of requests (can be 0)
+        N * 2 bytes: N requests
+    */
+    if (length < sizeof(namelen) + sizeof(requests)) {
+        msg = "overall request too short";
+        goto invalid;
+    }
+    if (nbd_read(client->ioc, &namelen, sizeof(namelen), errp) < 0) {
+        return -EIO;
+    }
+    be32_to_cpus(&namelen);
+    length -= sizeof(namelen);
+    if (namelen > length - sizeof(requests) || (length - namelen) % 2) {
+        msg = "name length is incorrect";
+        goto invalid;
+    }
+    if (nbd_read(client->ioc, name, namelen, errp) < 0) {
+        return -EIO;
+    }
+    name[namelen] = '\0';
+    length -= namelen;
+    trace_nbd_negotiate_handle_export_name_request(name);
+
+    if (nbd_read(client->ioc, &requests, sizeof(requests), errp) < 0) {
+        return -EIO;
+    }
+    be16_to_cpus(&requests);
+    length -= sizeof(requests);
+    trace_nbd_negotiate_handle_info_requests(requests);
+    if (requests != length / sizeof(request)) {
+        msg = "incorrect number of  requests for overall length";
+        goto invalid;
+    }
+    while (requests--) {
+        if (nbd_read(client->ioc, &request, sizeof(request), errp) < 0) {
+            return -EIO;
+        }
+        be16_to_cpus(&request);
+        length -= sizeof(request);
+        trace_nbd_negotiate_handle_info_request(request,
+                                                nbd_info_lookup(request));
+        /* For now, we only care about NBD_INFO_NAME; everything else
+         * is either a request we don't know or something we send
+         * regardless of request. */
+        if (request == NBD_INFO_NAME) {
+            sendname = true;
+        }
+    }
+
+    exp = nbd_export_find(name);
+    if (!exp) {
+        return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_UNKNOWN,
+                                          opt, errp, "export '%s' not present",
+                                          name);
+    }
+
+    /* Don't bother sending NBD_INFO_NAME unless client requested it */
+    if (sendname) {
+        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, length, name,
+                                     errp);
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
+                                     len, exp->description, errp);
+        if (rc < 0) {
+            return rc;
+        }
+    }
+
+    /* Send NBD_INFO_EXPORT always */
+    trace_nbd_negotiate_new_style_size_flags(exp->size,
+                                             exp->nbdflags | myflags);
+    stq_be_p(buf, exp->size);
+    stw_be_p(buf + 8, exp->nbdflags | myflags);
+    rc = nbd_negotiate_send_info(client, opt, NBD_INFO_EXPORT,
+                                 sizeof(buf), buf, errp);
+    if (rc < 0) {
+        return rc;
+    }
+
+    /* Final reply */
+    rc = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, opt, errp);
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
+    if (nbd_drop(client->ioc, length, errp) < 0) {
+        return -EIO;
+    }
+    return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
+                                      errp, "%s", msg);
+}
+
+
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
 static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
@@ -380,7 +539,8 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 }

 /* nbd_negotiate_options
- * Process all NBD_OPT_* client option commands.
+ * Process all NBD_OPT_* client option commands, during fixed newstyle
+ * negotiation.
  * Return:
  * -errno  on error, errp is set
  * 0       on successful negotiation, errp is not set
@@ -397,7 +557,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
     /* Client sends:
         [ 0 ..   3]   client flags

-       Then we loop until NBD_OPT_EXPORT_NAME:
+       Then we loop until NBD_OPT_EXPORT_NAME or NBD_OPT_GO:
         [ 0 ..   7]   NBD_OPTS_MAGIC
         [ 8 ..  11]   NBD option
         [12 ..  15]   Data length
@@ -524,6 +684,19 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                         myflags, no_zeroes,
                                                         errp);

+            case NBD_OPT_INFO:
+            case NBD_OPT_GO:
+                ret = nbd_negotiate_handle_info(client, length, option,
+                                                myflags, errp);
+                if (ret == 1) {
+                    assert(option == NBD_OPT_GO);
+                    return 0;
+                }
+                if (ret) {
+                    return ret;
+                }
+                break;
+
             case NBD_OPT_STARTTLS:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
@@ -606,7 +779,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
         [ 0 ..   7]   passwd       ("NBDMAGIC")
         [ 8 ..  15]   magic        (NBD_OPTS_MAGIC)
         [16 ..  17]   server flags (0)
-        ....options sent, ending in NBD_OPT_EXPORT_NAME....
+        ....options sent, ending in NBD_OPT_EXPORT_NAME or NBD_OPT_GO....
      */

     qio_channel_set_blocking(client->ioc, false, NULL);
diff --git a/nbd/trace-events b/nbd/trace-events
index 765f5f4..80c2447 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -33,6 +33,9 @@ nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
 nbd_negotiate_send_rep_list(const char *name, const char *desc) "Advertising export name '%s' description '%s'"
 nbd_negotiate_handle_export_name(void) "Checking length"
 nbd_negotiate_handle_export_name_request(const char *name) "Client requested export '%s'"
+nbd_negotiate_send_info(int info, const char *name, uint32_t length) "Sending NBD_REP_INFO type %d (%s) with remaining length %" PRIu32
+nbd_negotiate_handle_info_requests(int requests) "Client requested %d items of info"
+nbd_negotiate_handle_info_request(int request, const char *name) "Client requested info %d (%s)"
 nbd_negotiate_handle_starttls(void) "Setting up TLS"
 nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
 nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
-- 
2.9.4
