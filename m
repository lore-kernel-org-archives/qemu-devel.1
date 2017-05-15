Received: from eggs.gnu.org ([2001:4830:134:3::10]:35091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeP-0001Q2-PF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeO-0003Yj-Lm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:29 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:10 +0200
Message-Id: <20170515203114.9477-11-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/13] vvfat: correctly generate numeric-tail
 of short file names
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

More specifically:
- try without numeric-tail only if LFN didn't have invalid short chars
- start at ~1 (instead of ~0)
- handle case if numeric tail is more than one char (ie > 10)

Windows 9x Scandisk doesn't see anymore mismatches between short file nam=
es and
long file names for non-ASCII filenames.

Specification: "FAT: General overview of on-disk format" v1.03, page 31
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 67 +++++++++++++++++++++++++++++++----------------------=
------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 37cfaa85fc..98978df404 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -602,11 +602,14 @@ static uint8_t to_valid_short_char(uint8_t c)
     }
 }
=20
-static direntry_t *create_short_filename(BDRVVVFATState *s, long_file_na=
me *lfn)
+static direntry_t *create_short_filename(BDRVVVFATState *s, long_file_na=
me *lfn,
+                                         unsigned int directory_start)
 {
     int i, j =3D 0;
     direntry_t *entry =3D array_get_next(&(s->directory));
     uint8_t c;
+    bool lossy_conversion =3D false;
+    char tail[11];
=20
     if (!entry) {
         return NULL;
@@ -621,6 +624,8 @@ static direntry_t *create_short_filename(BDRVVVFATSta=
te *s, long_file_name *lfn)
         } else if (lfn->name[i + 1] =3D=3D 0 &&
                    (lfn->name[i] =3D=3D '.' || lfn->name[i] =3D=3D 0)) {
             break;
+        } else {
+            lossy_conversion =3D true;
         }
     }
     /* search last extension */
@@ -637,10 +642,37 @@ static direntry_t *create_short_filename(BDRVVVFATS=
tate *s, long_file_name *lfn)
                 entry->name[j++] =3D c;
             } else if (lfn->name[i + 1] =3D=3D 0 && lfn->name[i] =3D=3D =
0) {
                 break;
+            } else {
+                lossy_conversion =3D true;
             }
         }
     }
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
@@ -754,36 +786,7 @@ static inline direntry_t* create_short_and_long_name=
(BDRVVVFATState* s,
     }
=20
     entry_long =3D create_long_filename(s, filename, &lfn);
-    entry =3D create_short_filename(s, &lfn);
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
+    entry =3D create_short_filename(s, &lfn, directory_start);
=20
     /* calculate checksum; propagate to long name */
     if(entry_long) {
--=20
2.11.0
