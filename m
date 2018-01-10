Received: from eggs.gnu.org ([2001:4830:134:3::10]:50460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUC-0006J7-NA
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU8-00068z-Ti
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:24 -0600
Message-Id: <20180110230825.18321-6-eblake@redhat.com>
In-Reply-To: <20180110230825.18321-1-eblake@redhat.com>
References: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] nbd/server: Add helper functions for
 parsing option payload
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

Rather than making every callsite perform length sanity checks
and error reporting, add the helper functions nbd_opt_read()
and nbd_opt_drop() that use the length stored in the client
struct; also add an assertion that optlen is reduced to zero
after each option is handled.

Note that the call in nbd_negotiate_handle_export_name() does
not use the new helper (in part because the server cannot
reply to NBD_OPT_EXPORT_NAME - it either succeeds or the
connection drops).

Based on patches by Vladimir Sementsov-Ogievskiy.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 123 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index d23bc2918a..ec8c3be019 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -229,6 +229,41 @@ nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
     return ret;
 }

+/* Drop remainder of the current option, after sending a reply with
+ * the given error type and message. Return -errno on read or write
+ * failure; or 0 if connection is still live. */
+static int GCC_FMT_ATTR(4, 5)
+nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
+             const char *fmt, ...)
+{
+    int ret = nbd_drop(client->ioc, client->optlen, errp);
+
+    client->optlen = 0;
+    if (!ret) {
+        va_list va;
+
+        va_start(va, fmt);
+        ret = nbd_negotiate_send_rep_verr(client, type, errp, fmt, va);
+        va_end(va);
+    }
+    return ret;
+}
+
+/* Read size bytes from the unparsed payload of the current option.
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
+                        Error **errp)
+{
+    if (size > client->optlen) {
+        return nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
+                            "Inconsistent lengths in option %s",
+                            nbd_opt_lookup(client->opt));
+    }
+    client->optlen -= size;
+    return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
+}
+
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
@@ -378,14 +413,11 @@ static int nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
     int ret;

     assert(client->optlen);
-    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
-        return -EIO;
-    }
-    ret = nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID, errp,
-                                     "option '%s' should have zero length",
-                                     nbd_opt_lookup(client->opt));
+    ret = nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
+                       "option '%s' has unexpected length",
+                       nbd_opt_lookup(client->opt));
     if (fatal && !ret) {
-        error_setg(errp, "option '%s' should have zero length",
+        error_setg(errp, "option '%s' has unexpected length",
                    nbd_opt_lookup(client->opt));
         return -EINVAL;
     }
@@ -408,7 +440,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     bool blocksize = false;
     uint32_t sizes[3];
     char buf[sizeof(uint64_t) + sizeof(uint16_t)];
-    const char *msg;

     /* Client sends:
         4 bytes: L, name length (can be 0)
@@ -416,48 +447,34 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         2 bytes: N, number of requests (can be 0)
         N * 2 bytes: N requests
     */
-    if (client->optlen < sizeof(namelen) + sizeof(requests)) {
-        msg = "overall request too short";
-        goto invalid;
-    }
-    if (nbd_read(client->ioc, &namelen, sizeof(namelen), errp) < 0) {
-        return -EIO;
+    rc = nbd_opt_read(client, &namelen, sizeof(namelen), errp);
+    if (rc <= 0) {
+        return rc;
     }
     be32_to_cpus(&namelen);
-    client->optlen -= sizeof(namelen);
-    if (namelen > client->optlen - sizeof(requests) ||
-        (client->optlen - namelen) % 2)
-    {
-        msg = "name length is incorrect";
-        goto invalid;
-    }
     if (namelen >= sizeof(name)) {
-        msg = "name too long for qemu";
-        goto invalid;
+        return nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
+                            "name too long for qemu");
     }
-    if (nbd_read(client->ioc, name, namelen, errp) < 0) {
-        return -EIO;
+    rc = nbd_opt_read(client, name, namelen, errp);
+    if (rc <= 0) {
+        return rc;
     }
     name[namelen] = '\0';
-    client->optlen -= namelen;
     trace_nbd_negotiate_handle_export_name_request(name);

-    if (nbd_read(client->ioc, &requests, sizeof(requests), errp) < 0) {
-        return -EIO;
+    rc = nbd_opt_read(client, &requests, sizeof(requests), errp);
+    if (rc <= 0) {
+        return rc;
     }
     be16_to_cpus(&requests);
-    client->optlen -= sizeof(requests);
     trace_nbd_negotiate_handle_info_requests(requests);
-    if (requests != client->optlen / sizeof(request)) {
-        msg = "incorrect number of  requests for overall length";
-        goto invalid;
-    }
     while (requests--) {
-        if (nbd_read(client->ioc, &request, sizeof(request), errp) < 0) {
-            return -EIO;
+        rc = nbd_opt_read(client, &request, sizeof(request), errp);
+        if (rc <= 0) {
+            return rc;
         }
         be16_to_cpus(&request);
-        client->optlen -= sizeof(request);
         trace_nbd_negotiate_handle_info_request(request,
                                                 nbd_info_lookup(request));
         /* We care about NBD_INFO_NAME and NBD_INFO_BLOCK_SIZE;
@@ -472,7 +489,9 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
             break;
         }
     }
-    assert(client->optlen == 0);
+    if (client->optlen) {
+        return nbd_reject_length(client, false, errp);
+    }

     exp = nbd_export_find(name);
     if (!exp) {
@@ -560,13 +579,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         rc = 1;
     }
     return rc;
-
- invalid:
-    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
-        return -EIO;
-    }
-    return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID,
-                                      errp, "%s", msg);
 }


@@ -736,14 +748,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 return -EINVAL;

             default:
-                if (nbd_drop(client->ioc, length, errp) < 0) {
-                    return -EIO;
-                }
-                ret = nbd_negotiate_send_rep_err(client,
-                                                 NBD_REP_ERR_TLS_REQD, errp,
-                                                 "Option 0x%" PRIx32
-                                                 "not permitted before TLS",
-                                                 option);
+                ret = nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, errp,
+                                   "Option 0x%" PRIx32
+                                   "not permitted before TLS", option);
                 /* Let the client keep trying, unless they asked to
                  * quit. In this mode, we've already sent an error, so
                  * we can't ack the abort.  */
@@ -812,14 +819,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 break;

             default:
-                if (nbd_drop(client->ioc, length, errp) < 0) {
-                    return -EIO;
-                }
-                ret = nbd_negotiate_send_rep_err(client,
-                                                 NBD_REP_ERR_UNSUP, errp,
-                                                 "Unsupported option 0x%"
-                                                 PRIx32 " (%s)", option,
-                                                 nbd_opt_lookup(option));
+                ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
+                                   "Unsupported option 0x%" PRIx32 " (%s)",
+                                   option, nbd_opt_lookup(option));
                 break;
             }
         } else {
@@ -842,6 +844,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
         if (ret < 0) {
             return ret;
         }
+        assert(!client->optlen);
     }
 }

-- 
2.14.3
