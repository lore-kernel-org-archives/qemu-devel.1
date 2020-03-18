Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23BC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFF220768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFF220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESy6-0008N5-AN
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 03:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jESxQ-0007xU-9j
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jESxO-0008OE-Ug
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:17:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35118 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jESxO-000602-Ei
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:17:38 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7C4BD88D85FFC5CD00DE;
 Wed, 18 Mar 2020 15:17:25 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 15:17:15 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <dgilbert@redhat.com>
Subject: [PATCH] hmp-cmd: fix a missing_break warning
Date: Wed, 18 Mar 2020 15:16:20 +0800
Message-ID: <20200318071620.59748-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
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
Cc: zhukeqian1@huawei.com, zhanghailiang@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fix coverity issues 94417686:
    1260        break;
    CID 94417686: (MISSING_BREAK)
    1261. unterminated_case: The case for value "MIGRATION_PARAMETER_THRO=
TTLE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
    1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
    1262        p->has_throttle_trigger_threshold =3D true;
    1263        visit_type_int(v, param, &p->throttle_trigger_threshold, =
&err);
    1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:

Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: zhukeqian1@huawei.com
---
 monitor/hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..c882c9f3cc 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1261,6 +1261,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
     case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
         p->has_throttle_trigger_threshold =3D true;
         visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
+        break;
     case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
         p->has_cpu_throttle_initial =3D true;
         visit_type_int(v, param, &p->cpu_throttle_initial, &err);
--=20
2.21.0.windows.1



