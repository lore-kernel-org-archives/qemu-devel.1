Received: from eggs.gnu.org ([2001:4830:134:3::10]:41716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPz-0008Ry-Md
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPx-0005vK-7R
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:30 -0300
Message-Id: <20171006235023.11952-36-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 35/88] Record/replay: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 replay/replay-char.c   |  4 ++--
 replay/replay-events.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/replay/replay-char.c b/replay/replay-char.c
index cbf7c04a9f..b8ed5c51d1 100755
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -51,7 +51,7 @@ void replay_register_char_driver(Chardev *chr)
 
 void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
-    CharEvent *event = g_malloc0(sizeof(CharEvent));
+    CharEvent *event = g_new0(CharEvent, 1);
 
     event->id = find_char_driver(s);
     if (event->id < 0) {
@@ -86,7 +86,7 @@ void replay_event_char_read_save(void *opaque)
 
 void *replay_event_char_read_load(void)
 {
-    CharEvent *event = g_malloc0(sizeof(CharEvent));
+    CharEvent *event = g_new0(CharEvent, 1);
 
     event->id = replay_get_byte();
     replay_get_array_alloc(&event->buf, &event->len);
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 94a6dcccfc..c72dcaa708 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -128,7 +128,7 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
         return;
     }
 
-    Event *event = g_malloc0(sizeof(Event));
+    Event *event = g_new0(Event, 1);
     event->event_kind = event_kind;
     event->opaque = opaque;
     event->opaque2 = opaque2;
@@ -239,17 +239,17 @@ static Event *replay_read_event(int checkpoint)
         }
         break;
     case REPLAY_ASYNC_EVENT_INPUT:
-        event = g_malloc0(sizeof(Event));
+        event = g_new0(Event, 1);
         event->event_kind = read_event_kind;
         event->opaque = replay_read_input_event();
         return event;
     case REPLAY_ASYNC_EVENT_INPUT_SYNC:
-        event = g_malloc0(sizeof(Event));
+        event = g_new0(Event, 1);
         event->event_kind = read_event_kind;
         event->opaque = 0;
         return event;
     case REPLAY_ASYNC_EVENT_CHAR_READ:
-        event = g_malloc0(sizeof(Event));
+        event = g_new0(Event, 1);
         event->event_kind = read_event_kind;
         event->opaque = replay_event_char_read_load();
         return event;
@@ -259,7 +259,7 @@ static Event *replay_read_event(int checkpoint)
         }
         break;
     case REPLAY_ASYNC_EVENT_NET:
-        event = g_malloc0(sizeof(Event));
+        event = g_new0(Event, 1);
         event->event_kind = read_event_kind;
         event->opaque = replay_event_net_load();
         return event;
-- 
2.14.2
