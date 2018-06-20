Received: from eggs.gnu.org ([2001:4830:134:3::10]:55484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVfwy-0004tm-En
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVfww-0003LL-N0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:27:16 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <899fcefc-84f1-7238-c77b-9c925c9872c5@redhat.com>
Date: Wed, 20 Jun 2018 11:27:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:
> "qemu:dirty-bitmap:<export bitmap name>".
> 
> With new metadata context negotiated, BLOCK_STATUS query will reply
> with dirty-bitmap data, converted to extents. New public function
> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
> may be exported.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h |   6 ++
>   nbd/server.c        | 271 ++++++++++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 259 insertions(+), 18 deletions(-)

I'm squashing this in, and adding:
Reviewed-by: Eric Blake <eblake@redhat.com>

(Grammar fixes, prefer 'unsigned int' over 'unsigned', add 'last' flag 
for avoiding separate chunk in reply, shorter variable name to fit 80 
columns, tweak 'length' tracking in order to add a trace before sending 
a status reply)

diff --git i/include/block/nbd.h w/include/block/nbd.h
index a653d0fba79..8bb9606c39b 100644
--- i/include/block/nbd.h
+++ w/include/block/nbd.h
@@ -229,13 +229,11 @@ enum {
  #define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
  #define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)

-/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
- * for base:allocation meta context */
+/* Extent flags for base:allocation in NBD_REPLY_TYPE_BLOCK_STATUS */
  #define NBD_STATE_HOLE (1 << 0)
  #define NBD_STATE_ZERO (1 << 1)

-/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
- * for qemu:dirty-bitmap:* meta contexts */
+/* Extent flags for qemu:dirty-bitmap in NBD_REPLY_TYPE_BLOCK_STATUS */
  #define NBD_STATE_DIRTY (1 << 0)

  static inline bool nbd_reply_type_is_error(int type)
diff --git i/nbd/server.c w/nbd/server.c
index 6f662bd4c7f..e84aea6cf03 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -25,9 +25,10 @@
  #define NBD_META_ID_BASE_ALLOCATION 0
  #define NBD_META_ID_DIRTY_BITMAP 1

-/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical constant. 
If need
- * to increase, note that NBD protocol defines 32 mb as a limit, after 
which the
- * reply may be considered as a denial of service attack. */
+/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical
+ * constant. If an increase is needed, note that the NBD protocol
+ * recommends no larger than 32 mb, so that the client won't consider
+ * the reply as a denial of service attack. */
  #define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8)

  static int system_errno_to_nbd_errno(int err)
@@ -101,7 +102,7 @@ typedef struct NBDExportMetaContexts {
      bool valid; /* means that negotiation of the option finished without
                     errors */
      bool base_allocation; /* export base:allocation context (block 
status) */
-    bool dirty_bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
+    bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
  } NBDExportMetaContexts;

  struct NBDClient {
@@ -836,16 +837,17 @@ static int nbd_meta_qemu_query(NBDClient *client, 
NBDExportMetaContexts *meta,
                                 uint32_t len, Error **errp)
  {
      bool dirty_bitmap = false;
-    int dirty_bitmap_len = strlen("dirty-bitmap:");
+    size_t dirty_bitmap_len = strlen("dirty-bitmap:");
      int ret;

      if (!meta->exp->export_bitmap) {
+        trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
          return nbd_opt_skip(client, len, errp);
      }

      if (len == 0) {
          if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
-            meta->dirty_bitmap = true;
+            meta->bitmap = true;
          }
          trace_nbd_negotiate_meta_query_parse("empty");
          return 1;
@@ -870,7 +872,7 @@ static int nbd_meta_qemu_query(NBDClient *client, 
NBDExportMetaContexts *meta,

      return nbd_meta_empty_or_pattern(
              client, meta->exp->export_bitmap_context +
-            strlen("qemu:dirty_bitmap:"), len, &meta->dirty_bitmap, errp);
+            strlen("qemu:dirty_bitmap:"), len, &meta->bitmap, errp);
  }

  /* nbd_negotiate_meta_query
@@ -888,11 +890,14 @@ static int nbd_meta_qemu_query(NBDClient *client, 
NBDExportMetaContexts *meta,
  static int nbd_negotiate_meta_query(NBDClient *client,
                                      NBDExportMetaContexts *meta, Error 
**errp)
  {
+    /*
+     * Both 'qemu' and 'base' namespaces have length = 5 including a
+     * colon. If another length namespace is later introduced, this
+     * should certainly be refactored.
+     */
      int ret;
      size_t ns_len = 5;
-    char ns[5]; /* Both 'qemu' and 'base' namespaces have length = 5 
including a
-                   colon. If it's needed to introduce a namespace of 
the other
-                   length, this should be certainly refactored. */
+    char ns[5];
      uint32_t len;

      ret = nbd_opt_read(client, &len, sizeof(len), errp);
@@ -991,7 +996,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
          }
      }

-    if (meta->dirty_bitmap) {
+    if (meta->bitmap) {
          ret = nbd_negotiate_send_meta_context(client,
 
meta->exp->export_bitmap_context,
                                                NBD_META_ID_DIRTY_BITMAP,
@@ -1876,11 +1881,13 @@ static int 
blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,

  /* nbd_co_send_extents
   *
- * NBD_REPLY_FLAG_DONE is not set, don't forget to send it.
+ * @last controls whether NBD_REPLY_FLAG_DONE is sent.
   *
- * @extents should be in big-endian */
+ * @extents should already be in big-endian format.
+ */
  static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
-                               NBDExtent *extents, unsigned nb_extents,
+                               NBDExtent *extents, unsigned int nb_extents,
+                               uint64_t length, bool last,
                                 uint32_t context_id, Error **errp)
  {
      NBDStructuredMeta chunk;
@@ -1890,7 +1897,9 @@ static int nbd_co_send_extents(NBDClient *client, 
uint64_t handle,
          {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
      };

-    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STATUS,
+    trace_nbd_co_send_extents(handle, nb_extents, context_id, length, 
last);
+    set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
+                 NBD_REPLY_TYPE_BLOCK_STATUS,
                   handle, sizeof(chunk) - sizeof(chunk.h) + 
iov[1].iov_len);
      stl_be_p(&chunk.context_id, context_id);

@@ -1900,8 +1909,8 @@ static int nbd_co_send_extents(NBDClient *client, 
uint64_t handle,
  /* Get block status from the exported device and send it to the client */
  static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
                                      BlockDriverState *bs, uint64_t offset,
-                                    uint64_t length, uint32_t context_id,
-                                    Error **errp)
+                                    uint64_t length, bool last,
+                                    uint32_t context_id, Error **errp)
  {
      int ret;
      NBDExtent extent;
@@ -1912,17 +1921,18 @@ static int nbd_co_send_block_status(NBDClient 
*client, uint64_t handle,
                  client, handle, -ret, "can't get block status", errp);
      }

-    return nbd_co_send_extents(client, handle, &extent, 1, context_id, 
errp);
+    return nbd_co_send_extents(client, handle, &extent, 1, length, last,
+                               context_id, errp);
  }

  /* Set several extents, describing region of given @length with given 
@flags.
   * Do not set more than @nb_extents, return number of set extents.
   */
-static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
-                            uint64_t length, uint32_t flags)
+static unsigned int add_extents(NBDExtent *extents, unsigned nb_extents,
+                                uint64_t length, uint32_t flags)
  {
-    unsigned i = 0;
-    uint32_t max_extent = QEMU_ALIGN_DOWN(INT32_MAX, BDRV_SECTOR_SIZE);
+    unsigned int i = 0;
+    uint32_t max_extent = 0x80000000U;
      uint32_t max_extent_be = cpu_to_be32(max_extent);
      uint32_t flags_be = cpu_to_be32(flags);

@@ -1942,13 +1952,14 @@ static unsigned add_extents(NBDExtent *extents, 
unsigned nb_extents,
      return i;
  }

-static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
-                                  uint64_t length, NBDExtent *extents,
-                                  unsigned nb_extents, bool dont_fragment)
+static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t 
offset,
+                                      uint64_t *length, NBDExtent *extents,
+                                      unsigned int nb_extents,
+                                      bool dont_fragment)
  {
      uint64_t begin = offset, end;
-    uint64_t overall_end = offset + length;
-    unsigned i = 0;
+    uint64_t overall_end = offset + *length;
+    unsigned int i = 0;
      BdrvDirtyBitmapIter *it;
      bool dirty;

@@ -1983,23 +1994,25 @@ static unsigned 
bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,

      bdrv_dirty_bitmap_unlock(bitmap);

+    *length = end - begin;
      return i;
  }

  static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
                                BdrvDirtyBitmap *bitmap, uint64_t offset,
-                              uint64_t length, bool dont_fragment,
+                              uint32_t length, bool dont_fragment,
                                uint32_t context_id, Error **errp)
  {
      int ret;
-    unsigned nb_extents = dont_fragment ? 1 : NBD_MAX_BITMAP_EXTENTS;
+    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BITMAP_EXTENTS;
      NBDExtent *extents = g_new(NBDExtent, nb_extents);
+    uint64_t final_length = length;

-    nb_extents = bitmap_to_extents(bitmap, offset, length, extents, 
nb_extents,
-                                   dont_fragment);
+    nb_extents = bitmap_to_extents(bitmap, offset, &final_length, extents,
+                                   nb_extents, dont_fragment);

-    ret = nbd_co_send_extents(client, handle, extents, nb_extents, 
context_id,
-                              errp);
+    ret = nbd_co_send_extents(client, handle, extents, nb_extents,
+                              final_length, true, context_id, errp);

      g_free(extents);

@@ -2221,12 +2234,13 @@ static coroutine_fn int 
nbd_handle_request(NBDClient *client,
      case NBD_CMD_BLOCK_STATUS:
          if (client->export_meta.valid &&
              (client->export_meta.base_allocation ||
-             client->export_meta.dirty_bitmap))
+             client->export_meta.bitmap))
          {
              if (client->export_meta.base_allocation) {
                  ret = nbd_co_send_block_status(client, request->handle,
                                                 blk_bs(exp->blk), 
request->from,
                                                 request->len,
+                                               !client->export_meta.bitmap,
 
NBD_META_ID_BASE_ALLOCATION,
                                                 errp);
                  if (ret < 0) {
@@ -2234,7 +2248,7 @@ static coroutine_fn int 
nbd_handle_request(NBDClient *client,
                  }
              }

-            if (client->export_meta.dirty_bitmap) {
+            if (client->export_meta.bitmap) {
                  ret = nbd_co_send_bitmap(client, request->handle,
                                           client->exp->export_bitmap,
                                           request->from, request->len,
diff --git i/nbd/trace-events w/nbd/trace-events
index dee081e7758..5e1d4afe8e6 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -64,6 +64,7 @@ nbd_co_send_simple_reply(uint64_t handle, uint32_t 
error, const char *errname, i
  nbd_co_send_structured_done(uint64_t handle) "Send structured reply 
done: handle = %" PRIu64
  nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void 
*data, size_t size) "Send structured read data reply: handle = %" PRIu64 
", offset = %" PRIu64 ", data = %p, len = %zu"
  nbd_co_send_structured_read_hole(uint64_t handle, uint64_t offset, 
size_t size) "Send structured read hole reply: handle = %" PRIu64 ", 
offset = %" PRIu64 ", len = %zu"
+nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t id, 
uint64_t length, int last) "Send block status reply: handle = %" PRIu64 
", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last 
chunk = %d)"
  nbd_co_send_structured_error(uint64_t handle, int err, const char 
*errname, const char *msg) "Send structured error reply: handle = %" 
PRIu64 ", error = %d (%s), msg = '%s'"
  nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, 
const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 
" (%s)"
  nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) 
"Payload received: handle = %" PRIu64 ", len = %" PRIu32


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
