Received: from eggs.gnu.org ([2001:4830:134:3::10]:33868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rL-0005UW-B3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rI-0004H8-Ie
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:35 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rI-0004Gp-Cj
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:32 -0500
Received: by mail-wm0-x244.google.com with SMTP id r144so58441831wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:43 +0100
Message-Id: <1485524749-118532-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/41] spice-char: improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Set errp to report errors up to the right monitor.

Use error_append_hint() to give hints about parameters on !qmp monitors,
instead of a direct fprintf() call.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 spice-qemu-char.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 38b1f6c..5e5897b 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -2,6 +2,7 @@
 #include "trace.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/char.h"
+#include "qemu/error-report.h"
 #include <spice.h>
 #include <spice/protocol.h>
 
@@ -239,23 +240,6 @@ static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 #endif
 }
 
-static void print_allowed_subtypes(void)
-{
-    const char** psubtype;
-    int i;
-
-    fprintf(stderr, "allowed names: ");
-    for(i=0, psubtype = spice_server_char_device_recognized_subtypes();
-        *psubtype != NULL; ++psubtype, ++i) {
-        if (i == 0) {
-            fprintf(stderr, "%s", *psubtype);
-        } else {
-            fprintf(stderr, ", %s", *psubtype);
-        }
-    }
-    fprintf(stderr, "\n");
-}
-
 static void spice_chr_accept_input(struct Chardev *chr)
 {
     SpiceChardev *s = (SpiceChardev *)chr;
@@ -302,8 +286,14 @@ static Chardev *qemu_chr_open_spice_vmc(const CharDriver *driver,
         }
     }
     if (*psubtype == NULL) {
-        fprintf(stderr, "spice-qemu-char: unsupported type: %s\n", type);
-        print_allowed_subtypes();
+        char *subtypes = g_strjoinv(", ",
+            (gchar **)spice_server_char_device_recognized_subtypes());
+
+        error_setg(errp, "unsupported type name: %s", type);
+        error_append_hint(errp, "allowed spice char type names: %s\n",
+                          subtypes);
+
+        g_free(subtypes);
         return NULL;
     }
 
@@ -326,7 +316,7 @@ static Chardev *qemu_chr_open_spice_port(const CharDriver *driver,
     SpiceChardev *s;
 
     if (name == NULL) {
-        fprintf(stderr, "spice-qemu-char: missing name parameter\n");
+        error_setg(errp, "missing name parameter");
         return NULL;
     }
 
-- 
1.8.3.1
