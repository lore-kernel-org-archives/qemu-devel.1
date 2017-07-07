Received: from eggs.gnu.org ([2001:4830:134:3::10]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl0-0004nJ-TU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkz-0007iH-OB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:29 +0200
Message-Id: <1499447335-6125-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 014/100] vvfat: correctly generate numeric-tail
 of short file names
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

More specifically:
- try without numeric-tail only if LFN didn't have invalid short chars
- start at ~1 (instead of ~0)
- handle case if numeric tail is more than one char (ie > 10)

Windows 9x Scandisk doesn't see anymore mismatches between short file nam=
es and
long file names for non-ASCII filenames.

Specification: "FAT: General overview of on-disk format" v1.03, page 31
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 65 ++++++++++++++++++++++++++++-------------------------=
------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 2125ddb..62f411b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -528,13 +528,15 @@ static uint8_t to_valid_short_char(gunichar c)
 }
=20
 static direntry_t *create_short_filename(BDRVVVFATState *s,
-                                         const char *filename)
+                                         const char *filename,
+                                         unsigned int directory_start)
 {
-    int j =3D 0;
+    int i, j =3D 0;
     direntry_t *entry =3D array_get_next(&(s->directory));
     const gchar *p, *last_dot =3D NULL;
     gunichar c;
     bool lossy_conversion =3D false;
+    char tail[11];
=20
     if (!entry) {
         return NULL;
@@ -585,8 +587,32 @@ static direntry_t *create_short_filename(BDRVVVFATSt=
ate *s,
             }
         }
     }
-    (void)lossy_conversion;
-    return entry;
+
+    /* numeric-tail generation */
+    for (j =3D 0; j < 8; j++) {
+        if (entry->name[j] =3D=3D ' ') {
+            break;
+        }
+    }
+    for (i =3D lossy_conversion ? 1 : 0; i < 999999; i++) {
+        direntry_t *entry1;
+        if (i > 0) {
+            int len =3D sprintf(tail, "~%d", i);
+            memcpy(entry->name + MIN(j, 8 - len), tail, len);
+        }
+        for (entry1 =3D array_get(&(s->directory), directory_start);
+             entry1 < entry; entry1++) {
+            if (!is_long_name(entry1) &&
+                !memcmp(entry1->name, entry->name, 11)) {
+                break; /* found dupe */
+            }
+        }
+        if (entry1 =3D=3D entry) {
+            /* no dupe found */
+            return entry;
+        }
+    }
+    return NULL;
 }
=20
 /* fat functions */
@@ -699,36 +725,7 @@ static inline direntry_t* create_short_and_long_name=
(BDRVVVFATState* s,
     }
=20
     entry_long=3Dcreate_long_filename(s,filename);
-    entry =3D create_short_filename(s, filename);
-
-    /* mangle duplicates */
-    while(1) {
-        direntry_t* entry1=3Darray_get(&(s->directory),directory_start);
-        int j;
-
-        for(;entry1<entry;entry1++)
-            if(!is_long_name(entry1) && !memcmp(entry1->name,entry->name=
,11))
-                break; /* found dupe */
-        if(entry1=3D=3Dentry) /* no dupe found */
-            break;
-
-        /* use all 8 characters of name */
-        if(entry->name[7]=3D=3D' ') {
-            int j;
-            for(j=3D6;j>0 && entry->name[j]=3D=3D' ';j--)
-                entry->name[j]=3D'~';
-        }
-
-        /* increment number */
-        for(j=3D7;j>0 && entry->name[j]=3D=3D'9';j--)
-            entry->name[j]=3D'0';
-        if(j>0) {
-            if(entry->name[j]<'0' || entry->name[j]>'9')
-                entry->name[j]=3D'0';
-            else
-                entry->name[j]++;
-        }
-    }
+    entry =3D create_short_filename(s, filename, directory_start);
=20
     /* calculate checksum; propagate to long name */
     if(entry_long) {
--=20
1.8.3.1
