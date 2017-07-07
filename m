Received: from eggs.gnu.org ([2001:4830:134:3::10]:41380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWky-0004ju-44
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkx-0007gE-2v
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:27 +0200
Message-Id: <1499447335-6125-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 012/100] vvfat: correctly create long names for
 non-ASCII filenames
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

Assume that input filename is encoded as UTF-8, so correctly create UTF-1=
6 encoding.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 0c6d0f4..c52c9ba 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -424,28 +424,19 @@ static void init_mbr(BDRVVVFATState *s, int cyls, i=
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
@@ -460,8 +451,15 @@ static inline direntry_t* create_long_filename(BDRVV=
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
1.8.3.1
