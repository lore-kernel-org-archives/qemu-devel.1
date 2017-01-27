Received: from eggs.gnu.org ([2001:4830:134:3::10]:33916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rM-0005Yh-Vd
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rM-0004K1-3A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:37 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rL-0004JF-SH
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:36 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so58442107wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:47 +0100
Message-Id: <1485524749-118532-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/41] vc: use a common prefix for chr callbacks
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

vc_chr_write() is more appropriate than _puts() since no newline is
appended, even though it's not used only as a callback.

Keep "qemu_chr_parse" prefix, most chardev parse functions use this
prefix atm.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/console.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index d8bc8a6..c8ee164 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1051,7 +1051,7 @@ typedef struct VCChardev {
     QemuConsole *console;
 } VCChardev;
 
-static int console_puts(Chardev *chr, const uint8_t *buf, int len)
+static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     VCChardev *drv = (VCChardev *)chr;
     QemuConsole *s = drv->console;
@@ -1139,13 +1139,13 @@ void kbd_put_keysym_console(QemuConsole *s, int keysym)
             *q++ = '[';
             *q++ = keysym & 0xff;
         } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
-            console_puts(s->chr, (const uint8_t *) "\r", 1);
+            vc_chr_write(s->chr, (const uint8_t *) "\r", 1);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
         if (s->echo) {
-            console_puts(s->chr, buf, q - buf);
+            vc_chr_write(s->chr, buf, q - buf);
         }
         be = s->chr->be;
         if (be && be->chr_read) {
@@ -1962,7 +1962,7 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     return con ? surface_height(con->surface) : fallback;
 }
 
-static void text_console_set_echo(Chardev *chr, bool echo)
+static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
     VCChardev *drv = (VCChardev *)chr;
     QemuConsole *s = drv->console;
@@ -2049,7 +2049,7 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
 
         s->t_attrib.bgcol = QEMU_COLOR_BLUE;
         len = snprintf(msg, sizeof(msg), "%s console\r\n", chr->label);
-        console_puts(chr, (uint8_t*)msg, len);
+        vc_chr_write(chr, (uint8_t *)msg, len);
         s->t_attrib = s->t_attrib_default;
     }
 
@@ -2058,10 +2058,10 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
 
 static const CharDriver vc_driver;
 
-static Chardev *vc_init(const CharDriver *driver,
-                        const char *id, ChardevBackend *backend,
-                        ChardevReturn *ret, bool *be_opened,
-                        Error **errp)
+static Chardev *vc_chr_init(const CharDriver *driver,
+                            const char *id, ChardevBackend *backend,
+                            ChardevReturn *ret, bool *be_opened,
+                            Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
     ChardevCommon *common = qapi_ChardevVC_base(vc);
@@ -2197,9 +2197,9 @@ static const CharDriver vc_driver = {
     .instance_size = sizeof(VCChardev),
     .kind = CHARDEV_BACKEND_KIND_VC,
     .parse = qemu_chr_parse_vc,
-    .create = vc_init,
-    .chr_write = console_puts,
-    .chr_set_echo = text_console_set_echo,
+    .create = vc_chr_init,
+    .chr_write = vc_chr_write,
+    .chr_set_echo = vc_chr_set_echo,
 };
 
 static void register_types(void)
-- 
1.8.3.1
