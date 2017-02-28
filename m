Received: from eggs.gnu.org ([2001:4830:134:3::10]:36028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIn-0007Ry-AK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIl-0000tL-4a
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:21 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:26:56 +0100
Message-Id: <1488317230-26248-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/24] qjson: Abort earlier on
 qobject_from_jsonf() misuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Ignoring errors first, then asserting success is suboptimal.  Pass
&error_abort instead, so we abort earlier, and hopefully get more
useful clues on what's wrong.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qobject/qjson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index 339c9f7..c98d6a7 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -65,7 +65,7 @@ QObject *qobject_from_jsonf(const char *string, ...)
     va_list ap;
 
     va_start(ap, string);
-    obj = qobject_from_jsonv(string, &ap, NULL);
+    obj = qobject_from_jsonv(string, &ap, &error_abort);
     va_end(ap);
 
     assert(obj != NULL);
-- 
2.7.4
