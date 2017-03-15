Received: from eggs.gnu.org ([2001:4830:134:3::10]:43040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8og-0002gH-KN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8od-0005HF-1b
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8oc-0005Gm-RV
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:18:10 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6D26635CB
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:18:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v2FDI9UV021998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 09:18:10 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 14:18:06 +0100
Message-Id: <1489583887-14126-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1489583887-14126-1-git-send-email-armbru@redhat.com>
References: <1489583887-14126-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] tests: Use error_free_or_abort() where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Done with this Coccinelle semantic patch:

    @@
    expression E;
    @@
    -    g_assert(E);
    -    error_free(E);
    +    error_free_or_abort(&E);

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487362554-5688-1-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-qemu-opts.c              | 3 +--
 tests/test-qobject-output-visitor.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index f6310b3..0ad74b4 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -93,8 +93,7 @@ static void test_find_unknown_opts(void)
     /* should not return anything, we don't have an "unknown" option */
     list = qemu_find_opts_err("unknown", &err);
     g_assert(list == NULL);
-    g_assert(err);
-    error_free(err);
+    error_free_or_abort(&err);
 }
 
 static void test_qemu_find_opts(void)
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 500b452..c213fce 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -145,8 +145,7 @@ static void test_visitor_out_enum_errors(TestOutputVisitorData *data,
     for (i = 0; i < ARRAY_SIZE(bad_values) ; i++) {
         err = NULL;
         visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
-        g_assert(err);
-        error_free(err);
+        error_free_or_abort(&err);
         visitor_reset(data);
     }
 }
@@ -244,8 +243,7 @@ static void test_visitor_out_struct_errors(TestOutputVisitorData *data,
         u.has_enum1 = true;
         u.enum1 = bad_values[i];
         visit_type_UserDefOne(data->ov, "unused", &pu, &err);
-        g_assert(err);
-        error_free(err);
+        error_free_or_abort(&err);
         visitor_reset(data);
     }
 }
-- 
2.7.4
