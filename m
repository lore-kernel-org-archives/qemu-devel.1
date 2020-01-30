Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B93C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4D0206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjpNTvRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4D0206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix93R-0007MB-66
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92N-0005ae-Cf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92M-0004XC-AW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ix92M-0004R1-6s
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIB5EKz/PP52nepCG9ZIBf61jVupUOv7U1wULQeWDdA=;
 b=VjpNTvRqy1+hgfumobsWF69BdzaXotxit/DkzYGEtuM/1A3GzIm6eBt6bQUoZRVRSylzxV
 TdIS8pbKNbB866g+PgqwbiCTMvQHnLUoxPCqSh3IDXIlBgxlZb2xubidYxxj9w+bpFncYO
 k8wihcXlaBA6cWbicIr81PXOOiYOdOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-yUKiICx_MR2KgsZ-giPTQg-1; Thu, 30 Jan 2020 07:35:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12FB100550E;
 Thu, 30 Jan 2020 12:34:59 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0A6E167A3;
 Thu, 30 Jan 2020 12:34:57 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/11] monitor/hmp: uninline add_init_drive
Date: Thu, 30 Jan 2020 14:34:39 +0200
Message-Id: <20200130123448.21093-3-mlevitsk@redhat.com>
In-Reply-To: <20200130123448.21093-1-mlevitsk@redhat.com>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yUKiICx_MR2KgsZ-giPTQg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is only used by hmp_drive_add.
The code is just a bit shorter this way.

No functional changes

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 device-hotplug.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index f01d53774b..554e4d98db 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -34,42 +34,35 @@
 #include "monitor/monitor.h"
 #include "block/block_int.h"
=20
-static DriveInfo *add_init_drive(const char *optstr)
+
+void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
     DriveInfo *dinfo;
     QemuOpts *opts;
     MachineClass *mc;
+    const char *optstr =3D qdict_get_str(qdict, "opts");
+    bool node =3D qdict_get_try_bool(qdict, "node", false);
+
+    if (node) {
+        hmp_drive_add_node(mon, optstr);
+        return;
+    }
=20
     opts =3D drive_def(optstr);
     if (!opts)
-        return NULL;
+        return;
=20
     mc =3D MACHINE_GET_CLASS(current_machine);
     dinfo =3D drive_new(opts, mc->block_default_type, &err);
     if (err) {
         error_report_err(err);
         qemu_opts_del(opts);
-        return NULL;
-    }
-
-    return dinfo;
-}
-
-void hmp_drive_add(Monitor *mon, const QDict *qdict)
-{
-    DriveInfo *dinfo =3D NULL;
-    const char *opts =3D qdict_get_str(qdict, "opts");
-    bool node =3D qdict_get_try_bool(qdict, "node", false);
-
-    if (node) {
-        hmp_drive_add_node(mon, opts);
-        return;
+        goto err;
     }
=20
-    dinfo =3D add_init_drive(opts);
     if (!dinfo) {
-        goto err;
+        return;
     }
=20
     switch (dinfo->type) {
--=20
2.17.2


