Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7171C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7193420717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JridDZje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7193420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihc5A-0001gy-BX
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihc3c-0008Ld-UP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihc3a-00045r-U2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihc3a-0003tf-Mm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576686012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmhHiMhlijK1C0qJx4w61hjzZS+mRlDR39d3qAiWj6A=;
 b=JridDZje8G80ttOjoHSRSbR5lC18dB+B3mI3V/QxJFYGciwgd/pbRv1xURFr8QyUXydu8N
 jPYjVbjz29IEGXWDUKmy0r2RlHxrrboMpEnWE4Uq+Y95d6R8PmRSSjevYiLmrwSIuYSoQV
 SomQlDclNVLm3yEHl1CgCno009mL+Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-udeXqxBNPsCpQSIBi-eR_A-1; Wed, 18 Dec 2019 11:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7E54801E76;
 Wed, 18 Dec 2019 16:20:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-210.ams2.redhat.com
 [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 782911000325;
 Wed, 18 Dec 2019 16:20:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/4] monitor: Move monitor option parsing to monitor/monitor.c
Date: Wed, 18 Dec 2019 17:19:49 +0100
Message-Id: <20191218161952.10202-2-kwolf@redhat.com>
In-Reply-To: <20191218161952.10202-1-kwolf@redhat.com>
References: <20191218161952.10202-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: udeXqxBNPsCpQSIBi-eR_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the system emulators and tools with QMP support (specifically, the
planned storage daemon) will need to parse monitor options, so move that
code to monitor/monitor.c, which can be linked into binaries that aren't
a system emulator.

This patch moves the monitor option parsing from vl.c and adds an
allow_hmp parameter so that callers can support QMP without HMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/monitor/monitor.h |  4 +++
 include/sysemu/sysemu.h   |  1 -
 monitor/monitor.c         | 52 +++++++++++++++++++++++++++++++++++++++
 vl.c                      | 45 +--------------------------------
 4 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index a81eeff5f8..d3e8da36a5 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,6 +3,7 @@
=20
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
+#include "qemu/option.h"
 #include "qemu/readline.h"
=20
 extern __thread Monitor *cur_mon;
@@ -10,12 +11,15 @@ typedef struct MonitorHMP MonitorHMP;
=20
 #define QMP_REQ_QUEUE_LEN_MAX 8
=20
+extern QemuOptsList qemu_mon_opts;
+
 bool monitor_cur_is_qmp(void);
=20
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 void monitor_init_qmp(Chardev *chr, bool pretty);
 void monitor_init_hmp(Chardev *chr, bool use_readline);
+int monitor_init_opts(QemuOpts *opts, bool allow_hmp, Error **errp);
 void monitor_cleanup(void);
=20
 int monitor_suspend(Monitor *mon);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 80c57fdc4e..bbd02cf941 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -128,7 +128,6 @@ extern QemuOptsList qemu_netdev_opts;
 extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
 extern QemuOptsList qemu_global_opts;
-extern QemuOptsList qemu_mon_opts;
 extern QemuOptsList qemu_semihosting_config_opts;
=20
 #endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6448..316b71b928 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -609,6 +609,58 @@ void monitor_init_globals_core(void)
                                    NULL);
 }
=20
+int monitor_init_opts(QemuOpts *opts, bool allow_hmp, Error **errp)
+{
+    Chardev *chr;
+    bool qmp;
+    bool pretty =3D false;
+    const char *chardev;
+    const char *mode;
+
+    mode =3D qemu_opt_get(opts, "mode");
+    if (mode =3D=3D NULL) {
+        mode =3D allow_hmp ? "readline" : "control";
+    }
+    if (strcmp(mode, "readline") =3D=3D 0) {
+        qmp =3D false;
+    } else if (strcmp(mode, "control") =3D=3D 0) {
+        qmp =3D true;
+    } else {
+        error_setg(errp, "unknown monitor mode \"%s\"", mode);
+        return -1;
+    }
+    if (!allow_hmp && !qmp) {
+        error_setg(errp, "Only QMP is supported");
+        return -1;
+    }
+
+    if (!qmp && qemu_opt_get(opts, "pretty")) {
+        warn_report("'pretty' is deprecated for HMP monitors, it has no ef=
fect "
+                    "and will be removed in future versions");
+    }
+    if (qemu_opt_get_bool(opts, "pretty", 0)) {
+        pretty =3D true;
+    }
+
+    chardev =3D qemu_opt_get(opts, "chardev");
+    if (!chardev) {
+        error_report("chardev is required");
+        exit(1);
+    }
+    chr =3D qemu_chr_find(chardev);
+    if (chr =3D=3D NULL) {
+        error_setg(errp, "chardev \"%s\" not found", chardev);
+        return -1;
+    }
+
+    if (qmp) {
+        monitor_init_qmp(chr, pretty);
+    } else {
+        monitor_init_hmp(chr, true);
+    }
+    return 0;
+}
+
 QemuOptsList qemu_mon_opts =3D {
     .name =3D "mon",
     .implied_opt_name =3D "chardev",
diff --git a/vl.c b/vl.c
index 94508300c3..352c68c897 100644
--- a/vl.c
+++ b/vl.c
@@ -2116,50 +2116,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
=20
 static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    Chardev *chr;
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
-        return -1;
-    }
-
-    if (!qmp && qemu_opt_get(opts, "pretty")) {
-        warn_report("'pretty' is deprecated for HMP monitors, it has no ef=
fect "
-                    "and will be removed in future versions");
-    }
-    if (qemu_opt_get_bool(opts, "pretty", 0)) {
-        pretty =3D true;
-    }
-
-    chardev =3D qemu_opt_get(opts, "chardev");
-    if (!chardev) {
-        error_report("chardev is required");
-        exit(1);
-    }
-    chr =3D qemu_chr_find(chardev);
-    if (chr =3D=3D NULL) {
-        error_setg(errp, "chardev \"%s\" not found", chardev);
-        return -1;
-    }
-
-    if (qmp) {
-        monitor_init_qmp(chr, pretty);
-    } else {
-        monitor_init_hmp(chr, true);
-    }
-    return 0;
+    return monitor_init_opts(opts, true, errp);
 }
=20
 static void monitor_parse(const char *optarg, const char *mode, bool prett=
y)
--=20
2.20.1


