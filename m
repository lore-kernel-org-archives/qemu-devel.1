Received: from eggs.gnu.org ([2001:4830:134:3::10]:44574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyD-00035d-5i
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyB-0004mj-Uv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:49:53 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 18:49:27 +0200
Message-Id: <20181019164929.18404-4-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
References: <20181019164929.18404-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] qdev-monitor: Make device options help
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Just like in qemu_opts_print_help(), print the device name as a caption
instead of on every single line, indent all options, add angle brackets
around types, and align the descriptions after 24 characters.  Also,
separate the descriptions with " - " instead of putting them in
parentheses, because that is what we do everywhere else.  This does look
a bit funny here because basically all bits have the description
"on/off", but funny does not mean it is less readable.

Signed-off-by: Max Reitz <mreitz@redhat.com>
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
 
+    if (prop_list) {
+        out_printf("%s options:\n", driver);
+    } else {
+        out_printf("There are no options for %s.\n", driver);
+    }
     for (prop = prop_list; prop; prop = prop->next) {
-        out_printf("%s.%s=%s", driver, prop->value->name, prop->value->type);
+        int len;
+        out_printf("  %s=<%s>%n", prop->value->name, prop->value->type, &len);
         if (prop->value->has_description) {
-            out_printf(" (%s)\n", prop->value->description);
+            if (len < 24) {
+                out_printf("%*s", 24 - len, "");
+            }
+            out_printf(" - %s\n", prop->value->description);
         } else {
             out_printf("\n");
         }
-- 
2.17.1
