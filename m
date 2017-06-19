Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8d-000315-HY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8c-0004a6-MR
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw8c-0004Y3-CO
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51039C074542
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:40 +0800
Message-Id: <1497876588-947-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/13] tests: avoid check GlobalProperty.used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

After previous patch to let qdev_prop_register_global_list() use
register_compat_prop(), then caller won't be guaranteed that the
GlobalProperty pointer passed in will be the one linked to global_props
list (now we always alloc new GlobalProperty for it). So prop->used will
never be set.

Let's avoid checking this in test codes to make the test pass.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/test-qdev-global-props.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 48e5b73..599bb13 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -218,12 +218,6 @@ static void test_dynamic_globalprop_subprocess(void)
     g_assert_cmpuint(mt->prop2, ==, 102);
     all_used = qdev_prop_check_globals();
     g_assert_cmpuint(all_used, ==, 1);
-    g_assert(props[0].used);
-    g_assert(props[1].used);
-    g_assert(!props[2].used);
-    g_assert(!props[3].used);
-    g_assert(!props[4].used);
-    g_assert(!props[5].used);
 }
 
 static void test_dynamic_globalprop(void)
@@ -263,12 +257,6 @@ static void test_dynamic_globalprop_nouser_subprocess(void)
     g_assert_cmpuint(mt->prop2, ==, 102);
     all_used = qdev_prop_check_globals();
     g_assert_cmpuint(all_used, ==, 0);
-    g_assert(props[0].used);
-    g_assert(props[1].used);
-    g_assert(!props[2].used);
-    g_assert(!props[3].used);
-    g_assert(!props[4].used);
-    g_assert(!props[5].used);
 }
 
 static void test_dynamic_globalprop_nouser(void)
-- 
2.7.4
