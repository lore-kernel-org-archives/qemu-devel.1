Received: from eggs.gnu.org ([2001:4830:134:3::10]:56869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft85O-0008Il-HF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft85N-000655-K9
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ft85N-00064x-EN
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21C0287A74
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:08:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Aug 2018 17:08:26 +0800
Message-Id: <20180824090826.21370-4-peterx@redhat.com>
In-Reply-To: <20180824090826.21370-1-peterx@redhat.com>
References: <20180824090826.21370-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] monitor: switch to use chardev's iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Now after we have chardev maintained iothread, we switch to that one by
adding a parsing phase for monitors even before chardevs start to
initialize.  Then chardevs will use a constant gcontext since the
creation of the object and it should never change.

Remove the context setup in qemu_chr_be_update_read_handlers(), instead
assert it in qemu_chr_fe_set_handlers() properly to make sure the
context to be setup is always the one provided when chardev creates.

Note that now we kept all the context parameters in misc functions,
however it should be always setting the same context, otherwise a
programming bug.  In the future we may remove all these parameters.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-fe.c |  6 ++++++
 chardev/char.c    |  1 -
 monitor.c         |  4 ++--
 vl.c              | 31 +++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b1f228e8b5..fcb232c9b6 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -267,6 +267,12 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         remove_fd_in_watch(s);
     } else {
         fe_open = 1;
+        /*
+         * Currently we don't allow to change context after chardev is
+         * created.  TODO: either remove these context parameters, or
+         * re-activate dynamic context switch for chardevs.
+         */
+        assert(context == s->gcontext);
     }
     b->chr_can_read = fd_can_read;
     b->chr_read = fd_read;
diff --git a/chardev/char.c b/chardev/char.c
index c98d245ef7..da8ca9082b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -200,7 +200,6 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(s);
 
-    s->gcontext = context;
     if (cc->chr_update_read_handler) {
         cc->chr_update_read_handler(s);
     }
diff --git a/monitor.c b/monitor.c
index a1999e396c..1e45f3466e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4543,7 +4543,7 @@ static AioContext *monitor_get_aio_context(void)
 
 static void monitor_iothread_init(void)
 {
-    mon_iothread = iothread_create("mon_iothread", &error_abort);
+    mon_iothread = qemu_chr_iothread_get(CHR_CONTEXT_MONITOR);
 
     /*
      * The dispatcher BH must run in the main loop thread, since we
@@ -4735,7 +4735,7 @@ void monitor_cleanup(void)
     qemu_bh_delete(qmp_respond_bh);
     qmp_respond_bh = NULL;
 
-    iothread_destroy(mon_iothread);
+    /* It'll be cleaned up by chardev */
     mon_iothread = NULL;
 }
 
diff --git a/vl.c b/vl.c
index 25e156c020..5bc0946987 100644
--- a/vl.c
+++ b/vl.c
@@ -2349,6 +2349,32 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+/*
+ * This setup the backends properly, it really has nothing to do with
+ * monitor itself yet.
+ */
+static int mon_setup_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    const char *chardev;
+    int flags;
+    QemuOpts *chr_opts;
+
+    flags = mon_parse_flags(opts);
+    chardev = qemu_opt_get(opts, "chardev");
+
+    /*
+     * If out-of-band is enabled on the monitor, choose the correct
+     * context for the backend before it initializes.
+     */
+    if (flags & MONITOR_USE_OOB) {
+        chr_opts = qemu_opts_find(qemu_find_opts("chardev"), chardev);
+        qemu_opt_set_number(chr_opts, "context", CHR_CONTEXT_MONITOR,
+                            &error_abort);
+    }
+
+    return 0;
+}
+
 static void monitor_parse(const char *optarg, const char *mode, bool pretty)
 {
     static int monitor_device_index = 0;
@@ -4278,6 +4304,11 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    if (qemu_opts_foreach(qemu_find_opts("mon"),
+                          mon_setup_func, NULL, NULL)) {
+        exit(1);
+    }
+
     if (qemu_opts_foreach(qemu_find_opts("chardev"),
                           chardev_init_func, NULL, NULL)) {
         exit(1);
-- 
2.17.1
