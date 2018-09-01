Received: from eggs.gnu.org ([2001:4830:134:3::10]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fwDJ2-0007E6-Qv
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 17:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fwDIz-0004bD-MI
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 17:19:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fwDIz-0004ZW-HP
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 17:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4789085774
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 21:19:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  1 Sep 2018 23:19:17 +0200
Message-Id: <20180901211917.10372-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/check-qjson: fix a leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Spotted by ASAN:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D11893=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 1120 byte(s) in 28 object(s) allocated from:
    #0 0x7fd0515b0c48 in malloc (/lib64/libasan.so.5+0xeec48)
    #1 0x7fd050ffa3c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
    #2 0x559e708b56a4 in qstring_from_str /home/elmarco/src/qq/qobject/qs=
tring.c:66
    #3 0x559e708b4fe0 in qstring_new /home/elmarco/src/qq/qobject/qstring=
.c:23
    #4 0x559e708bda7d in parse_string /home/elmarco/src/qq/qobject/json-p=
arser.c:143
    #5 0x559e708c1009 in parse_literal /home/elmarco/src/qq/qobject/json-=
parser.c:484
    #6 0x559e708c1627 in parse_value /home/elmarco/src/qq/qobject/json-pa=
rser.c:547
    #7 0x559e708c1c67 in json_parser_parse /home/elmarco/src/qq/qobject/j=
son-parser.c:573
    #8 0x559e708bc0ff in json_message_process_token /home/elmarco/src/qq/=
qobject/json-streamer.c:92
    #9 0x559e708d1655 in json_lexer_feed_char /home/elmarco/src/qq/qobjec=
t/json-lexer.c:292
    #10 0x559e708d1fe1 in json_lexer_feed /home/elmarco/src/qq/qobject/js=
on-lexer.c:339
    #11 0x559e708bc856 in json_message_parser_feed /home/elmarco/src/qq/q=
object/json-streamer.c:121
    #12 0x559e708b8b4b in qobject_from_jsonv /home/elmarco/src/qq/qobject=
/qjson.c:69
    #13 0x559e708b8d02 in qobject_from_json /home/elmarco/src/qq/qobject/=
qjson.c:83
    #14 0x559e708a74ae in from_json_str /home/elmarco/src/qq/tests/check-=
qjson.c:30
    #15 0x559e708a9f83 in utf8_string /home/elmarco/src/qq/tests/check-qj=
son.c:781
    #16 0x7fd05101bc49 in test_case_run gtestutils.c:2255
    #17 0x7fd05101bc49 in g_test_run_suite_internal gtestutils.c:2339

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/check-qjson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index cc13f3d41e..d876a7a96e 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -780,6 +780,7 @@ static void utf8_string(void)
             if (!strstr(json_out, "\\uFFFD")) {
                 str =3D from_json_str(json_out, j, &error_abort);
                 g_assert_cmpstr(qstring_get_try_str(str), =3D=3D, utf8_i=
n);
+                qobject_unref(str);
             }
         }
     }
--=20
2.19.0.rc1
