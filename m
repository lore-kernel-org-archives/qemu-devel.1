Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUC-0006J8-NE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU8-00068h-5E
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:21 -0600
Message-Id: <20180110230825.18321-3-eblake@redhat.com>
In-Reply-To: <20180110230825.18321-1-eblake@redhat.com>
References: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] nbd/server: refactor negotiation
 functions parameters
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

Instead of passing currently negotiating option and its length to
many of negotiation functions let's just store them on NBDClient
struct to be state-variables of negotiation phase.

This unifies semantics of negotiation functions and allows
tracking changes of remaining option length in future patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171122101958.17065-2-vsementsov@virtuozzo.com>
[eblake: rebase, commit message tweak, assert !optlen after
negotiation completes]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 168 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index d3b457c337..08a24b56f4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -102,9 +102,11 @@ struct NBDClient {
     bool closing;

     bool structured_reply;
-};

-/* That's all folks */
+    uint32_t opt; /* Current option being negotiated */
+    uint32_t optlen; /* remaining length of data in ioc for the option being
+                        negotiated now */
+};

 static void nbd_client_receive_next_request(NBDClient *client);

@@ -137,10 +139,12 @@ static void nbd_client_receive_next_request(NBDClient *client);

 /* Send a reply header, including length, but no payload.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
-                                      uint32_t opt, uint32_t len, Error **errp)
+static int nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type,
+                                      uint32_t len, Error **errp)
 {
     uint64_t magic;
+    QIOChannel *ioc = client->ioc;
+    uint32_t opt = client->opt;

     trace_nbd_negotiate_send_rep_len(opt, nbd_opt_lookup(opt),
                                      type, nbd_rep_lookup(type), len);
@@ -174,17 +178,17 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,

 /* Send a reply header with default 0 length.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep(QIOChannel *ioc, uint32_t type, uint32_t opt,
+static int nbd_negotiate_send_rep(NBDClient *client, uint32_t type,
                                   Error **errp)
 {
-    return nbd_negotiate_send_rep_len(ioc, type, opt, 0, errp);
+    return nbd_negotiate_send_rep_len(client, type, 0, errp);
 }

 /* Send an error reply.
  * Return -errno on error, 0 on success. */
-static int GCC_FMT_ATTR(5, 6)
-nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
-                           uint32_t opt, Error **errp, const char *fmt, ...)
+static int GCC_FMT_ATTR(4, 5)
+nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
+                           Error **errp, const char *fmt, ...)
 {
     va_list va;
     char *msg;
@@ -197,11 +201,11 @@ nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
     len = strlen(msg);
     assert(len < 4096);
     trace_nbd_negotiate_send_rep_err(msg);
-    ret = nbd_negotiate_send_rep_len(ioc, type, opt, len, errp);
+    ret = nbd_negotiate_send_rep_len(client, type, len, errp);
     if (ret < 0) {
         goto out;
     }
-    if (nbd_write(ioc, msg, len, errp) < 0) {
+    if (nbd_write(client->ioc, msg, len, errp) < 0) {
         error_prepend(errp, "write failed (error message): ");
         ret = -EIO;
     } else {
@@ -215,21 +219,21 @@ out:

 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,
+static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
                                        Error **errp)
 {
     size_t name_len, desc_len;
     uint32_t len;
     const char *name = exp->name ? exp->name : "";
     const char *desc = exp->description ? exp->description : "";
+    QIOChannel *ioc = client->ioc;
     int ret;

     trace_nbd_negotiate_send_rep_list(name, desc);
     name_len = strlen(name);
     desc_len = strlen(desc);
     len = name_len + desc_len + sizeof(len);
-    ret = nbd_negotiate_send_rep_len(ioc, NBD_REP_SERVER, NBD_OPT_LIST, len,
-                                     errp);
+    ret = nbd_negotiate_send_rep_len(client, NBD_REP_SERVER, len, errp);
     if (ret < 0) {
         return ret;
     }
@@ -258,20 +262,21 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,
 static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
 {
     NBDExport *exp;
+    assert(client->opt == NBD_OPT_LIST);

     /* For each export, send a NBD_REP_SERVER reply. */
     QTAILQ_FOREACH(exp, &exports, next) {
-        if (nbd_negotiate_send_rep_list(client->ioc, exp, errp)) {
+        if (nbd_negotiate_send_rep_list(client, exp, errp)) {
             return -EINVAL;
         }
     }
     /* Finish with a NBD_REP_ACK. */
-    return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, NBD_OPT_LIST, errp);
+    return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
 }

 /* Send a reply to NBD_OPT_EXPORT_NAME.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
+static int nbd_negotiate_handle_export_name(NBDClient *client,
                                             uint16_t myflags, bool no_zeroes,
                                             Error **errp)
 {
@@ -288,15 +293,16 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
         [10 .. 133]   reserved     (0) [unless no_zeroes]
      */
     trace_nbd_negotiate_handle_export_name();
-    if (length >= sizeof(name)) {
+    if (client->optlen >= sizeof(name)) {
         error_setg(errp, "Bad length received");
         return -EINVAL;
     }
-    if (nbd_read(client->ioc, name, length, errp) < 0) {
+    if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
         error_prepend(errp, "read failed: ");
         return -EINVAL;
     }
-    name[length] = '\0';
+    name[client->optlen] = '\0';
+    client->optlen = 0;

     trace_nbd_negotiate_handle_export_name_request(name);

@@ -326,14 +332,14 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
 /* Send a single NBD_REP_INFO, with a buffer @buf of @length bytes.
  * The buffer does NOT include the info type prefix.
  * Return -errno on error, 0 if ready to send more. */
-static int nbd_negotiate_send_info(NBDClient *client, uint32_t opt,
+static int nbd_negotiate_send_info(NBDClient *client,
                                    uint16_t info, uint32_t length, void *buf,
                                    Error **errp)
 {
     int rc;

     trace_nbd_negotiate_send_info(info, nbd_info_lookup(info), length);
-    rc = nbd_negotiate_send_rep_len(client->ioc, NBD_REP_INFO, opt,
+    rc = nbd_negotiate_send_rep_len(client, NBD_REP_INFO,
                                     sizeof(info) + length, errp);
     if (rc < 0) {
         return rc;
@@ -355,22 +361,20 @@ static int nbd_negotiate_send_info(NBDClient *client, uint32_t opt,
  * -errno  transmission error occurred or @fatal was requested, errp is set
  * 0       error message successfully sent to client, errp is not set
  */
-static int nbd_reject_length(NBDClient *client, uint32_t length,
-                             uint32_t option, bool fatal, Error **errp)
+static int nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
 {
     int ret;

-    assert(length);
-    if (nbd_drop(client->ioc, length, errp) < 0) {
+    assert(client->optlen);
+    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
         return -EIO;
     }
-    ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID,
-                                     option, errp,
+    ret = nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID, errp,
                                      "option '%s' should have zero length",
-                                     nbd_opt_lookup(option));
+                                     nbd_opt_lookup(client->opt));
     if (fatal && !ret) {
         error_setg(errp, "option '%s' should have zero length",
-                   nbd_opt_lookup(option));
+                   nbd_opt_lookup(client->opt));
         return -EINVAL;
     }
     return ret;
@@ -379,8 +383,7 @@ static int nbd_reject_length(NBDClient *client, uint32_t length,
 /* Handle NBD_OPT_INFO and NBD_OPT_GO.
  * Return -errno on error, 0 if ready for next option, and 1 to move
  * into transmission phase.  */
-static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
-                                     uint32_t opt, uint16_t myflags,
+static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
                                      Error **errp)
 {
     int rc;
@@ -401,7 +404,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         2 bytes: N, number of requests (can be 0)
         N * 2 bytes: N requests
     */
-    if (length < sizeof(namelen) + sizeof(requests)) {
+    if (client->optlen < sizeof(namelen) + sizeof(requests)) {
         msg = "overall request too short";
         goto invalid;
     }
@@ -409,8 +412,10 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         return -EIO;
     }
     be32_to_cpus(&namelen);
-    length -= sizeof(namelen);
-    if (namelen > length - sizeof(requests) || (length - namelen) % 2) {
+    client->optlen -= sizeof(namelen);
+    if (namelen > client->optlen - sizeof(requests) ||
+        (client->optlen - namelen) % 2)
+    {
         msg = "name length is incorrect";
         goto invalid;
     }
@@ -422,16 +427,16 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         return -EIO;
     }
     name[namelen] = '\0';
-    length -= namelen;
+    client->optlen -= namelen;
     trace_nbd_negotiate_handle_export_name_request(name);

     if (nbd_read(client->ioc, &requests, sizeof(requests), errp) < 0) {
         return -EIO;
     }
     be16_to_cpus(&requests);
-    length -= sizeof(requests);
+    client->optlen -= sizeof(requests);
     trace_nbd_negotiate_handle_info_requests(requests);
-    if (requests != length / sizeof(request)) {
+    if (requests != client->optlen / sizeof(request)) {
         msg = "incorrect number of  requests for overall length";
         goto invalid;
     }
@@ -440,7 +445,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
             return -EIO;
         }
         be16_to_cpus(&request);
-        length -= sizeof(request);
+        client->optlen -= sizeof(request);
         trace_nbd_negotiate_handle_info_request(request,
                                                 nbd_info_lookup(request));
         /* We care about NBD_INFO_NAME and NBD_INFO_BLOCK_SIZE;
@@ -455,18 +460,18 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
             break;
         }
     }
-    assert(length == 0);
+    assert(client->optlen == 0);

     exp = nbd_export_find(name);
     if (!exp) {
-        return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_UNKNOWN,
-                                          opt, errp, "export '%s' not present",
+        return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_UNKNOWN,
+                                          errp, "export '%s' not present",
                                           name);
     }

     /* Don't bother sending NBD_INFO_NAME unless client requested it */
     if (sendname) {
-        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, namelen, name,
+        rc = nbd_negotiate_send_info(client, NBD_INFO_NAME, namelen, name,
                                      errp);
         if (rc < 0) {
             return rc;
@@ -478,7 +483,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
     if (exp->description) {
         size_t len = strlen(exp->description);

-        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_DESCRIPTION,
+        rc = nbd_negotiate_send_info(client, NBD_INFO_DESCRIPTION,
                                      len, exp->description, errp);
         if (rc < 0) {
             return rc;
@@ -490,7 +495,8 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
      * whether this is OPT_INFO or OPT_GO. */
     /* minimum - 1 for back-compat, or 512 if client is new enough.
      * TODO: consult blk_bs(blk)->bl.request_alignment? */
-    sizes[0] = (opt == NBD_OPT_INFO || blocksize) ? BDRV_SECTOR_SIZE : 1;
+    sizes[0] =
+            (client->opt == NBD_OPT_INFO || blocksize) ? BDRV_SECTOR_SIZE : 1;
     /* preferred - Hard-code to 4096 for now.
      * TODO: is blk_bs(blk)->bl.opt_transfer appropriate? */
     sizes[1] = 4096;
@@ -500,7 +506,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
     cpu_to_be32s(&sizes[0]);
     cpu_to_be32s(&sizes[1]);
     cpu_to_be32s(&sizes[2]);
-    rc = nbd_negotiate_send_info(client, opt, NBD_INFO_BLOCK_SIZE,
+    rc = nbd_negotiate_send_info(client, NBD_INFO_BLOCK_SIZE,
                                  sizeof(sizes), sizes, errp);
     if (rc < 0) {
         return rc;
@@ -511,7 +517,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
                                              exp->nbdflags | myflags);
     stq_be_p(buf, exp->size);
     stw_be_p(buf + 8, exp->nbdflags | myflags);
-    rc = nbd_negotiate_send_info(client, opt, NBD_INFO_EXPORT,
+    rc = nbd_negotiate_send_info(client, NBD_INFO_EXPORT,
                                  sizeof(buf), buf, errp);
     if (rc < 0) {
         return rc;
@@ -521,21 +527,21 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
      * request block sizes, return an error.
      * TODO: consult blk_bs(blk)->request_align, and only error if it
      * is not 1? */
-    if (opt == NBD_OPT_INFO && !blocksize) {
-        return nbd_negotiate_send_rep_err(client->ioc,
-                                          NBD_REP_ERR_BLOCK_SIZE_REQD, opt,
+    if (client->opt == NBD_OPT_INFO && !blocksize) {
+        return nbd_negotiate_send_rep_err(client,
+                                          NBD_REP_ERR_BLOCK_SIZE_REQD,
                                           errp,
                                           "request NBD_INFO_BLOCK_SIZE to "
                                           "use this export");
     }

     /* Final reply */
-    rc = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, opt, errp);
+    rc = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
     if (rc < 0) {
         return rc;
     }

-    if (opt == NBD_OPT_GO) {
+    if (client->opt == NBD_OPT_GO) {
         client->exp = exp;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
@@ -544,10 +550,10 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
     return rc;

  invalid:
-    if (nbd_drop(client->ioc, length, errp) < 0) {
+    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
         return -EIO;
     }
-    return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
+    return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID,
                                       errp, "%s", msg);
 }

@@ -561,11 +567,12 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     QIOChannelTLS *tioc;
     struct NBDTLSHandshakeData data = { 0 };

+    assert(client->opt == NBD_OPT_STARTTLS);
+
     trace_nbd_negotiate_handle_starttls();
     ioc = client->ioc;

-    if (nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
-                               NBD_OPT_STARTTLS, errp) < 0) {
+    if (nbd_negotiate_send_rep(client, NBD_REP_ACK, errp) < 0) {
         return NULL;
     }

@@ -670,12 +677,14 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             return -EINVAL;
         }
         option = be32_to_cpu(option);
+        client->opt = option;

         if (nbd_read(client->ioc, &length, sizeof(length), errp) < 0) {
             error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
         length = be32_to_cpu(length);
+        client->optlen = length;

         if (length > NBD_MAX_BUFFER_SIZE) {
             error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
@@ -697,8 +706,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 if (length) {
                     /* Unconditionally drop the connection if the client
                      * can't start a TLS negotiation correctly */
-                    return nbd_reject_length(client, length, option, true,
-                                             errp);
+                    return nbd_reject_length(client, true, errp);
                 }
                 tioc = nbd_negotiate_handle_starttls(client, errp);
                 if (!tioc) {
@@ -719,9 +727,8 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
                 }
-                ret = nbd_negotiate_send_rep_err(client->ioc,
-                                                 NBD_REP_ERR_TLS_REQD,
-                                                 option, errp,
+                ret = nbd_negotiate_send_rep_err(client,
+                                                 NBD_REP_ERR_TLS_REQD, errp,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
                                                  option);
@@ -737,8 +744,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             switch (option) {
             case NBD_OPT_LIST:
                 if (length) {
-                    ret = nbd_reject_length(client, length, option, false,
-                                            errp);
+                    ret = nbd_reject_length(client, false, errp);
                 } else {
                     ret = nbd_negotiate_handle_list(client, errp);
                 }
@@ -748,18 +754,17 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 /* NBD spec says we must try to reply before
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
-                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option, NULL);
+                nbd_negotiate_send_rep(client, NBD_REP_ACK, NULL);
                 return 1;

             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length,
+                return nbd_negotiate_handle_export_name(client,
                                                         myflags, no_zeroes,
                                                         errp);

             case NBD_OPT_INFO:
             case NBD_OPT_GO:
-                ret = nbd_negotiate_handle_info(client, length, option,
-                                                myflags, errp);
+                ret = nbd_negotiate_handle_info(client, myflags, errp);
                 if (ret == 1) {
                     assert(option == NBD_OPT_GO);
                     return 0;
@@ -768,32 +773,27 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,

             case NBD_OPT_STARTTLS:
                 if (length) {
-                    ret = nbd_reject_length(client, length, option, false,
-                                            errp);
+                    ret = nbd_reject_length(client, false, errp);
                 } else if (client->tlscreds) {
-                    ret = nbd_negotiate_send_rep_err(client->ioc,
-                                                     NBD_REP_ERR_INVALID,
-                                                     option, errp,
+                    ret = nbd_negotiate_send_rep_err(client,
+                                                     NBD_REP_ERR_INVALID, errp,
                                                      "TLS already enabled");
                 } else {
-                    ret = nbd_negotiate_send_rep_err(client->ioc,
-                                                     NBD_REP_ERR_POLICY,
-                                                     option, errp,
+                    ret = nbd_negotiate_send_rep_err(client,
+                                                     NBD_REP_ERR_POLICY, errp,
                                                      "TLS not configured");
                 }
                 break;

             case NBD_OPT_STRUCTURED_REPLY:
                 if (length) {
-                    ret = nbd_reject_length(client, length, option, false,
-                                            errp);
+                    ret = nbd_reject_length(client, false, errp);
                 } else if (client->structured_reply) {
                     ret = nbd_negotiate_send_rep_err(
-                        client->ioc, NBD_REP_ERR_INVALID, option, errp,
+                        client, NBD_REP_ERR_INVALID, errp,
                         "structured reply already negotiated");
                 } else {
-                    ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
-                                                 option, errp);
+                    ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
                     client->structured_reply = true;
                     myflags |= NBD_FLAG_SEND_DF;
                 }
@@ -803,9 +803,8 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
                 }
-                ret = nbd_negotiate_send_rep_err(client->ioc,
-                                                 NBD_REP_ERR_UNSUP,
-                                                 option, errp,
+                ret = nbd_negotiate_send_rep_err(client,
+                                                 NBD_REP_ERR_UNSUP, errp,
                                                  "Unsupported option 0x%"
                                                  PRIx32 " (%s)", option,
                                                  nbd_opt_lookup(option));
@@ -818,7 +817,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
              */
             switch (option) {
             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length,
+                return nbd_negotiate_handle_export_name(client,
                                                         myflags, no_zeroes,
                                                         errp);

@@ -1707,6 +1706,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
         return;
     }

+    assert(!client->optlen);
     nbd_client_receive_next_request(client);
 }

-- 
2.14.3
