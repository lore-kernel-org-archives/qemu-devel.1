Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571C2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD672075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD672075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZW38-00048d-81
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iZW2R-0003iZ-Nn
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iZW2Q-0005Jl-NP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:17:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42934 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iZW2O-0005HL-3D; Tue, 26 Nov 2019 03:17:32 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EF58A27935F99949E3CD;
 Tue, 26 Nov 2019 16:17:26 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 16:17:19 +0800
From: <pannengyuan@huawei.com>
To: <berto@igalia.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH] throttle-groups: fix memory leak in throttle_group_set_limits
Date: Tue, 26 Nov 2019 16:17:02 +0800
Message-ID: <1574756222-43976-1-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: liyiting@huawei.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 PanNengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: PanNengyuan <pannengyuan@huawei.com>

This avoid a memory leak when qom-set is called to set throttle_group
limits, here is an easy way to reproduce:

1. run qemu-iotests as follow and check the result with asan:
       ./check -qcow2 184

Following is the asan output backtrack:
Direct leak of 912 byte(s) in 3 object(s) allocated from:
    #0 0xffff8d7ab3c3 in __interceptor_calloc    (/lib64/libasan.so.4+0xd33c3)
    #1 0xffff8d4c31cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
    #2 0x190c857 in qobject_input_start_struct  /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:295
    #3 0x19070df in visit_start_struct /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:49
    #4 0x1948b87 in visit_type_ThrottleLimits  qapi/qapi-visit-block-core.c:3759
    #5 0x17e4aa3 in throttle_group_set_limits  /mnt/sdc/qemu-master/qemu-4.2.0-rc0/block/throttle-groups.c:900
    #6 0x1650eff in object_property_set  /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qom/object.c:1272
    #7 0x1658517 in object_property_set_qobject  /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qom/qom-qobject.c:26
    #8 0x15880bb in qmp_qom_set /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qom/qom-qmp-cmds.c:74
    #9 0x157e3e3 in qmp_marshal_qom_set  qapi/qapi-commands-qom.c:154

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
---
 block/throttle-groups.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 77014c7..88418e6 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -912,6 +912,7 @@ static void throttle_group_set_limits(Object *obj, Visitor *v,
 unlock:
     qemu_mutex_unlock(&tg->lock);
 ret:
+    qapi_free_ThrottleLimits(argp);
     error_propagate(errp, local_err);
     return;
 }
-- 
2.7.2.windows.1



