Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09240C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AC42076C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta7CQfjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AC42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnmp-00038a-1m
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCnkU-0008GN-N1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCnkT-0006X1-Dy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCnkT-0006WL-9W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584119125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXFL1Ha/rKYObaZ6v70V4iaynp2s2hyBUXDZFuBgsZc=;
 b=Ta7CQfjCL1jbpCeXxyoXKmmc2HAltMQHF7QUur6r4w3EJmxsNKc+X09jdeoxm4e/5LTWfs
 VZO4/vlSrwh5AZvt942FC5AdsD2kfQLMYHoskufS9XItckQHJF5lk5yQldmhaWEmjCJ5Is
 NZfwxYVyXXDlmjCaqVnMvrxu+9qmJHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ZdOZT-LYMDmYXNzbO3iczA-1; Fri, 13 Mar 2020 13:05:21 -0400
X-MC-Unique: ZdOZT-LYMDmYXNzbO3iczA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE62C1418;
 Fri, 13 Mar 2020 17:05:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53F141001B34;
 Fri, 13 Mar 2020 17:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C626211385ED; Fri, 13 Mar 2020 18:05:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] Use &error_abort instead of separate assert()
Date: Fri, 13 Mar 2020 18:05:15 +0100
Message-Id: <20200313170517.22480-2-armbru@redhat.com>
In-Reply-To: <20200313170517.22480-1-armbru@redhat.com>
References: <20200313170517.22480-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: alxndr@bu.edu, vsementsov@virtuozzo.com, ashijeetacharya@gmail.com,
 qemu-block@nongnu.org, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 4 +---
 target/arm/monitor.c           | 8 ++------
 tests/qtest/fuzz/qos_fuzz.c    | 6 ++----
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index c3a6368dfc..4c8c375172 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -838,10 +838,8 @@ void hmp_info_blockstats(Monitor *mon, const QDict *qd=
ict)
 void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
 {
     BlockJobInfoList *list;
-    Error *err =3D NULL;
=20
-    list =3D qmp_query_block_jobs(&err);
-    assert(!err);
+    list =3D qmp_query_block_jobs(&error_abort);
=20
     if (!list) {
         monitor_printf(mon, "No active jobs\n");
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index c2dc7908de..ea6598c412 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -206,9 +206,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(Cp=
uModelExpansionType type,
             return NULL;
         }
     } else {
-        Error *err =3D NULL;
-        arm_cpu_finalize_features(ARM_CPU(obj), &err);
-        assert(err =3D=3D NULL);
+        arm_cpu_finalize_features(ARM_CPU(obj), &error_abort);
     }
=20
     expansion_info =3D g_new0(CpuModelExpansionInfo, 1);
@@ -221,12 +219,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
     while ((name =3D cpu_model_advertised_features[i++]) !=3D NULL) {
         ObjectProperty *prop =3D object_property_find(obj, name, NULL);
         if (prop) {
-            Error *err =3D NULL;
             QObject *value;
=20
             assert(prop->get);
-            value =3D object_property_get_qobject(obj, name, &err);
-            assert(!err);
+            value =3D object_property_get_qobject(obj, name, &error_abort)=
;
=20
             qdict_put_obj(qdict_out, name, value);
         }
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index 1a99277d60..aa9eee6ebf 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -57,8 +57,7 @@ static void qos_set_machines_devices_available(void)
     QList *lst;
     Error *err =3D NULL;
=20
-    qmp_marshal_query_machines(NULL, &response, &err);
-    assert(!err);
+    qmp_marshal_query_machines(NULL, &response, &error_abort);
     lst =3D qobject_to(QList, response);
     apply_to_qlist(lst, true);
=20
@@ -70,8 +69,7 @@ static void qos_set_machines_devices_available(void)
     qdict_put_bool(args, "abstract", true);
     qdict_put_obj(req, "arguments", (QObject *) args);
=20
-    qmp_marshal_qom_list_types(args, &response, &err);
-    assert(!err);
+    qmp_marshal_qom_list_types(args, &response, &error_abort);
     lst =3D qobject_to(QList, response);
     apply_to_qlist(lst, false);
     qobject_unref(response);
--=20
2.21.1


