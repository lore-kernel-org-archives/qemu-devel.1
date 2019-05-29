Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE2CC28CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 10:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6962E21721
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 10:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6962E21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvgl-00076k-Mv
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 06:20:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVvf6-00060W-Pd
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVvf4-0001fB-QD
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hVvf2-0001e0-Ua
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FDFFC0AD2AD
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 10:18:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45EE66A96F;
	Wed, 29 May 2019 10:18:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
	armbru@redhat.com, laine@redhat.com
Date: Wed, 29 May 2019 11:17:56 +0100
Message-Id: <20190529101756.22557-3-dgilbert@redhat.com>
In-Reply-To: <20190529101756.22557-1-dgilbert@redhat.com>
References: <20190529101756.22557-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 29 May 2019 10:18:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] net/announce: Add HMP optional
 interface list
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the optional interface list to the HMP command.

i.e.

   All interfaces
        announce_self

   Just the named interfaces:
        announce_self vn1,vn2

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx |  6 ++++--
 hmp.c           | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 3dc421cb6a..1b63372713 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -955,8 +955,8 @@ ETEXI
=20
     {
         .name       =3D "announce_self",
-        .args_type  =3D "",
-        .params     =3D "",
+        .args_type  =3D "interfaces:s?",
+        .params     =3D "[interfaces]",
         .help       =3D "Trigger GARP/RARP announcements",
         .cmd        =3D hmp_announce_self,
     },
@@ -967,6 +967,8 @@ STEXI
 Trigger a round of GARP/RARP broadcasts; this is useful for explicitly u=
pdating the
 network infrastructure after a reconfiguration or some forms of migratio=
n.
 The timings of the round are set by the migration announce parameters.
+An optional comma separated @var{interfaces} list restricts the announce=
 to the
+named set of interfaces.
 ETEXI
=20
     {
diff --git a/hmp.c b/hmp.c
index a9665da6ec..f42b47f130 100644
--- a/hmp.c
+++ b/hmp.c
@@ -27,6 +27,7 @@
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
@@ -38,6 +39,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-visit-net.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
@@ -67,6 +69,32 @@ static void hmp_handle_error(Monitor *mon, Error **err=
p)
     }
 }
=20
+/*
+ * Produce a strList from a comma separated list.
+ * A NULL or empty input string return NULL.
+ */
+static strList *strList_from_comma_list(const char *in)
+{
+    strList *res =3D NULL;
+    strList **hook =3D &res;
+
+    while (in && in[0]) {
+        char *comma =3D strchr(in, ',');
+        *hook =3D g_new0(strList, 1);
+
+        if (comma) {
+            (*hook)->value =3D g_strndup(in, comma - in);
+            in =3D comma + 1; /* skip the , */
+        } else {
+            (*hook)->value =3D g_strdup(in);
+            in =3D NULL;
+        }
+        hook =3D &(*hook)->next;
+    }
+
+    return res;
+}
+
 void hmp_info_name(Monitor *mon, const QDict *qdict)
 {
     NameInfo *info;
@@ -1640,7 +1668,15 @@ void hmp_info_snapshots(Monitor *mon, const QDict =
*qdict)
=20
 void hmp_announce_self(Monitor *mon, const QDict *qdict)
 {
-    qmp_announce_self(migrate_announce_params(), NULL);
+    const char *interfaces_str =3D qdict_get_try_str(qdict, "interfaces"=
);
+    AnnounceParameters *params =3D QAPI_CLONE(AnnounceParameters,
+                                            migrate_announce_params());
+
+    qapi_free_strList(params->interfaces);
+    params->interfaces =3D strList_from_comma_list(interfaces_str);
+    params->has_interfaces =3D params->interfaces !=3D NULL;
+    qmp_announce_self(params, NULL);
+    qapi_free_AnnounceParameters(params);
 }
=20
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
--=20
2.21.0


