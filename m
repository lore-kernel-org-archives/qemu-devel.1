Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828y-0002Gg-Cq
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828v-00042F-G0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f828v-00041F-BJ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:53 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 16 Apr 2018 12:17:41 +0100
Message-Id: <20180416111743.8473-2-berrange@redhat.com>
In-Reply-To: <20180416111743.8473-1-berrange@redhat.com>
References: <20180416111743.8473-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] accel: use g_strsplit for parsing
 accelerator names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Instead of re-using the get_opt_name() method from QemuOpts to split a
string on ':', just use g_strsplit().

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 accel/accel.c         | 16 +++++++---------
 include/qemu/option.h |  1 -
 util/qemu-option.c    |  3 ++-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 93e2434c87..4981e7fff3 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -70,8 +70,8 @@ static int accel_init_machine(AccelClass *acc, MachineS=
tate *ms)
=20
 void configure_accelerator(MachineState *ms)
 {
-    const char *accel, *p;
-    char buf[10];
+    const char *accel;
+    char **accel_list, **tmp;
     int ret;
     bool accel_initialised =3D false;
     bool init_failed =3D false;
@@ -83,13 +83,10 @@ void configure_accelerator(MachineState *ms)
         accel =3D "tcg";
     }
=20
-    p =3D accel;
-    while (!accel_initialised && *p !=3D '\0') {
-        if (*p =3D=3D ':') {
-            p++;
-        }
-        p =3D get_opt_name(buf, sizeof(buf), p, ':');
-        acc =3D accel_find(buf);
+    accel_list =3D g_strsplit(accel, ":", 0);
+
+    for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        acc =3D accel_find(*tmp);
         if (!acc) {
             continue;
         }
@@ -107,6 +104,7 @@ void configure_accelerator(MachineState *ms)
             accel_initialised =3D true;
         }
     }
+    g_strfreev(accel_list);
=20
     if (!accel_initialised) {
         if (!init_failed) {
diff --git a/include/qemu/option.h b/include/qemu/option.h
index 306fdb5f7a..1cfe5cbc2d 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,7 +28,6 @@
=20
 #include "qemu/queue.h"
=20
-const char *get_opt_name(char *buf, int buf_size, const char *p, char de=
lim);
 const char *get_opt_value(char *buf, int buf_size, const char *p);
=20
 void parse_option_size(const char *name, const char *value,
diff --git a/util/qemu-option.c b/util/qemu-option.c
index d0756fda58..baca40fb94 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -49,7 +49,8 @@
  * The return value is the position of the delimiter/zero byte after the=
 option
  * name in p.
  */
-const char *get_opt_name(char *buf, int buf_size, const char *p, char de=
lim)
+static const char *get_opt_name(char *buf, int buf_size, const char *p,
+                                char delim)
 {
     char *q;
=20
--=20
2.14.3
