Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB7C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD37A2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD37A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxC6-0008NQ-3s
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwh7-0001pV-Ci
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwh5-0007wa-Co
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwh5-0007ii-3q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52730B2DFB
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF85F7D8C3;
 Mon, 17 Jun 2019 18:49:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86B831133023; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:49:02 +0200
Message-Id: <20190617184903.19436-16-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/16] monitor: Replace monitor_init() with
 monitor_init_{hmp, qmp}()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Most callers know which monitor type they want to have. Instead of
calling monitor_init() with flags that can describe both types of
monitors, make monitor_init_{hmp,qmp}() public interfaces that take
specific bools instead of flags and call these functions directly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20190613153405.24769-15-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char.c             |  2 +-
 gdbstub.c                  |  2 +-
 include/monitor/monitor.h  |  9 ++-------
 monitor/hmp.c              |  4 ++--
 monitor/monitor-internal.h |  3 ---
 monitor/monitor.c          |  9 ---------
 monitor/qmp.c              |  7 ++-----
 stubs/monitor.c            |  6 +++++-
 tests/test-util-sockets.c  |  3 ++-
 vl.c                       | 18 ++++++++++++------
 10 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index e4887bcc82..7b6b2cb123 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -731,7 +731,7 @@ Chardev *qemu_chr_new_noreplay(const char *label, con=
st char *filename,
=20
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
-        monitor_init(chr, MONITOR_USE_READLINE);
+        monitor_init_hmp(chr, true);
     }
=20
 out:
diff --git a/gdbstub.c b/gdbstub.c
index d614a1f3c0..8618e34311 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3344,7 +3344,7 @@ int gdbserver_start(const char *device)
         /* Initialize a monitor terminal for gdb */
         mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_init(mon_chr, 0);
+        monitor_init_hmp(mon_chr, false);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
         mon_chr =3D s->mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 44ac43df34..a81eeff5f8 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -8,19 +8,14 @@
 extern __thread Monitor *cur_mon;
 typedef struct MonitorHMP MonitorHMP;
=20
-/* flags for monitor_init */
-/* 0x01 unused */
-#define MONITOR_USE_READLINE  0x02
-#define MONITOR_USE_CONTROL   0x04
-#define MONITOR_USE_PRETTY    0x08
-
 #define QMP_REQ_QUEUE_LEN_MAX 8
=20
 bool monitor_cur_is_qmp(void);
=20
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_init(Chardev *chr, int flags);
+void monitor_init_qmp(Chardev *chr, bool pretty);
+void monitor_init_hmp(Chardev *chr, bool use_readline);
 void monitor_cleanup(void);
=20
 int monitor_suspend(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 07f827c90c..5349a81307 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1394,14 +1394,14 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->common);
 }
=20
-void monitor_init_hmp(Chardev *chr, int flags)
+void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
     MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
=20
     monitor_data_init(&mon->common, false, false, false);
     qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
=20
-    mon->use_readline =3D flags & MONITOR_USE_READLINE;
+    mon->use_readline =3D use_readline;
     if (mon->use_readline) {
         mon->rs =3D readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 03ea0239ef..7760b22ba3 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -163,9 +163,6 @@ extern int mon_refcount;
=20
 extern HMPCommand hmp_cmds[];
=20
-void monitor_init_qmp(Chardev *chr, int flags);
-void monitor_init_hmp(Chardev *chr, int flags);
-
 int monitor_puts(Monitor *mon, const char *str);
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 3f4808240a..3ef28171c0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -551,15 +551,6 @@ void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->mon_lock);
 }
=20
-void monitor_init(Chardev *chr, int flags)
-{
-    if (flags & MONITOR_USE_CONTROL) {
-        monitor_init_qmp(chr, flags);
-    } else {
-        monitor_init_hmp(chr, flags);
-    }
-}
-
 void monitor_cleanup(void)
 {
     /*
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 940649f688..e1b196217d 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -364,18 +364,15 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
     monitor_list_append(&mon->common);
 }
=20
-void monitor_init_qmp(Chardev *chr, int flags)
+void monitor_init_qmp(Chardev *chr, bool pretty)
 {
     MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
=20
-    /* Only HMP supports readline */
-    assert(!(flags & MONITOR_USE_READLINE));
-
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
     monitor_data_init(&mon->common, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
=20
-    mon->pretty =3D flags & MONITOR_USE_PRETTY;
+    mon->pretty =3D pretty;
=20
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests =3D g_queue_new();
diff --git a/stubs/monitor.c b/stubs/monitor.c
index cdbf5c5f9a..c3e9a2e4dc 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -16,7 +16,11 @@ int monitor_get_fd(Monitor *mon, const char *name, Err=
or **errp)
     return -1;
 }
=20
-void monitor_init(Chardev *chr, int flags)
+void monitor_init_qmp(Chardev *chr, bool pretty)
+{
+}
+
+void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
 }
=20
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index fd1ced058c..f1ebffee5a 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -71,7 +71,8 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
  */
 __thread Monitor *cur_mon;
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort()=
; }
-void monitor_init(Chardev *chr, int flags) {}
+void monitor_init_qmp(Chardev *chr, bool pretty) {}
+void monitor_init_hmp(Chardev *chr, bool use_readline) {}
=20
=20
 static void test_socket_fd_pass_name_good(void)
diff --git a/vl.c b/vl.c
index 005468cbfb..32daa434eb 100644
--- a/vl.c
+++ b/vl.c
@@ -2299,25 +2299,27 @@ static int fsdev_init_func(void *opaque, QemuOpts=
 *opts, Error **errp)
 static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Chardev *chr;
+    bool qmp;
+    bool pretty =3D false;
     const char *chardev;
     const char *mode;
-    int flags;
=20
     mode =3D qemu_opt_get(opts, "mode");
     if (mode =3D=3D NULL) {
         mode =3D "readline";
     }
     if (strcmp(mode, "readline") =3D=3D 0) {
-        flags =3D MONITOR_USE_READLINE;
+        qmp =3D false;
     } else if (strcmp(mode, "control") =3D=3D 0) {
-        flags =3D MONITOR_USE_CONTROL;
+        qmp =3D true;
     } else {
         error_setg(errp, "unknown monitor mode \"%s\"", mode);
         return -1;
     }
=20
-    if (qemu_opt_get_bool(opts, "pretty", 0))
-        flags |=3D MONITOR_USE_PRETTY;
+    if (qemu_opt_get_bool(opts, "pretty", 0)) {
+        pretty =3D true;
+    }
=20
     chardev =3D qemu_opt_get(opts, "chardev");
     if (!chardev) {
@@ -2330,7 +2332,11 @@ static int mon_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
         return -1;
     }
=20
-    monitor_init(chr, flags);
+    if (qmp) {
+        monitor_init_qmp(chr, pretty);
+    } else {
+        monitor_init_hmp(chr, true);
+    }
     return 0;
 }
=20
--=20
2.21.0


