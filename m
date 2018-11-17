Received: from eggs.gnu.org ([2001:4830:134:3::10]:53820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gO98m-0006Ed-LL
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 17:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gO98l-0008CR-RC
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 17:32:36 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 17 Nov 2018 16:32:21 -0600
Message-Id: <20181117223221.2198751-1-eblake@redhat.com>
In-Reply-To: <353b130c-aefb-ec4c-411b-571a79ec76e2@redhat.com>
References: <353b130c-aefb-ec4c-411b-571a79ec76e2@redhat.com>
Subject: [Qemu-devel] [PATCH 1.5/6] nbd/server: Ignore write errors when
 replying to NBD_OPT_ABORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Commit 37ec36f6 intentionally ignores errors when trying to reply
to an NBD_OPT_ABORT request for plaintext clients, but did not make
the same change for a TLS server.  Since NBD_OPT_ABORT is
documented as being a potential for an EPIPE when the client hangs
up without waiting for our reply, we don't need to pollute the
server's output with that failure.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 056cfa5ad47..dc04513de70 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1134,12 +1134,16 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 return -EINVAL;

             default:
-                ret = nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, errp,
+                /* Let the client keep trying, unless they asked to
+                 * quit. Always try to give an error back to the
+                 * client; but when replying to OPT_ABORT, be aware
+                 * that the client may hang up before receiving the
+                 * error, in which case we are fine ignoring the
+                 * resulting EPIPE. */
+                ret = nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD,
+                                   option == NBD_OPT_ABORT ? NULL : errp,
                                    "Option 0x%" PRIx32
                                    " not permitted before TLS", option);
-                /* Let the client keep trying, unless they asked to
-                 * quit. In this mode, we've already sent an error, so
-                 * we can't ack the abort.  */
                 if (option == NBD_OPT_ABORT) {
                     return 1;
                 }
-- 
2.17.2
