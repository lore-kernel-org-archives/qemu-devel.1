Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B33C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229D020828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2kFomAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229D020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOPn-0002G2-9x
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMj-0005qz-Gf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMi-0008US-54
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMi-0008U7-0W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzdJIcSAlt55GQyVa7oRfwTxAgNZnAPE4Rs/+yLA3uo=;
 b=G2kFomAot86ozBtrjjxodlv6TH1J4Lc8b4b8d4EAYRP131U2VNRRHOwSbi+GKhIYOOKn+z
 46NGfaWVDCZ49HKSJ/nn+1z+FEoooNzk6tLkCpQIe3V299YNxTT7Bdo99KXcIMDR/9YyIz
 qjJ3BIQ2zPHErKFZ1SE8JZHurNFPSAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-HI6r1ev7MYCTFrNxWhbVLA-1; Mon, 09 Mar 2020 15:47:01 -0400
X-MC-Unique: HI6r1ev7MYCTFrNxWhbVLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3BA61005509
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:47:00 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C90D65C28D;
 Mon,  9 Mar 2020 19:46:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 06/12] monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
Date: Mon,  9 Mar 2020 19:46:44 +0000
Message-Id: <20200309194650.160552-7-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200308092440.23564-7-mlevitsk@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index 6254f19842..25d1c19a96 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1997,58 +1997,6 @@ void hmp_block_stream(Monitor *mon, const QDict *qdi=
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
2.24.1


