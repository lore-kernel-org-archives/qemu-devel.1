Received: from eggs.gnu.org ([208.118.235.92]:47170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1geh9c-0006LZ-0X
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1geh9Z-0001A9-1Q
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:05:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1geh9U-00015F-4F
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:05:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BCAAC06512E
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 14:05:39 +0000 (UTC)
Received: from natto.ory.fergeau.eu (unknown [10.41.1.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F1DEE1019632
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 14:05:38 +0000 (UTC)
From: Christophe Fergeau <cfergeau@redhat.com>
Date: Wed,  2 Jan 2019 15:05:35 +0100
Message-Id: <20190102140535.11512-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

commit 8bca4613 added support for %% in json strings when interpolating,
but in doing so, this broke handling of % when not interpolating as the
'%' is skipped in both cases.
This commit ensures we only try to handle %% when interpolating.

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
---
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7a7ae9e8d1..d8eb210c0c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -208,11 +208,13 @@ static QString *parse_string(JSONParserContext *ctx=
t, JSONToken *token)
             }
             break;
         case '%':
-            if (ctxt->ap && ptr[1] !=3D '%') {
-                parse_error(ctxt, token, "can't interpolate into string"=
);
-                goto out;
+            if (ctxt->ap) {
+                if (ptr[1] !=3D '%') {
+                    parse_error(ctxt, token, "can't interpolate into str=
ing");
+                    goto out;
+                }
+                ptr++;
             }
-            ptr++;
             /* fall through */
         default:
             cp =3D mod_utf8_codepoint(ptr, 6, &end);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index d876a7a96e..fa2afccb0a 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -175,6 +175,11 @@ static void utf8_string(void)
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
             "\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5",
+        },
+            /* '%' character when not interpolating */
+        {
+            "100%",
+            "100%",
         },
         /* 2  Boundary condition test cases */
         /* 2.1  First possible sequence of a certain length */
--=20
2.20.1
