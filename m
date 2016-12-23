Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cKS5e-000358-Ob
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cKS5b-0005m3-M3
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:49:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:44798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1cKS5b-0005la-Fk
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:48:59 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 95AFDAC40
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 15:48:57 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
Date: Fri, 23 Dec 2016 16:48:53 +0100
Message-Id: <20161223154853.23672-1-msuchanek@suse.de>
In-Reply-To: <20161223151253.21338-1-msuchanek@suse.de>
References: <20161223151253.21338-1-msuchanek@suse.de>
Subject: [Qemu-devel] [RFC PATCH] Fix pasting into serial console in GTK ui
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Suchanek <msuchanek@suse.de>

This copies the timer hack from ui/console.c kbd_send_chars to ui/gtk.c
gd_vc_in.

There is no fd-like object to peek repatedly so the paste data is saved
in a free-floating buffer only submitted to gtk_timeout_add. Multiple
pastes can potentially interleave if qemu blocks for long or the user
pastes fast.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 ui/gtk.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index a216216..58e97ab 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1715,11 +1715,15 @@ static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
     return chr;
 }
 
-static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
-                         gpointer user_data)
-{
-    VirtualConsole *vc = user_data;
+struct vc_in_buffer {
+    VirtualConsole *vc;
+    gchar *text;
+    guint size;
+    guint sent;
+};
 
+static gboolean do_gd_vc_in(VirtualConsole *vc, gchar *text, guint size)
+{
     if (vc->vte.echo) {
         VteTerminal *term = VTE_TERMINAL(vc->vte.terminal);
         int i;
@@ -1742,6 +1746,52 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
     return TRUE;
 }
 
+static gint gd_vc_in_timer(gpointer data)
+{
+    struct vc_in_buffer *inbuf = data;
+    VirtualConsole *vc = inbuf->vc;
+    int len = qemu_chr_be_can_write(vc->vte.chr);
+    int size = inbuf->size - inbuf->sent;
+    if (size > len) {
+        size = len;
+    }
+    do_gd_vc_in(vc, inbuf->text + inbuf->sent, size);
+
+    inbuf->sent += size;
+    if (inbuf->sent < inbuf->size) {
+        return TRUE;
+    } else {
+        g_clear_pointer(&inbuf->text, g_free);
+        g_free(inbuf);
+        return FALSE;
+    }
+}
+
+static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
+                         gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    int len = qemu_chr_be_can_write(vc->vte.chr);
+
+    if (size > len) {
+        struct vc_in_buffer *inbuf = g_try_new0(struct vc_in_buffer, 1);
+        if (!inbuf) {
+            return FALSE;
+        }
+        inbuf->text = g_strndup(text, size);
+        if (!inbuf->text) {
+            g_free(inbuf);
+            return FALSE;
+        }
+        inbuf->vc = vc;
+        inbuf->size = size;
+        inbuf->sent = len;
+        size = len;
+        g_timeout_add(1, gd_vc_in_timer, inbuf);
+    }
+    return do_gd_vc_in(vc, text, size);
+}
+
 static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                               CharDriverState *chr, int idx,
                               GSList *group, GtkWidget *view_menu)
-- 
2.10.2
