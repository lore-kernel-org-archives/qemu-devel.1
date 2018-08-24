Received: from eggs.gnu.org ([2001:4830:134:3::10]:33249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoj-0002Ie-8P
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001gx-OZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoe-0001br-5v
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2847C40241DC
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 059402026E1A
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:31 +0200
Message-Id: <20180824193206.25475-24-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 23/58] json: Report first rather than last parse
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Quiz time!  When a parser reports multiple errors, but the user gets
to see just one, which one is (on average) the least useful one?

Yes, you're right, it's the last one!  You're clearly familiar with
compilers.

Which one does QEMU report?

Right again, the last one!  You're clearly familiar with QEMU.

Reproducer: feeding

    {"abc\xC2ijk": 1}\n

to QMP produces

    {"error": {"class": "GenericError", "desc": "JSON parse error, key is not a string in object"}}

Report the first error instead.  The reproducer now produces

    {"error": {"class": "GenericError", "desc": "JSON parse error, invalid UTF-8 sequence in string"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-24-armbru@redhat.com>
---
 qobject/json-parser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 0e232ff101..b77931614b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -54,13 +54,13 @@ static void GCC_FMT_ATTR(3, 4) parse_error(JSONParserContext *ctxt,
 {
     va_list ap;
     char message[1024];
+
+    if (ctxt->err) {
+        return;
+    }
     va_start(ap, msg);
     vsnprintf(message, sizeof(message), msg, ap);
     va_end(ap);
-    if (ctxt->err) {
-        error_free(ctxt->err);
-        ctxt->err = NULL;
-    }
     error_setg(&ctxt->err, "JSON parse error, %s", message);
 }
 
-- 
2.17.1
