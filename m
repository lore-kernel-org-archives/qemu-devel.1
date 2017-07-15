Received: from eggs.gnu.org ([2001:4830:134:3::10]:43290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8B-0003fu-29
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8A-0002yM-7V
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:11 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 15 Jul 2017 15:28:38 +0200
Message-Id: <20170715132841.9865-2-hpoussin@reactos.org>
In-Reply-To: <20170715132841.9865-1-hpoussin@reactos.org>
References: <20170715132841.9865-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] vvfat: add constants for special values of
 name[0]
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

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 4fd28e1e87..c2674d7703 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -71,6 +71,11 @@ void nonono(const char* file, int line, const char* ms=
g) {
=20
 #endif
=20
+#define DIR_DELETED 0xe5
+#define DIR_KANJI DIR_DELETED
+#define DIR_KANJI_FAKE 0x05
+#define DIR_FREE 0x00
+
 /* dynamic array functions */
 typedef struct array_t {
     char* pointer;
@@ -466,7 +471,7 @@ static direntry_t *create_long_filename(BDRVVVFATStat=
e *s, const char *filename)
=20
 static char is_free(const direntry_t* direntry)
 {
-    return direntry->name[0]=3D=3D0xe5 || direntry->name[0]=3D=3D0x00;
+    return direntry->name[0] =3D=3D DIR_DELETED || direntry->name[0] =3D=
=3D DIR_FREE;
 }
=20
 static char is_volume_label(const direntry_t* direntry)
@@ -487,7 +492,7 @@ static char is_short_name(const direntry_t* direntry)
=20
 static char is_directory(const direntry_t* direntry)
 {
-    return direntry->attributes & 0x10 && direntry->name[0] !=3D 0xe5;
+    return direntry->attributes & 0x10 && direntry->name[0] !=3D DIR_DEL=
ETED;
 }
=20
 static inline char is_dot(const direntry_t* direntry)
@@ -589,8 +594,8 @@ static direntry_t *create_short_filename(BDRVVVFATSta=
te *s,
         }
     }
=20
-    if (entry->name[0] =3D=3D 0xe5) {
-        entry->name[0] =3D 0x05;
+    if (entry->name[0] =3D=3D DIR_KANJI) {
+        entry->name[0] =3D DIR_KANJI_FAKE;
     }
=20
     /* numeric-tail generation */
@@ -1748,8 +1753,8 @@ static int parse_short_name(BDRVVVFATState* s,
     } else
         lfn->name[i + j + 1] =3D '\0';
=20
-    if (lfn->name[0] =3D=3D 0x05) {
-        lfn->name[0] =3D 0xe5;
+    if (lfn->name[0] =3D=3D DIR_KANJI_FAKE) {
+        lfn->name[0] =3D DIR_KANJI;
     }
     lfn->len =3D strlen((char*)lfn->name);
=20
--=20
2.11.0
