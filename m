Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77994C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6092051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3U3LVU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6092051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGqc-00080o-Cv
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZc-0005A3-1H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZY-0008JI-J9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZY-0008Gn-CA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uFL4C+g/wYV+XiCjlejBiTbCr21q+WQpO8lPEL1vkA=;
 b=e3U3LVU0BjzJXFbTNMPe63W9nLyP2Ma9CdPtm2UZYLmlumL3O66R45xUXpGDQTcKodCXFK
 S2JHJu3xVZLI7NgJKbAEZxwCsSwlB+mQtsqZj1QFC2DWYNxsU+/lnUpGGc4JXEumvzSKGK
 IuQUwyy+0oIaCFZb8cB6+svvwCkyxnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-5xXzSdz6NsGse4T3DnQPTQ-1; Fri, 06 Mar 2020 12:15:37 -0500
X-MC-Unique: 5xXzSdz6NsGse4T3DnQPTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19EA184C801;
 Fri,  6 Mar 2020 17:15:36 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9EE973873;
 Fri,  6 Mar 2020 17:15:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/29] hmp: Fail gracefully if chardev is already in use
Date: Fri,  6 Mar 2020 18:14:53 +0100
Message-Id: <20200306171458.1848-25-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trying to attach a HMP monitor to a chardev that is already in use
results in a crash because monitor_init_hmp() passes &error_abort to
qemu_chr_fe_init():

$ ./x86_64-softmmu/qemu-system-x86_64 --chardev stdio,id=3Dfoo --mon foo --=
mon foo
QEMU 4.2.50 monitor - type 'help' for more information
(qemu) Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:220:
qemu-system-x86_64: --mon foo: Device 'foo' is in use
Abgebrochen (Speicherabzug geschrieben)

Fix this by allowing monitor_init_hmp() to return an error and passing
any error in qemu_chr_fe_init() to its caller instead of aborting.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-19-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/monitor/monitor.h | 2 +-
 chardev/char.c            | 8 +++++++-
 gdbstub.c                 | 2 +-
 monitor/hmp.c             | 8 ++++++--
 monitor/monitor.c         | 2 +-
 stubs/monitor.c           | 2 +-
 tests/test-util-sockets.c | 2 +-
 7 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index e55a3b57e0..ad823b9edb 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -18,7 +18,7 @@ bool monitor_cur_is_qmp(void);
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
-void monitor_init_hmp(Chardev *chr, bool use_readline);
+void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
 int monitor_init(MonitorOptions *opts, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
diff --git a/chardev/char.c b/chardev/char.c
index 87237568df..e77564060d 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -737,7 +737,13 @@ Chardev *qemu_chr_new_noreplay(const char *label, cons=
t char *filename,
=20
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
-        monitor_init_hmp(chr, true);
+        monitor_init_hmp(chr, true, &err);
+        if (err) {
+            error_report_err(err);
+            object_unparent(OBJECT(chr));
+            chr =3D NULL;
+            goto out;
+        }
     }
=20
 out:
diff --git a/gdbstub.c b/gdbstub.c
index ce304ff482..22a2d630cd 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3367,7 +3367,7 @@ int gdbserver_start(const char *device)
         /* Initialize a monitor terminal for gdb */
         mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_init_hmp(mon_chr, false);
+        monitor_init_hmp(mon_chr, false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
         mon_chr =3D s->mon_chr;
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 944fa9651e..d598dd02bb 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1399,12 +1399,16 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->common);
 }
=20
-void monitor_init_hmp(Chardev *chr, bool use_readline)
+void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
     MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
=20
+    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
+        g_free(mon);
+        return;
+    }
+
     monitor_data_init(&mon->common, false, false, false);
-    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
=20
     mon->use_readline =3D use_readline;
     if (mon->use_readline) {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00d287655e..2282bf6780 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -631,7 +631,7 @@ int monitor_init(MonitorOptions *opts, Error **errp)
             warn_report("'pretty' is deprecated for HMP monitors, it has n=
o "
                         "effect and will be removed in future versions");
         }
-        monitor_init_hmp(chr, true);
+        monitor_init_hmp(chr, true, &local_err);
         break;
     default:
         g_assert_not_reached();
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 9403f8e72c..20786ac4ff 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -9,7 +9,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **=
errp)
     return -1;
 }
=20
-void monitor_init_hmp(Chardev *chr, bool use_readline)
+void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
=20
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 2edb4c539d..5fd947c7bf 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -72,7 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Erro=
r **errp)
 __thread Monitor *cur_mon;
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); =
}
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp) {}
-void monitor_init_hmp(Chardev *chr, bool use_readline) {}
+void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp) {}
=20
=20
 static void test_socket_fd_pass_name_good(void)
--=20
2.20.1


