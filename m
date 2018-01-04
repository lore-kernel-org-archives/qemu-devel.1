Received: from eggs.gnu.org ([2001:4830:134:3::10]:38198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84c-0000Nd-WF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84Z-0005FY-9t
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX84Z-0005Eu-0y
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4322E1A4081
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:08:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:15 +0100
Message-Id: <20180104160523.22995-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/18] readline: add a free function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Fixes leaks such as:

Direct leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x7eff58beb850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7eff57942f0c in g_malloc ../glib/gmem.c:94
    #2 0x7eff579431cf in g_malloc_n ../glib/gmem.c:331
    #3 0x7eff5795f6eb in g_strdup ../glib/gstrfuncs.c:363
    #4 0x55db720f1d46 in readline_hist_add /home/elmarco/src/qq/util/read=
line.c:258
    #5 0x55db720f2d34 in readline_handle_byte /home/elmarco/src/qq/util/r=
eadline.c:387
    #6 0x55db71539d00 in monitor_read /home/elmarco/src/qq/monitor.c:3896
    #7 0x55db71f9be35 in qemu_chr_be_write_impl /home/elmarco/src/qq/char=
dev/char.c:167
    #8 0x55db71f9bed3 in qemu_chr_be_write /home/elmarco/src/qq/chardev/c=
har.c:179
    #9 0x55db71fa013c in fd_chr_read /home/elmarco/src/qq/chardev/char-fd=
.c:66
    #10 0x55db71fe18a8 in qio_channel_fd_source_dispatch /home/elmarco/sr=
c/qq/io/channel-watch.c:84
    #11 0x7eff5793a90b in g_main_dispatch ../glib/gmain.c:3182
    #12 0x7eff5793b7ac in g_main_context_dispatch ../glib/gmain.c:3847
    #13 0x55db720af3bd in glib_pollfds_poll /home/elmarco/src/qq/util/mai=
n-loop.c:214
    #14 0x55db720af505 in os_host_main_loop_wait /home/elmarco/src/qq/uti=
l/main-loop.c:261
    #15 0x55db720af6d6 in main_loop_wait /home/elmarco/src/qq/util/main-l=
oop.c:515
    #16 0x55db7184e0de in main_loop /home/elmarco/src/qq/vl.c:1995
    #17 0x55db7185e956 in main /home/elmarco/src/qq/vl.c:4914
    #18 0x7eff4ea17039 in __libc_start_main (/lib64/libc.so.6+0x21039)

(while at it, use g_new0(ReadLineState), it's a bit easier to read)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/qemu/readline.h |  1 +
 monitor.c               |  2 +-
 util/readline.c         | 18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/qemu/readline.h b/include/qemu/readline.h
index c08cf7400e..e81258322b 100644
--- a/include/qemu/readline.h
+++ b/include/qemu/readline.h
@@ -59,5 +59,6 @@ ReadLineState *readline_init(ReadLinePrintfFunc *printf=
_func,
                              ReadLineFlushFunc *flush_func,
                              void *opaque,
                              ReadLineCompletionFunc *completion_finder);
+void readline_free(ReadLineState *rs);
=20
 #endif /* READLINE_H */
diff --git a/monitor.c b/monitor.c
index d682eee2d8..b9da5e20d1 100644
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
index bbdee790b0..24ec839854 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -500,12 +500,28 @@ const char *readline_get_history(ReadLineState *rs,=
 unsigned int index)
     return rs->history[index];
 }
=20
+void readline_free(ReadLineState *rs)
+{
+    int i;
+
+    if (!rs) {
+        return;
+    }
+    for (i =3D 0; i < READLINE_MAX_CMDS; i++) {
+        g_free(rs->history[i]);
+    }
+    for (i =3D 0; i < READLINE_MAX_COMPLETIONS; i++) {
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
-    ReadLineState *rs =3D g_malloc0(sizeof(*rs));
+    ReadLineState *rs =3D g_new0(ReadLineState, 1);
=20
     rs->hist_entry =3D -1;
     rs->opaque =3D opaque;
--=20
2.15.1.355.g36791d7216
