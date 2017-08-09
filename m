Received: from eggs.gnu.org ([2001:4830:134:3::10]:60139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG9O-0003Ib-Az
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG9L-0006Ax-1T
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfG9K-0006Ac-QX
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:51:06 -0400
Date: Wed, 9 Aug 2017 04:50:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502241852-6302-6-git-send-email-mst@redhat.com>
References: <1502241852-6302-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502241852-6302-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] libqtest: always set up signal handler for
 SIGABRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jens Freimann <jfreimann@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Jens Freimann <jfreimann@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4a5492a..b9a1f18 100644
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
MST
