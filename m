Received: from eggs.gnu.org ([209.51.188.92]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9ft-00016q-Fd
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9fr-0005SS-UL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 09:33:21 -0600
Message-Id: <20190117153321.29749-4-eblake@redhat.com>
In-Reply-To: <20190117153321.29749-1-eblake@redhat.com>
References: <20190117153321.29749-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] RFC: nbd: Expose protocol-specific
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Expose information that the NBD client remembers from its handshake
with the server. This is comparable to what 'qemu-nbd --list'
outputs when describing a server's capability, so a future patch
may refactor that to reuse this QAPI type.

The display of flags is interesting - rather than compute the
ImageInfoSpecificNBDFlagsList on every handshake, the client
code just saves raw flags. But it we know we will be presenting
things to an end user, it's nicer to have a list of flag names
than it is to have a raw integer that must be decoded.

Example output:
$ ./qemu-img info nbd://localhost:10809
image: nbd://localhost:10809
file format: raw
virtual size: 1.0M (1048576 bytes)
disk size: unavailable
Protocol specific information:
    flags:
    active contexts:
        [0]:
            name: base:allocation
            id: 0
    unknown flags: 1260

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Work in progress; there are several todos that I would polish up if
the idea behind this patch is agreeable, including making the 'flags'
reporting accurate.  Also, if this works well, I'd like to improve
'qemu-nbd --list' to reuse this QAPI type.
---
 qapi/block-core.json | 59 +++++++++++++++++++++++++++++++++++++++++++-
 block/nbd-client.h   |  1 +
 block/nbd-client.c   | 39 +++++++++++++++++++++++++++++
 block/nbd.c          |  3 +++
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 296c22a1003..f5fcd329dc6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -120,6 +120,62 @@
   'data': { 'align': 'int', 'discard': 'bool', 'write-zero': 'bool',
             '*discard-zero': 'bool' } }

+##
+# @ImageInfoSpecificNBDFlags:
+#
+# Enumeration of known NBD export flags.
+#
+# Since: 4.0
+##
+{ 'enum': 'ImageInfoSpecificNBDFlags', 'data': [
+    'readonly', 'flush', 'fua', 'rotational', 'trim', 'zeroes', 'df',
+    'multi', 'resize', 'cache'
+  ] }
+
+##
+# @ImageInfoSpecificNBDContext:
+#
+# Details about an NBD meta-context negotiated with NBD_OPT_SET_META_CON=
TEXT
+# and later observed via NBD_CMD_BLOCK_STATUS.
+#
+# @name: context name
+#
+# @id: context id, if context is active
+#
+# Since: 4.0
+##
+{ 'struct': 'ImageInfoSpecificNBDContext',
+  'data': { 'name': 'str', '*id': 'uint32' } }
+
+##
+# @ImageInfoSpecificNBD:
+#
+# @description: server's description of export
+#
+# @flags: listing of servers' export flags with names recognized by qemu
+#
+# @unknown-flags: any remaining export flags
+#
+# @min-block: minimum I/O size reported by server (assumed 512 if omitte=
d)
+#
+# @opt-block: optimum I/O size reported by server
+#
+# @max-block: maximum I/O size reported by server (assumed 32M if omitte=
d)
+#
+# @active-contexts: server meta-contexts in use by this client
+#
+# @contexts: server meta-contexts that were advertised but not selected
+#
+# Since: 4.0
+##
+{ 'struct': 'ImageInfoSpecificNBD',
+  'data': { '*description': 'str', '*flags': [ 'ImageInfoSpecificNBDFlag=
s' ],
+            '*unknown-flags': 'uint16', '*min-block': 'uint32',
+            '*opt-block': 'uint32', '*max-block': 'uint32',
+            '*active-contexts': [ 'ImageInfoSpecificNBDContext' ],
+            '*contexts': [ 'ImageInfoSpecificNBDContext' ]
+  } }
+
 ##
 # @ImageInfoSpecific:
 #
@@ -137,7 +193,8 @@
       # to define a ImageInfoSpecificLUKS
       'luks': 'QCryptoBlockInfoLUKS',
       # Protocol drivers:
-      'file': 'ImageInfoSpecificFile'
+      'file': 'ImageInfoSpecificFile',
+      'nbd': 'ImageInfoSpecificNBD'
   } }

 ##
diff --git a/block/nbd-client.h b/block/nbd-client.h
index cfc90550b99..09f51ca2529 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -67,5 +67,6 @@ int coroutine_fn nbd_client_co_block_status(BlockDriver=
State *bs,
                                             int64_t offset, int64_t byte=
s,
                                             int64_t *pnum, int64_t *map,
                                             BlockDriverState **file);
+ImageInfoSpecific *nbd_client_specific_info(BlockDriverState *bs);

 #endif /* NBD_CLIENT_H */
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 813539676d2..0cc67d45b5e 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -952,6 +952,45 @@ int coroutine_fn nbd_client_co_block_status(BlockDri=
verState *bs,
            (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
 }

+ImageInfoSpecific *nbd_client_specific_info(BlockDriverState *bs)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    ImageInfoSpecific *info;
+    ImageInfoSpecificNBD *infonbd;
+
+    info =3D g_new0(ImageInfoSpecific, 1);
+    info->type =3D IMAGE_INFO_SPECIFIC_KIND_NBD;
+    infonbd =3D info->u.nbd.data =3D g_new0(ImageInfoSpecificNBD, 1);
+
+    /* TODO: Remember/expose server's description during handshake? */
+    if (client->info.flags & NBD_FLAG_HAS_FLAGS) {
+        uint16_t remaining =3D client->info.flags;
+
+        infonbd->has_flags =3D true;
+        remaining &=3D ~NBD_FLAG_HAS_FLAGS;
+        /* TODO: Populate flags */
+        if (remaining) {
+            infonbd->has_unknown_flags =3D true;
+            infonbd->unknown_flags =3D remaining;
+        }
+    }
+    /* TODO: Populate block sizing */
+    if (client->info.base_allocation) {
+        ImageInfoSpecificNBDContext *context;
+
+        infonbd->has_active_contexts =3D true;
+        infonbd->active_contexts =3D g_new0(ImageInfoSpecificNBDContextL=
ist, 1);
+        context =3D g_new(ImageInfoSpecificNBDContext, 1);
+        infonbd->active_contexts->value =3D context;
+        context->name =3D g_strdup(client->info.x_dirty_bitmap ?:
+                                 "base:allocation");
+        context->has_id =3D true;
+        context->id =3D client->info.context_id;
+    }
+    /* TODO: Remember/expose non-tracked contexts learned during handsha=
ke? */
+    return info;
+}
+
 void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73b..8b6d3d6cf4a 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -576,6 +576,7 @@ static BlockDriver bdrv_nbd =3D {
     .bdrv_close                 =3D nbd_close,
     .bdrv_co_flush_to_os        =3D nbd_co_flush,
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
+    .bdrv_get_specific_info     =3D nbd_client_specific_info,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_detach_aio_context,
@@ -596,6 +597,7 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .bdrv_close                 =3D nbd_close,
     .bdrv_co_flush_to_os        =3D nbd_co_flush,
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
+    .bdrv_get_specific_info     =3D nbd_client_specific_info,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_detach_aio_context,
@@ -616,6 +618,7 @@ static BlockDriver bdrv_nbd_unix =3D {
     .bdrv_close                 =3D nbd_close,
     .bdrv_co_flush_to_os        =3D nbd_co_flush,
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
+    .bdrv_get_specific_info     =3D nbd_client_specific_info,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_detach_aio_context,
--=20
2.20.1
