Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ED920835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eEX+rCTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ED920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2pH-00067p-In
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oF-0004Rj-Th; Wed, 27 May 2020 16:37:55 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:57342 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oE-0007uz-Ot; Wed, 27 May 2020 16:37:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqKaaoPqqCaUiuFWQX7FdFljpUPu2jrlxTiv8UWv4USXYVg7j3mF4Qfw0hs5MNUmswBwNerO+OHIjVVWux4kiy2Ed4K+0FPLexvW9H/2owy6DRHS+aiBZFzu3aQB0WtzxlCqvWSUdSHQbRLT+ddJZtEUdr7NNHQAfHz5+FT8z0bOoQwkQcBiDUKp6lQKTjn75E34AgYiLN3VyFlXRa6Wt8SJEzvFjnAb88mMj9xijKgBda6x86K3VwymAOtBesH8Gtgxsd9QF+fHSrM83gMmogpL/pvZgDZa88HJ56BAGtTMzeXQHwnb7JS3Ck7z5PvEnYbgrCGGRKAo/XukYcKCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfPufP/IZK8kRWDGxlOJVFuyZsiyXUFfZaqTGzDh6NM=;
 b=mYlz32ZqgOyqw9UkS0tvDTblLx3FayQmiyyOsNxqXej14fDQGKa3+jrT4JaQDhrnjxpIpsD4PeSVG7aeFBTMbm8+AxguyjBl4YqT3HbGdiqXay2ae6Wk8ukKvBr7YiQmwKGmT+LejB/Qwz1Sz7kU/5mdgoqBUVhzZ2CLo4BzoH4rGxwpTGycMaoxRh5HOUsoLh/7AMPY/hwY+8owMeE/7NyD4BBqXDDkTv2Vt2LyD7hPSZZ1ws9zFd5NMbQ2typlipkXcoj9zy24MkFAQs+xbd0lN4StXB1I5moHj7/l1Cd7uiL6fSGqoECPeFSvt95WkyPoJuAtj9QcIywZXXnFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfPufP/IZK8kRWDGxlOJVFuyZsiyXUFfZaqTGzDh6NM=;
 b=eEX+rCTxt09igMHo7TDiizeVo7OJJa4OQq7awxTL2FNNuT/h8fv7yip7561Cemw9W0neSDgF9t8rP6FcitoTWy6Pp+LzmVa/T0+w+jGSAQi7aOUygdIuFD8l3dEl0SwIdu6DlI4S0azkWXLhzgU/vGf7UgNkYWLzazyPB9/3Ft4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 20:37:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:37:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 1/7] block: return error-code from bdrv_invalidate_cache
Date: Wed, 27 May 2020 23:37:27 +0300
Message-Id: <20200527203733.16129-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200527203733.16129-1-vsementsov@virtuozzo.com>
References: <20200527203733.16129-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.148) by
 AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:37:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5039558f-8c68-482d-1a5f-08d8027dd263
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336891B460BD84E32CE167CC1B10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJgZTqUR+h6bbSxcnQzbqhaK1oucTCJM6YYY0FB0p9ycUhMYyArVicbahZXk2Fo+Yk9LdUwTMKPjg4VmqptAgAvGKvBa7siaS7db747pLIgzCCh9JtFi801Dxtqkxyowe89/HRB1iWuDkzPVZcb0ZX6nsXf6G0AIxW3hlWogj6dfy0L66HpWTRTzNsAI03IyJWfnbBI/sTi8N1f3WhQjFqX4/pK19eLjbQA9qYTJaHiqGMnVA1P7R0Q4OKQnFbBuPqNkThVtRa3iBJFlYqNe3R7/sBERefqLspWr+UaVW1GBXlzF+QBXd8sgHkDOaUiR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(956004)(66556008)(66946007)(66476007)(8676002)(6486002)(6512007)(1076003)(478600001)(186003)(316002)(5660300002)(6916009)(2616005)(6506007)(8936002)(16526019)(26005)(2906002)(6666004)(83380400001)(36756003)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8/msihvap/dfpggpLPhVW9B4fuFxOBf8obm7H3mZFzJoBGpkwP8hvUEhyoLvU9Yzpg5vWvho0rtj+UHUGTuKHX5zW+rsyfS8QQCZNsRwuS3yC2InLc1vfuNy2A+p6TwKujJX22jvexooWj/XO9DwofH9X/bPreKYsXWRt4L9id3dfw6JvLA9lqm+bzexg4qzVsNVviieqBog8T8mrRE+VSoMaWkpmpU4fQoo2I8ZDFSaaMCFbScAfT3jJ5KqeNkx62HkCPREtNbckPumyaDKi2psXoMGCALqFPWyvNUymLP50IVwhLw+jjbPK5cowQC0523jAhBeBhXsVv3CBDjYmncHKy0pV2q3Rza3wP3fF5A0YvPMbjCEiZvxEiQG4hwJ96PBkLbwGdH4IFtCZjkd89kGexsYOiwlJ3il6ldMqv2joI5H+yImK4ZGfwBw6kDjFHGuMSkL2+1WYynwDl1J6qhpbO6I2gbXujhMgIdTmmoLiogcpXl2eIicpzrtNM8G
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039558f-8c68-482d-1a5f-08d8027dd263
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:37:49.8779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8jYznJxCmaZAiAE/MeVn/Xhm/gedUh6DMkR6t/wWYe+Z+JeSvkNo/sR6nWDzaRwP+s2hUHD4TVeeenJxoQVBgNNFt3AFGJ2PA2JeKXeWS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:37:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the only coroutine wrapper from block.c and block/io.c which
doesn't return value, so let's convert it to the common behavior, to
simplify moving to generated coroutine wrappers in further commit.

Also, bdrv_invalidate_cache is a void function, returning error only
through **errp parameter, which considered to be bad practice, as it
forces callers to define and propagate local_err variable, so
conversion is good anyway.

This patch leaves convertion of .bdrv_co_invalidate_cache() driver
callbacks and bdrv_invalidate_cache_all() for another-day refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  2 +-
 block.c               | 32 ++++++++++++++++++--------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 25e299605e..46965a7780 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -464,7 +464,7 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
diff --git a/block.c b/block.c
index 8416376c9b..b01551f21c 100644
--- a/block.c
+++ b/block.c
@@ -5643,8 +5643,8 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
+                                                 Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -5653,14 +5653,14 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     BdrvDirtyBitmap *bm;
 
     if (!bs->drv)  {
-        return;
+        return -ENOMEDIUM;
     }
 
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_co_invalidate_cache(child->bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            return;
+            return -EINVAL;
         }
     }
 
@@ -5684,7 +5684,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
-            return;
+            return ret;
         }
         bdrv_set_perm(bs, perm, shared_perm);
 
@@ -5693,7 +5693,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
-                return;
+                return -EINVAL;
             }
         }
 
@@ -5705,7 +5705,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_setg_errno(errp, -ret, "Could not refresh total sector count");
-            return;
+            return ret;
         }
     }
 
@@ -5715,27 +5715,30 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
-                return;
+                return -EINVAL;
             }
         }
     }
+
+    return 0;
 }
 
 typedef struct InvalidateCacheCo {
     BlockDriverState *bs;
     Error **errp;
     bool done;
+    int ret;
 } InvalidateCacheCo;
 
 static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
 {
     InvalidateCacheCo *ico = opaque;
-    bdrv_co_invalidate_cache(ico->bs, ico->errp);
+    ico->ret = bdrv_co_invalidate_cache(ico->bs, ico->errp);
     ico->done = true;
     aio_wait_kick();
 }
 
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
+int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     Coroutine *co;
     InvalidateCacheCo ico = {
@@ -5752,22 +5755,23 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !ico.done);
     }
+
+    return ico.ret;
 }
 
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
-    Error *local_err = NULL;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
+        int ret;
 
         aio_context_acquire(aio_context);
-        bdrv_invalidate_cache(bs, &local_err);
+        ret = bdrv_invalidate_cache(bs, errp);
         aio_context_release(aio_context);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ret < 0) {
             bdrv_next_cleanup(&it);
             return;
         }
-- 
2.21.0


