Received: from eggs.gnu.org ([2001:4830:134:3::10]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwh-0002uW-PH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwX-00049Y-4T
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:40 +0100
Message-Id: <20181105163744.25139-33-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/36] qdev-monitor: Make device options help
 nicer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Just like in qemu_opts_print_help(), print the device name as a caption
instead of on every single line, indent all options, add angle brackets
around types, and align the descriptions after 24 characters.  Also,
separate the descriptions with " - " instead of putting them in
parentheses, because that is what we do everywhere else.  This does look
a bit funny here because basically all bits have the description
"on/off", but funny does not mean it is less readable.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qdev-monitor.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 802c18a74e..07147c63bf 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -285,10 +285,19 @@ int qdev_device_help(QemuOpts *opts)
         goto error;
     }
=20
+    if (prop_list) {
+        out_printf("%s options:\n", driver);
+    } else {
+        out_printf("There are no options for %s.\n", driver);
+    }
     for (prop =3D prop_list; prop; prop =3D prop->next) {
-        out_printf("%s.%s=3D%s", driver, prop->value->name, prop->value-=
>type);
+        int len;
+        out_printf("  %s=3D<%s>%n", prop->value->name, prop->value->type=
, &len);
         if (prop->value->has_description) {
-            out_printf(" (%s)\n", prop->value->description);
+            if (len < 24) {
+                out_printf("%*s", 24 - len, "");
+            }
+            out_printf(" - %s\n", prop->value->description);
         } else {
             out_printf("\n");
         }
--=20
2.19.1
