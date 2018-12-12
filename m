Received: from eggs.gnu.org ([2001:4830:134:3::10]:49115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uj-0000y1-Ce
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ui-0003Se-9q
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Ui-0003Ri-1h
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61E7E307EAA1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:43 +0100
Message-Id: <20181212101145.3496-10-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/11] monitor: Remove "x-oob",
 offer capability "oob" unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Out-of-band command execution was introduced in commit cf869d53172.
Unfortunately, we ran into a regression, and had to turn it into an
experimental option for 2.12 (commit be933ffc23).

  http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

The regression has since been fixed (commit 951702f39c7 "monitor: bind
dispatch bh to iohandler context").  A thorough re-review of OOB
commands led to a few more issues, which have also been addressed.

This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
and makes QMP monitors again offer capability "oob" whenever they can
provide it, i.e. when the monitor's character device is capable of
running in an I/O thread.

Some trivial touch-up in the test code is required to make sure qmp-test
won't break.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20181009062718.1914-4-peterx@redhat.com>
[Conflict with "monitor: check if chardev can switch gcontext for OOB"
resolved, commit message updated]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h |  1 -
 monitor.c                 | 23 +++++------------------
 tests/libqtest.c          |  2 +-
 tests/qmp-test.c          |  2 +-
 vl.c                      |  5 -----
 5 files changed, 7 insertions(+), 26 deletions(-)

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
index d2529260ed..6e81b09294 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4567,22 +4567,12 @@ void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
     bool use_readline =3D flags & MONITOR_USE_READLINE;
-    bool use_oob =3D flags & MONITOR_USE_OOB;
=20
-    if (use_oob) {
-        if (!qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
-            error_report("Monitor out-of-band is not supported with "
-                         "%s typed chardev backend",
-                         object_get_typename(OBJECT(chr)));
-            exit(1);
-        }
-        if (use_readline) {
-            error_report("Monitor out-of-band is only supported by QMP")=
;
-            exit(1);
-        }
-    }
-
-    monitor_data_init(mon, false, use_oob);
+    /* Note: we run QMP monitor in I/O thread when @chr supports that */
+    monitor_data_init(mon, false,
+                      (flags & MONITOR_USE_CONTROL)
+                      && qemu_chr_has_feature(chr,
+                                              QEMU_CHAR_FEATURE_GCONTEXT=
));
=20
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags =3D flags;
@@ -4677,9 +4667,6 @@ QemuOptsList qemu_mon_opts =3D {
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
index 75e07e16e7..225a123649 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -224,7 +224,7 @@ QTestState *qtest_init_without_qmp_handshake(bool use=
_oob,
                               "-display none "
                               "%s", qemu_binary, socket_path,
                               getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/=
null",
-                              qmp_socket_path, use_oob ? ",x-oob=3Don" :=
 "",
+                              qmp_socket_path, "",
                               extra_args ?: "");
=20
     g_test_message("starting QEMU: %s", command);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 7517be4654..5ba22af6a0 100644
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
index a5ae5f23d2..2a8b2ee16d 100644
--- a/vl.c
+++ b/vl.c
@@ -2322,11 +2322,6 @@ static int mon_init_func(void *opaque, QemuOpts *o=
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
     if (!chardev) {
         error_report("chardev is required");
--=20
2.17.2
