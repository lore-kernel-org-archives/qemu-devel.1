Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD5DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF9B20672
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjNXBEE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF9B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCAJ-0007LF-QD
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6V-0005YP-DY
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6T-00044a-VI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6T-000441-SH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N71bCkeEmFSODmHaBuaJPIbj18h0+RvLK7sZTaIwMuU=;
 b=AjNXBEE6NsRBtv5P7fk/kqX+PPaWFNatj1/2CJEreNWBp/0gpQSH9wu1LHqqIpxJii7qnt
 oJmNQBNOzF2Nd3FsfeXFI+OIbkUWF5hGp6qZxFyksPqRlLVHjGQl5x9cEyxwaFfNMEo51X
 yZd0r7GpzkN+3wFRwjNjvzNrZGS0smk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-oZuBV2hMNo-7KmtgLVaCzw-1; Fri, 22 Nov 2019 11:48:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF82801E76;
 Fri, 22 Nov 2019 16:48:13 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDF54691A4;
 Fri, 22 Nov 2019 16:48:11 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] monitor/hmp: uninline add_init_drive
Date: Fri, 22 Nov 2019 18:47:59 +0200
Message-Id: <20191122164807.27938-2-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: oZuBV2hMNo-7KmtgLVaCzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is only used by hmp_drive_add.
The code is just a bit shorter this way.

No functional changes

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 device-hotplug.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index f01d53774b..5ce73f0cff 100644
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
-    DriveInfo *dinfo;
+    DriveInfo *dinfo =3D NULL;
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


