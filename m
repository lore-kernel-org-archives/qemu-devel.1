Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D530C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326B4206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326B4206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy5W4-0000c0-HA
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 23:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1jy5V2-0008CY-P5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 23:32:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39210 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1jy5V0-0001nB-NU
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 23:32:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 12D0974C484305D92D5B;
 Wed, 22 Jul 2020 11:32:46 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.173) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 11:32:40 +0800
From: Zhenyu Ye <yezhenyu2@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v1] migration: tls: fix memory leak in migration_tls_get_creds
Date: Wed, 22 Jul 2020 11:32:28 +0800
Message-ID: <20200722033228.71-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:32:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, quintela@redhat.com, yezhenyu2@huawei.com,
 dgilbert@redhat.com, xiexiangyou@huawei.com, zhengchuan@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently migration_tls_get_creds() adds the reference of creds
but there was no place to unref it.  So the OBJECT(creds) will
never be freed and result in memory leak.

The leak stack:
Direct leak of 104 byte(s) in 1 object(s) allocated from:
    #0 0xffffa88bd20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
    #1 0xffffa7f0cb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
    #2 0x14b58cb in object_new_with_type qom/object.c:634
    #3 0x14b597b in object_new qom/object.c:645
    #4 0x14c0e4f in user_creatable_add_type qom/object_interfaces.c:59
    #5 0x141c78b in qmp_object_add qom/qom-qmp-cmds.c:312
    #6 0x140e513 in qmp_marshal_object_add qapi/qapi-commands-qom.c:279
    #7 0x176ba97 in do_qmp_dispatch qapi/qmp-dispatch.c:165
    #8 0x176bee7 in qmp_dispatch qapi/qmp-dispatch.c:208
    #9 0x136e337 in monitor_qmp_dispatch monitor/qmp.c:150
    #10 0x136eae3 in monitor_qmp_bh_dispatcher monitor/qmp.c:239
    #11 0x1852e93 in aio_bh_call util/async.c:89
    #12 0x18531b7 in aio_bh_poll util/async.c:117
    #13 0x18616bf in aio_dispatch util/aio-posix.c:459
    #14 0x1853f37 in aio_ctx_dispatch util/async.c:268
    #15 0xffffa7f06a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)

Since we're fine to use the borrowed reference when using the creds,
so just remove the object_ref() in migration_tls_get_creds().

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 migration/tls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/tls.c b/migration/tls.c
index 5171afc6c4..7a02ec8656 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -58,7 +58,6 @@ migration_tls_get_creds(MigrationState *s,
         return NULL;
     }
 
-    object_ref(OBJECT(ret));
     return ret;
 }
 
-- 
2.19.1



