Received: from eggs.gnu.org ([2001:4830:134:3::10]:41528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl5-0004t6-VB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl1-0007jJ-C4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:31 +0200
Message-Id: <1499447335-6125-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 016/100] vvfat: handle KANJI lead byte 0xe5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Specification: "FAT: General overview of on-disk format" v1.03, page 23
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index dc9af01..9cb48ef 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -589,6 +589,10 @@ static direntry_t *create_short_filename(BDRVVVFATSt=
ate *s,
         }
     }
=20
+    if (entry->name[0] =3D=3D 0xe5) {
+        entry->name[0] =3D 0x05;
+    }
+
     /* numeric-tail generation */
     for (j =3D 0; j < 8; j++) {
         if (entry->name[j] =3D=3D ' ') {
@@ -709,8 +713,6 @@ static inline void init_fat(BDRVVVFATState* s)
=20
 }
=20
-/* TODO: in create_short_filename, 0xe5->0x05 is not yet handled! */
-/* TODO: in parse_short_filename, 0x05->0xe5 is not yet handled! */
 static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
         unsigned int directory_start, const char* filename, int is_dot)
 {
@@ -1743,6 +1745,9 @@ static int parse_short_name(BDRVVVFATState* s,
     } else
         lfn->name[i + j + 1] =3D '\0';
=20
+    if (lfn->name[0] =3D=3D 0x05) {
+        lfn->name[0] =3D 0xe5;
+    }
     lfn->len =3D strlen((char*)lfn->name);
=20
     return 0;
--=20
1.8.3.1
