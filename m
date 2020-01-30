Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596FBC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2881F206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCAqpI0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2881F206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix96R-0005io-C3
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92W-0005xu-Pv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92V-0004o3-3z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ix92U-0004nU-WC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EP96nc4+jZv7gcbZ9+98UgVX3lg0fmtpP2kk0L0diwc=;
 b=PCAqpI0KwrraL6shSpGRh0MWSQnHfplQuEyqlbeMJIJ9MoRzLp7nplH3cNEn4bdaFbx+sP
 b4pK1Etba4I4IshhQ29t+0DmTkeKZ9Y7+d3ajY2P0MAmuGw3hxeEqytHG2jkMaj8rCuuc3
 AmGZIVhb7eQyOi7vSDyWna7JVgqqxNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-O_RqVOmwO4uH1myoPepXtw-1; Thu, 30 Jan 2020 07:35:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96F0DDB61;
 Thu, 30 Jan 2020 12:35:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DAE1167A3;
 Thu, 30 Jan 2020 12:35:10 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/11] monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
Date: Thu, 30 Jan 2020 14:34:43 +0200
Message-Id: <20200130123448.21093-7-mlevitsk@redhat.com>
In-Reply-To: <20200130123448.21093-1-mlevitsk@redhat.com>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: O_RqVOmwO4uH1myoPepXtw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 52 ++++++++++++++++++++++++++++++++++
 include/block/block-hmp-cmds.h |  6 ++++
 include/monitor/hmp.h          |  5 ----
 monitor/hmp-cmds.c             | 52 ----------------------------------
 4 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index d6dd5d97f7..8e8288c2f1 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -247,3 +247,55 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdict=
)
     qmp_drive_backup(&backup, &err);
     hmp_handle_error(mon, err);
 }
+
+void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+    int64_t value =3D qdict_get_int(qdict, "speed");
+
+    qmp_block_job_set_speed(device, value, &error);
+
+    hmp_handle_error(mon, error);
+}
+
+void hmp_block_job_cancel(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+    bool force =3D qdict_get_try_bool(qdict, "force", false);
+
+    qmp_block_job_cancel(device, true, force, &error);
+
+    hmp_handle_error(mon, error);
+}
+
+void hmp_block_job_pause(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+
+    qmp_block_job_pause(device, &error);
+
+    hmp_handle_error(mon, error);
+}
+
+void hmp_block_job_resume(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+
+    qmp_block_job_resume(device, &error);
+
+    hmp_handle_error(mon, error);
+}
+
+void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+
+    qmp_block_job_complete(device, &error);
+
+    hmp_handle_error(mon, error);
+}
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
index a64b737b3a..fcdf1eec48 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -23,4 +23,10 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict);
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
 void hmp_drive_backup(Monitor *mon, const QDict *qdict);
=20
+void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
+void hmp_block_job_cancel(Monitor *mon, const QDict *qdict);
+void hmp_block_job_pause(Monitor *mon, const QDict *qdict);
+void hmp_block_job_resume(Monitor *mon, const QDict *qdict);
+void hmp_block_job_complete(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c1b363ee57..592ce0ccfe 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -87,11 +87,6 @@ void hmp_eject(Monitor *mon, const QDict *qdict);
 void hmp_change(Monitor *mon, const QDict *qdict);
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
 void hmp_block_stream(Monitor *mon, const QDict *qdict);
-void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
-void hmp_block_job_cancel(Monitor *mon, const QDict *qdict);
-void hmp_block_job_pause(Monitor *mon, const QDict *qdict);
-void hmp_block_job_resume(Monitor *mon, const QDict *qdict);
-void hmp_block_job_complete(Monitor *mon, const QDict *qdict);
 void hmp_migrate(Monitor *mon, const QDict *qdict);
 void hmp_device_add(Monitor *mon, const QDict *qdict);
 void hmp_device_del(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index a70bcb1d16..996ce96430 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1975,58 +1975,6 @@ void hmp_block_stream(Monitor *mon, const QDict *qdi=
ct)
     hmp_handle_error(mon, error);
 }
=20
-void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-    int64_t value =3D qdict_get_int(qdict, "speed");
-
-    qmp_block_job_set_speed(device, value, &error);
-
-    hmp_handle_error(mon, error);
-}
-
-void hmp_block_job_cancel(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-    bool force =3D qdict_get_try_bool(qdict, "force", false);
-
-    qmp_block_job_cancel(device, true, force, &error);
-
-    hmp_handle_error(mon, error);
-}
-
-void hmp_block_job_pause(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-
-    qmp_block_job_pause(device, &error);
-
-    hmp_handle_error(mon, error);
-}
-
-void hmp_block_job_resume(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-
-    qmp_block_job_resume(device, &error);
-
-    hmp_handle_error(mon, error);
-}
-
-void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-
-    qmp_block_job_complete(device, &error);
-
-    hmp_handle_error(mon, error);
-}
-
 typedef struct HMPMigrationStatus
 {
     QEMUTimer *timer;
--=20
2.17.2


