Received: from eggs.gnu.org ([2001:4830:134:3::10]:41723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYq-0007TF-7i
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYn-0005CT-Fy
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:48 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:42455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYn-00059o-9t
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:45 -0500
Received: by mail-wr0-x236.google.com with SMTP id e41so4697471wre.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:45 +0100
Message-Id: <1515756676-3860-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/52] qemu-config: fix leak in
 query-command-line-options
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

Direct leak of 160 byte(s) in 4 object(s) allocated from:
    #0 0x55ed7678cda8 in calloc (/home/elmarco/src/qq/build/x86_64-softmmu/qemu-system-x86_64+0x797da8)
    #1 0x7f3f5e725f75 in g_malloc0 /home/elmarco/src/gnome/glib/builddir/../glib/gmem.c:124
    #2 0x55ed778aa3a7 in query_option_descs /home/elmarco/src/qq/util/qemu-config.c:60:16
    #3 0x55ed778aa307 in get_drive_infolist /home/elmarco/src/qq/util/qemu-config.c:140:19
    #4 0x55ed778a9f40 in qmp_query_command_line_options /home/elmarco/src/qq/util/qemu-config.c:254:36
    #5 0x55ed76d4868c in qmp_marshal_query_command_line_options /home/elmarco/src/qq/build/qmp-marshal.c:3078:14
    #6 0x55ed77855dd5 in do_qmp_dispatch /home/elmarco/src/qq/qapi/qmp-dispatch.c:104:5
    #7 0x55ed778558cc in qmp_dispatch /home/elmarco/src/qq/qapi/qmp-dispatch.c:131:11
    #8 0x55ed768b592f in handle_qmp_command /home/elmarco/src/qq/monitor.c:3840:11
    #9 0x55ed7786ccfe in json_message_process_token /home/elmarco/src/qq/qobject/json-streamer.c:105:5
    #10 0x55ed778fe37c in json_lexer_feed_char /home/elmarco/src/qq/qobject/json-lexer.c:323:13
    #11 0x55ed778fdde6 in json_lexer_feed /home/elmarco/src/qq/qobject/json-lexer.c:373:15
    #12 0x55ed7786cd83 in json_message_parser_feed /home/elmarco/src/qq/qobject/json-streamer.c:124:12
    #13 0x55ed768b559e in monitor_qmp_read /home/elmarco/src/qq/monitor.c:3882:5
    #14 0x55ed77714f29 in qemu_chr_be_write_impl /home/elmarco/src/qq/chardev/char.c:167:9
    #15 0x55ed77714fde in qemu_chr_be_write /home/elmarco/src/qq/chardev/char.c:179:9
    #16 0x55ed7772ffad in tcp_chr_read /home/elmarco/src/qq/chardev/char-socket.c:440:13
    #17 0x55ed7777113b in qio_channel_fd_source_dispatch /home/elmarco/src/qq/io/channel-watch.c:84:12
    #18 0x7f3f5e71d90b in g_main_dispatch /home/elmarco/src/gnome/glib/builddir/../glib/gmain.c:3182
    #19 0x7f3f5e71e7ac in g_main_context_dispatch /home/elmarco/src/gnome/glib/builddir/../glib/gmain.c:3847
    #20 0x55ed77886ffc in glib_pollfds_poll /home/elmarco/src/qq/util/main-loop.c:214:9
    #21 0x55ed778865fd in os_host_main_loop_wait /home/elmarco/src/qq/util/main-loop.c:261:5
    #22 0x55ed77886222 in main_loop_wait /home/elmarco/src/qq/util/main-loop.c:515:11
    #23 0x55ed76d2a4df in main_loop /home/elmarco/src/qq/vl.c:1995:9
    #24 0x55ed76d1cb4a in main /home/elmarco/src/qq/vl.c:4914:5
    #25 0x7f3f555f6039 in __libc_start_main (/lib64/libc.so.6+0x21039)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180104160523.22995-14-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/qemu-config.c b/util/qemu-config.c
index 99b0e46..029fec5 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -105,7 +105,8 @@ static void cleanup_infolist(CommandLineParameterInfoList *head)
             if (!strcmp(pre_entry->value->name, cur->next->value->name)) {
                 del_entry = cur->next;
                 cur->next = cur->next->next;
-                g_free(del_entry);
+                del_entry->next = NULL;
+                qapi_free_CommandLineParameterInfoList(del_entry);
                 break;
             }
             pre_entry = pre_entry->next;
-- 
1.8.3.1
