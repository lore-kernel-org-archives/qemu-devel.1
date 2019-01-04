Received: from eggs.gnu.org ([208.118.235.92]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNYK-0002Uk-HG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNYJ-0005Rj-Rg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 Jan 2019 11:21:43 +0000
Message-Id: <20190104112145.12413-3-stefanha@redhat.com>
In-Reply-To: <20190104112145.12413-1-stefanha@redhat.com>
References: <20190104112145.12413-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>

From: yuchenlin <npes87184@gmail.com>

There is a possible hang in original binary search implementation. That i=
s
if chunk1 =3D 4, chunk2 =3D 5, chunk3 =3D 4, and we go else case.

The chunk1 will be still 4, and so on.

Signed-off-by: yuchenlin <npes87184@gmail.com>
Message-id: 20190103114700.9686-2-npes87184@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 2c806e3389..b26ddb1f68 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -572,16 +572,20 @@ static inline uint32_t search_chunk(BDRVDMGState *s=
, uint64_t sector_num)
 {
     /* binary search */
     uint32_t chunk1 =3D 0, chunk2 =3D s->n_chunks, chunk3;
-    while (chunk1 !=3D chunk2) {
+    while (chunk1 <=3D chunk2) {
         chunk3 =3D (chunk1 + chunk2) / 2;
         if (s->sectors[chunk3] > sector_num) {
-            chunk2 =3D chunk3;
+            if (chunk3 =3D=3D 0) {
+                goto err;
+            }
+            chunk2 =3D chunk3 - 1;
         } else if (s->sectors[chunk3] + s->sectorcounts[chunk3] > sector=
_num) {
             return chunk3;
         } else {
-            chunk1 =3D chunk3;
+            chunk1 =3D chunk3 + 1;
         }
     }
+err:
     return s->n_chunks; /* error */
 }
=20
--=20
2.20.1
