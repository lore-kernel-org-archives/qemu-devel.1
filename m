Received: from eggs.gnu.org ([2001:4830:134:3::10]:41680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYl-0007NV-3g
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYj-0004zn-Vu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:43 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYj-0004xK-PX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:41 -0500
Received: by mail-wr0-x22d.google.com with SMTP id 36so5057314wrh.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:42 +0100
Message-Id: <1515756676-3860-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/52] readline: add a free function
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

Fixes leaks such as:

Direct leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x7eff58beb850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7eff57942f0c in g_malloc ../glib/gmem.c:94
    #2 0x7eff579431cf in g_malloc_n ../glib/gmem.c:331
    #3 0x7eff5795f6eb in g_strdup ../glib/gstrfuncs.c:363
    #4 0x55db720f1d46 in readline_hist_add /home/elmarco/src/qq/util/readline.c:258
    #5 0x55db720f2d34 in readline_handle_byte /home/elmarco/src/qq/util/readline.c:387
    #6 0x55db71539d00 in monitor_read /home/elmarco/src/qq/monitor.c:3896
    #7 0x55db71f9be35 in qemu_chr_be_write_impl /home/elmarco/src/qq/chardev/char.c:167
    #8 0x55db71f9bed3 in qemu_chr_be_write /home/elmarco/src/qq/chardev/char.c:179
    #9 0x55db71fa013c in fd_chr_read /home/elmarco/src/qq/chardev/char-fd.c:66
    #10 0x55db71fe18a8 in qio_channel_fd_source_dispatch /home/elmarco/src/qq/io/channel-watch.c:84
    #11 0x7eff5793a90b in g_main_dispatch ../glib/gmain.c:3182
    #12 0x7eff5793b7ac in g_main_context_dispatch ../glib/gmain.c:3847
    #13 0x55db720af3bd in glib_pollfds_poll /home/elmarco/src/qq/util/main-loop.c:214
    #14 0x55db720af505 in os_host_main_loop_wait /home/elmarco/src/qq/util/main-loop.c:261
    #15 0x55db720af6d6 in main_loop_wait /home/elmarco/src/qq/util/main-loop.c:515
    #16 0x55db7184e0de in main_loop /home/elmarco/src/qq/vl.c:1995
    #17 0x55db7185e956 in main /home/elmarco/src/qq/vl.c:4914
    #18 0x7eff4ea17039 in __libc_start_main (/lib64/libc.so.6+0x21039)

(while at it, use g_new0(ReadLineState), it's a bit easier to read)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180104160523.22995-11-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/readline.h |  1 +
 monitor.c               |  2 +-
 util/readline.c         | 18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/qemu/readline.h b/include/qemu/readline.h
index c08cf74..e812583 100644
--- a/include/qemu/readline.h
+++ b/include/qemu/readline.h
@@ -59,5 +59,6 @@ ReadLineState *readline_init(ReadLinePrintfFunc *printf_func,
                              ReadLineFlushFunc *flush_func,
                              void *opaque,
                              ReadLineCompletionFunc *completion_finder);
+void readline_free(ReadLineState *rs);
 
 #endif /* READLINE_H */
diff --git a/monitor.c b/monitor.c
index d682eee..b9da5e2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -583,7 +583,7 @@ static void monitor_data_destroy(Monitor *mon)
     if (monitor_is_qmp(mon)) {
         json_message_parser_destroy(&mon->qmp.parser);
     }
-    g_free(mon->rs);
+    readline_free(mon->rs);
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
 }
diff --git a/util/readline.c b/util/readline.c
index bbdee79..24ec839 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -500,12 +500,28 @@ const char *readline_get_history(ReadLineState *rs, unsigned int index)
     return rs->history[index];
 }
 
+void readline_free(ReadLineState *rs)
+{
+    int i;
+
+    if (!rs) {
+        return;
+    }
+    for (i = 0; i < READLINE_MAX_CMDS; i++) {
+        g_free(rs->history[i]);
+    }
+    for (i = 0; i < READLINE_MAX_COMPLETIONS; i++) {
+        g_free(rs->completions[i]);
+    }
+    g_free(rs);
+}
+
 ReadLineState *readline_init(ReadLinePrintfFunc *printf_func,
                              ReadLineFlushFunc *flush_func,
                              void *opaque,
                              ReadLineCompletionFunc *completion_finder)
 {
-    ReadLineState *rs = g_malloc0(sizeof(*rs));
+    ReadLineState *rs = g_new0(ReadLineState, 1);
 
     rs->hist_entry = -1;
     rs->opaque = opaque;
-- 
1.8.3.1
