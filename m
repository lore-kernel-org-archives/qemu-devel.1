Received: from eggs.gnu.org ([2001:4830:134:3::10]:40906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOs-0007JU-EY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOq-00055e-BQ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:10 -0300
Message-Id: <20171006235023.11952-16-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/88] ui/spice: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/spice-core.c    | 10 +++++-----
 ui/spice-display.c |  4 ++--
 ui/spice-input.c   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index ea04dc69b5..e76a3f46eb 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -63,7 +63,7 @@ static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)
 {
     SpiceTimer *timer;
 
-    timer = g_malloc0(sizeof(*timer));
+    timer = g_new0(SpiceTimer, 1);
     timer->timer = timer_new_ms(QEMU_CLOCK_REALTIME, func, opaque);
     QTAILQ_INSERT_TAIL(&timers, timer, next);
     return timer;
@@ -127,7 +127,7 @@ static SpiceWatch *watch_add(int fd, int event_mask, SpiceWatchFunc func, void *
 {
     SpiceWatch *watch;
 
-    watch = g_malloc0(sizeof(*watch));
+    watch = g_new0(SpiceWatch, 1);
     watch->fd     = fd;
     watch->func   = func;
     watch->opaque = opaque;
@@ -155,7 +155,7 @@ static void channel_list_add(SpiceChannelEventInfo *info)
 {
     ChannelList *item;
 
-    item = g_malloc0(sizeof(*item));
+    item = g_new0(ChannelList, 1);
     item->info = info;
     QTAILQ_INSERT_TAIL(&channel_list, item, link);
 }
@@ -380,7 +380,7 @@ static SpiceChannelList *qmp_query_spice_channels(void)
 
         assert(item->info->flags & SPICE_CHANNEL_EVENT_FLAG_ADDR_EXT);
 
-        chan = g_malloc0(sizeof(*chan));
+        chan = g_new0(SpiceChannelList, 1);
         chan->value = g_malloc0(sizeof(*chan->value));
 
         paddr = (struct sockaddr *)&item->info->paddr_ext;
@@ -525,7 +525,7 @@ SpiceInfo *qmp_query_spice(Error **errp)
     unsigned int minor;
     unsigned int micro;
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(SpiceInfo, 1);
 
     if (!spice_server || !opts) {
         info->enabled = false;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 0963c7825f..5b9f6f0bb0 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -66,7 +66,7 @@ QXLCookie *qxl_cookie_new(int type, uint64_t io)
 {
     QXLCookie *cookie;
 
-    cookie = g_malloc0(sizeof(*cookie));
+    cookie = g_new0(QXLCookie, 1);
     cookie->type = type;
     cookie->io = io;
     return cookie;
@@ -142,7 +142,7 @@ static void qemu_spice_create_one_update(SimpleSpiceDisplay *ssd,
            rect->left, rect->right,
            rect->top, rect->bottom);
 
-    update   = g_malloc0(sizeof(*update));
+    update = g_new0(SimpleSpiceUpdate, 1);
     drawable = &update->drawable;
     image    = &update->image;
     cmd      = &update->ext.cmd;
diff --git a/ui/spice-input.c b/ui/spice-input.c
index 3d41aa1831..e47ca7a051 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -243,12 +243,12 @@ void qemu_spice_input_init(void)
     QemuSpiceKbd *kbd;
     QemuSpicePointer *pointer;
 
-    kbd = g_malloc0(sizeof(*kbd));
+    kbd = g_new0(QemuSpiceKbd, 1);
     kbd->sin.base.sif = &kbd_interface.base;
     qemu_spice_add_interface(&kbd->sin.base);
     qemu_add_led_event_handler(kbd_leds, kbd);
 
-    pointer = g_malloc0(sizeof(*pointer));
+    pointer = g_new0(QemuSpicePointer, 1);
     pointer->mouse.base.sif  = &mouse_interface.base;
     pointer->tablet.base.sif = &tablet_interface.base;
     qemu_spice_add_interface(&pointer->mouse.base);
-- 
2.14.2
