Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC5C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1F120828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPZ66lzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1F120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6EvS-0005Ce-Rl
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6ElT-0002Nd-Pg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6ElR-0002lP-QS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6ElR-0002gO-K8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEVkE58gDi8LcdZVuY33caFAMSeIEoH80hX4xa4PU9w=;
 b=BPZ66lzxvFOsUggKaSGlkluTAdPRiH0v51qSW2d9RWsjgJCDmmHpBTFxxUJ3V4BGkPMd9D
 68L+df9NPji0HVb4vrlTXuAX3KPTbLL7dt7P8WMIBvX7yXZ0dUCBwNXnuNXyS/mmLrTn+K
 SrSL7frfXVVbkBUKxxmv6PNhDa0q3Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-cgPQtB1pNhe05DinyGVCTg-1; Mon, 24 Feb 2020 09:31:10 -0500
X-MC-Unique: cgPQtB1pNhe05DinyGVCTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0DE107B102;
 Mon, 24 Feb 2020 14:31:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-134.ams2.redhat.com
 [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A20F5C114;
 Mon, 24 Feb 2020 14:31:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 16/20] monitor: Create QAPIfied monitor_init()
Date: Mon, 24 Feb 2020 15:30:04 +0100
Message-Id: <20200224143008.13362-17-kwolf@redhat.com>
In-Reply-To: <20200224143008.13362-1-kwolf@redhat.com>
References: <20200224143008.13362-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 coiby.xu@gmail.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a new QAPI-based monitor_init() function. The existing
monitor_init_opts() is rewritten to simply put its QemuOpts parameter
into a visitor and pass the resulting QAPI object to monitor_init().

This will cause some change in those error messages for the monitor
options in the system emulator that are now generated by the visitor
rather than explicitly checked in monitor_init_opts().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/control.json         | 36 ++++++++++++++++++
 include/monitor/monitor.h |  2 +
 monitor/monitor.c         | 77 +++++++++++++++++++++------------------
 3 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 759c20e76f..3ee086aec7 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -216,3 +216,39 @@
 # <- { "return": {} }
 ##
 { 'command': 'quit' }
+
+##
+# @MonitorMode:
+#
+# An enumeration of monitor modes.
+#
+# @readline: HMP monitor (human-oriented command line interface)
+#
+# @control: QMP monitor (JSON-based machine interface)
+#
+# Since: 5.0
+##
+{ 'enum': 'MonitorMode', 'data': [ 'readline', 'control' ] }
+
+##
+# @MonitorOptions:
+#
+# Options to be used for adding a new monitor.
+#
+# @id:          Name of the monitor
+#
+# @mode:        Selects the monitor mode (default: readline)
+#
+# @pretty:      Enables pretty printing (QMP only)
+#
+# @chardev:     Name of a character device to expose the monitor on
+#
+# Since: 5.0
+##
+{ 'struct': 'MonitorOptions',
+  'data': {
+      '*id': 'str',
+      '*mode': 'MonitorMode',
+      '*pretty': 'bool',
+      'chardev': 'str'
+  } }
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index b7bdd2bb2a..db1112552c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -7,6 +7,7 @@
=20
 extern __thread Monitor *cur_mon;
 typedef struct MonitorHMP MonitorHMP;
+typedef struct MonitorOptions MonitorOptions;
=20
 #define QMP_REQ_QUEUE_LEN_MAX 8
=20
@@ -18,6 +19,7 @@ void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 void monitor_init_qmp(Chardev *chr, bool pretty);
 void monitor_init_hmp(Chardev *chr, bool use_readline);
+int monitor_init(MonitorOptions *opts, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
=20
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c1a6c4460f..cc7ee812eb 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -25,7 +25,9 @@
 #include "qemu/osdep.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
+#include "qapi/opts-visitor.h"
 #include "qapi/qapi-emit-events.h"
+#include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
@@ -609,50 +611,55 @@ void monitor_init_globals_core(void)
                                    NULL);
 }
=20
-int monitor_init_opts(QemuOpts *opts, Error **errp)
+int monitor_init(MonitorOptions *opts, Error **errp)
 {
     Chardev *chr;
-    bool qmp;
-    bool pretty =3D false;
-    const char *chardev;
-    const char *mode;
-
-    mode =3D qemu_opt_get(opts, "mode");
-    if (mode =3D=3D NULL) {
-        mode =3D "readline";
-    }
-    if (strcmp(mode, "readline") =3D=3D 0) {
-        qmp =3D false;
-    } else if (strcmp(mode, "control") =3D=3D 0) {
-        qmp =3D true;
-    } else {
-        error_setg(errp, "unknown monitor mode \"%s\"", mode);
+
+    chr =3D qemu_chr_find(opts->chardev);
+    if (chr =3D=3D NULL) {
+        error_setg(errp, "chardev \"%s\" not found", opts->chardev);
         return -1;
     }
=20
-    if (!qmp && qemu_opt_get(opts, "pretty")) {
-        warn_report("'pretty' is deprecated for HMP monitors, it has no ef=
fect "
-                    "and will be removed in future versions");
-    }
-    if (qemu_opt_get_bool(opts, "pretty", 0)) {
-        pretty =3D true;
+    switch(opts->mode) {
+    case MONITOR_MODE_CONTROL:
+        monitor_init_qmp(chr, opts->pretty);
+        break;
+    case MONITOR_MODE_READLINE:
+        if (opts->pretty) {
+            warn_report("'pretty' is deprecated for HMP monitors, it has n=
o "
+                        "effect and will be removed in future versions");
+        }
+        monitor_init_hmp(chr, true);
+        break;
+    default:
+        g_assert_not_reached();
     }
=20
-    chardev =3D qemu_opt_get(opts, "chardev");
-    if (!chardev) {
-        error_report("chardev is required");
-        exit(1);
-    }
-    chr =3D qemu_chr_find(chardev);
-    if (chr =3D=3D NULL) {
-        error_setg(errp, "chardev \"%s\" not found", chardev);
-        return -1;
+    return 0;
+}
+
+int monitor_init_opts(QemuOpts *opts, Error **errp)
+{
+    Visitor *v;
+    MonitorOptions *options;
+    Error *local_err =3D NULL;
+
+    v =3D opts_visitor_new(opts);
+    visit_type_MonitorOptions(v, NULL, &options, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        goto out;
     }
=20
-    if (qmp) {
-        monitor_init_qmp(chr, pretty);
-    } else {
-        monitor_init_hmp(chr, true);
+    monitor_init(options, &local_err);
+    qapi_free_MonitorOptions(options);
+
+out:
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
     }
     return 0;
 }
--=20
2.20.1


