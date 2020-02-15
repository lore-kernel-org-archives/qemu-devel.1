Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A01C7114D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6E2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2bUsR9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2x9T-0001S4-AC
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 08:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2x8c-0000A3-ID
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2x8Z-0002hM-HY
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2x8Z-0002fE-DW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581771932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MigBGLsrO/+pwGnF6sP4SvTd1Mfyh92oDXRaaJehpwc=;
 b=T2bUsR9lVeW3yoajmJ0mGSFVWbtnZ9TD2ywMo9tc23Z8c7BJ2i0aGx/rejJF7q05uTF56d
 FnaTdHuVWgwVJy4321wSQ/C4I3acOJ1w08NEnMghSLuT0uy1imlHEvknjjpF3u4sWKFBck
 hNFSd+CJonoNhbN5LOXDt65xnsdO4OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-iqTqh5oNPaWJYsACaY4bpw-1; Sat, 15 Feb 2020 08:05:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5041D107ACC5
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 13:05:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEAA49050E;
 Sat, 15 Feb 2020 13:05:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 692F411366C0; Sat, 15 Feb 2020 14:05:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] monitor: Move monitor option parsing to monitor/monitor.c
Date: Sat, 15 Feb 2020 14:05:23 +0100
Message-Id: <20200215130527.28861-2-armbru@redhat.com>
In-Reply-To: <20200215130527.28861-1-armbru@redhat.com>
References: <20200215130527.28861-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: iqTqh5oNPaWJYsACaY4bpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Both the system emulators and tools with QMP support (specifically, the
planned storage daemon) will need to parse monitor options, so move that
code to monitor/monitor.c, which can be linked into binaries that aren't
a system emulator.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200129102239.31435-2-kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h |  3 +++
 include/sysemu/sysemu.h   |  1 -
 monitor/monitor.c         | 48 +++++++++++++++++++++++++++++++++++++++
 vl.c                      | 45 +-----------------------------------
 4 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index a81eeff5f8..b7bdd2bb2a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -10,12 +10,15 @@ typedef struct MonitorHMP MonitorHMP;
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
+int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
=20
 int monitor_suspend(Monitor *mon);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 7956e9054a..c0678c1ca3 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -125,7 +125,6 @@ extern QemuOptsList qemu_netdev_opts;
 extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
 extern QemuOptsList qemu_global_opts;
-extern QemuOptsList qemu_mon_opts;
 extern QemuOptsList qemu_semihosting_config_opts;
=20
 #endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6448..c1a6c4460f 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -609,6 +609,54 @@ void monitor_init_globals_core(void)
                                    NULL);
 }
=20
+int monitor_init_opts(QemuOpts *opts, Error **errp)
+{
+    Chardev *chr;
+    bool qmp;
+    bool pretty =3D false;
+    const char *chardev;
+    const char *mode;
+
+    mode =3D qemu_opt_get(opts, "mode");
+    if (mode =3D=3D NULL) {
+        mode =3D "readline";
+    }
+    if (strcmp(mode, "readline") =3D=3D 0) {
+        qmp =3D false;
+    } else if (strcmp(mode, "control") =3D=3D 0) {
+        qmp =3D true;
+    } else {
+        error_setg(errp, "unknown monitor mode \"%s\"", mode);
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
index b0ee318f99..794f2e5733 100644
--- a/vl.c
+++ b/vl.c
@@ -2127,50 +2127,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *o=
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
+    return monitor_init_opts(opts, errp);
 }
=20
 static void monitor_parse(const char *optarg, const char *mode, bool prett=
y)
--=20
2.21.1


