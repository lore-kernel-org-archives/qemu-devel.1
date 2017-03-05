Received: from eggs.gnu.org ([2001:4830:134:3::10]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReA-0000Oj-KY
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe7-0002xp-Co
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe7-0002wi-47
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:03 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 498AD3B713
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258a2B7022883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:03 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:45 +0100
Message-Id: <1488702958-24336-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 14/27] qapi: Drop string input visitor method
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
Message-Id: <1488544368-30622-16-git-send-email-armbru@redhat.com>
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
