Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED94C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE1820DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pnhNP4O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE1820DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL3D-0001JK-OS
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL01-0007OZ-TE; Fri, 18 Sep 2020 14:20:48 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:41027 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzp-0004nY-HX; Fri, 18 Sep 2020 14:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS21SY2f1fZ4p98EML+ndfW+je4tAoTg12qKbCU16VsMElJAFavaBwqBjibBeuMWtl4e0DSusi5723DPwHZ2lfmngGyRKaUkqzkLwBOB7sCNHy/sqzRnJrW4aPDPURMYWLpRiXtTSUDIBMEKi05uzO9W/ou2peusf7oBRDszPGaloFjSp3v40lhcBskHaFVbHiHZ9QxJwLv/bW2f8HnVT3CFi9JwU5BVMct/JRsMicPbCoKvR5lTuTJ0303zFPnpW6DXpggZTfLxJYkK6EGrQ1dFX22sSiUKZrmfieGhcrEJIwD7ncrXZAY9S6beNEsGk3Skv7cm1R5qcQT8ag+ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFBZkftLXX/Y3HnlWPhJKOZuo8TRJWRrZ+Ziw+DB6aI=;
 b=I0oiLIt9gLAX0tOEKNEOHJq7b0sQJBoIa9i4MRi9N4djK0+7J0iq+pa8RXPwtq7BEed1HvZh/WLe96g4ISgVZsZgX+CvHSEmNi8h9tT7l21NIM1WR5+a9D7lcWn35tVnYOck8Zw1iFKMpB0ryd2gz7wOs/32Oj4ve9uafXlDr9mZeFw1570L47zqb3xByGE2mbz6GlanpAwfZWTo3Es35Z5lE+V17hRSh6CgQ29CRPSvjK8t2xReT2oj6fNaO2hkXaSjVh742+Pw7W6gXmz8xY85Ee8HUjg38Y8Ex0aW8ZAksDwqWMGuoPLa7Q09JqxP9iLIwt8lRUbRUV7zCmET7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFBZkftLXX/Y3HnlWPhJKOZuo8TRJWRrZ+Ziw+DB6aI=;
 b=pnhNP4O8VInriwlxDw54JnRna1kE70XrxvcWwgPEs56qoN/p8pl93DcoFdOXe6KKAFbXEUilxCn03Zoo3Nxuld5SSlD/55RBli5mPI8lUnY116WZt4/47W5Ok/MYYJ133FQjJn9Y3jxuoMVIDaUptVHSG/1W76ifk1F5B9Vogz4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 05/15] block: bdrv_mark_request_serialising: split
 non-waiting function
Date: Fri, 18 Sep 2020 21:19:41 +0300
Message-Id: <20200918181951.21752-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:08 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fbad14d-c543-4b3e-68bb-08d85bff79e3
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905B13A3C10EC5EC1617D84C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4FrA8cbwNjE8ra0PGcOW9lFbttviwXNc2cyqdQpREXqWwJO9yDMHkuHnxp8CpNL+RcBPOLMhA5UfingSR7CASVmrbMnC8PrS7gqrW1JUv/ZomN+jz7jbBaKTP0IMW1l7uSRgY6/wm5H15IewJJDH9vtbO1+WxmdF1EU+eYE+0vfzfm3H+kXwFtOEGUBDKFFsL7yvsldJRCstu7/Ar5zUsunS1PC5VSu+Mvbi3Z/7t1nSlVK6YWgDTJLy2waW8k3vpu6boxyoodWfH8Lk5NeRsfARf7oNnC/Lm/PhAorLqMZTVx7g9Y9axS1az4KCoDblns8t7tMZ7V56DlIRf7TF4wi5oxjSjU3di1emaGNKJZLrgbuGBOmr6NN1W0xT+hD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mWkFK5drIQ4MZuzOWwgk+2soJE7JFAgnZx++nqzmZ4jJ/Q730bIKMDGU4a8X5i7PVporp745SHoSUAhk8RlbF0mSxc8BpnKJlC8jejUr+tvjHA5z002tK9Wu/pJqt+Xq7xtn+b+jhPmU2L+FgdtgnM/4fQphFcQlwFTEMS0pTWk30ml18mT1uEzizqcSXrimTFaHzT2M52c14OD7sFtYVNLfkwV+Yj+1F/4i+2OOQZoQCXXzN3FU8MtNNWz6mkKp6BNgK3d2LgnuD3xVRNPlwIe68zN3qdzjKcgSL8FKGQBYImnGJJdw6GY5gwWvSayvt1yO3FuXITBOglACoBsFsGR6tEi4MQOySu7c+1GMHCDbbguo4TKappIaABC1XjtAP2wlQL5H/40WTYz6h3T3wV/d29Z5pFQ/vbGng88RTSpF6E5Riip1fuU9YcRzKWjqfHgvk1vcL4l81doSwuqNrvMz+TwCu25GCLGAMi8ZjztfEs1RPO1Iz6Wm5ADX2dA+2J/5kqvpzQaMLS9SM1hBoss6R5PgAZPEct1FzFblp1KQSYhYddO5qzvVLsb3fZQ7T2M6n8AGkIkk43mSBKEh/fl+1XUMisycniozW30pcWOWsVqPPMFCNhgS4n4FIzYE9N7Q+vBzI0iOrFZ5B54cqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbad14d-c543-4b3e-68bb-08d85bff79e3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:09.4641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+GyL5lG9D7vLyBcvIXhZVwtP2qBNCHhDBhrTEi7H7EL1hZZN0NYZFQU9riTGvwG0XHJJd3/h8DYyKQ/PvPLgfxcVQY8km1evTwVRVSOtX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll need a separate function, which will only "mark" request
serialising with specified align but not wait for conflicting
requests. So, it will be like old bdrv_mark_request_serialising(),
before merging bdrv_wait_serialising_requests_locked() into it.

To reduce the possible mess, let's do the following:

Public function that does both marking and waiting will be called
bdrv_make_request_serialising, and private function which will only
"mark" will be called tracked_request_set_serialising().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 ++-
 block/file-posix.c        |  2 +-
 block/io.c                | 35 +++++++++++++++++++++++------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38cad9d15c..887b0668d8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1052,7 +1052,8 @@ extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
 
-bool coroutine_fn bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align);
+bool coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
+                                                uint64_t align);
 BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs);
 
 int get_tmp_filename(char *filename, int size);
diff --git a/block/file-posix.c b/block/file-posix.c
index c63926d592..37d9266f6a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2953,7 +2953,7 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
         req->bytes = end - req->offset;
         req->overlap_bytes = req->bytes;
 
-        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
+        bdrv_make_request_serialising(req, bs->bl.request_alignment);
     }
 #endif
 
diff --git a/block/io.c b/block/io.c
index ab9ef7fd1a..9b148bb8ea 100644
--- a/block/io.c
+++ b/block/io.c
@@ -778,15 +778,14 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
     return waited;
 }
 
-bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
+/* Called with req->bs->reqs_lock held */
+static void tracked_request_set_serialising(BdrvTrackedRequest *req,
+                                            uint64_t align)
 {
-    BlockDriverState *bs = req->bs;
     int64_t overlap_offset = req->offset & ~(align - 1);
     uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
-    bool waited;
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
     if (!req->serialising) {
         atomic_inc(&req->bs->serialising_in_flight);
         req->serialising = true;
@@ -794,9 +793,6 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(req);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
-    return waited;
 }
 
 /**
@@ -882,6 +878,21 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     return waited;
 }
 
+bool coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
+                                                uint64_t align)
+{
+    bool waited;
+
+    qemu_co_mutex_lock(&req->bs->reqs_lock);
+
+    tracked_request_set_serialising(req, align);
+    waited = bdrv_wait_serialising_requests_locked(req);
+
+    qemu_co_mutex_unlock(&req->bs->reqs_lock);
+
+    return waited;
+}
+
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
                                    size_t size)
 {
@@ -1492,7 +1503,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
          * with each other for the same cluster.  For example, in copy-on-read
          * it ensures that the CoR read and write operations are atomic and
          * guest writes cannot interleave between them. */
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
@@ -1903,7 +1914,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
@@ -2069,7 +2080,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     padding = bdrv_init_padding(bs, offset, bytes, &pad);
     if (padding) {
-        bdrv_mark_request_serialising(req, align);
+        bdrv_make_request_serialising(req, align);
 
         bdrv_padding_rmw_read(child, req, &pad, true);
 
@@ -2183,7 +2194,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     }
 
     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) {
-        bdrv_mark_request_serialising(&req, align);
+        bdrv_make_request_serialising(&req, align);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
 
@@ -3344,7 +3355,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
      * new area, we need to make sure that no write requests are made to it
      * concurrently or they might be overwritten by preallocation. */
     if (new_bytes) {
-        bdrv_mark_request_serialising(&req, 1);
+        bdrv_make_request_serialising(&req, 1);
     }
     if (bs->read_only) {
         error_setg(errp, "Image is read-only");
-- 
2.21.3


