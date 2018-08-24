Received: from eggs.gnu.org ([2001:4830:134:3::10]:33209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoi-0002Hm-DE
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001fD-Dv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001Zi-4q
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4220A804B9F4
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DAA8A9F0C
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:38 +0200
Message-Id: <20180824193206.25475-31-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 30/58] check-qjson: Fix and enable
 utf8_string()'s disabled part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-31-armbru@redhat.com>
---
 tests/check-qjson.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 343f8af36a..defc21fa04 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -776,15 +776,10 @@ static void utf8_string(void)
             qobject_unref(str);
             g_free(jstr);
 
-            /*
-             * Parse @json_out right back
-             * Disabled, because qobject_from_json() is buggy, and I can't
-             * be bothered to add the expected incorrect results.
-             * FIXME Enable once these bugs have been fixed.
-             */
-            if (0 && json_out != json_in) {
+            /* Parse @json_out right back, unless it has replacements */
+            if (!strstr(json_out, "\\uFFFD")) {
                 str = from_json_str(json_out, j, &error_abort);
-                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_out);
+                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_in);
             }
         }
     }
-- 
2.17.1
