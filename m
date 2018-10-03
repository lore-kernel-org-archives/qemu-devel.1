Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obO-0001fG-1p
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obM-000110-3B
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 Oct 2018 16:22:07 -0500
Message-Id: <20181003212211.812374-2-eblake@redhat.com>
In-Reply-To: <20181003212211.812374-1-eblake@redhat.com>
References: <20181003212211.812374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] nbd: Don't take address of fields in packed
 structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by not using the
"modify in place" byte swapping functions.

This patch was produced with the following spatch script:
@@
expression E;
@@
-be16_to_cpus(&E);
+E = be16_to_cpu(E);
@@
expression E;
@@
-be32_to_cpus(&E);
+E = be32_to_cpu(E);
@@
expression E;
@@
-be64_to_cpus(&E);
+E = be64_to_cpu(E);
@@
expression E;
@@
-cpu_to_be16s(&E);
+E = cpu_to_be16(E);
@@
expression E;
@@
-cpu_to_be32s(&E);
+E = cpu_to_be32(E);
@@
expression E;
@@
-cpu_to_be64s(&E);
+E = cpu_to_be64(E);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180927164200.15097-1-peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase, and squash in missed changes]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 44 ++++++++++++++++++++++----------------------
 nbd/server.c | 24 ++++++++++++------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 40b74d9761f..b4d457a19ad 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -117,10 +117,10 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    be64_to_cpus(&reply->magic);
-    be32_to_cpus(&reply->option);
-    be32_to_cpus(&reply->type);
-    be32_to_cpus(&reply->length);
+    reply->magic = be64_to_cpu(reply->magic);
+    reply->option = be32_to_cpu(reply->option);
+    reply->type = be32_to_cpu(reply->type);
+    reply->length = be32_to_cpu(reply->length);

     trace_nbd_receive_option_reply(reply->option, nbd_opt_lookup(reply->option),
                                    reply->type, nbd_rep_lookup(reply->type),
@@ -396,7 +396,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             return -1;
         }
         len -= sizeof(type);
-        be16_to_cpus(&type);
+        type = be16_to_cpu(type);
         switch (type) {
         case NBD_INFO_EXPORT:
             if (len != sizeof(info->size) + sizeof(info->flags)) {
@@ -410,13 +410,13 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            be64_to_cpus(&info->size);
+            info->size = be64_to_cpu(info->size);
             if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
                 error_prepend(errp, "failed to read info flags: ");
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            be16_to_cpus(&info->flags);
+            info->flags = be16_to_cpu(info->flags);
             trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
             break;

@@ -433,7 +433,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            be32_to_cpus(&info->min_block);
+            info->min_block = be32_to_cpu(info->min_block);
             if (!is_power_of_2(info->min_block)) {
                 error_setg(errp, "server minimum block size %" PRIu32
                            " is not a power of two", info->min_block);
@@ -447,7 +447,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            be32_to_cpus(&info->opt_block);
+            info->opt_block = be32_to_cpu(info->opt_block);
             if (!is_power_of_2(info->opt_block) ||
                 info->opt_block < info->min_block) {
                 error_setg(errp, "server preferred block size %" PRIu32
@@ -461,7 +461,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            be32_to_cpus(&info->max_block);
+            info->max_block = be32_to_cpu(info->max_block);
             if (info->max_block < info->min_block) {
                 error_setg(errp, "server maximum block size %" PRIu32
                            " is not valid", info->max_block);
@@ -668,7 +668,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
             return -1;
         }
-        be32_to_cpus(&received_id);
+        received_id = be32_to_cpu(received_id);

         reply.length -= sizeof(received_id);
         name = g_malloc(reply.length + 1);
@@ -872,13 +872,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
             error_prepend(errp, "Failed to read export length: ");
             goto fail;
         }
-        be64_to_cpus(&info->size);
+        info->size = be64_to_cpu(info->size);

         if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags: ");
             goto fail;
         }
-        be16_to_cpus(&info->flags);
+        info->flags = be16_to_cpu(info->flags);
     } else if (magic == NBD_CLIENT_MAGIC) {
         uint32_t oldflags;

@@ -895,13 +895,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
             error_prepend(errp, "Failed to read export length: ");
             goto fail;
         }
-        be64_to_cpus(&info->size);
+        info->size = be64_to_cpu(info->size);

         if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags: ");
             goto fail;
         }
-        be32_to_cpus(&oldflags);
+        oldflags = be32_to_cpu(oldflags);
         if (oldflags & ~0xffff) {
             error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
             goto fail;
@@ -1080,8 +1080,8 @@ static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
         return ret;
     }

-    be32_to_cpus(&reply->error);
-    be64_to_cpus(&reply->handle);
+    reply->error = be32_to_cpu(reply->error);
+    reply->handle = be64_to_cpu(reply->handle);

     return 0;
 }
@@ -1105,10 +1105,10 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
         return ret;
     }

-    be16_to_cpus(&chunk->flags);
-    be16_to_cpus(&chunk->type);
-    be64_to_cpus(&chunk->handle);
-    be32_to_cpus(&chunk->length);
+    chunk->flags = be16_to_cpu(chunk->flags);
+    chunk->type = be16_to_cpu(chunk->type);
+    chunk->handle = be64_to_cpu(chunk->handle);
+    chunk->length = be32_to_cpu(chunk->length);

     return 0;
 }
@@ -1128,7 +1128,7 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
         return ret;
     }

-    be32_to_cpus(&reply->magic);
+    reply->magic = be32_to_cpu(reply->magic);

     switch (reply->magic) {
     case NBD_SIMPLE_REPLY_MAGIC:
diff --git a/nbd/server.c b/nbd/server.c
index c3dd402b45e..98d0fa25158 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -333,7 +333,7 @@ static int nbd_opt_read_name(NBDClient *client, char *name, uint32_t *length,
     if (ret <= 0) {
         return ret;
     }
-    cpu_to_be32s(&len);
+    len = cpu_to_be32(len);

     if (len > NBD_MAX_NAME_SIZE) {
         return nbd_opt_invalid(client, errp,
@@ -486,7 +486,7 @@ static int nbd_negotiate_send_info(NBDClient *client,
     if (rc < 0) {
         return rc;
     }
-    cpu_to_be16s(&info);
+    info = cpu_to_be16(info);
     if (nbd_write(client->ioc, &info, sizeof(info), errp) < 0) {
         return -EIO;
     }
@@ -551,14 +551,14 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     if (rc <= 0) {
         return rc;
     }
-    be16_to_cpus(&requests);
+    requests = be16_to_cpu(requests);
     trace_nbd_negotiate_handle_info_requests(requests);
     while (requests--) {
         rc = nbd_opt_read(client, &request, sizeof(request), errp);
         if (rc <= 0) {
             return rc;
         }
-        be16_to_cpus(&request);
+        request = be16_to_cpu(request);
         trace_nbd_negotiate_handle_info_request(request,
                                                 nbd_info_lookup(request));
         /* We care about NBD_INFO_NAME and NBD_INFO_BLOCK_SIZE;
@@ -618,9 +618,9 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     /* maximum - At most 32M, but smaller as appropriate. */
     sizes[2] = MIN(blk_get_max_transfer(exp->blk), NBD_MAX_BUFFER_SIZE);
     trace_nbd_negotiate_handle_info_block_size(sizes[0], sizes[1], sizes[2]);
-    cpu_to_be32s(&sizes[0]);
-    cpu_to_be32s(&sizes[1]);
-    cpu_to_be32s(&sizes[2]);
+    sizes[0] = cpu_to_be32(sizes[0]);
+    sizes[1] = cpu_to_be32(sizes[1]);
+    sizes[2] = cpu_to_be32(sizes[2]);
     rc = nbd_negotiate_send_info(client, NBD_INFO_BLOCK_SIZE,
                                  sizeof(sizes), sizes, errp);
     if (rc < 0) {
@@ -904,7 +904,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
     if (ret <= 0) {
         return ret;
     }
-    cpu_to_be32s(&len);
+    len = cpu_to_be32(len);

     if (len < ns_len) {
         trace_nbd_negotiate_meta_query_skip("length too short");
@@ -971,7 +971,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (ret <= 0) {
         return ret;
     }
-    cpu_to_be32s(&nb_queries);
+    nb_queries = cpu_to_be32(nb_queries);
     trace_nbd_negotiate_meta_context(nbd_opt_lookup(client->opt),
                                      export_name, nb_queries);

@@ -1049,7 +1049,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
         error_prepend(errp, "read failed: ");
         return -EIO;
     }
-    be32_to_cpus(&flags);
+    flags = be32_to_cpu(flags);
     trace_nbd_negotiate_options_flags(flags);
     if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
         fixedNewstyle = true;
@@ -1900,8 +1900,8 @@ static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
     extents_end = extent + 1;

     for (extent = extents; extent < extents_end; extent++) {
-        cpu_to_be32s(&extent->flags);
-        cpu_to_be32s(&extent->length);
+        extent->flags = cpu_to_be32(extent->flags);
+        extent->length = cpu_to_be32(extent->length);
     }

     *bytes -= remaining_bytes;
-- 
2.17.1
