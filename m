Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2E-0003J8-ML
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-0001zp-EO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yK-66
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1B5E8182D2F
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:16 +0100
Message-Id: <20180222102317.25776-9-kraxel@redhat.com>
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] keymap: record multiple keysym -> keycode
 mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Sometimes the same keysym can be created using different key
combinations.  Record them all in the reverse keymap, not only
the first one.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180222070513.8740-5-kraxel@redhat.com
---
 ui/keymaps.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index cbdd65c767..1eba6d7057 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -29,7 +29,8 @@
 #include "qemu/error-report.h"
=20
 struct keysym2code {
-    uint16_t keycode;
+    uint32_t count;
+    uint16_t keycodes[4];
 };
=20
 struct kbd_layout_t {
@@ -62,11 +63,18 @@ static void add_keysym(char *line, int keysym, int ke=
ycode, kbd_layout_t *k)
=20
     keysym2code =3D g_hash_table_lookup(k->hash, GINT_TO_POINTER(keysym)=
);
     if (keysym2code) {
+        if (keysym2code->count < ARRAY_SIZE(keysym2code->keycodes)) {
+            keysym2code->keycodes[keysym2code->count++] =3D keycode;
+        } else {
+            warn_report("more than %zd keycodes for keysym %d",
+                        ARRAY_SIZE(keysym2code->keycodes), keysym);
+        }
         return;
     }
=20
     keysym2code =3D g_new0(struct keysym2code, 1);
-    keysym2code->keycode =3D keycode;
+    keysym2code->keycodes[0] =3D keycode;
+    keysym2code->count =3D 1;
     g_hash_table_replace(k->hash, GINT_TO_POINTER(keysym), keysym2code);
     trace_keymap_add(keysym, keycode, line);
 }
@@ -185,7 +193,7 @@ int keysym2scancode(kbd_layout_t *k, int keysym)
         return 0;
     }
=20
-    return keysym2code->keycode;
+    return keysym2code->keycodes[0];
 }
=20
 int keycode_is_keypad(kbd_layout_t *k, int keycode)
--=20
2.9.3
