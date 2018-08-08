Received: from eggs.gnu.org ([2001:4830:134:3::10]:52745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBv-0006p4-N6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-00007Z-GI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBl-000052-19
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:07 +0200
Message-Id: <20180808120334.10970-30-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 29/56] check-qjson: Fix and enable
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 3d3a3f105f..c8c0ad95a6 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -750,15 +750,10 @@ static void utf8_string(void)
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
                 str = from_json_str(json_out, &error_abort, j);
-                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_out);
+                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_in);
             }
         }
     }
-- 
2.17.1
