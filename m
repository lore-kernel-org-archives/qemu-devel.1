Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F340C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E888238A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H7I5wrUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E888238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWRG-0003Je-Td
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWO9-00019y-J8; Thu, 24 Sep 2020 14:54:41 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWO7-0002O2-K2; Thu, 24 Sep 2020 14:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDjRdPJa2vuPky/KFF2jfzDzq0+7CmgMS2NVx59ECBPDe6x+qmxnrXUMTwOcAhSZtmXbP0YedSPL4VWaQWAM20H7LRhHOvhJ3iRV8EZ1QVFImYBtwS7zvDNey7alWvCBo/yZAzo6Bee+HPoF8QNNFP0gZR94oLPnFeOWd05ZHNvmDRCKZu7VxqoUiSUTFVwgEMtpDu/b+W1DxDjCQzUtQkMqD68lADPXf0USC9t2iDahoLrOb7oRTXFUdALkSwAv6GAw0nsAcFClS0KFq/e/rY/FMvjot3VHm6/CaLILHJqC57c2xHQgVoBTSxYjC++palTda53fCW4bJjsNpwMD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYqpEH297IGWkFRtD9+RMk5kfLYHxD2l9A+HPSnAJ1E=;
 b=IVec6ND9OsfWS3F5y8gEhVnZ3wGKzcs/CXXW+IStbC2MQnhQYGtHpjkIiMdaB06dKXi1exOAiEC6wQj9ZZBpZz0HK9cnKnj1K5e50x9AeMBU/36Mspv73RG/KJkhIFC0MS0PS55O5dEWXrcGk7Ct+jwcMDAhihQcsN6sduM71tdUPgX/w593NQROmQdCNVcBblshJdDnVOMAC/wylLH/vVKk/6tu1pDMIolza+tvXZ6BKkytie22XJD0JA92gqzTydA/MKOfKfLoddmrThDUDB07AtLyRmmeFwqHSiKl+/uFT1iPo7uJ4zzUiDjtIHhIlN+741dMqwDT4nqLnTV42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYqpEH297IGWkFRtD9+RMk5kfLYHxD2l9A+HPSnAJ1E=;
 b=H7I5wrUxjimoK5jawXoJnJV/iSab0ZW71Zknw87KUT2CvmntiW3HOrBOoUZEvt+R06t8nqJ4CbKdE7FxZx6o0q0MQqhvv5KyYpWs+2mF0caPsZSww10gFBXJApsJ4mTAR1WopSdNAMbqmdtK0jJOgkVv2fE67ap4ur9cn23j78Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v9 1/7] block: return error-code from bdrv_invalidate_cache
Date: Thu, 24 Sep 2020 21:54:08 +0300
Message-Id: <20200924185414.28642-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 18:54:33 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a7fbbba-9538-4016-f3bf-08d860bb4715
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB434193EDCB84F17E25BC2702C1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36DzF1346X0PuKHZcZy0bS4W4LZzERv0e1odRGIfLo2R+DUQhOYJQ+TP6a31A2ILAIvKSJbOIVsZLGb7gKR+mfs4j6x0OYKNi2HQA6btn8WwBAQ6rdJpYVacIg6ETx1fwnVPmyHMF9TgIdQS2G9oH5Z+lGs9+UsJiOY8y7AFASNO0fohbvfIUAnMUpjyIwzFLq0zz9SI7cjYaK9V9n2k/esUKLhiXVrlgr/QTc9B4C/v50DFTPx7eRdZEZaeEmTn4tOLtIRxnVGrE5dYwnKy3Du2pZWXDgzMxv+H377XdyYmuKGLjD1FzD2ADseoU00MTdm7M20o/Imb5b3mf86C3QWcj26Qog5yOtxCOVskMCj0bJnl13OTOX8/BYcpkAxe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(7416002)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ok+psQ9yheokqXgHqp/iTA8n3/52iIjom1ceNGlqYLanxQWuEYce+5AByy4aS1ye0Yjj4m2XZMf6ILO4RRZ1uwEGHOmbqWqYkUF00IQT5Zk7yOwL16SNcXOUT1ywF2sOTXJfkLIL7xX7wc1+i/xaQC9rUL70GDbNM8ZAXy5Xz8sIpzdHMTQxvZpxrZ786WC/7d7X6GXN0eDAWbOWNuFrCjUMkMn5yZFwkvuQqezf4sACdvXXadP7KScNJHPHcqs+F07dLQE0tzqQugdFtfmtXYK9TlTTG2IQxtZhJeE2s+W0BVRI0uc40S9ptj/9NLVQicd2MLuSBbgn9CCFtDIp3EBMYnbrrJvjPPSAtYrGKw/I9xDv4B7Al5tQB16uNISaw4xV/3Xq03/SYRUA/TIGAorGgYZlSFIs2ToHfo9eIVtIqgpteJKXxGfE7+PXF/M/G7BLz5HTX1svy9hKn7v6F2kAN+a9rt3UCJf/K6iRWhGl7juDA8w78+u1DBVgJp101oR9hD4ZiuYQgaUkKuzGxJ+KwYuIk00SuUIfwx0M4swSmFlj7ut1DCHquXAe4Gumc033W3rL9z8w18IrOKes9ATwCxuaUXHodW10dK8yYlRZx/l4SXuCoKDHWg37fg3REpU+fmpakoF2Lf7VY/6pSw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7fbbba-9538-4016-f3bf-08d860bb4715
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:34.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UclNqJ5Gex4qGTccM420fgpV70US2ZJo5g/oXn02vHx16Egx2QA91puiDLBYvmzpP/Fzmrt+lq94hGhQ/yT8ygTDvqRyLiIV00DI9qrC7kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:54:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the only coroutine wrapper from block.c and block/io.c which
doesn't return a value, so let's convert it to the common behavior, to
simplify moving to generated coroutine wrappers in a further commit.

Also, bdrv_invalidate_cache is a void function, returning error only
through **errp parameter, which is considered to be bad practice, as
it forces callers to define and propagate local_err variable, so
conversion is good anyway.

This patch leaves the conversion of .bdrv_co_invalidate_cache() driver
callbacks and bdrv_invalidate_cache_all() for another day.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               | 32 ++++++++++++++++++--------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 981ab5b314..81d591dd4c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -460,7 +460,7 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
diff --git a/block.c b/block.c
index 11ab55f80b..47b3845e14 100644
--- a/block.c
+++ b/block.c
@@ -5781,8 +5781,8 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
+                                                 Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -5791,14 +5791,14 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
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
 
@@ -5821,7 +5821,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
-            return;
+            return ret;
         }
         bdrv_set_perm(bs, perm, shared_perm);
 
@@ -5830,7 +5830,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
-                return;
+                return -EINVAL;
             }
         }
 
@@ -5842,7 +5842,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_setg_errno(errp, -ret, "Could not refresh total sector count");
-            return;
+            return ret;
         }
     }
 
@@ -5852,27 +5852,30 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
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
@@ -5889,22 +5892,23 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
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
2.21.3


