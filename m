Received: from eggs.gnu.org ([2001:4830:134:3::10]:58767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g7NVv-0001WM-H9
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g7NVn-0000Gx-S5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:27:09 -0400
Received: from m12-16.163.com ([220.181.12.16]:44467)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g7NVl-0000E1-JU
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:27:02 -0400
From: Li Qiang <liq3ea@163.com>
Date: Tue,  2 Oct 2018 09:26:52 -0700
Message-Id: <20181002162652.19377-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] tests: check-qjson: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Spotted by ASAN.

=================================================================
==17531==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 1120 byte(s) in 28 object(s) allocated from:
    #0 0x7f9fb85eeb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
    #1 0x7f9fb824b8d8 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x518d8)
    #2 0x5654ae94f073 in qstring_from_str qobject/qstring.c:66
    #3 0x5654ae94ede7 in qstring_new qobject/qstring.c:23
    #4 0x5654ae953b6b in parse_string qobject/json-parser.c:143
    #5 0x5654ae955e3e in parse_literal qobject/json-parser.c:484
    #6 0x5654ae956227 in parse_value qobject/json-parser.c:547
    #7 0x5654ae9565c7 in json_parser_parse qobject/json-parser.c:573
    #8 0x5654ae952d5d in json_message_process_token qobject/json-streamer.c:92
    #9 0x5654ae9608fa in json_lexer_feed_char qobject/json-lexer.c:313
    #10 0x5654ae960ea5 in json_lexer_feed qobject/json-lexer.c:350
    #11 0x5654ae9530de in json_message_parser_feed qobject/json-streamer.c:121
    #12 0x5654ae950b6e in qobject_from_jsonv qobject/qjson.c:69
    #13 0x5654ae950d30 in qobject_from_json qobject/qjson.c:83
    #14 0x5654ae9449af in from_json_str tests/check-qjson.c:30
    #15 0x5654ae946399 in utf8_string tests/check-qjson.c:781
    #16 0x7f9fb826cc39  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72c39)

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/check-qjson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index cc13f3d41e..d876a7a96e 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -780,6 +780,7 @@ static void utf8_string(void)
             if (!strstr(json_out, "\\uFFFD")) {
                 str = from_json_str(json_out, j, &error_abort);
                 g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_in);
+                qobject_unref(str);
             }
         }
     }
-- 
2.17.1
