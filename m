Received: from eggs.gnu.org ([209.51.188.92]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDb-0000H6-5g
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDa-000588-4j
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:22 -0500
Message-Id: <20190403030526.12258-4-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/7] nbd/server: Don't fail NBD_OPT_INFO for
 byte-aligned sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

In commit 0c1d50bd, I added a couple of TODO comments about whether we
consult bl.request_alignment when responding to NBD_OPT_INFO. At the
time, qemu as server was hard-coding an advertised alignment of 512 to
clients that promised to obey constraints, and there was no function
for getting at a device's preferred alignment. But in hindsight,
advertising 512 when the block device prefers 1 caused other
compliance problems, and commit b0245d64 changed one of the two TODO
comments to advertise a more accurate alignment. Time to fix the other
TODO.  Doesn't really impact qemu as client (our normal client doesn't
use NBD_OPT_INFO, and qemu-nbd --list promises to obey block sizes),
but it might prove useful to other clients.

Fixes: b0245d64
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3040ceb5606..faa3c7879fd 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -642,11 +642,14 @@ static int nbd_negotiate_handle_info(NBDClient *cli=
ent, uint16_t myflags,
         return rc;
     }

-    /* If the client is just asking for NBD_OPT_INFO, but forgot to
-     * request block sizes, return an error.
-     * TODO: consult blk_bs(blk)->request_align, and only error if it
-     * is not 1? */
-    if (client->opt =3D=3D NBD_OPT_INFO && !blocksize) {
+    /*
+     * If the client is just asking for NBD_OPT_INFO, but forgot to
+     * request block sizes in a situation that would impact
+     * performance, then return an error. But for NBD_OPT_GO, we
+     * tolerate all clients, regardless of alignments.
+     */
+    if (client->opt =3D=3D NBD_OPT_INFO && !blocksize &&
+        blk_get_request_alignment(exp->blk) > 1) {
         return nbd_negotiate_send_rep_err(client,
                                           NBD_REP_ERR_BLOCK_SIZE_REQD,
                                           errp,
--=20
2.20.1
