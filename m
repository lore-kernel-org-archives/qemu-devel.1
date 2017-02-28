Received: from eggs.gnu.org ([2001:4830:134:3::10]:45419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6j-0001Yp-3X
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6g-0006ul-Fa
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6g-0006u5-8i
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E5CC81F01
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SJ6fkS028186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:06:42 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:25 +0100
Message-Id: <1488308796-28832-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/26] qom: Make object_property_set_qobject()'s
 input visitor strict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 240f64b made all qobject input visitors created outside tests
strict, except for the one in object_property_set_qobject().  That one
was left behind only because Eric couldn't spare the time to figure
out whether making it strict would break anything, with a TODO
comment.  Time to resolve it.

Strict makes a difference only for otherwise successful visits of QAPI
structs or unions.  Let's examine what the callers of
object_property_set_qobject() visit:

* object_property_set_str(), object_property_set_bool(),
  object_property_set_int() visit a QString, QBool, QInt,
  respectively.  Strictness can't matter.

* qmp_qom_set visits its @value argument.  Comes straight from QMP and
  can be anything ('any' in the QAPI schema).  Strictness matters when
  the property's set() method visits a struct or union QAPI type.

  No such methods exist, thus switching to strict can't break
  anything.

  If we acquire such methods in the future, we'll *want* the visitor
  to be strict, so that unexpected members get rejected as they should
  be.

Switch to strict.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-16-git-send-email-armbru@redhat.com>
---
 qom/qom-qobject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index 447e4a0..bbdedda 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -22,8 +22,8 @@ void object_property_set_qobject(Object *obj, QObject *value,
                                  const char *name, Error **errp)
 {
     Visitor *v;
-    /* TODO: Should we reject, rather than ignore, excess input? */
-    v = qobject_input_visitor_new(value, false);
+
+    v = qobject_input_visitor_new(value, true);
     object_property_set(obj, v, name, errp);
     visit_free(v);
 }
-- 
2.7.4
