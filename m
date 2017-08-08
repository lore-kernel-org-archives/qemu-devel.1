Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBRf-0007rP-9i
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBRe-0007zu-7g
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfBRe-0007zC-1l
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0363CC058EBF
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:45 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Tue,  8 Aug 2017 22:38:59 +0200
Message-Id: <20170808203900.7661-5-jfreimann@redhat.com>
In-Reply-To: <20170808203900.7661-1-jfreimann@redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] libqtest: always set up signal handler
 for SIGABRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

Currently abort handlers only work for the first test function
in a testcase, because the list of abort handlers is not properly
cleared when qtest_quit() is called.

qtest_quit() only deletes the kill_qemu_hook but doesn't completely
clear the abrt_hooks list.  The effect is that abrt_hooks.is_setup is
never set to false and in a following test the abrt_hooks list is not
initialized and setup_sigabrt_handler() is not called.

One way to solve this is to clear the list in qtest_quit(), but
that means only asserts between qtest_start and qtest_quit will
be catched by the abort handler.

We can make abort handlers work in all cases if we always setup the
signal handler for SIGABRT in qtest_init.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 tests/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4a5492a603..b9a1f180e1 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -140,8 +140,8 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data)
     /* Only install SIGABRT handler once */
     if (!abrt_hooks.is_setup) {
         g_hook_list_init(&abrt_hooks, sizeof(GHook));
-        setup_sigabrt_handler();
     }
+    setup_sigabrt_handler();
 
     hook = g_hook_alloc(&abrt_hooks);
     hook->func = fn;
-- 
2.13.3
