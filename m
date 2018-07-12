Received: from eggs.gnu.org ([2001:4830:134:3::10]:47841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWN-000778-KV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWL-0006ol-4k
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWK-0006ny-S1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 882E0406DE36
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:10 +0200
Message-Id: <20180712111221.20326-10-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 09/20] qobject: qobject_from_jsonv() is
 dangerous, hide it away
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_from_jsonv() takes ownership of %p arguments.  On failure, we
can't generally know whether we failed before or after %p, so
ownership becomes indeterminate.  To avoid leaks, callers passing %p
must terminate on error, e.g. by passing &error_abort.  Trap for the
unwary; document and give the function internal linkage.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qjson.h |  2 --
 qobject/qjson.c          | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index 0db121bef9..4a225cf7d1 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -15,8 +15,6 @@
 #define QJSON_H
 
 QObject *qobject_from_json(const char *string, Error **errp);
-QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
-    GCC_FMT_ATTR(1, 0);
 
 QObject *qobject_from_vjsonf_nofail(const char *string, va_list)
     GCC_FMT_ATTR(1, 0);
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 2e450231ff..ab4040f235 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -39,7 +39,18 @@ static void parse_json(JSONMessageParser *parser, GQueue *tokens)
     s->result = json_parser_parse_err(tokens, s->ap, &s->err);
 }
 
-QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
+/*
+ * Parse @string as JSON value.
+ * If @ap is non-null, interpolate %-escapes.
+ * Takes ownership of %p arguments.
+ * On success, return the JSON value.
+ * On failure, store an error through @errp and return NULL.
+ * Ownership of %p arguments becomes indeterminate then.  To avoid
+ * leaks, callers passing %p must terminate on error, e.g. by passing
+ * &error_abort.
+ */
+static QObject *qobject_from_jsonv(const char *string, va_list *ap,
+                                   Error **errp)
 {
     JSONParsingState state = {};
 
-- 
2.17.1
