Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A321EC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E28720661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZHj8Sg0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E28720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT52Z-0004Xf-FE
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4vH-0008Ux-5z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4vG-0007o8-Ow
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:50 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v7-0007iF-7A; Mon, 27 Apr 2020 10:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX060VwXV9NUZgzkd9ARvUT1XOMgkOcRwtwW6gbSOIm9wJ/QBczxx4nqJ+tTwXbC5a6IzniVx1JWp8R5mjpTKRVXTvnEwKnu9q19Lz+wi4yZ32XDOE2sPc1SJrvWqC2FjOisfuiFR5uX8PI7iprTX8PR1MFh6mlkYEY4OHq3e5Bo5lgIOkOF1RsIriLUQSoIV7nPa9On12+5aJdLoAA0VlekPPBJVZsyS2ZdTRn4nxoLAUpldAer4FUt59XVJYPyFXQr8ry51ogHXfCGaOEMBMCbkqJBtCAFTGZVwQVST9K9gpVd3aPwCoDjJC5ZydOIMbvPKFM6wCbHoxEW28WQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhCI3mR5pgL/iYViE4V7hx6uZsZTQBrSjdHTZOX0Z4A=;
 b=YQT+AnsX8VGWVvRS1NqYiBQZaDJulWyVYwluM+tdNQjclrjkW+iEcpUmuDpCLSRGp6yIpIFI0m/flSk46h+T1Az+o8xTr62x7y0iMm03IXEScn0ZCcVs6OMJjzJzYZw8dqUC8A/4ej6fCpQlSYUmWgm2jrJ/Jk8iOg+npYjCi01eyIKW/nsw02YciltKAgs6o9hJaIAE1QGCn92Nrmnhv0BSdPW6M9RrJkkPatYTP6SaDaAPAi6n1WMwYlzF4UhdjdDDbcIx9pSMSh7G4oikxP0ufJy62ENT5a6Nj90vehKXodiM3W83+wmEB7JGsPCQkwLVICjw1xYCXrXiQQnxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhCI3mR5pgL/iYViE4V7hx6uZsZTQBrSjdHTZOX0Z4A=;
 b=ZHj8Sg0Dnv4B4qN8LiLeNPRVisbFqUSb2h/z/t9yo6LiyxOLtR3xvlREnz6dMshkPKk/zfXmxcTm/cUPBawQyqKV+HfLE/t+pIxs8iz312IQu+azTieajqA+Cqxnsn9l0v9QjONSX41qNChvsFRJZA2MjFLuGSNRtKl/4jdkiAI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 9/9] block/io: expand in_flight inc/dec section:
 bdrv_make_zero
Date: Mon, 27 Apr 2020 17:39:07 +0300
Message-Id: <20200427143907.5710-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:36 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b1b9897-6afe-48c7-449d-08d7eab8cf90
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552776CF32DCA84F073A2DF9C1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfUIeXB7MPLq/l6bYP1esF1UvzDwbKMUP1sIu73zk0W4SQTLbHujYK8mPBDDs/n7MgtCWE8kuRPz5eeBL4Lv71pzW7yFWqycpn1PVGZuhzuDIbAPLlzbpUKvPkTlzbRRjckZISCjxTh1AupX/DqnWB3C1i2Ng3UjIVPBNZkM3ktSUIBqKaZUfFe+9s0+7yw09n3uNIYoZU6xWFbNYOfQMgW0vE8GhUqcwHSx4Fuh18h8otthCMB483yb+zMG7E3e1jqz40tNvEmGB2fyQ+OhL7lkjYyiGckaik8yiVO2u0EYRrKJjVSEUmRFfSkQA+3PI5V9GRHm6yr61t151h7qiCttLk8tI4H+lrS0WJkqD6lZdYV6HXnOa4vnDsrUUHY2AtcMDxl7T5vaIplvrCFOA7P4Md0sFBW96bfvSykN8YA7pNl8Uh5wZGUZZcP9Tdq2vUXG6AdcaqxR0pC7nKtfC9fUxgUo3Sj4x8EWhfs+0Z6ne7c52lgoR/5ZUqSKMmlz
X-MS-Exchange-AntiSpam-MessageData: /bq9qBvTjGt8cgaZpRk2MmKrx5dUa0qYqnqVFB7M+nX7axKJB+bHh1+XkZ8evEMB3Ueh9hnesol7uUxNiwOIie2ovZYg2jKgHG77hJ1obob2wgPGkGTnw9KtTg34pSSFcuLMedQoXf0Ks1yhZYtMH14Hajg+5SlKyyiLbp7BYBVMQWvcz0IPOEjTvi16IPB822E/xqFLxKVLdlx9gTiIyujfbMfzV5kUI2684tXfUTt31gl8PgCig4lXse1620y15WQEGR6c43WtlwuM20FjTiBtpc4hDxFWkn7MAWbBJA1TMQ3ow/RfyfQNltT2XuuWbTag+IXWki+utsDMqMFHrmzUbyGcJ15xMm2E3iZGuTA2nnrcROtQw8TXo2EYMAAbn2iFHLAi97nUiJ2/TmDEHvt1We3pNhe41eVn6WyUXgNk1sLBfHkBvTb1xKpUwgMYVGUK8l0w8kwg09ueah9JuX5kXviEjvFdoMhy1XIePfoX+/4JLi6YOjLBCZrur6bOAsPCM3HvyzPd20D3y666nDzVFPTQEZbc3tl2kCCWs7C+OuNN2ES8vTHUT9DvxSNt5rNfAsSWc3TgwuZLJF95Ytc7haemXiTgr97OQImKqYmC/77xwZ8U3EoIeOCWaX70vvQJHAeVdi3mRG6CeQb9v2mz5tXINKquAnp9wjrI3nQAYZn7AEeGW9PVip6nfi5+oM3JFiI8CUVTD/nqvw5BQ65zHscxEwi+2JKHHHH/U19tu0n6mp3uWVBOdYCr77WF5HwUEJ3jhKA8YOvvk7I/1OE14Y8EvBkEWQXFmUMyj2o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1b9897-6afe-48c7-449d-08d7eab8cf90
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:37.5436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj9UX7klU47bQ9As2zCq1K29MHjf3FtlSkd6QrMsKgwGpe2Ase4pF1OtB9Y0JmMPmflW5uhE4K9am4kDnNFuzKOFYgdzpdlICWeS5749qFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's safer to expand in_flight request to start before enter to
coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
Note that qemu_coroutine_enter may only schedule the coroutine in some
circumstances.

bdrv_make_zero update includes refactoring: move the whole loop into
coroutine, which has additional benefit of not create/enter new
coroutine on each iteration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3bc0daec33..cd5374e6c7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2740,8 +2740,11 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
  * BDRV_REQ_FUA).
  *
  * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ *
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight()
  */
-int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+static int coroutine_fn
+bdrv_do_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
     int ret;
     int64_t target_size, bytes, offset = 0;
@@ -2757,7 +2760,8 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
         if (bytes <= 0) {
             return 0;
         }
-        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        ret = bdrv_co_block_status(bs, true, false,
+                                   offset, bytes, &bytes, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -2765,7 +2769,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
             offset += bytes;
             continue;
         }
-        ret = bdrv_pwrite_zeroes(child, offset, bytes, flags);
+        ret = bdrv_do_pwrite_zeroes(child, offset, bytes, flags);
         if (ret < 0) {
             return ret;
         }
@@ -2773,6 +2777,50 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
     }
 }
 
+typedef struct BdrvDoMakeZeroData {
+    BdrvChild *child;
+    BdrvRequestFlags flags;
+    int ret;
+    bool done;
+} BdrvDoMakeZeroData;
+
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static void coroutine_fn bdrv_make_zero_co_entry(void *opaque)
+{
+    BdrvDoMakeZeroData *data = opaque;
+
+    data->ret = bdrv_do_make_zero(data->child, data->flags);
+    data->done = true;
+    aio_wait_kick();
+}
+
+int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        ret = bdrv_do_make_zero(child, flags);
+    } else {
+        BdrvDoMakeZeroData data = {
+            .child = child,
+            .flags = flags,
+            .done = false,
+        };
+        Coroutine *co = qemu_coroutine_create(bdrv_make_zero_co_entry, &data);
+
+        bdrv_coroutine_enter(child->bs, co);
+        BDRV_POLL_WHILE(child->bs, !data.done);
+        ret = data.ret;
+    }
+
+    bdrv_dec_in_flight(child->bs);
+
+    return ret;
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
-- 
2.21.0


