Received: from eggs.gnu.org ([209.51.188.92]:41682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDZ-0000FJ-Cb
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDY-0004yS-Cu
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:20 -0500
Message-Id: <20190403030526.12258-2-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/7] nbd/server: Fix blockstatus trace
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

Don't increment remaining_bytes until we know that we will actually be
including the current block status extent in the reply; otherwise, the
value traced will include a bytes value that is oversized by the
length of the next block status extent which did not get sent because
it instead ended the loop.

Fixes: fb7afc79
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 218a2aa5e65..1b8c8619896 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1880,17 +1880,12 @@ static int blockstatus_to_extents(BlockDriverStat=
e *bs, uint64_t offset,

         flags =3D (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
                 (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
-        offset +=3D num;
-        remaining_bytes -=3D num;

         if (first_extent) {
             extent->flags =3D flags;
             extent->length =3D num;
             first_extent =3D false;
-            continue;
-        }
-
-        if (flags =3D=3D extent->flags) {
+        } else if (flags =3D=3D extent->flags) {
             /* extend current extent */
             extent->length +=3D num;
         } else {
@@ -1903,6 +1898,8 @@ static int blockstatus_to_extents(BlockDriverState =
*bs, uint64_t offset,
             extent->flags =3D flags;
             extent->length =3D num;
         }
+        offset +=3D num;
+        remaining_bytes -=3D num;
     }

     extents_end =3D extent + 1;
--=20
2.20.1
