Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC8EC3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F0B217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F0B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2WUj-0005oo-PG
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i2WTo-0005MV-26
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i2WTm-00009g-MK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:05:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47930 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i2WTm-00007e-A8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:05:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9822B10AC53E6A66FB6C;
 Tue, 27 Aug 2019 16:05:22 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 16:05:16 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <dgilbert@redhat.com>, <quintela@redhat.com>
Date: Tue, 27 Aug 2019 16:05:12 +0800
Message-ID: <20190827080512.2417-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH] qmp: Fix memory leak in
 migrate_params_test_apply
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
Cc: lcf.lichaofeng@huawei.com, Ying Fang <fangying1@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, zhouyibo3@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Address Sanitizer shows memory leak in migrate_params_test_apply
migration/migration.c:1253 and the stack is as bellow:

Direct leak of 45 byte(s) in 9 object(s) allocated from:
    #0 0xffffbd7fc1db in __interceptor_malloc (/lib64/libasan.so.4+0xd31d=
b)
    #1 0xffffbd514163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xffffbd52f43b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
    #3 0xaaaadfa4d623 in migrate_params_test_apply migration/migration.c:=
1253
    #4 0xaaaadfa4d623 in qmp_migrate_set_parameters migration/migration.c=
:1422
    #5 0xaaaadfa963f3 in hmp_migrate_set_parameter monitor/hmp-cmds.c:186=
7
    #6 0xaaaadfa8afe3 in handle_hmp_command monitor/hmp.c:1082
    #7 0xaaaadf479c57 in qmp_human_monitor_command monitor/misc.c:140
    #8 0xaaaadfadf87b in qmp_marshal_human_monitor_command qapi/qapi-comm=
ands-misc.c:1024
    #9 0xaaaadfc7797b in do_qmp_dispatch qapi/qmp-dispatch.c:131
    #10 0xaaaadfc7797b in qmp_dispatch qapi/qmp-dispatch.c:174
    #11 0xaaaadfa84fff in monitor_qmp_dispatch monitor/qmp.c:120
    #12 0xaaaadfa85bbf in monitor_qmp_bh_dispatcher monitor/qmp.c:209
    #13 0xaaaadfd2228f in aio_bh_call util/async.c:89
    #14 0xaaaadfd2228f in aio_bh_poll util/async.c:117
    #15 0xaaaadfd29bc3 in aio_dispatch util/aio-posix.c:459
    #16 0xaaaadfd21ff7 in aio_ctx_dispatch util/async.c:260
    #17 0xffffbd50e2f7 in g_main_context_dispatch (/lib64/libglib-2.0.so.=
0+0x512f7)
    #18 0xaaaadfd278d7 in glib_pollfds_poll util/main-loop.c:218
    #19 0xaaaadfd278d7 in os_host_main_loop_wait util/main-loop.c:241
    #20 0xaaaadfd278d7 in main_loop_wait util/main-loop.c:517
    #21 0xaaaadf67b5e7 in main_loop vl.c:1806
    #22 0xaaaadf15d453 in main vl.c:4488

Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 migration/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8b9f2fe30a..05e44ff7cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1250,11 +1250,17 @@ static void migrate_params_test_apply(MigrateSetP=
arameters *params,
=20
     if (params->has_tls_creds) {
         assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
+        if (dest->tls_creds) {
+            g_free(dest->tls_creds);
+        }
         dest->tls_creds =3D g_strdup(params->tls_creds->u.s);
     }
=20
     if (params->has_tls_hostname) {
         assert(params->tls_hostname->type =3D=3D QTYPE_QSTRING);
+        if (dest->tls_hostname) {
+            g_free(dest->tls_hostname);
+        }
         dest->tls_hostname =3D g_strdup(params->tls_hostname->u.s);
     }
=20
--=20
2.19.1



