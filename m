Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD04C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8E22173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYfdVvmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8E22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV8J-000471-BQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwV2G-0002qU-9Q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwV2E-0004VQ-DY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwV2E-0004UA-4u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580233941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+e8tEWoHDL30yoC/I9+ea2SPJ7Jxnqf4dabeelZsp0=;
 b=ZYfdVvmQqDxPPAnVzAhjRRVUPKA7H76lOFlCukQiNqasaqXlME2xOjHJi2Bay94vp6YIyv
 cHJ7FVETy3vW3a7ePyz4xB5pm216d+ORDvhXkcq8iCQgcgYZ4GXy5Fyjog3rXZY39ppipv
 Xfq9f/o9PhMdipv5w6w2QqseugGacXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-7EBIWjM3MHaJ0KrpO4qVBQ-1; Tue, 28 Jan 2020 12:52:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5638010D8;
 Tue, 28 Jan 2020 17:52:18 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-106.ams2.redhat.com
 [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C63160BE0;
 Tue, 28 Jan 2020 17:52:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/4] monitor: Move monitor option parsing to
 monitor/monitor.c
Date: Tue, 28 Jan 2020 18:52:08 +0100
Message-Id: <20200128175211.30007-2-kwolf@redhat.com>
In-Reply-To: <20200128175211.30007-1-kwolf@redhat.com>
References: <20200128175211.30007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7EBIWjM3MHaJ0KrpO4qVBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the system emulators and tools with QMP support (specifically, the
planned storage daemon) will need to parse monitor options, so move that
code to monitor/monitor.c, which can be linked into binaries that aren't
a system emulator.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h |  4 ++++
 include/sysemu/sysemu.h   |  1 -
 monitor/monitor.c         | 48 +++++++++++++++++++++++++++++++++++++++
 vl.c                      | 45 +-----------------------------------
 4 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index a81eeff5f8..ecf6cce827 100644
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
+int monitor_init_opts(QemuOpts *opts, Error **errp);
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
index b0f52c4d6e..e263e15cd6 100644
--- a/vl.c
+++ b/vl.c
@@ -2118,50 +2118,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *o=
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
2.20.1


