Received: from eggs.gnu.org ([2001:4830:134:3::10]:38147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNy-0006up-2Z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNx-0000zB-5L
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSNw-0000yp-Vw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C0C0C0A5253
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:20:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:49 -0500
Message-Id: <20170911172022.4738-6-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 05/38] libqtest: Remove dead qtest_instances
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
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com

Prior to commit 063c23d9, we were tracking a list of parallel
qtest objects, in order to safely clean up a SIGABRT handler
only after the last connection quits.  But when we switched to
more of glib's infrastructure, the list became dead code that
is never assigned to.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index b9a1f180e1..3f956f09fc 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -42,7 +42,6 @@ struct QTestState
 };

 static GHookList abrt_hooks;
-static GList *qtest_instances;
 static struct sigaction sigact_old;

 #define g_assert_no_errno(ret) do { \
@@ -240,13 +239,10 @@ QTestState *qtest_init(const char *extra_args)

 void qtest_quit(QTestState *s)
 {
-    qtest_instances =3D g_list_remove(qtest_instances, s);
     g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE,=
 s));

     /* Uninstall SIGABRT handler on last instance */
-    if (!qtest_instances) {
-        cleanup_sigabrt_handler();
-    }
+    cleanup_sigabrt_handler();

     kill_qemu(s);
     close(s->fd);
--=20
2.13.5
