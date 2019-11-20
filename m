Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B900C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3592C2068D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqxbI0ke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3592C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVHo-0003Vr-9J
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVBu-0006bG-Re
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVBs-0002Mf-S8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iXVBs-0002Lq-Nt
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N71bCkeEmFSODmHaBuaJPIbj18h0+RvLK7sZTaIwMuU=;
 b=GqxbI0kehDmSR1UEDoOrzixGygAkfoGHAtJBWvTVlDizUFNq3RkndogovZWP2r4aywRqPo
 0FztWzyxbQF4R/9cDH203YTkP9U5eUPNJmUEm1iUruZX6WGVD2YSYW+HgLZL/lNw04+44b
 E7Vm8PsKK6/bxq2qO/BVzhcukMuT0jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-uZ8LHJb4PyiLadgYsflPkg-1; Wed, 20 Nov 2019 13:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E48ADB63;
 Wed, 20 Nov 2019 18:58:56 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAECD1838A;
 Wed, 20 Nov 2019 18:58:54 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] monitor: uninline add_init_drive
Date: Wed, 20 Nov 2019 20:58:42 +0200
Message-Id: <20191120185850.18986-2-mlevitsk@redhat.com>
In-Reply-To: <20191120185850.18986-1-mlevitsk@redhat.com>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uZ8LHJb4PyiLadgYsflPkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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


