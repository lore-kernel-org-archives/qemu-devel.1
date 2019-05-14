Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA33C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9114220879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9114220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcQG-0006sW-QN
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:45:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcHU-0007Os-Hx
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcHT-0001rS-Gh
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQcHT-0001pz-9B
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82CBD3079B6B;
	Tue, 14 May 2019 18:36:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
	[10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94661608B9;
	Tue, 14 May 2019 18:35:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
	ehabkost@redhat.com, richardw.yang@linux.intel.com,
	yury-kotov@yandex-team.ru, chen.zhang@intel.com
Date: Tue, 14 May 2019 19:34:51 +0100
Message-Id: <20190514183454.12758-14-dgilbert@redhat.com>
In-Reply-To: <20190514183454.12758-1-dgilbert@redhat.com>
References: <20190514183454.12758-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 14 May 2019 18:36:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/16] migration/savevm: wrap into
 qemu_loadvm_state_header()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

On source side, we have qemu_savevm_state_header() to send related data,
while on the receiving side those steps are scattered in
qemu_loadvm_state().

This patch wrap those related steps into qemu_loadvm_state_header() to
make it friendly to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190424004700.12766-5-richardw.yang@linux.intel.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 69 +++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4c7b8379e8..c0e557b4c2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2262,6 +2262,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, Migratio=
nIncomingState *mis)
     return 0;
 }
=20
+static int qemu_loadvm_state_header(QEMUFile *f)
+{
+    unsigned int v;
+    int ret;
+
+    v =3D qemu_get_be32(f);
+    if (v !=3D QEMU_VM_FILE_MAGIC) {
+        error_report("Not a migration stream");
+        return -EINVAL;
+    }
+
+    v =3D qemu_get_be32(f);
+    if (v =3D=3D QEMU_VM_FILE_VERSION_COMPAT) {
+        error_report("SaveVM v2 format is obsolete and don't work anymor=
e");
+        return -ENOTSUP;
+    }
+    if (v !=3D QEMU_VM_FILE_VERSION) {
+        error_report("Unsupported migration stream version");
+        return -ENOTSUP;
+    }
+
+    if (migrate_get_current()->send_configuration) {
+        if (qemu_get_byte(f) !=3D QEMU_VM_CONFIGURATION) {
+            error_report("Configuration section missing");
+            qemu_loadvm_state_cleanup();
+            return -EINVAL;
+        }
+        ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm_st=
ate, 0);
+
+        if (ret) {
+            qemu_loadvm_state_cleanup();
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static int qemu_loadvm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
@@ -2410,7 +2447,6 @@ int qemu_loadvm_state(QEMUFile *f)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
     Error *local_err =3D NULL;
-    unsigned int v;
     int ret;
=20
     if (qemu_savevm_state_blocked(&local_err)) {
@@ -2418,34 +2454,9 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
=20
-    v =3D qemu_get_be32(f);
-    if (v !=3D QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
-        return -EINVAL;
-    }
-
-    v =3D qemu_get_be32(f);
-    if (v =3D=3D QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymor=
e");
-        return -ENOTSUP;
-    }
-    if (v !=3D QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
-        return -ENOTSUP;
-    }
-
-    if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) !=3D QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
-            qemu_loadvm_state_cleanup();
-            return -EINVAL;
-        }
-        ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm_st=
ate, 0);
-
-        if (ret) {
-            qemu_loadvm_state_cleanup();
-            return ret;
-        }
+    ret =3D qemu_loadvm_state_header(f);
+    if (ret) {
+        return ret;
     }
=20
     if (qemu_loadvm_state_setup(f) !=3D 0) {
--=20
2.21.0


