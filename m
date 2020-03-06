Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F773C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6E72051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuQ+Q4TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6E72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGnT-0002Us-5r
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZa-00056L-1h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZX-0008Fy-L1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZX-0008E7-Fq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfVKE4oQOv+fEEApXhx4oJW0V8OXPw6JlAQlw/LRLN4=;
 b=cuQ+Q4TWA0RTy1RlmEiUigA0gGBuqVbz8oMSqenycF5EYlc1gUg93rh9WT1QOB6H5thd8g
 T0RmkWc7/ffkDYi3/hIfFvV1Q+7x4Zk+SbOsMN/uEe9/AXRtsCQcAW4ZM0kKVWjzlZ+VK5
 0oyuK7H3oCfGAE1DITcFcK+CSmiGDQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-6XZNeu-rOqG2R3Jc9Q75Yg-1; Fri, 06 Mar 2020 12:15:36 -0500
X-MC-Unique: 6XZNeu-rOqG2R3Jc9Q75Yg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 725A213F5;
 Fri,  6 Mar 2020 17:15:35 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76A3673873;
 Fri,  6 Mar 2020 17:15:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/29] qmp: Fail gracefully if chardev is already in use
Date: Fri,  6 Mar 2020 18:14:52 +0100
Message-Id: <20200306171458.1848-24-kwolf@redhat.com>
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

Trying to attach a QMP monitor to a chardev that is already in use
results in a crash because monitor_init_qmp() passes &error_abort to
qemu_chr_fe_init():

$ ./x86_64-softmmu/qemu-system-x86_64 --chardev stdio,id=3Dfoo --mon foo,mo=
de=3Dcontrol --mon foo,mode=3Dcontrol
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:220:
qemu-system-x86_64: --mon foo,mode=3Dcontrol: Device 'foo' is in use
Abgebrochen (Speicherabzug geschrieben)

Fix this by allowing monitor_init_qmp() to return an error and passing
any error in qemu_chr_fe_init() to its caller instead of aborting.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-18-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 monitor/monitor.c         |  7 ++++++-
 monitor/qmp.c             | 11 +++++++----
 stubs/monitor-core.c      |  2 +-
 tests/test-util-sockets.c |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index db1112552c..e55a3b57e0 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -17,7 +17,7 @@ bool monitor_cur_is_qmp(void);
=20
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_init_qmp(Chardev *chr, bool pretty);
+void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
 void monitor_init_hmp(Chardev *chr, bool use_readline);
 int monitor_init(MonitorOptions *opts, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f8a6ef795b..00d287655e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -614,6 +614,7 @@ void monitor_init_globals_core(void)
 int monitor_init(MonitorOptions *opts, Error **errp)
 {
     Chardev *chr;
+    Error *local_err =3D NULL;
=20
     chr =3D qemu_chr_find(opts->chardev);
     if (chr =3D=3D NULL) {
@@ -623,7 +624,7 @@ int monitor_init(MonitorOptions *opts, Error **errp)
=20
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_init_qmp(chr, opts->pretty);
+        monitor_init_qmp(chr, opts->pretty, &local_err);
         break;
     case MONITOR_MODE_READLINE:
         if (opts->pretty) {
@@ -636,6 +637,10 @@ int monitor_init(MonitorOptions *opts, Error **errp)
         g_assert_not_reached();
     }
=20
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
     return 0;
 }
=20
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 8379c8f96e..f89e7daf27 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -395,10 +395,16 @@ static void monitor_qmp_setup_handlers_bh(void *opaqu=
e)
     monitor_list_append(&mon->common);
 }
=20
-void monitor_init_qmp(Chardev *chr, bool pretty)
+void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
 {
     MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
=20
+    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
+        g_free(mon);
+        return;
+    }
+    qemu_chr_fe_set_echo(&mon->common.chr, true);
+
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
     monitor_data_init(&mon->common, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT=
));
@@ -408,9 +414,6 @@ void monitor_init_qmp(Chardev *chr, bool pretty)
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests =3D g_queue_new();
=20
-    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
-    qemu_chr_fe_set_echo(&mon->common.chr, true);
-
     json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
     if (mon->common.use_io_thread) {
         /*
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 403c00a6d0..6cff1c4e1d 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -5,7 +5,7 @@
=20
 __thread Monitor *cur_mon;
=20
-void monitor_init_qmp(Chardev *chr, bool pretty)
+void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
 {
 }
=20
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 8ce55efe70..2edb4c539d 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -71,7 +71,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Erro=
r **errp)
  */
 __thread Monitor *cur_mon;
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); =
}
-void monitor_init_qmp(Chardev *chr, bool pretty) {}
+void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp) {}
 void monitor_init_hmp(Chardev *chr, bool use_readline) {}
=20
=20
--=20
2.20.1


