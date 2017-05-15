Received: from eggs.gnu.org ([2001:4830:134:3::10]:35046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeO-0001P9-RM
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeN-0003Y0-MH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:28 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:12 +0200
Message-Id: <20170515203114.9477-13-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/13] vvfat: handle KANJI lead byte 0xe5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Specification: "FAT: General overview of on-disk format" v1.03, page 23
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 7b21d6bb21..f96034cda1 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -648,6 +648,9 @@ static direntry_t *create_short_filename(BDRVVVFATSta=
te *s, long_file_name *lfn,
             }
         }
     }
+    if (entry->name[0] =3D=3D 0xe5) {
+        entry->name[0] =3D 0x05;
+    }
=20
     /* numeric-tail generation */
     for (j =3D 0; j < 8; j++) {
@@ -769,8 +772,6 @@ static inline void init_fat(BDRVVVFATState* s)
=20
 }
=20
-/* TODO: in create_short_filename, 0xe5->0x05 is not yet handled! */
-/* TODO: in parse_short_filename, 0x05->0xe5 is not yet handled! */
 static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
         unsigned int directory_start, const char* filename, int is_dot)
 {
@@ -1773,6 +1774,9 @@ static int parse_short_name(BDRVVVFATState* s,
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
2.11.0
