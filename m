Received: from eggs.gnu.org ([2001:4830:134:3::10]:40509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIH85-0001wp-60
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIH84-0006LY-7Z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:19:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fIH84-0006LH-3L
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:19:20 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 14 May 2018 18:19:13 +0100
Message-Id: <20180514171913.17664-4-berrange@redhat.com>
In-Reply-To: <20180514171913.17664-1-berrange@redhat.com>
References: <20180514171913.17664-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] opts: remove redundant check for NULL
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

No callers of get_opt_value() pass in a NULL for the "value" parameter,
so the check is redundant.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 util/qemu-option.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 8a68bc2314..a1ff682aac 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -75,9 +75,7 @@ const char *get_opt_value(const char *p, char **value)
     size_t capacity =3D 0, length;
     const char *offset;
=20
-    if (value) {
-        *value =3D NULL;
-    }
+    *value =3D NULL;
     while (1) {
         offset =3D strchr(p, ',');
         if (!offset) {
@@ -88,11 +86,9 @@ const char *get_opt_value(const char *p, char **value)
         if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
             length++;
         }
-        if (value) {
-            *value =3D g_renew(char, *value, capacity + length + 1);
-            strncpy(*value + capacity, p, length);
-            (*value)[capacity + length] =3D '\0';
-        }
+        *value =3D g_renew(char, *value, capacity + length + 1);
+        strncpy(*value + capacity, p, length);
+        (*value)[capacity + length] =3D '\0';
         capacity +=3D length;
         if (*offset =3D=3D '\0' ||
             *(offset + 1) !=3D ',') {
--=20
2.17.0
