Received: from eggs.gnu.org ([2001:4830:134:3::10]:45416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6j-0001Ym-3U
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6e-0006sp-Rj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6e-0006sJ-Mb
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:40 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8FC93D948
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SJ6dt9020651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:06:40 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:19 +0100
Message-Id: <1488308796-28832-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/26] qapi: Improve a QObject input visitor
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The QObject input visitor has three error message formats:

* Parameter '%s' is missing
* "Invalid parameter type for '%s', expected: %s"
* "QMP input object member '%s' is unexpected"

The '%s' are member names (or "null", but I'll fix that later).

The last error message calls the thing "QMP input object member"
instead of "parameter".  Misleading when the visitor is used on
QObjects that don't come from QMP.  Change it to "Parameter '%s' is
unexpected".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-10-git-send-email-armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 3 +--
 tests/test-qga.c             | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index ed6c24c..f3b6713 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -140,8 +140,7 @@ static void qobject_input_check_struct(Visitor *v, Error **errp)
 
             g_hash_table_iter_init(&iter, top_ht);
             if (g_hash_table_iter_next(&iter, (void **)&key, NULL)) {
-                error_setg(errp, "QMP input object member '%s' is unexpected",
-                           key);
+                error_setg(errp, "Parameter '%s' is unexpected", key);
             }
         }
     }
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 868b02a..ae97b57 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -213,7 +213,7 @@ static void test_qga_invalid_args(gconstpointer fix)
     desc = qdict_get_try_str(error, "desc");
 
     g_assert_cmpstr(class, ==, "GenericError");
-    g_assert_cmpstr(desc, ==, "QMP input object member 'foo' is unexpected");
+    g_assert_cmpstr(desc, ==, "Parameter 'foo' is unexpected");
 
     QDECREF(ret);
 }
-- 
2.7.4
