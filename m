Received: from eggs.gnu.org ([2001:4830:134:3::10]:37429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bg-0004U3-Kh
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bd-0004MO-KD
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ci6bd-0004LO-Co
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:49 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80E2E3B3D2
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:43:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1QLhm3o008758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 16:43:49 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 26 Feb 2017 22:43:26 +0100
Message-Id: <1488145424-14974-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-1-git-send-email-armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/26] qmp: Improve QMP dispatch error
 messages
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
---
 qapi/qmp-dispatch.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 377ebb5..4610b6d 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
     dict = qobject_to_qdict(request);
     if (!dict) {
-        error_setg(errp, "Expected '%s' in QMP input", "object");
+        error_setg(errp, "QMP input must be a JSON object");
         return NULL;
     }
 
@@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
         if (!strcmp(arg_name, "execute")) {
             if (qobject_type(arg_obj) != QTYPE_QSTRING) {
-                error_setg(errp, "QMP input object member '%s' expects '%s'",
-                           "execute", "string");
+                error_setg(errp,
+                           "QMP input object member '%s' must be %s",
+                           "execute", "a string");
                 return NULL;
             }
             has_exec_key = true;
         } else if (!strcmp(arg_name, "arguments")) {
             if (qobject_type(arg_obj) != QTYPE_QDICT) {
-                error_setg(errp, "QMP input object member '%s' expects '%s'",
-                           "arguments", "object");
+                error_setg(errp,
+                           "QMP input object member '%s' must be %s",
+                           "arguments", "an object");
                 return NULL;
             }
         } else {
@@ -60,7 +62,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
     }
 
     if (!has_exec_key) {
-        error_setg(errp, "Expected '%s' in QMP input", "execute");
+        error_setg(errp, "QMP input object lacks key 'execute'");
         return NULL;
     }
 
-- 
2.7.4
