Received: from eggs.gnu.org ([2001:4830:134:3::10]:33079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyy-00014r-2s
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyw-0006rW-Bt
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZbyw-0006r9-5b
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1591580F9C
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-94.ams2.redhat.com
	[10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C7061B95
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Jul 2017 13:56:53 +0200
Message-Id: <1500897419-15539-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1500897419-15539-1-git-send-email-armbru@redhat.com>
References: <1500897419-15539-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/10] tests/test-qobject-input-visitor: Drop
 redundant test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

test_visitor_in_alternate() tests UserDefAlternate with inadmissible
input.  test_visitor_in_fail_alternate() does basically the same.
Drop the former, keep the latter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-qobject-input-visitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index f451844..bcf0261 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -567,7 +567,6 @@ static void test_visitor_in_alternate(TestInputVisitorData *data,
                                       const void *unused)
 {
     Visitor *v;
-    Error *err = NULL;
     UserDefAlternate *tmp;
     WrapAlternate *wrap;
 
@@ -599,11 +598,6 @@ static void test_visitor_in_alternate(TestInputVisitorData *data,
     g_assert_cmpint(tmp->u.udfu.u.value1.has_a_b, ==, false);
     qapi_free_UserDefAlternate(tmp);
 
-    v = visitor_input_test_init(data, "false");
-    visit_type_UserDefAlternate(v, NULL, &tmp, &err);
-    error_free_or_abort(&err);
-    qapi_free_UserDefAlternate(tmp);
-
     v = visitor_input_test_init(data, "{ 'alt': 42 }");
     visit_type_WrapAlternate(v, NULL, &wrap, &error_abort);
     g_assert_cmpint(wrap->alt->type, ==, QTYPE_QNUM);
-- 
2.7.5
