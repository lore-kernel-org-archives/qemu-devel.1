Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438732068D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438732068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgMiu-0000YA-Hq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jgMi7-000837-IW
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 02:17:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3701 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jgMi5-0003Ub-Rf
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 02:17:11 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 79A54A2BE10EAA627F68;
 Wed,  3 Jun 2020 14:16:59 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 14:16:50 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>, <berrange@redhat.com>, <ehabkost@redhat.com>
Subject: [PATCH] qom-hmp-cmds: fix a memleak in hmp_qom_get
Date: Wed, 3 Jun 2020 03:03:38 -0400
Message-ID: <20200603070338.7922-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 02:17:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: euler.robot@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'obj' forgot to free at the end of hmp_qom_get(). Fix that.

The leak stack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f4e3a779ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f4e398f91d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x55c9fd9a3999 in qstring_from_substr /build/qemu/src/qobject/qstring.c:45
    #3 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:175
    #4 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:168
    #5 0x55c9fd88b34d in visit_type_str /build/qemu/src/qapi/qapi-visit-core.c:308
    #6 0x55c9fd59aa6b in property_get_str /build/qemu/src/qom/object.c:2064
    #7 0x55c9fd5adb8a in object_property_get_qobject /build/qemu/src/qom/qom-qobject.c:38
    #8 0x55c9fd4a029d in hmp_qom_get /build/qemu/src/qom/qom-hmp-cmds.c:66

Fixes: 89cf4fe34f4
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 qom/qom-hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index f704b6949a..3d2a23292d 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -71,6 +71,7 @@ void hmp_qom_get(Monitor *mon, const QDict *qdict)
         qobject_unref(str);
     }
 
+    qobject_unref(obj);
     hmp_handle_error(mon, err);
 }
 
-- 
2.18.2


