Received: from eggs.gnu.org ([2001:4830:134:3::10]:55522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMl-0001oF-Op
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMk-00068P-R1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  9 Aug 2018 13:44:16 +0200
Message-Id: <20180809114417.28718-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180809114417.28718-1-marcandre.lureau@redhat.com>
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] monitor: fix oob command leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Hannes Reinecke <hare@suse.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN, during make check...

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f8e27262c48 in malloc (/lib64/libasan.so.5+0xeec48)
    #1 0x7f8e26a5f3c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
    #2 0x555ab67078a8 in qstring_from_str /home/elmarco/src/qq/qobject/qs=
tring.c:67
    #3 0x555ab67071e4 in qstring_new /home/elmarco/src/qq/qobject/qstring=
.c:24
    #4 0x555ab6713fbf in qstring_from_escaped_str /home/elmarco/src/qq/qo=
bject/json-parser.c:144
    #5 0x555ab671738c in parse_literal /home/elmarco/src/qq/qobject/json-=
parser.c:506
    #6 0x555ab67179c3 in parse_value /home/elmarco/src/qq/qobject/json-pa=
rser.c:569
    #7 0x555ab6715123 in parse_pair /home/elmarco/src/qq/qobject/json-par=
ser.c:306
    #8 0x555ab6715483 in parse_object /home/elmarco/src/qq/qobject/json-p=
arser.c:357
    #9 0x555ab671798b in parse_value /home/elmarco/src/qq/qobject/json-pa=
rser.c:561
    #10 0x555ab6717a6b in json_parser_parse_err /home/elmarco/src/qq/qobj=
ect/json-parser.c:592
    #11 0x555ab4fd4dcf in handle_qmp_command /home/elmarco/src/qq/monitor=
.c:4257
    #12 0x555ab6712c4d in json_message_process_token /home/elmarco/src/qq=
/qobject/json-streamer.c:105
    #13 0x555ab67e01e2 in json_lexer_feed_char /home/elmarco/src/qq/qobje=
ct/json-lexer.c:323
    #14 0x555ab67e0af6 in json_lexer_feed /home/elmarco/src/qq/qobject/js=
on-lexer.c:373
    #15 0x555ab6713010 in json_message_parser_feed /home/elmarco/src/qq/q=
object/json-streamer.c:124
    #16 0x555ab4fd58ec in monitor_qmp_read /home/elmarco/src/qq/monitor.c=
:4337
    #17 0x555ab6559df2 in qemu_chr_be_write_impl /home/elmarco/src/qq/cha=
rdev/char.c:175
    #18 0x555ab6559e95 in qemu_chr_be_write /home/elmarco/src/qq/chardev/=
char.c:187
    #19 0x555ab6560127 in fd_chr_read /home/elmarco/src/qq/chardev/char-f=
d.c:66
    #20 0x555ab65d9c73 in qio_channel_fd_source_dispatch /home/elmarco/sr=
c/qq/io/channel-watch.c:84
    #21 0x7f8e26a598ac in g_main_context_dispatch (/lib64/libglib-2.0.so.=
0+0x4c8ac)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor.c b/monitor.c
index 77861e96af..a1999e396c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4277,6 +4277,8 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
                                           ?: "");
         monitor_qmp_dispatch(mon, req, id);
+        qobject_unref(req);
+        qobject_unref(id);
         return;
     }
=20
--=20
2.18.0.547.g1d89318c48
