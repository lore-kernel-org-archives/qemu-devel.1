Received: from eggs.gnu.org ([2001:4830:134:3::10]:35079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeP-0001Q0-J1
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeN-0003Xw-LJ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:29 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:08 +0200
Message-Id: <20170515203114.9477-9-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/13] vvfat: correctly create long names for
 non-ASCII filenames
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

Assume that input filename is encoded as UTF-8, so correctly create UTF-1=
6 encoding.
Reuse long_file_name structure to give back to caller the generated long =
name.
It will be used in next commit to transform the long file name into short=
 file name.

Reference: http://stackoverflow.com/questions/7153935/how-to-convert-utf-=
8-stdstring-to-utf-16-stdwstring
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 132 ++++++++++++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 97 insertions(+), 35 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 7da07068b8..5f6356c834 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -357,6 +357,23 @@ typedef struct BDRVVVFATState {
     Error *migration_blocker;
 } BDRVVVFATState;
=20
+typedef struct {
+    /*
+     * Since the sequence number is at most 0x3f, and the filename
+     * length is at most 13 times the sequence number, the maximal
+     * filename length is 0x3f * 13 bytes.
+     */
+    unsigned char name[0x3f * 13 + 1];
+    int checksum, len;
+    int sequence_number;
+} long_file_name;
+
+static void lfn_init(long_file_name *lfn)
+{
+   lfn->sequence_number =3D lfn->len =3D 0;
+   lfn->checksum =3D 0x100;
+}
+
 /* take the sector position spos and convert it to Cylinder/Head/Sector =
position
  * if the position is outside the specified geometry, fill maximum value=
 for CHS
  * and return 1 to signal overflow.
@@ -418,29 +435,90 @@ static void init_mbr(BDRVVVFATState *s, int cyls, i=
nt heads, int secs)
=20
 /* direntry functions */
=20
-/* dest is assumed to hold 258 bytes, and pads with 0xffff up to next mu=
ltiple of 26 */
-static inline int short2long_name(char* dest,const char* src)
-{
-    int i;
-    int len;
-    for(i=3D0;i<129 && src[i];i++) {
-        dest[2*i]=3Dsrc[i];
-        dest[2*i+1]=3D0;
+/* fills lfn with UTF-16 representation of src filename */
+/* return true if src is valid UTF-8 string, false otherwise */
+static bool filename2long_name(long_file_name *lfn, const char* src)
+{
+    uint8_t *dest =3D lfn->name;
+    int i =3D 0, j;
+    int len =3D 0;
+    while (src[i]) {
+        uint32_t uni =3D 0;
+        size_t todo;
+        uint8_t ch =3D src[i++];
+        if (ch <=3D 0x7f) {
+            uni =3D ch;
+            todo =3D 0;
+        } else if (ch <=3D 0xbf) {
+            return false;
+        } else if (ch <=3D 0xdf) {
+            uni =3D ch & 0x1f;
+            todo =3D 1;
+        } else if (ch <=3D 0xef) {
+            uni =3D ch & 0x0f;
+            todo =3D 2;
+        } else if (ch <=3D 0xf7) {
+            uni =3D ch & 0x07;
+            todo =3D 3;
+        } else {
+            return false;
+        }
+        for (j =3D 0; j < todo; j++) {
+            uint8_t ch;
+            if (src[i] =3D=3D '\0') {
+                return false;
+            }
+            ch =3D src[i++];
+            if (ch < 0x80 || ch >=3D 0xbf) {
+                return false;
+            }
+            uni <<=3D 6;
+            uni +=3D ch & 0x3f;
+        }
+        if (uni >=3D 0xd800 && uni <=3D 0xdfff) {
+            return false;
+        } else if (uni >=3D 0x10ffff) {
+            return false;
+        }
+        if (uni <=3D 0xffff) {
+            dest[len++] =3D uni & 0xff;
+            dest[len++] =3D uni >> 8;
+        } else {
+            uint16_t w;
+            uni -=3D 0x10000;
+            w =3D (uni >> 10) + 0xd800;
+            dest[len++] =3D w & 0xff;
+            dest[len++] =3D w >> 8;
+            w =3D (uni & 0x3ff) + 0xdc00;
+            dest[len++] =3D w & 0xff;
+            dest[len++] =3D w >> 8;
+        }
+    }
+    dest[len++] =3D 0;
+    dest[len++] =3D 0;
+    while (len % 26 !=3D 0) {
+        dest[len++] =3D 0xff;
     }
-    len=3D2*i;
-    dest[2*i]=3Ddest[2*i+1]=3D0;
-    for(i=3D2*i+2;(i%26);i++)
-        dest[i]=3D0xff;
-    return len;
+    lfn->len =3D len;
+    return true;
 }
=20
-static inline direntry_t* create_long_filename(BDRVVVFATState* s,const c=
har* filename)
+static direntry_t *create_long_filename(BDRVVVFATState *s, const char *f=
ilename,
+                                        long_file_name *lfn)
 {
-    char buffer[258];
-    int length=3Dshort2long_name(buffer,filename),
-        number_of_entries=3D(length+25)/26,i;
+    uint8_t *buffer;
+    int length, number_of_entries, i;
     direntry_t* entry;
=20
+    lfn_init(lfn);
+    if (!filename2long_name(lfn, filename)) {
+        fprintf(stderr, "vvfat: invalid UTF-8 name: %s\n", filename);
+        return NULL;
+    }
+    buffer =3D lfn->name;
+    length =3D lfn->len;
+    number_of_entries =3D (length + 25) / 26;
+
     for(i=3D0;i<number_of_entries;i++) {
         entry=3Darray_get_next(&(s->directory));
         entry->attributes=3D0xf;
@@ -612,6 +690,7 @@ static inline direntry_t* create_short_and_long_name(=
BDRVVVFATState* s,
     int i,j,long_index=3Ds->directory.next;
     direntry_t* entry =3D NULL;
     direntry_t* entry_long =3D NULL;
+    long_file_name lfn;
=20
     if(is_dot) {
         entry=3Darray_get_next(&(s->directory));
@@ -620,7 +699,7 @@ static inline direntry_t* create_short_and_long_name(=
BDRVVVFATState* s,
         return entry;
     }
=20
-    entry_long=3Dcreate_long_filename(s,filename);
+    entry_long =3D create_long_filename(s, filename, &lfn);
=20
     i =3D strlen(filename);
     for(j =3D i - 1; j>0  && filename[j]!=3D'.';j--);
@@ -1575,23 +1654,6 @@ static void schedule_mkdir(BDRVVVFATState* s, uint=
32_t cluster, char* path)
     commit->action =3D ACTION_MKDIR;
 }
=20
-typedef struct {
-    /*
-     * Since the sequence number is at most 0x3f, and the filename
-     * length is at most 13 times the sequence number, the maximal
-     * filename length is 0x3f * 13 bytes.
-     */
-    unsigned char name[0x3f * 13 + 1];
-    int checksum, len;
-    int sequence_number;
-} long_file_name;
-
-static void lfn_init(long_file_name* lfn)
-{
-   lfn->sequence_number =3D lfn->len =3D 0;
-   lfn->checksum =3D 0x100;
-}
-
 /* return 0 if parsed successfully, > 0 if no long name, < 0 if error */
 static int parse_long_name(long_file_name* lfn,
         const direntry_t* direntry)
--=20
2.11.0
