Received: from eggs.gnu.org ([2001:4830:134:3::10]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOo-0007Gr-2g
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOn-00054V-6X
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:09 -0300
Message-Id: <20171006235023.11952-15-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/88] ui/vnc: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: renamed 'Graphics' -> ui/vnc, added ui/vnc.c and ui/vnc-palette.c]
---
 ui/vnc-enc-tight.c | 2 +-
 ui/vnc-palette.c   | 2 +-
 ui/vnc.c           | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index f38aceb4da..48ec584098 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1475,7 +1475,7 @@ static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
 #endif
 
     if (!color_count_palette) {
-        color_count_palette = g_malloc(sizeof(VncPalette));
+        color_count_palette = g_new(VncPalette, 1);
         vnc_tight_cleanup_notifier.notify = vnc_tight_cleanup;
         qemu_thread_atexit_add(&vnc_tight_cleanup_notifier);
     }
diff --git a/ui/vnc-palette.c b/ui/vnc-palette.c
index dc7c0ba997..284e118715 100644
--- a/ui/vnc-palette.c
+++ b/ui/vnc-palette.c
@@ -56,7 +56,7 @@ VncPalette *palette_new(size_t max, int bpp)
 {
     VncPalette *palette;
 
-    palette = g_malloc0(sizeof(*palette));
+    palette = g_new0(VncPalette, 1);
     palette_init(palette, max, bpp);
     return palette;
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 9f8d5a1b1f..b021fb398b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -231,7 +231,7 @@ static VncServerInfo *vnc_server_info_get(VncDisplay *vd)
         return NULL;
     }
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(VncServerInfo, 1);
     vnc_init_basic_info_from_server_addr(vd->lsock[0],
                                          qapi_VncServerInfo_base(info), &err);
     info->has_auth = true;
@@ -316,7 +316,7 @@ static VncClientInfo *qmp_query_vnc_client(const VncState *client)
     VncClientInfo *info;
     Error *err = NULL;
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(VncClientInfo, 1);
 
     vnc_init_basic_info_from_remote_addr(client->sioc,
                                          qapi_VncClientInfo_base(info),
@@ -3047,7 +3047,7 @@ void vnc_display_init(const char *id)
     if (vnc_display_find(id) != NULL) {
         return;
     }
-    vd = g_malloc0(sizeof(*vd));
+    vd = g_new0(VncDisplay, 1);
 
     vd->id = strdup(id);
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
-- 
2.14.2
