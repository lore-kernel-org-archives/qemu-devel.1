Received: from eggs.gnu.org ([2001:4830:134:3::10]:40800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q1-0005ZV-Qp
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q0-0003WT-OO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:09 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:47 -0600
Message-Id: <20170221024248.11027-8-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on
 server
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

The upstream NBD Protocol has defined a new extension to allow
the server to advertise block sizes to the client, as well as
a way for the client to inform the server that it intends to
obey block sizes.

Thanks to a recent fix (commit df7b97ff), our real minimum
transfer size is always 1 (the block layer takes care of
read-modify-write on our behalf), but we're still more efficient
if we advertise 512 when the client supports it, as follows:
- OPT_INFO, but no NBD_INFO_BLOCK_SIZE: advertise 512, then
fail with NBD_REP_ERR_BLOCK_SIZE_REQD; client is free to try
something else since we don't disconnect
- OPT_INFO with NBD_INFO_BLOCK_SIZE: advertise 512
- OPT_GO, but no NBD_INFO_BLOCK_SIZE: advertise 1
- OPT_GO with NBD_INFO_BLOCK_SIZE: advertise 512

We can also advertise the optimum block size (presumably the
cluster size, when exporting a qcow2 file), and our absolute
maximum transfer size of 32M, to help newer clients avoid
EINVAL failures or abrupt disconnects on oversize requests.

We do not reject clients for using the older NBD_OPT_EXPORT_NAME;
we are no worse off for those clients than we used to be.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 nbd/server.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3b1a4a5..d63e5d3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -409,6 +409,8 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
     uint16_t request;
     uint32_t namelen;
     bool sendname = false;
+    bool blocksize = false;
+    uint32_t sizes[3];
     char buf[sizeof(uint64_t) + sizeof(uint16_t)];
     const char *msg;

@@ -444,11 +446,16 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         length -= sizeof(request);
         TRACE("Client requested info %d (%s)", request,
               nbd_info_lookup(request));
-        /* For now, we only care about NBD_INFO_NAME; everything else
-         * is either a request we don't know or something we send
-         * regardless of request. */
-        if (request == NBD_INFO_NAME) {
+        /* We care about NBD_INFO_NAME and NBD_INFO_BLOCK_SIZE;
+         * everything else is either a request we don't know or
+         * something we send regardless of request */
+        switch (request) {
+        case NBD_INFO_NAME:
             sendname = true;
+            break;
+        case NBD_INFO_BLOCK_SIZE:
+            blocksize = true;
+            break;
         }
     }

@@ -499,6 +506,27 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         }
     }

+    /* Send NBD_INFO_BLOCK_SIZE always, but tweak the minimum size
+     * according to whether the client requested it, and according to
+     * whether this is OPT_INFO or OPT_GO. */
+    /* minimum - 1 for back-compat, or 512 if client is new enough.
+     * TODO: consult blk_bs(blk)->request_align? */
+    sizes[0] = (opt == NBD_OPT_INFO || blocksize) ? BDRV_SECTOR_SIZE : 1;
+    /* preferred - At least 4096, but larger as appropriate. */
+    sizes[1] = MAX(blk_get_opt_transfer(exp->blk), 4096);
+    /* maximum - At most 32M, but smaller as appropriate. */
+    sizes[2] = MIN(blk_get_max_transfer(exp->blk), NBD_MAX_BUFFER_SIZE);
+    TRACE("advertising minimum 0x%" PRIx32 ", preferred 0x%" PRIx32
+          ", maximum 0x%" PRIx32, sizes[0], sizes[1], sizes[2]);
+    cpu_to_be32s(&sizes[0]);
+    cpu_to_be32s(&sizes[1]);
+    cpu_to_be32s(&sizes[2]);
+    rc = nbd_negotiate_send_info(client, opt, NBD_INFO_BLOCK_SIZE,
+                                 sizeof(sizes), sizes);
+    if (rc < 0) {
+        return rc;
+    }
+
     /* Send NBD_INFO_EXPORT always */
     TRACE("advertising size %" PRIu64 " and flags %" PRIx16,
           exp->size, exp->nbdflags | myflags);
@@ -510,6 +538,17 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         return rc;
     }

+    /* If the client is just asking for NBD_OPT_INFO, but forgot to
+     * request block sizes, return an error.
+     * TODO: consult blk_bs(blk)->request_align, and only error if it
+     * is not 1? */
+    if (opt == NBD_OPT_INFO && !blocksize) {
+        return nbd_negotiate_send_rep_err(client->ioc,
+                                          NBD_REP_ERR_BLOCK_SIZE_REQD, opt,
+                                          "request NBD_INFO_BLOCK_SIZE to "
+                                          "use this export");
+    }
+
     /* Final reply */
     rc = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, opt);
     if (rc < 0) {
-- 
2.9.3
