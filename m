Received: from eggs.gnu.org ([2001:4830:134:3::10]:49597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCX-0000nS-7U
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCU-0000om-Ip
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCT-0000nM-U8
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JECCh044598
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:45 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5edb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:44 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:43 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:32 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-40-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 39/55] nbd/client: Use error_prepend() correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

When using error prepend(), it is necessary to end with a space
in the format string; otherwise, messages come out incorrectly,
such as when connecting to a socket that hangs up immediately:

can't open device nbd://localhost:10809/: Failed to read dataUnexpected end-of-file before all bytes were read

Originally botched in commit e44ed99d, then several more instances
added in the meantime.

Pre-existing and not fixed here: we are inconsistent on capitalization;
some of our messages start with lower case, and others start with upper,
although the use of error_prepend() is much nicer to read when all
fragments consistently start with lower.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171113152424.25381-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit cb6b1a3fc30c52ffd94ed0b69ca5991b19651724)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/client.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 0a17de80b5..4caff77119 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -111,12 +111,12 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
     stl_be_p(&req.length, len);
 
     if (nbd_write(ioc, &req, sizeof(req), errp) < 0) {
-        error_prepend(errp, "Failed to send option request header");
+        error_prepend(errp, "Failed to send option request header: ");
         return -1;
     }
 
     if (len && nbd_write(ioc, (char *) data, len, errp) < 0) {
-        error_prepend(errp, "Failed to send option request data");
+        error_prepend(errp, "Failed to send option request data: ");
         return -1;
     }
 
@@ -145,7 +145,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
 {
     QEMU_BUILD_BUG_ON(sizeof(*reply) != 20);
     if (nbd_read(ioc, reply, sizeof(*reply), errp) < 0) {
-        error_prepend(errp, "failed to read option reply");
+        error_prepend(errp, "failed to read option reply: ");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -198,7 +198,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
         msg = g_malloc(reply->length + 1);
         if (nbd_read(ioc, msg, reply->length, errp) < 0) {
             error_prepend(errp, "failed to read option error 0x%" PRIx32
-                          " (%s) message",
+                          " (%s) message: ",
                           reply->type, nbd_rep_lookup(reply->type));
             goto cleanup;
         }
@@ -309,7 +309,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         return -1;
     }
     if (nbd_read(ioc, &namelen, sizeof(namelen), errp) < 0) {
-        error_prepend(errp, "failed to read option name length");
+        error_prepend(errp, "failed to read option name length: ");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -322,7 +322,8 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
     }
     if (namelen != strlen(want)) {
         if (nbd_drop(ioc, len, errp) < 0) {
-            error_prepend(errp, "failed to skip export name with wrong length");
+            error_prepend(errp,
+                          "failed to skip export name with wrong length: ");
             nbd_send_opt_abort(ioc);
             return -1;
         }
@@ -331,14 +332,14 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
 
     assert(namelen < sizeof(name));
     if (nbd_read(ioc, name, namelen, errp) < 0) {
-        error_prepend(errp, "failed to read export name");
+        error_prepend(errp, "failed to read export name: ");
         nbd_send_opt_abort(ioc);
         return -1;
     }
     name[namelen] = '\0';
     len -= namelen;
     if (nbd_drop(ioc, len, errp) < 0) {
-        error_prepend(errp, "failed to read export description");
+        error_prepend(errp, "failed to read export description: ");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -424,7 +425,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             return -1;
         }
         if (nbd_read(ioc, &type, sizeof(type), errp) < 0) {
-            error_prepend(errp, "failed to read info type");
+            error_prepend(errp, "failed to read info type: ");
             nbd_send_opt_abort(ioc);
             return -1;
         }
@@ -439,13 +440,13 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                 return -1;
             }
             if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
-                error_prepend(errp, "failed to read info size");
+                error_prepend(errp, "failed to read info size: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
             be64_to_cpus(&info->size);
             if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
-                error_prepend(errp, "failed to read info flags");
+                error_prepend(errp, "failed to read info flags: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -462,7 +463,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             }
             if (nbd_read(ioc, &info->min_block, sizeof(info->min_block),
                          errp) < 0) {
-                error_prepend(errp, "failed to read info minimum block size");
+                error_prepend(errp, "failed to read info minimum block size: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -475,7 +476,8 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             }
             if (nbd_read(ioc, &info->opt_block, sizeof(info->opt_block),
                          errp) < 0) {
-                error_prepend(errp, "failed to read info preferred block size");
+                error_prepend(errp,
+                              "failed to read info preferred block size: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -489,7 +491,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             }
             if (nbd_read(ioc, &info->max_block, sizeof(info->max_block),
                          errp) < 0) {
-                error_prepend(errp, "failed to read info maximum block size");
+                error_prepend(errp, "failed to read info maximum block size: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -501,7 +503,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
         default:
             trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
             if (nbd_drop(ioc, len, errp) < 0) {
-                error_prepend(errp, "Failed to read info payload");
+                error_prepend(errp, "Failed to read info payload: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
@@ -624,7 +626,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
     }
 
     if (nbd_read(ioc, buf, 8, errp) < 0) {
-        error_prepend(errp, "Failed to read data");
+        error_prepend(errp, "Failed to read data: ");
         goto fail;
     }
 
@@ -643,7 +645,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
     }
 
     if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
-        error_prepend(errp, "Failed to read magic");
+        error_prepend(errp, "Failed to read magic: ");
         goto fail;
     }
     magic = be64_to_cpu(magic);
@@ -655,7 +657,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         bool fixedNewStyle = false;
 
         if (nbd_read(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
-            error_prepend(errp, "Failed to read server flags");
+            error_prepend(errp, "Failed to read server flags: ");
             goto fail;
         }
         globalflags = be16_to_cpu(globalflags);
@@ -671,7 +673,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         /* client requested flags */
         clientflags = cpu_to_be32(clientflags);
         if (nbd_write(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
-            error_prepend(errp, "Failed to send clientflags field");
+            error_prepend(errp, "Failed to send clientflags field: ");
             goto fail;
         }
         if (tlscreds) {
@@ -723,13 +725,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
 
         /* Read the response */
         if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
-            error_prepend(errp, "Failed to read export length");
+            error_prepend(errp, "Failed to read export length: ");
             goto fail;
         }
         be64_to_cpus(&info->size);
 
         if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
-            error_prepend(errp, "Failed to read export flags");
+            error_prepend(errp, "Failed to read export flags: ");
             goto fail;
         }
         be16_to_cpus(&info->flags);
@@ -746,13 +748,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         }
 
         if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
-            error_prepend(errp, "Failed to read export length");
+            error_prepend(errp, "Failed to read export length: ");
             goto fail;
         }
         be64_to_cpus(&info->size);
 
         if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
-            error_prepend(errp, "Failed to read export flags");
+            error_prepend(errp, "Failed to read export flags: ");
             goto fail;
         }
         be32_to_cpus(&oldflags);
@@ -768,7 +770,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
 
     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
     if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
-        error_prepend(errp, "Failed to read reserved block");
+        error_prepend(errp, "Failed to read reserved block: ");
         goto fail;
     }
     rc = 0;
-- 
2.11.0
