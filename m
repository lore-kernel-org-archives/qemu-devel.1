Received: from eggs.gnu.org ([2001:4830:134:3::10]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCuco-0007dP-Lk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCucn-00007Y-Ie
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:22 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 22 May 2017 23:12:00 +0200
Message-Id: <20170522211205.14265-9-hpoussin@reactos.org>
In-Reply-To: <20170522211205.14265-1-hpoussin@reactos.org>
References: <20170522211205.14265-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/13] vvfat: correctly create long names
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

Assume that input filename is encoded as UTF-8, so correctly create UTF-1=
6 encoding.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index d4664c531b..d34241da17 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -425,28 +425,19 @@ static void init_mbr(BDRVVVFATState *s, int cyls, i=
nt heads, int secs)
=20
 /* direntry functions */
=20
-/* dest is assumed to hold 258 bytes, and pads with 0xffff up to next mu=
ltiple of 26 */
-static inline int short2long_name(char* dest,const char* src)
+static direntry_t *create_long_filename(BDRVVVFATState *s, const char *f=
ilename)
 {
-    int i;
-    int len;
-    for(i=3D0;i<129 && src[i];i++) {
-        dest[2*i]=3Dsrc[i];
-        dest[2*i+1]=3D0;
+    int number_of_entries, i;
+    glong length;
+    direntry_t *entry;
+
+    gunichar2 *longname =3D g_utf8_to_utf16(filename, -1, NULL, &length,=
 NULL);
+    if (!longname) {
+        fprintf(stderr, "vvfat: invalid UTF-8 name: %s\n", filename);
+        return NULL;
     }
-    len=3D2*i;
-    dest[2*i]=3Ddest[2*i+1]=3D0;
-    for(i=3D2*i+2;(i%26);i++)
-        dest[i]=3D0xff;
-    return len;
-}
=20
-static inline direntry_t* create_long_filename(BDRVVVFATState* s,const c=
har* filename)
-{
-    char buffer[258];
-    int length=3Dshort2long_name(buffer,filename),
-        number_of_entries=3D(length+25)/26,i;
-    direntry_t* entry;
+    number_of_entries =3D (length * 2 + 25) / 26;
=20
     for(i=3D0;i<number_of_entries;i++) {
         entry=3Darray_get_next(&(s->directory));
@@ -461,8 +452,15 @@ static inline direntry_t* create_long_filename(BDRVV=
VFATState* s,const char* fil
         else if(offset<22) offset=3D14+offset-10;
         else offset=3D28+offset-22;
         entry=3Darray_get(&(s->directory),s->directory.next-1-(i/26));
-        entry->name[offset]=3Dbuffer[i];
+        if (i >=3D 2 * length + 2) {
+            entry->name[offset] =3D 0xff;
+        } else if (i % 2 =3D=3D 0) {
+            entry->name[offset] =3D longname[i / 2] & 0xff;
+        } else {
+            entry->name[offset] =3D longname[i / 2] >> 8;
+        }
     }
+    g_free(longname);
     return array_get(&(s->directory),s->directory.next-number_of_entries=
);
 }
=20
--=20
2.11.0
