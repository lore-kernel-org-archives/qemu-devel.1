Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31914C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01ADD20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/+3QqO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ADD20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOPt-0002MT-69
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMh-0005nS-MT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMg-0008TQ-LF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMg-0008TA-H3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0J1BgM8G3GVqw+1UzdlGEgpXHPM12sB3GODgYTmeRtY=;
 b=G/+3QqO5qMsEPzlRao6ENHTev4EPsd1DZlFDu5r6JvnC9kOjIKcgZxvhRgNQmopM3j/2/G
 Lr7R9xsoxNwVsqZuEyCT4OMbTZ/p0uZ9b1XA6z4JoK6vNqAfP4dVUtfivKfxgonEQfV6Al
 hKw2IUAR/Ey5S4NTS3ze2wQB7Qtvljs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-qQRu-WNzOn6K60yJ-WFmCA-1; Mon, 09 Mar 2020 15:46:56 -0400
X-MC-Unique: qQRu-WNzOn6K60yJ-WFmCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7A11005512
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:46:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31CB85C28D;
 Mon,  9 Mar 2020 19:46:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 02/12] monitor/hmp: inline add_init_drive
Date: Mon,  9 Mar 2020 19:46:40 +0000
Message-Id: <20200309194650.160552-3-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

This function is only used by hmp_drive_add.
The code is just a bit shorter this way.

No functional changes

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200308092440.23564-3-mlevitsk@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.24.1


