Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8N-0003zm-DD
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8M-00037G-8W
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:23 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 15 Jul 2017 15:28:40 +0200
Message-Id: <20170715132841.9865-4-hpoussin@reactos.org>
In-Reply-To: <20170715132841.9865-1-hpoussin@reactos.org>
References: <20170715132841.9865-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] vvfat: correctly parse non-ASCII short and
 long file names
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

Write support works again when image contains non-ASCII names. It is eith=
er the
case when user created a non-ASCII filename, or when initial directory co=
ntained
a non-ASCII filename (since 0c36111f57ec2188f679e7fa810291b7386bdca1)

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 59 +++++++++++++++++++++++++++++++++++++----------------=
------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index e585a8e0be..afc6170a69 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1669,6 +1669,7 @@ typedef struct {
      * filename length is 0x3f * 13 bytes.
      */
     unsigned char name[0x3f * 13 + 1];
+    gunichar2 name2[0x3f * 13 + 1];
     int checksum, len;
     int sequence_number;
 } long_file_name;
@@ -1690,16 +1691,21 @@ static int parse_long_name(long_file_name* lfn,
         return 1;
=20
     if (pointer[0] & 0x40) {
+        /* first entry; do some initialization */
         lfn->sequence_number =3D pointer[0] & 0x3f;
         lfn->checksum =3D pointer[13];
         lfn->name[0] =3D 0;
         lfn->name[lfn->sequence_number * 13] =3D 0;
-    } else if ((pointer[0] & 0x3f) !=3D --lfn->sequence_number)
+    } else if ((pointer[0] & 0x3f) !=3D --lfn->sequence_number) {
+        /* not the expected sequence number */
         return -1;
-    else if (pointer[13] !=3D lfn->checksum)
+    } else if (pointer[13] !=3D lfn->checksum) {
+        /* not the expected checksum */
         return -2;
-    else if (pointer[12] || pointer[26] || pointer[27])
+    } else if (pointer[12] || pointer[26] || pointer[27]) {
+        /* invalid zero fields */
         return -3;
+    }
=20
     offset =3D 13 * (lfn->sequence_number - 1);
     for (i =3D 0, j =3D 1; i < 13; i++, j+=3D2) {
@@ -1708,16 +1714,29 @@ static int parse_long_name(long_file_name* lfn,
         else if (j =3D=3D 26)
             j =3D 28;
=20
-        if (pointer[j+1] =3D=3D 0)
-            lfn->name[offset + i] =3D pointer[j];
-        else if (pointer[j+1] !=3D 0xff || (pointer[0] & 0x40) =3D=3D 0)
-            return -4;
-        else
-            lfn->name[offset + i] =3D 0;
+        if (pointer[j] =3D=3D 0 && pointer[j + 1] =3D=3D 0) {
+            /* end of long file name */
+            break;
+        }
+        gunichar2 c =3D (pointer[j + 1] << 8) + pointer[j];
+        lfn->name2[offset + i] =3D c;
     }
=20
-    if (pointer[0] & 0x40)
-        lfn->len =3D offset + strlen((char*)lfn->name + offset);
+    if (pointer[0] & 0x40) {
+        /* first entry; set len */
+        lfn->len =3D offset + i;
+    }
+    if ((pointer[0] & 0x3f) =3D=3D 0x01) {
+        /* last entry; finalize entry */
+        glong olen;
+        gchar *utf8 =3D g_utf16_to_utf8(lfn->name2, lfn->len, NULL, &ole=
n, NULL);
+        if (!utf8) {
+            return -4;
+        }
+        lfn->len =3D olen;
+        memcpy(lfn->name, utf8, olen + 1);
+        g_free(utf8);
+    }
=20
     return 0;
 }
@@ -1733,12 +1752,14 @@ static int parse_short_name(BDRVVVFATState* s,
=20
     for (j =3D 7; j >=3D 0 && direntry->name[j] =3D=3D ' '; j--);
     for (i =3D 0; i <=3D j; i++) {
-        if (direntry->name[i] <=3D ' ' || direntry->name[i] > 0x7f)
+        uint8_t c =3D direntry->name[i];
+        if (c !=3D to_valid_short_char(c)) {
             return -1;
-        else if (s->downcase_short_names)
+        } else if (s->downcase_short_names) {
             lfn->name[i] =3D qemu_tolower(direntry->name[i]);
-        else
+        } else {
             lfn->name[i] =3D direntry->name[i];
+        }
     }
=20
     for (j =3D 2; j >=3D 0 && direntry->name[8 + j] =3D=3D ' '; j--) {
@@ -1748,7 +1769,7 @@ static int parse_short_name(BDRVVVFATState* s,
         lfn->name[i + j + 1] =3D '\0';
         for (;j >=3D 0; j--) {
             uint8_t c =3D direntry->name[8 + j];
-            if (c <=3D ' ' || c > 0x7f) {
+            if (c !=3D to_valid_short_char(c)) {
                 return -2;
             } else if (s->downcase_short_names) {
                 lfn->name[i + j] =3D qemu_tolower(c);
@@ -2966,7 +2987,6 @@ DLOG(checkpoint());
     /*
      * Some sanity checks:
      * - do not allow writing to the boot sector
-     * - do not allow to write non-ASCII filenames
      */
=20
     if (sector_num < s->offset_to_fat)
@@ -3000,13 +3020,8 @@ DLOG(checkpoint());
                 direntries =3D (direntry_t*)(buf + 0x200 * (begin - sect=
or_num));
=20
                 for (k =3D 0; k < (end - begin) * 0x10; k++) {
-                    /* do not allow non-ASCII filenames */
-                    if (parse_long_name(&lfn, direntries + k) < 0) {
-                        fprintf(stderr, "Warning: non-ASCII filename\n")=
;
-                        return -1;
-                    }
                     /* no access to the direntry of a read-only file */
-                    else if (is_short_name(direntries+k) &&
+                    if (is_short_name(direntries + k) &&
                             (direntries[k].attributes & 1)) {
                         if (memcmp(direntries + k,
                                     array_get(&(s->directory), dir_index=
 + k),
--=20
2.11.0
