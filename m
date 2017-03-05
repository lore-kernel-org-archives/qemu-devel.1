Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReC-0000P4-EX
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe9-0002zf-Cj
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe8-0002yf-Tc
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1758C8123A
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4AE15A81
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:58 +0100
Message-Id: <1488702958-24336-28-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 27/27] qapi: Improve qobject visitor
 documentation
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
Message-Id: <1488544368-30622-29-git-send-email-armbru@redhat.com>
---
 include/qapi/qobject-input-visitor.h  | 37 ++++++++++++++++++++++++++++++++++-
 include/qapi/qobject-output-visitor.h | 35 +++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index 21db9c4..0b7633a 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -1,6 +1,7 @@
 /*
  * Input Visitor
  *
+ * Copyright (C) 2017 Red Hat, Inc.
  * Copyright IBM, Corp. 2011
  *
  * Authors:
@@ -20,7 +21,41 @@
 typedef struct QObjectInputVisitor QObjectInputVisitor;
 
 /*
- * Return a new input visitor that converts a QObject to a QAPI object.
+ * Create a QObject input visitor for @obj
+ *
+ * A QObject input visitor visit builds a QAPI object from a QObject.
+ * This simultaneously walks the QAPI object being built and the
+ * QObject.  The latter walk starts at @obj.
+ *
+ * visit_type_FOO() creates an instance of QAPI type FOO.  The visited
+ * QObject must match FOO.  QDict matches struct/union types, QList
+ * matches list types, QString matches type 'str' and enumeration
+ * types, QInt matches integer types, QFloat matches type 'number',
+ * QBool matches type 'bool'.  Type 'any' is matched by QObject.  A
+ * QAPI alternate type is matched when one of its member types is.
+ *
+ * visit_start_struct() ... visit_end_struct() visits a QDict and
+ * creates a QAPI struct/union.  Visits in between visit the
+ * dictionary members.  visit_optional() is true when the QDict has
+ * this member.  visit_check_struct() fails if unvisited members
+ * remain.
+ *
+ * visit_start_list() ... visit_end_list() visits a QList and creates
+ * a QAPI list.  Visits in between visit list members, one after the
+ * other.  visit_next_list() returns NULL when all QList members have
+ * been visited.  visit_check_list() fails if unvisited members
+ * remain.
+ *
+ * visit_start_alternate() ... visit_end_alternate() visits a QObject
+ * and creates a QAPI alternate.  The visit in between visits the same
+ * QObject and initializes the alternate member that is in use.
+ *
+ * Error messages refer to parts of @obj in JavaScript/Python syntax.
+ * For example, 'a.b[2]' refers to the second member of the QList
+ * member 'b' of the QDict member 'a' of QDict @obj.
+ *
+ * The caller is responsible for freeing the visitor with
+ * visit_free().
  */
 Visitor *qobject_input_visitor_new(QObject *obj);
 
diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject-output-visitor.h
index 8241877..9b990c3 100644
--- a/include/qapi/qobject-output-visitor.h
+++ b/include/qapi/qobject-output-visitor.h
@@ -19,11 +19,38 @@
 
 typedef struct QObjectOutputVisitor QObjectOutputVisitor;
 
-/*
- * Create a new QObject output visitor.
+/**
+ * Create a QObject output visitor for @obj
  *
- * If everything else succeeds, pass @result to visit_complete() to
- * collect the result of the visit.
+ * A QObject output visitor visit builds a QObject from QAPI Object.
+ * This simultaneously walks the QAPI object and the QObject being
+ * built.  The latter walk starts at @obj.
+ *
+ * visit_type_FOO() creates a QObject for QAPI type FOO.  It creates a
+ * QDict for struct/union types, a QList for list types, QString for
+ * type 'str' and enumeration types, QInt for integer types, QFloat
+ * for type 'number', QBool for type 'bool'.  For type 'any', it
+ * increments the QObject's reference count.  For QAPI alternate
+ * types, it creates the QObject for the member that is in use.
+ *
+ * visit_start_struct() ... visit_end_struct() visits a QAPI
+ * struct/union and creates a QDict.  Visits in between visit the
+ * members.  visit_optional() is true when the struct/union has this
+ * member.  visit_check_struct() does nothing.
+ *
+ * visit_start_list() ... visit_end_list() visits a QAPI list and
+ * creates a QList.  Visits in between visit list members, one after
+ * the other.  visit_next_list() returns NULL when all QAPI list
+ * members have been visited.  visit_check_list() does nothing.
+ *
+ * visit_start_alternate() ... visit_end_alternate() visits a QAPI
+ * alternate.  The visit in between creates the QObject for the
+ * alternate member that is in use.
+ *
+ * Errors are not expected to happen.
+ *
+ * The caller is responsible for freeing the visitor with
+ * visit_free().
  */
 Visitor *qobject_output_visitor_new(QObject **result);
 
-- 
2.7.4
