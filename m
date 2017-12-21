Received: from eggs.gnu.org ([2001:4830:134:3::10]:35373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwKH-0007wY-VT
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwKG-0006Bs-0B
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:37 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRwKF-0006As-Oz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:35 -0500
Received: by mail-wm0-x241.google.com with SMTP id t8so14328886wmc.3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:35:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Dec 2017 09:35:28 +0100
Message-Id: <20171221083529.6982-3-pbonzini@redhat.com>
In-Reply-To: <20171221083529.6982-1-pbonzini@redhat.com>
References: <20171221083529.6982-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/41] chardev: fix backend events regression
 with mux chardev
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

Kirill noticied that on recent versions on QEMU he was not able to
trigger SysRq to invoke debug capabilites of Linux Kernel.  He tracked
it down to qemu_chr_be_event() ignoring CHR_EVENT_BREAK due s->be
being NULL. The bug was introduced in 2.8, commit a4afa548fc6d ("char:
move front end handlers in CharBackend"). Since the commit, the
qemu_chr_be_event() failed to deliver CHR_EVENT_BREAK due to
qemu_chr_fe_init() does not set s->be in case of mux.

Let's fix this by teaching mux to send an event to the frontend with
the focus.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
Message-Id: <20171103152824.21948-2-marcandre.lureau@redhat.com>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-mux.c     | 10 ++++++++++
 chardev/char.c         | 18 ++++++++++++------
 include/chardev/char.h |  1 +
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 4cda5e7458..567bf965cd 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -123,6 +123,15 @@ static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
     }
 }
 
+static void mux_chr_be_event(Chardev *chr, int event)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+
+    if (d->focus != -1) {
+        mux_chr_send_event(d, d->focus, event);
+    }
+}
+
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
@@ -346,6 +355,7 @@ static void char_mux_class_init(ObjectClass *oc, void *data)
     cc->chr_write = mux_chr_write;
     cc->chr_accept_input = mux_chr_accept_input;
     cc->chr_add_watch = mux_chr_add_watch;
+    cc->chr_be_event = mux_chr_be_event;
 }
 
 static const TypeInfo char_mux_type_info = {
diff --git a/chardev/char.c b/chardev/char.c
index 2ae4f465ec..8c3765ee99 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -43,10 +43,19 @@ static Object *get_chardevs_root(void)
     return container_get(object_get_root(), "/chardevs");
 }
 
-void qemu_chr_be_event(Chardev *s, int event)
+static void chr_be_event(Chardev *s, int event)
 {
     CharBackend *be = s->be;
 
+    if (!be || !be->chr_event) {
+        return;
+    }
+
+    be->chr_event(be->opaque, event);
+}
+
+void qemu_chr_be_event(Chardev *s, int event)
+{
     /* Keep track if the char device is open */
     switch (event) {
         case CHR_EVENT_OPENED:
@@ -57,11 +66,7 @@ void qemu_chr_be_event(Chardev *s, int event)
             break;
     }
 
-    if (!be || !be->chr_event) {
-        return;
-    }
-
-    be->chr_event(be->opaque, event);
+    CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
 }
 
 /* Not reporting errors from writing to logfile, as logs are
@@ -244,6 +249,7 @@ static void char_class_init(ObjectClass *oc, void *data)
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->chr_write = null_chr_write;
+    cc->chr_be_event = chr_be_event;
 }
 
 static void char_finalize(Object *obj)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 43aabccef5..778d610295 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -248,6 +248,7 @@ typedef struct ChardevClass {
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
+    void (*chr_be_event)(Chardev *s, int event);
 } ChardevClass;
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-- 
2.14.3
