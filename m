Received: from eggs.gnu.org ([2001:4830:134:3::10]:45415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6j-0001Yl-3V
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6e-0006tD-W4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6e-0006sQ-RC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:40 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1862D4E4F3
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D9F2F2D655
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:23 +0100
Message-Id: <1488308796-28832-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/26] qapi: Drop string input visitor method
 optional()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

visit_optional() is to be called only between visit_start_struct() and
visit_end_struct().  Visitors that don't support struct visits,
i.e. don't implement start_struct(), end_struct(), have no use for it.
Clarify documentation.

The string input visitor doesn't support struct visits.  Its
parse_optional() is therefore useless.  Drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-14-git-send-email-armbru@redhat.com>
---
 include/qapi/visitor-impl.h |  4 ++--
 qapi/string-input-visitor.c | 13 -------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 8bd47ee..962ba1d 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -102,8 +102,8 @@ struct Visitor
     /* Must be set to visit explicit null values.  */
     void (*type_null)(Visitor *v, const char *name, Error **errp);
 
-    /* Must be set for input visitors, optional otherwise.  The core
-     * takes care of the return type in the public interface. */
+    /* Must be set for input visitors to visit structs, optional otherwise.
+       The core takes care of the return type in the public interface. */
     void (*optional)(Visitor *v, const char *name, bool *present);
 
     /* Must be set */
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 8dfa561..1a855c5 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -314,18 +314,6 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     *obj = val;
 }
 
-static void parse_optional(Visitor *v, const char *name, bool *present)
-{
-    StringInputVisitor *siv = to_siv(v);
-
-    if (!siv->string) {
-        *present = false;
-        return;
-    }
-
-    *present = true;
-}
-
 static void string_input_free(Visitor *v)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -351,7 +339,6 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
     v->visitor.end_list = end_list;
-    v->visitor.optional = parse_optional;
     v->visitor.free = string_input_free;
 
     v->string = str;
-- 
2.7.4
