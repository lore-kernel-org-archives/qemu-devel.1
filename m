Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF6FC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8465B2464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8465B2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBYRW-0003TT-Nw
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 02:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jBYQR-00031q-Lb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jBYQQ-0001iu-EI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:31:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59720 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jBYQQ-0001Ud-3G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:31:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9CC3B7F5F86EE8CE53FA;
 Tue, 10 Mar 2020 14:31:23 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 14:31:14 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>, <berrange@redhat.com>, <ehabkost@redhat.com>
Subject: [PATCH v2] qom-qmp-cmds: fix two memleaks in qmp_object_add
Date: Tue, 10 Mar 2020 14:46:40 +0800
Message-ID: <20200310064640.5059-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'type/id' forgot to free in qmp_object_add, this patch fix that.

The leak stack:
Direct leak of 84 byte(s) in 6 object(s) allocated from:
    #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
    #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
    #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
    #3 0x56344954e692 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:258
    #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
    #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
    #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
    #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
    #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136

Direct leak of 54 byte(s) in 6 object(s) allocated from:
    #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
    #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
    #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
    #3 0x56344954e6c4 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:267
    #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
    #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
    #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
    #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
    #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136

Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
v2->v1:
- do not store both a const and non-const string in the same variable, ch=
ange it to a non-const string.
  (Suggested by Daniel P. Berrang=C3=A9)
---
 qom/qom-qmp-cmds.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 49db926fcc..435193b036 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -247,26 +247,22 @@ void qmp_object_add(QDict *qdict, QObject **ret_dat=
a, Error **errp)
     QDict *pdict;
     Visitor *v;
     Object *obj;
-    const char *type;
-    const char *id;
+    g_autofree char *type =3D NULL;
+    g_autofree char *id =3D NULL;
=20
-    type =3D qdict_get_try_str(qdict, "qom-type");
+    type =3D g_strdup(qdict_get_try_str(qdict, "qom-type"));
     if (!type) {
         error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
         return;
-    } else {
-        type =3D g_strdup(type);
-        qdict_del(qdict, "qom-type");
     }
+    qdict_del(qdict, "qom-type");
=20
-    id =3D qdict_get_try_str(qdict, "id");
+    id =3D g_strdup(qdict_get_try_str(qdict, "id"));
     if (!id) {
         error_setg(errp, QERR_MISSING_PARAMETER, "id");
         return;
-    } else {
-        id =3D g_strdup(id);
-        qdict_del(qdict, "id");
     }
+    qdict_del(qdict, "id");
=20
     props =3D qdict_get(qdict, "props");
     if (props) {
--=20
2.18.2


