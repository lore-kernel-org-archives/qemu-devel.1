Received: from eggs.gnu.org ([2001:4830:134:3::10]:46606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKX-0003Jk-Jl
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001o8-AN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001j5-Kg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:28 +0200
Message-Id: <20180817150559.16243-30-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 29/60] check-qjson: Fix and enable
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 3be32f3fcb..b0efddebd2 100644
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
                 str = from_json_str(json_out, &error_abort, j);
-                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_out);
+                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_in);
             }
         }
     }
-- 
2.17.1
