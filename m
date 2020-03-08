Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3A9C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD82206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6fp7QCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD82206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAsBz-0004Bo-Mp
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 05:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsB6-0002cH-QY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsB5-0008QA-S7
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAsB5-0008Pt-Oa
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583659495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qNpcWxMNhKSHAyHJ/6I9p7T+0h3KsCJucmDPFGTxZrA=;
 b=Y6fp7QCCaf8E1d/lDnT19ziC9d10uvwCbNfsKVroBquCMw0NvYrAG/SQI/77iDWvLO4wYB
 MWA1ywS1zcq/FCU6wG0oD/SCel9hKYmo9qvkptN9bmlSH4oKvTyCbdEzyDRVGnFmDI/vyP
 JkA4soJiyx6S8nsd95ozp/U/LSbpooc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-HV0oCh05PoGtAUariO1roQ-1; Sun, 08 Mar 2020 05:24:53 -0400
X-MC-Unique: HV0oCh05PoGtAUariO1roQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF0B477;
 Sun,  8 Mar 2020 09:24:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20F5A101D486;
 Sun,  8 Mar 2020 09:24:49 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/11] monitor/hmp: inline add_init_drive
Date: Sun,  8 Mar 2020 11:24:31 +0200
Message-Id: <20200308092440.23564-3-mlevitsk@redhat.com>
In-Reply-To: <20200308092440.23564-1-mlevitsk@redhat.com>
References: <20200308092440.23564-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function is only used by hmp_drive_add.
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


