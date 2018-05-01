Received: from eggs.gnu.org ([2001:4830:134:3::10]:46232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcax-0006n0-0x
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcav-0001ae-T5
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  1 May 2018 16:13:36 -0500
Message-Id: <20180501211336.986372-5-eblake@redhat.com>
In-Reply-To: <20180501211336.986372-1-eblake@redhat.com>
References: <20180501211336.986372-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] nbd/server: Support requests of additional
 block sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

The NBD spec is clarifying [1] that a server may want to advertise
different limits for READ/WRITE (in our case, 32M) than for
TRIM/ZERO (in our case, nearly 4G).  Implement the server
side support for these alternate limits, by always advertising
the new information (a compliant client must ignore a gratuitous
advertisement if it is unknown).

[1] https://lists.debian.org/nbd/2018/03/msg00048.html

Signed-off-by: Eric Blake <eblake@redhat.com>

---

The given URL for the NBD spec was v3; it will change to be a v4
version of that patch in part to point back to this qemu commit
as a proof of implementation.
---
 nbd/server.c     | 30 ++++++++++++++++++++++++++++++
 nbd/trace-events |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 9e1f2271784..39502b58446 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -617,6 +617,36 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         return rc;
     }

+    /* Send NBD_INFO_TRIM_SIZE always. */
+    /* minimum - Hard-code to 4096 for now, matching preferred block.
+     * TODO: consult blk_bs(blk)->bl.pdiscard_alignment? */
+    sizes[0] = 4096;
+    /* maximum - < 2G (then block layer fragments to bl.max_pdiscard). */
+    sizes[1] = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES, sizes[0]);
+    trace_nbd_negotiate_handle_info_trim_size(sizes[0], sizes[1]);
+    cpu_to_be32s(&sizes[0]);
+    cpu_to_be32s(&sizes[1]);
+    rc = nbd_negotiate_send_info(client, NBD_INFO_TRIM_SIZE,
+                                 2 * sizeof(sizes[0]), sizes, errp);
+    if (rc < 0) {
+        return rc;
+    }
+
+    /* Send NBD_INFO_ZERO_SIZE always. */
+    /* minimum - Hard-code to 4096 for now, matching preferred block.
+     * TODO: consult blk_bs(blk)->bl.pwrite_zeroes_alignment? */
+    sizes[0] = 4096;
+    /* maximum - < 2G (then block layer fragments to bl.max_pwrite_zeroes). */
+    sizes[1] = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES, sizes[0]);
+    trace_nbd_negotiate_handle_info_zero_size(sizes[0], sizes[1]);
+    cpu_to_be32s(&sizes[0]);
+    cpu_to_be32s(&sizes[1]);
+    rc = nbd_negotiate_send_info(client, NBD_INFO_ZERO_SIZE,
+                                 2 * sizeof(sizes[0]), sizes, errp);
+    if (rc < 0) {
+        return rc;
+    }
+
     /* Send NBD_INFO_EXPORT always */
     trace_nbd_negotiate_new_style_size_flags(exp->size,
                                              exp->nbdflags | myflags);
diff --git a/nbd/trace-events b/nbd/trace-events
index ddb9d0a2b3e..d8849c43b21 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -46,6 +46,8 @@ nbd_negotiate_send_info(int info, const char *name, uint32_t length) "Sending NB
 nbd_negotiate_handle_info_requests(int requests) "Client requested %d items of info"
 nbd_negotiate_handle_info_request(int request, const char *name) "Client requested info %d (%s)"
 nbd_negotiate_handle_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "advertising minimum 0x%" PRIx32 ", preferred 0x%" PRIx32 ", maximum 0x%" PRIx32
+nbd_negotiate_handle_info_trim_size(uint32_t minimum, uint32_t maximum) "advertising minimum 0x%" PRIx32 ", maximum 0x%" PRIx32
+nbd_negotiate_handle_info_zero_size(uint32_t minimum, uint32_t maximum) "advertising minimum 0x%" PRIx32 ", maximum 0x%" PRIx32
 nbd_negotiate_handle_starttls(void) "Setting up TLS"
 nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
 nbd_negotiate_meta_context(const char *optname, const char *export, uint32_t queries) "Client requested %s for export %s, with %" PRIu32 " queries"
-- 
2.14.3
