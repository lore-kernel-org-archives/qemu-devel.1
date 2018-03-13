Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshp-0005VZ-Kc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsho-0002zc-6F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshn-0002yQ-Sz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:40 -0400
Received: by mail-wm0-x241.google.com with SMTP id q83so871350wme.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:24 +0100
Message-Id: <20180313224719.4954-15-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/69] chardev: introduce chr_machine_done hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Introduce ChardevClass.chr_machine_done() hook so that chardevs can run
customized procedures after machine init.

There was an existing mux user already that did similar thing but used a
raw machine done notifier.  Generalize it into a framework, and let the
mux chardevs provide such a class-specific hook to achieve the same
thing.  Then we can move the mux related code to the char-mux.c file.

Since at it, replace the mux_realized variable with the global
machine_init_done varible.

This notifier framework will be further leverged by other type of
chardevs soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180306053320.15401-6-peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-mux.c         | 33 +++++++++++++++++++++++++++++----
 chardev/char.c             | 43 +++++++++++++++++--------------------------
 include/chardev/char-mux.h |  2 --
 include/chardev/char.h     |  2 ++
 tests/test-char.c          |  1 -
 5 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index d48e78103a..1b925c8dec 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -27,6 +27,7 @@
 #include "qemu/option.h"
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
 #include "chardev/char-mux.h"
 
 /* MUX driver for serial I/O splitting */
@@ -230,14 +231,12 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
         }
 }
 
-bool muxes_realized;
-
 void mux_chr_send_all_event(Chardev *chr, int event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
     int i;
 
-    if (!muxes_realized) {
+    if (!machine_init_done) {
         return;
     }
 
@@ -327,7 +326,7 @@ static void qemu_chr_open_mux(Chardev *chr,
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
-    *be_opened = muxes_realized;
+    *be_opened = machine_init_done;
     qemu_chr_fe_init(&d->chr, drv, errp);
 }
 
@@ -347,6 +346,31 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
+/**
+ * Called after processing of default and command-line-specified
+ * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
+ * to a mux chardev. This is done here to ensure that
+ * output/prompts/banners are only displayed for the FE that has
+ * focus when initial command-line processing/machine init is
+ * completed.
+ *
+ * After this point, any new FE attached to any new or existing
+ * mux will receive CHR_EVENT_OPENED notifications for the BE
+ * immediately.
+ */
+static int open_muxes(Chardev *chr)
+{
+    /* send OPENED to all already-attached FEs */
+    mux_chr_send_all_event(chr, CHR_EVENT_OPENED);
+    /*
+     * mark mux as OPENED so any new FEs will immediately receive
+     * OPENED event
+     */
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+
+    return 0;
+}
+
 static void char_mux_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -357,6 +381,7 @@ static void char_mux_class_init(ObjectClass *oc, void *data)
     cc->chr_accept_input = mux_chr_accept_input;
     cc->chr_add_watch = mux_chr_add_watch;
     cc->chr_be_event = mux_chr_be_event;
+    cc->chr_machine_done = open_muxes;
 }
 
 static const TypeInfo char_mux_type_info = {
diff --git a/chardev/char.c b/chardev/char.c
index 5d7b079ef0..a6250cac80 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -281,40 +281,31 @@ static const TypeInfo char_type_info = {
     .class_init = char_class_init,
 };
 
-/**
- * Called after processing of default and command-line-specified
- * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
- * to a mux chardev. This is done here to ensure that
- * output/prompts/banners are only displayed for the FE that has
- * focus when initial command-line processing/machine init is
- * completed.
- *
- * After this point, any new FE attached to any new or existing
- * mux will receive CHR_EVENT_OPENED notifications for the BE
- * immediately.
- */
-static int open_muxes(Object *child, void *opaque)
+static int chardev_machine_done_notify_one(Object *child, void *opaque)
 {
-    if (CHARDEV_IS_MUX(child)) {
-        /* send OPENED to all already-attached FEs */
-        mux_chr_send_all_event(CHARDEV(child), CHR_EVENT_OPENED);
-        /* mark mux as OPENED so any new FEs will immediately receive
-         * OPENED event
-         */
-        qemu_chr_be_event(CHARDEV(child), CHR_EVENT_OPENED);
+    Chardev *chr = (Chardev *)child;
+    ChardevClass *class = CHARDEV_GET_CLASS(chr);
+
+    if (class->chr_machine_done) {
+        return class->chr_machine_done(chr);
     }
 
     return 0;
 }
 
-static void muxes_realize_done(Notifier *notifier, void *unused)
+static void chardev_machine_done_hook(Notifier *notifier, void *unused)
 {
-    muxes_realized = true;
-    object_child_foreach(get_chardevs_root(), open_muxes, NULL);
+    int ret = object_child_foreach(get_chardevs_root(),
+                                   chardev_machine_done_notify_one, NULL);
+
+    if (ret) {
+        error_report("Failed to call chardev machine_done hooks");
+        exit(1);
+    }
 }
 
-static Notifier muxes_realize_notify = {
-    .notify = muxes_realize_done,
+static Notifier chardev_machine_done_notify = {
+    .notify = chardev_machine_done_hook,
 };
 
 static bool qemu_chr_is_busy(Chardev *s)
@@ -1118,7 +1109,7 @@ static void register_types(void)
      * as part of realize functions like serial_isa_realizefn when -nographic
      * is specified
      */
-    qemu_add_machine_init_done_notifier(&muxes_realize_notify);
+    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
 }
 
 type_init(register_types);
diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
index 8928977897..1e13187767 100644
--- a/include/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -27,8 +27,6 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 
-extern bool muxes_realized;
-
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ebf1e0ba04..04de45795e 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -248,6 +248,8 @@ typedef struct ChardevClass {
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
     void (*chr_be_event)(Chardev *s, int event);
+    /* Return 0 if succeeded, 1 if failed */
+    int (*chr_machine_done)(Chardev *chr);
 } ChardevClass;
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
diff --git a/tests/test-char.c b/tests/test-char.c
index b3a77af085..c731313098 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -166,7 +166,6 @@ static void char_mux_test(void)
     FeHandler h1 = { 0, }, h2 = { 0, };
     CharBackend chr_be1, chr_be2;
 
-    muxes_realized = true; /* done after machine init */
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
-- 
2.14.3
