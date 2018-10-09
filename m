Received: from eggs.gnu.org ([2001:4830:134:3::10]:34907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9lUh-0000Fp-3R
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9lUd-0006gu-Tt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9lUd-0006gA-LF
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E9033084219
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 06:27:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 Oct 2018 14:27:15 +0800
Message-Id: <20181009062718.1914-4-peterx@redhat.com>
In-Reply-To: <20181009062718.1914-1-peterx@redhat.com>
References: <20181009062718.1914-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 3/6] monitor: remove "x-oob",
 turn oob on by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

OOB commands were introduced in commit cf869d53172.  Unfortunately, we
ran into a regression, and had to disable them by default for 2.12
(commit be933ffc23).

  http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

The regression has since been fixed (commit 951702f39c7 "monitor: bind
dispatch bh to iohandler context").  Time to re-enable OOB.

This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
and turns it on again for non-MUX QMPs.  Note that we can't enable
Out-Of-Band for monitors with MUX-typed chardev backends, because not
all the chardev frontends can run without main thread, or can run in
multiple threads.

Some trivial touch-up in the test code is required to make sure qmp-test
won't break.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/monitor.h |  1 -
 monitor.c                 | 22 ++++++----------------
 tests/libqtest.c          |  2 +-
 tests/qmp-test.c          |  2 +-
 vl.c                      |  5 -----
 5 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 0c0a37d8cb..c1b40a9cac 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,7 +13,6 @@ extern __thread Monitor *cur_mon;
 #define MONITOR_USE_READLINE  0x02
 #define MONITOR_USE_CONTROL   0x04
 #define MONITOR_USE_PRETTY    0x08
-#define MONITOR_USE_OOB       0x10
=20
 #define QMP_REQ_QUEUE_LEN_MAX 8
=20
diff --git a/monitor.c b/monitor.c
index f5911399d8..65a5e5f41a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4545,19 +4545,12 @@ void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
     bool use_readline =3D flags & MONITOR_USE_READLINE;
-    bool use_oob =3D flags & MONITOR_USE_OOB;
-
-    if (use_oob) {
-        if (CHARDEV_IS_MUX(chr)) {
-            error_report("Monitor out-of-band is not supported with "
-                         "MUX typed chardev backend");
-            exit(1);
-        }
-        if (use_readline) {
-            error_report("Monitor out-of-band is only supported by QMP")=
;
-            exit(1);
-        }
-    }
+    /*
+     * Note: we can't enable Out-Of-Band for monitors with MUX-typed
+     * chardev backends, because not all the chardev frontends can run
+     * without main thread, or can run in multiple threads.
+     */
+    bool use_oob =3D (flags & MONITOR_USE_CONTROL) && !CHARDEV_IS_MUX(ch=
r);
=20
     monitor_data_init(mon, false, use_oob);
=20
@@ -4647,9 +4640,6 @@ QemuOptsList qemu_mon_opts =3D {
         },{
             .name =3D "pretty",
             .type =3D QEMU_OPT_BOOL,
-        },{
-            .name =3D "x-oob",
-            .type =3D QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2cd5736642..8bf9fd1ae3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -231,7 +231,7 @@ QTestState *qtest_init_without_qmp_handshake(bool use=
_oob,
                                   "-display none "
                                   "%s", qemu_binary, socket_path,
                                   getenv("QTEST_LOG") ? "/dev/fd/2" : "/=
dev/null",
-                                  qmp_socket_path, use_oob ? ",x-oob=3Do=
n" : "",
+                                  qmp_socket_path, "",
                                   extra_args ?: "");
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 6c419f6023..030d813f77 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -116,7 +116,7 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities =3D qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities && qlist_empty(capabilities));
+    g_assert(capabilities);
     qobject_unref(resp);
=20
     /* Test valid command before handshake */
diff --git a/vl.c b/vl.c
index 4e25c78bff..db766f5295 100644
--- a/vl.c
+++ b/vl.c
@@ -2282,11 +2282,6 @@ static int mon_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
     if (qemu_opt_get_bool(opts, "pretty", 0))
         flags |=3D MONITOR_USE_PRETTY;
=20
-    /* OOB is off by default */
-    if (qemu_opt_get_bool(opts, "x-oob", 0)) {
-        flags |=3D MONITOR_USE_OOB;
-    }
-
     chardev =3D qemu_opt_get(opts, "chardev");
     chr =3D qemu_chr_find(chardev);
     if (chr =3D=3D NULL) {
--=20
2.17.1
