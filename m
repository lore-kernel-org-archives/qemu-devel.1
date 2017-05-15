Received: from eggs.gnu.org ([2001:4830:134:3::10]:35062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeP-0001Pe-7J
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeN-0003Xo-IG
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:29 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:09 +0200
Message-Id: <20170515203114.9477-10-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/13] vvfat: correctly create base short names
 for non-ASCII filenames
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

More specifically, create short name from long name and change blacklist =
of
invalid chars to whitelist of valid chars.

Windows 9x also now correctly see long file names of filenames containing=
 a space,
but Scandisk still complains about mismatch between SFN and LFN.

Specification: "FAT: General overview of on-disk format" v1.03, pages 30/=
31
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 84 +++++++++++++++++++++++++++++++++++++++--------------=
------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 5f6356c834..37cfaa85fc 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -589,6 +589,60 @@ static void set_begin_of_direntry(direntry_t* dirent=
ry, uint32_t begin)
     direntry->begin_hi =3D cpu_to_le16((begin >> 16) & 0xffff);
 }
=20
+static uint8_t to_valid_short_char(uint8_t c)
+{
+    if ((c >=3D '0' && c <=3D '9') ||
+        (c >=3D 'A' && c <=3D 'Z') ||
+        strchr("$%'-_@~`!(){}^#&", c) !=3D 0) {
+        return c;
+    } else if (c >=3D 'a' && c <=3D 'z') {
+        return c - 'a' + 'A';
+    } else {
+        return 0;
+    }
+}
+
+static direntry_t *create_short_filename(BDRVVVFATState *s, long_file_na=
me *lfn)
+{
+    int i, j =3D 0;
+    direntry_t *entry =3D array_get_next(&(s->directory));
+    uint8_t c;
+
+    if (!entry) {
+        return NULL;
+    }
+    memset(entry->name, 0x20, sizeof(entry->name));
+
+    /* create short name (keep only valid chars and upcase letters) */
+    for (i =3D 0; i < lfn->len && j < 8; i +=3D 2) {
+        c =3D to_valid_short_char(lfn->name[i]);
+        if (lfn->name[i + 1] =3D=3D 0 && c !=3D 0) {
+            entry->name[j++] =3D c;
+        } else if (lfn->name[i + 1] =3D=3D 0 &&
+                   (lfn->name[i] =3D=3D '.' || lfn->name[i] =3D=3D 0)) {
+            break;
+        }
+    }
+    /* search last extension */
+    for (i =3D lfn->len - 2; i > 0; i -=3D 2) {
+        if (lfn->name[i] =3D=3D '.' && lfn->name[i + 1] =3D=3D 0) {
+            break;
+        }
+    }
+    if (i !=3D 0) {
+        /* create short extension */
+        for (; i < lfn->len && j < 11; i +=3D 2) {
+            c =3D to_valid_short_char(lfn->name[i]);
+            if (lfn->name[i + 1] =3D=3D 0 && c !=3D 0) {
+                entry->name[j++] =3D c;
+            } else if (lfn->name[i + 1] =3D=3D 0 && lfn->name[i] =3D=3D =
0) {
+                break;
+            }
+        }
+    }
+    return entry;
+}
+
 /* fat functions */
=20
 static inline uint8_t fat_chksum(const direntry_t* entry)
@@ -687,7 +741,7 @@ static inline void init_fat(BDRVVVFATState* s)
 static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
         unsigned int directory_start, const char* filename, int is_dot)
 {
-    int i,j,long_index=3Ds->directory.next;
+    int long_index =3D s->directory.next;
     direntry_t* entry =3D NULL;
     direntry_t* entry_long =3D NULL;
     long_file_name lfn;
@@ -700,33 +754,7 @@ static inline direntry_t* create_short_and_long_name=
(BDRVVVFATState* s,
     }
=20
     entry_long =3D create_long_filename(s, filename, &lfn);
-
-    i =3D strlen(filename);
-    for(j =3D i - 1; j>0  && filename[j]!=3D'.';j--);
-    if (j > 0)
-        i =3D (j > 8 ? 8 : j);
-    else if (i > 8)
-        i =3D 8;
-
-    entry=3Darray_get_next(&(s->directory));
-    memset(entry->name, 0x20, sizeof(entry->name));
-    memcpy(entry->name, filename, i);
-
-    if (j > 0) {
-        for (i =3D 0; i < 3 && filename[j + 1 + i]; i++) {
-            entry->name[8 + i] =3D filename[j + 1 + i];
-        }
-    }
-
-    /* upcase & remove unwanted characters */
-    for(i=3D10;i>=3D0;i--) {
-        if(i=3D=3D10 || i=3D=3D7) for(;i>0 && entry->name[i]=3D=3D' ';i-=
-);
-        if(entry->name[i]<=3D' ' || entry->name[i]>0x7f
-                || strchr(".*?<>|\":/\\[];,+=3D'",entry->name[i]))
-            entry->name[i]=3D'_';
-        else if(entry->name[i]>=3D'a' && entry->name[i]<=3D'z')
-            entry->name[i]+=3D'A'-'a';
-    }
+    entry =3D create_short_filename(s, &lfn);
=20
     /* mangle duplicates */
     while(1) {
--=20
2.11.0
