Received: from eggs.gnu.org ([2001:4830:134:3::10]:54825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslac-00081U-8J
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaW-0000lz-Ap
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaW-0000ls-5J
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:28 +0200
Message-Id: <1505462549-27298-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] libqtest: Remove dead qtest_instances
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

From: Eric Blake <eblake@redhat.com>

Prior to commit 063c23d9, we were tracking a list of parallel
qtest objects, in order to safely clean up a SIGABRT handler
only after the last connection quits.  But when we switched to
more of glib's infrastructure, the list became dead code that
is never assigned to.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3daa0e3..cbd7094 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -42,7 +42,6 @@ struct QTestState
 };
=20
 static GHookList abrt_hooks;
-static GList *qtest_instances;
 static struct sigaction sigact_old;
=20
 #define g_assert_no_errno(ret) do { \
@@ -247,13 +246,10 @@ QTestState *qtest_init(const char *extra_args)
=20
 void qtest_quit(QTestState *s)
 {
-    qtest_instances =3D g_list_remove(qtest_instances, s);
     g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE,=
 s));
=20
     /* Uninstall SIGABRT handler on last instance */
-    if (!qtest_instances) {
-        cleanup_sigabrt_handler();
-    }
+    cleanup_sigabrt_handler();
=20
     kill_qemu(s);
     close(s->fd);
--=20
1.8.3.1
