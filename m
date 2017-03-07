Received: from eggs.gnu.org ([2001:4830:134:3::10]:44538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QO-0001ZX-5e
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QM-0006Cj-Rt
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9QM-0006C2-L0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6FDB83F45
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 07:20:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v277Khnq016483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 02:20:45 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 08:20:28 +0100
Message-Id: <1488871237-12332-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488871237-12332-1-git-send-email-armbru@redhat.com>
References: <1488871237-12332-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 15/24] test-visitor-serialization: Pass
 &error_abort to qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qmp_deserialize() calls qobject_from_json() ignoring errors.  It
passes the result to qobject_input_visitor_new(), which asserts it's
not null.  Therefore, we can just as well pass &error_abort to
qobject_from_json().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-16-git-send-email-armbru@redhat.com>
---
 tests/test-visitor-serialization.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-serialization.c
index 37dff41..4d47cee 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -1037,7 +1037,7 @@ static void qmp_deserialize(void **native_out, void *datap,
     visit_complete(d->qov, &d->obj);
     obj_orig = d->obj;
     output_json = qobject_to_json(obj_orig);
-    obj = qobject_from_json(qstring_get_str(output_json), NULL);
+    obj = qobject_from_json(qstring_get_str(output_json), &error_abort);
 
     QDECREF(output_json);
     d->qiv = qobject_input_visitor_new(obj);
-- 
2.7.4
