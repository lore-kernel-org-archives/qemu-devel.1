Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5FBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0D620659
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v7sOLXD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0D620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWVA-0000T9-2G
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQZ-0004ew-44; Wed, 16 Sep 2020 08:20:48 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:3150 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQU-0004Gb-KJ; Wed, 16 Sep 2020 08:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU1mpViYcU/yVKNd9pJPN5IEJsML5HbP5vGIaPap1zNaQgSEOfZmSMcW0tLNmVgNVufAm+VuIyWtqVqcwDmyq0sn9bVVN53mmqK5Bp9Eiw0jeOSmOst3buBN00QYb0wPOFRNAHRZ7JAcOW8y1eW8Kx1Q+u2HhW5xK9cHkL/hnXM9cDmmbtwz0npY+GD9MEU8DDmIT/GJE/j7F47Ip3rK+3sFAtWXlB6H5bYcZxgTMn1wK69p+rDCg1ynSNYmmA38zrgAzsrm2ZgjqAu2gQR2h100nA+cNY9IldCRD8ZtGcDVCg0XhUm06cpQjxPzLsekN8ZntTT41xaenEl3ISbWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHGui9e28287bTitd6Jgt1pRrEyLELX/dwjny1Dn7rk=;
 b=NHOMNJJNW6VDNhejfXfQX4yC+6ZtuswCPP9eHF1fM5uPCBk6aRZ6snjwefjhGH44dQBgjqLksfifgs+L0Axwj3F/Ps8gHcMN/82KFG4URywRdjDTo8ocY6ZbBhAYmly3LimoTbY7DG79V+V4EuXDdD24tB3OHj1lkLfz8f84dJRoaVh57TP9M3HLlTxKY7dApqiVjHPWRzQionotA3mVUaMh6qaiQ9OoFsyRpCMbHqnD+s6P5IXlu/WrdRhwAGwn6VQaofze4kbLgzVEBeKnUYhz5lbWtwDcRuXHjWKqCnOVq+hjb6AD/NaF0iTj2iYMo+/2VT7iYJsyebwP1yI6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHGui9e28287bTitd6Jgt1pRrEyLELX/dwjny1Dn7rk=;
 b=v7sOLXD1tMYSkskSKCWEhLsl/i5xXQFbaHeJ9xExx5mBKvzSWFdK5PJST1wCe8SnP1PUd1pmAPd/utvAwowBYQPMjovRZrLNKzRoLqGA0iFdAqfyb240VilaovRM5xJHeDH5ztoQEUpWSqpnGZBhzsJHYfrNZkK4h5MWFmXDw70=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 12:20:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 12:20:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH v6 2/5] block/io: bdrv_common_block_status_above: support
 include_base
Date: Wed, 16 Sep 2020 15:20:05 +0300
Message-Id: <20200916122008.20303-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200916122008.20303-1-vsementsov@virtuozzo.com>
References: <20200916122008.20303-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:208:122::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 12:20:24 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c517bd-e9ba-4f50-b80e-08d85a3ae38c
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5077A4314E01E653F6A4833FC1210@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3wE52k8uQyNhK4Gsh63L2BBOkyfHYi7wd97agJ8a28BH0cF5mUrM6x1QaEb110DsvQftLK96YKbx59benaouo+WIMM/HJlsBeBcjPqOuhqxODO4MDX5V//RpM11pw6szx18s7hDPOQ88TA77bP36dwiq20pnbW937RfolQjfxcZDijnzLYHd0X/UsH5sSbHBKvTqU6GjwhP9lURVySqsKKyO1bAjPuogN22E6IfqkIPTS9PhGcvEoWeuDAVSmiMLJzio6OyCh099C4rkYo/GKfodDOW/KztVP202wUpITFTvC7FUJ96lFDWoTebzJsBgW0oN0/1gnHR5hLyXlTIcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39830400003)(366004)(396003)(26005)(16526019)(6486002)(316002)(478600001)(6506007)(186003)(5660300002)(6512007)(2616005)(956004)(1076003)(36756003)(6916009)(2906002)(8676002)(66556008)(66476007)(86362001)(52116002)(107886003)(4326008)(66946007)(83380400001)(6666004)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i5IMuTVsBIq+roXxxZ89cbmtmH2C+rC7fDj22ErqQDMYYiUKZsbbu6x0Ij/rXepGss3mmO23f2oszWwZ1MDxRSslEcdk4e1dVu4O8u7wO8OIgYVmkV1n3XgJY2pc1F5vhSHIYltkEsXE3Wi2b/YU4uaRYT2X5gyboM/629hpGBejM9858YpM87ygAigBdPu69XwN3700cGZ9h9/LI2jDcWYPqO00wvpjLi5zKqt3pi2eIkLUDNHb7Ez6BGWgg8B8ZVFhayHGvEbHC6Jx9hCe7QPNujBlR3JMF12KQuR0YDM5ythUQNV89i2QtlQiATJtRMaqXXG9/nlEkYGzjK93EaqzMxNaRgklGYD6wAPjZLQ8ySlPhotkPp1Er2IhMsCimAENdtZULgdktyXC7NrDHAcWU7z7KFIkXRn69Ydx0mt8VCqBDqGtA0zIRz+ghufRsq/ube8k8J21SuTI7hx+ElDDxQzURZcvrtmYjOKyNIQFaEqNKbGNEnJznrKo/Br++LdMNcuYIfcaptBqM0Aapk/1dzTK68PwW5c2SHCQ2rGr/kba4YFdBO3vNG16msXGv/bGhQApAGlKVlLFoP068GbJ0x11+gVRjWSYjrz/3D/28zMOkKeAQI/Ncwd2i8iHGkeQ74fvCwZwwarFYbqXvw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c517bd-e9ba-4f50-b80e-08d85a3ae38c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:20:24.6472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUtws1bhqSqUxoldI9rJVmtAhjrihXabQSjNxk0NUyi//bSjfV6q8fqp+TbS5E5dP/d/IsBzZRPdF9/WO7beeZIrf+Jn+L/D3W+ycjhbVGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:20:24
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

In order to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above, let's support include_base parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h |  2 ++
 block/io.c         | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index f69179f5ef..1cb3128b94 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -41,6 +41,7 @@ bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
+                                  bool include_base,
                                   bool want_zero,
                                   int64_t offset,
                                   int64_t bytes,
@@ -50,6 +51,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
 int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
+                               bool include_base,
                                bool want_zero,
                                int64_t offset,
                                int64_t bytes,
diff --git a/block/io.c b/block/io.c
index e381d2da35..0cc2dd7a3e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2359,6 +2359,7 @@ early_out:
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
+                                  bool include_base,
                                   bool want_zero,
                                   int64_t offset,
                                   int64_t bytes,
@@ -2370,10 +2371,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     BlockDriverState *p;
     int64_t eof = 0;
 
-    assert(bs != base);
+    assert(include_base || bs != base);
+    assert(!include_base || base); /* Can't include NULL base */
 
     ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
-    if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED) {
+    if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
     }
 
@@ -2384,7 +2386,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     assert(*pnum <= bytes);
     bytes = *pnum;
 
-    for (p = backing_bs(bs); p != base; p = backing_bs(p)) {
+    for (p = backing_bs(bs); include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2420,6 +2422,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
             break;
         }
 
+        if (p == base) {
+            assert(include_base);
+            break;
+        }
+
         /*
          * OK, [offset, offset + *pnum) region is unallocated on this layer,
          * let's continue the diving.
@@ -2439,7 +2446,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
                                           pnum, map, file);
 }
 
@@ -2456,7 +2463,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
-- 
2.21.3


