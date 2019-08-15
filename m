Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44813C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F05420578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F05420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIwN-0000d0-JB
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIiz-0001gi-Bs
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIiu-0002Kc-Lu
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIiu-0002JQ-EH
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79DB53002069;
 Thu, 15 Aug 2019 16:35:35 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E0A7BAAC;
 Thu, 15 Aug 2019 16:35:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:41 +0100
Message-Id: <20190815163504.18937-11-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 15 Aug 2019 16:35:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/33] migration/savevm: split
 qemu_savevm_state_complete_precopy() into two parts
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

This is a preparation patch for further cleanup.

No functional change, just wrap two major part of
qemu_savevm_state_complete_precopy() into function.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190709140924.13291-3-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 66 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0bfdceefcc..63545a3026 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1246,23 +1246,12 @@ void qemu_savevm_state_complete_postcopy(QEMUFile=
 *f)
     qemu_fflush(f);
 }
=20
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks)
+static
+int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_pos=
tcopy,
+                                                bool iterable_only)
 {
-    QJSON *vmdesc;
-    int vmdesc_len;
     SaveStateEntry *se;
     int ret;
-    bool in_postcopy =3D migration_in_postcopy();
-    Error *local_err =3D NULL;
-
-    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
-        error_report_err(local_err);
-    }
-
-    trace_savevm_state_complete_precopy();
-
-    cpu_synchronize_all_states();
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
@@ -1291,9 +1280,18 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f=
, bool iterable_only,
         }
     }
=20
-    if (iterable_only) {
-        goto flush;
-    }
+    return 0;
+}
+
+static
+int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
+                                                    bool in_postcopy,
+                                                    bool inactivate_disk=
s)
+{
+    QJSON *vmdesc;
+    int vmdesc_len;
+    SaveStateEntry *se;
+    int ret;
=20
     vmdesc =3D qjson_new();
     json_prop_int(vmdesc, "page_size", qemu_target_page_size());
@@ -1353,6 +1351,40 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f=
, bool iterable_only,
     }
     qjson_destroy(vmdesc);
=20
+    return 0;
+}
+
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
+                                       bool inactivate_disks)
+{
+    int ret;
+    Error *local_err =3D NULL;
+    bool in_postcopy =3D migration_in_postcopy();
+
+    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
+        error_report_err(local_err);
+    }
+
+    trace_savevm_state_complete_precopy();
+
+    cpu_synchronize_all_states();
+
+    ret =3D qemu_savevm_state_complete_precopy_iterable(f, in_postcopy,
+                                                      iterable_only);
+    if (ret) {
+        return ret;
+    }
+
+    if (iterable_only) {
+        goto flush;
+    }
+
+    ret =3D qemu_savevm_state_complete_precopy_non_iterable(f, in_postco=
py,
+                                                          inactivate_dis=
ks);
+    if (ret) {
+        return ret;
+    }
+
 flush:
     qemu_fflush(f);
     return 0;
--=20
2.21.0


