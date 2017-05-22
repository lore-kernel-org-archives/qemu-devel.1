Received: from eggs.gnu.org ([2001:4830:134:3::10]:37379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCucq-0007eg-2P
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCuco-00008r-Ko
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:24 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 22 May 2017 23:12:01 +0200
Message-Id: <20170522211205.14265-10-hpoussin@reactos.org>
In-Reply-To: <20170522211205.14265-1-hpoussin@reactos.org>
References: <20170522211205.14265-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/13] vvfat: correctly create base short
 names for non-ASCII filenames
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

More specifically, create short name from filename and change blacklist o=
f
invalid chars to whitelist of valid chars.

Windows 9x also now correctly see long file names of filenames containing=
 a space,
but Scandisk still complains about mismatch between SFN and LFN.

Specification: "FAT: General overview of on-disk format" v1.03, pages 30-=
31
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 105 ++++++++++++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 77 insertions(+), 28 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index d34241da17..3cb65493cd 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -516,6 +516,81 @@ static void set_begin_of_direntry(direntry_t* dirent=
ry, uint32_t begin)
     direntry->begin_hi =3D cpu_to_le16((begin >> 16) & 0xffff);
 }
=20
+static uint8_t to_valid_short_char(gunichar c)
+{
+    c =3D g_unichar_toupper(c);
+    if ((c >=3D '0' && c <=3D '9') ||
+        (c >=3D 'A' && c <=3D 'Z') ||
+        strchr("$%'-_@~`!(){}^#&", c) !=3D 0) {
+        return c;
+    } else {
+        return 0;
+    }
+}
+
+static direntry_t *create_short_filename(BDRVVVFATState *s,
+                                         const char *filename)
+{
+    int i, j =3D 0;
+    direntry_t *entry =3D array_get_next(&(s->directory));
+    const gchar *p, *last_dot =3D NULL;
+    gunichar c;
+    bool lossy_conversion =3D false;
+    char tail[11];
+
+    if (!entry) {
+        return NULL;
+    }
+    memset(entry->name, 0x20, sizeof(entry->name));
+
+    /* copy filename and search last dot */
+    for (p =3D filename; ; p =3D g_utf8_next_char(p)) {
+        c =3D g_utf8_get_char(p);
+        if (c =3D=3D '\0') {
+            break;
+        } else if (c =3D=3D '.') {
+            if (j =3D=3D 0) {
+                /* '.' at start of filename */
+                lossy_conversion =3D true;
+            } else {
+                if (last_dot) {
+                    lossy_conversion =3D true;
+                }
+                last_dot =3D p;
+            }
+        } else if (!last_dot) {
+            /* first part of the name; copy it */
+            uint8_t v =3D to_valid_short_char(c);
+            if (j < 8 && v) {
+                entry->name[j++] =3D v;
+            } else {
+                lossy_conversion =3D true;
+            }
+        }
+    }
+
+    /* copy extension (if any) */
+    if (last_dot) {
+        j =3D 0;
+        for (p =3D g_utf8_next_char(last_dot); ; p =3D g_utf8_next_char(=
p)) {
+            c =3D g_utf8_get_char(p);
+            if (c =3D=3D '\0') {
+                break;
+            } else {
+                /* extension; copy it */
+                uint8_t v =3D to_valid_short_char(c);
+                if (j < 3 && v) {
+                    entry->name[8 + (j++)] =3D v;
+                } else {
+                    lossy_conversion =3D true;
+                }
+            }
+        }
+    }
+    (void)lossy_conversion;
+    return entry;
+}
+
 /* fat functions */
=20
 static inline uint8_t fat_chksum(const direntry_t* entry)
@@ -614,7 +689,7 @@ static inline void init_fat(BDRVVVFATState* s)
 static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
         unsigned int directory_start, const char* filename, int is_dot)
 {
-    int i,j,long_index=3Ds->directory.next;
+    int long_index =3D s->directory.next;
     direntry_t* entry =3D NULL;
     direntry_t* entry_long =3D NULL;
=20
@@ -626,33 +701,7 @@ static inline direntry_t* create_short_and_long_name=
(BDRVVVFATState* s,
     }
=20
     entry_long=3Dcreate_long_filename(s,filename);
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
+    entry =3D create_short_filename(s, filename);
=20
     /* mangle duplicates */
     while(1) {
--=20
2.11.0
