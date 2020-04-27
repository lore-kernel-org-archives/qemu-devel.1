Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16110C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C083820728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JrOq8SCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C083820728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzEs-0000NF-R8
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3y-0003Ra-EZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3u-0000Ne-JG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:26 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com
 ([40.107.0.96]:55939 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3p-00081B-7w; Mon, 27 Apr 2020 04:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXuOYknfBnOG4HcTNRZSPMGHKZgRHbd0yuvRDcRDC1m+xVfdSV+/Ra45fQNwuhOFBnmejOEFWqIKSmP+pf2ICZ0ynhYgMSAQr5EMjTCO60DOqI3+2nENrQQVXXNO2XPR0md0uW9fMXwfGrYNW1XuMDcsuOqErnhNQBXAhCcYRLP3OnULOVztdl8I9zWV9VJjGnG0ZT9brkJClTDnBRFn3N+3wNJoZmdiZ5VhGvsSIuMlkd6HGX13oqJ4zYH4CqyiCmFJqLOr+Q1IzM55AvOg+ctUuVPhsZU4MNU33djvm6gwmcBOdrQ48wkxYdeqeW2XOSE8YAsnruFyzYjcaTCfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSZy6lMpx7dhfLgg1s1Ig9Xl/S/zmXJuQMmJEzzr+PY=;
 b=meCEnmWdjlfN2eXgnj7bPOULe+YpxLQUns3eSDRm4vBXjK7PDSgODV8JZqKrkuxlN/LN2S/upTw6uP3MKaOAaoNXZ24pf+qZxypiqzAFWwY+8sQj5w85Ld0FHboyBrOuFqcx4oTCdS4/Vh0O2HER4su/FtzfHs80AqUWT1bPYL+UpI+LM4L9GMtwZI1bYCd/dlqg0EGrQlVqv0Y89+335VHDpZg7ZPYyDWN4G+n+9kNFjVi+NR19/RfYGfGL4EkZr3FwrkrO5yxdOFZzAjliJGa8qnXvTBD1rgBut/a0oTEHZkoKbPNcfeMb02eHm79gwaH/g4zKhxHQX5C7Yag9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSZy6lMpx7dhfLgg1s1Ig9Xl/S/zmXJuQMmJEzzr+PY=;
 b=JrOq8SCshYjkluadbXpu+kFpaJ2H4G192AeE7bUgkRVZgNrHBBXtT3isLV80Fd1pVF/oJn2icwywpoZ5A+So6NpwV+dTa8V7XCe1NoflBR9fYSRYUJt6RVgoDI0gkLlDQFCNNxMal3cce9u6Q9UDmrntfcJYVAgIIW2eiH677Uw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5400.eurprd08.prod.outlook.com (2603:10a6:20b:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:24:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 16/17] block: use int64_t instead of int in driver
 write_zeroes handlers
Date: Mon, 27 Apr 2020 11:23:24 +0300
Message-Id: <20200427082325.10414-17-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:13 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f83b831-0bc8-4413-7687-08d7ea845ea7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5400A0E643F5F702244E5946C1AF0@AM7PR08MB5400.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(136003)(376002)(366004)(346002)(107886003)(36756003)(956004)(2616005)(2906002)(4326008)(26005)(6512007)(6916009)(6486002)(5660300002)(6506007)(186003)(69590400007)(1076003)(316002)(8676002)(66946007)(81156014)(52116002)(478600001)(30864003)(86362001)(7416002)(66556008)(6666004)(8936002)(66476007)(16526019);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY53l4mv4icL9t/fiJdE4QbYqe818MMz1LcHsNMD5hK7Ts+zLgTsBy9CFujgyd9N64yhf0Be9AyIM+IP7qMhKFGzQA/OaQjqSqTtQbFLfRcF6+NijO2JyF+X3SwRibMQTVqaKT/wrFFcIYVYDxxOhKWH5uFYY/0x56tMVjOQP1v6oTZEekeJQqYeGAMrNLhZoWHKmYLmSS6tXi4GjXzI1/A+Ywa7L1a2q1flBtkc9a1XejzLY3C+VDiEubnrQW0HhHlh1JTeValaEKyk1j6XTZt2FGj3WGvABixNvwJXIsSJxo7vvjyLMZGfIVfiRYUOKXmYgIy28h1GRT+fPcfXsetuUL+9b5qO2WalnIFqDlDGtHvGy3bMEofFX8pHiNtp0NBo6V1Ey/CMbp5Rcx9Lo6CUDnF/w/Du2img/7VZINLFtYZAtT1rqIsc1cV0Mr4+rPX6fEXuRnS+MEOWb5eNsmvlE/C7D/JnX1th0KBlwx/MozpyqrRuzd8nQxryOXAr
X-MS-Exchange-AntiSpam-MessageData: +uqfiCw79EGF5pURTegnAmDDptyJeRyDilO7Ux4vvaRkBgLTJxXMvTsZD9FYHIkxr1EPNqCbK/+m3YTHQdXHDYn+aRB/T5V4zhzDVVAE2HJ+tqD4MrxmLYXKJHhphckoTS2rrT+0mRNQmo5mzPLCf7eHeSLdkzPRsapSeTwLw64Xzx10YaGUh4F/DP463ht2krSIJX9rv1VpYBWsN+UIqdX3G+yrrNbW8sUnHie9amNp6ftUyicy5sPeJ8VJhYAc6cL9Zuh/kBr0TeY5Z0Gw+K86k6oxvKvX7aNG/2/eJGKOX7OvfROLQIrh1aSeSI+QttulmzKqQPallJfpkBw6IIgHvrHkYBeyAa6Gh6S6Ia5jXy6LgkwxkQ1AjRNLLkkgYNl8fQzwrIK9p6OCEG0VD4KtAGNuSBDYls/ipICUZ5gnzVn/3qqFcREsfag4OTAthteoO+bo5EwJoIkb/VFUdGANXPd2jvQWcQnCFUlnJ2nP5ta+u9CSbjlMmBqb53O160sWrqum79pl8qh32CcnvzDYkC4c/hNwwlAXhzMyhe8DcJsnsXrFhuydFb1UbGN+bz3ArP60frwx95fcF4rGPq6+nnApYmEkmfgobXpHISnbPo0Y5886LY5U1mUSy9yHD1t1CHrt6ZpX79v4BU+KYHOmfAwt+UMVUoTXpuC1bU7ggc6KVMTj4L9SLkJlX0BnROoVQhQdHqpYBohVdjUensY9AMgn7j7VVR0/tXzdHhmrtgfFl/bqqwa8R70Yk1V8Ub9/RB+9CKQi2HcAQYHRYYOHzeKvnI4mPyZ7cma4sAA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f83b831-0bc8-4413-7687-08d7ea845ea7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:14.2552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9KlhGqdctlU7TJcT2/ogWDqiTIDmLv2piX9pRgVZq6EVMgsWGwvq9jXvUl7KdkoobDYJGj8rt/6s+z0ZnDoaBqWA03tkQLajfZ79wNeW6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5400
Received-SPF: pass client-ip=40.107.0.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.96
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert driver write_zeroes handlers bytes parameter
to int64_t.

This patch just converts handlers where it is obvious that bytes
parameter is passed further to 64bit interfaces, and add simple
wrappers where it is not obvious.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  2 +-
 block/backup-top.c        |  2 +-
 block/blkdebug.c          |  2 +-
 block/blklogwrites.c      |  4 ++--
 block/blkreplay.c         |  2 +-
 block/copy-on-read.c      |  2 +-
 block/file-posix.c        |  6 +++---
 block/filter-compress.c   |  2 +-
 block/gluster.c           |  8 +++++---
 block/iscsi.c             | 12 ++++++++++--
 block/mirror.c            |  2 +-
 block/nbd.c               |  4 +++-
 block/nvme.c              | 16 ++++++++++++----
 block/qcow2.c             |  9 ++++++++-
 block/qed.c               | 17 +++++++++++++----
 block/raw-format.c        |  2 +-
 block/throttle.c          |  2 +-
 block/vmdk.c              |  2 +-
 18 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ea8fca5e28..fe446f11eb 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -244,7 +244,7 @@ struct BlockDriver {
      * will be called instead.
      */
     int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
-        int64_t offset, int bytes, BdrvRequestFlags flags);
+        int64_t offset, int64_t bytes, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
         int64_t offset, int bytes);
 
diff --git a/block/backup-top.c b/block/backup-top.c
index 4190d465d6..20c943280f 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -76,7 +76,7 @@ static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
 }
 
 static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
-        int64_t offset, int bytes, BdrvRequestFlags flags)
+        int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     int ret = backup_top_cbw(bs, offset, bytes, flags);
     if (ret < 0) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index b4d0966982..521b7b1fe2 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -672,7 +672,7 @@ static int blkdebug_co_flush(BlockDriverState *bs)
 }
 
 static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int bytes,
+                                                  int64_t offset, int64_t bytes,
                                                   BdrvRequestFlags flags)
 {
     uint32_t align = MAX(bs->bl.request_alignment,
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 890a61dfba..ccfb1100e4 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -474,8 +474,8 @@ blk_log_writes_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-blk_log_writes_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
-                                BdrvRequestFlags flags)
+blk_log_writes_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+                                int64_t bytes, BdrvRequestFlags flags)
 {
     return blk_log_writes_co_log(bs, offset, bytes, NULL, flags,
                                  blk_log_writes_co_do_file_pwrite_zeroes, 0,
diff --git a/block/blkreplay.c b/block/blkreplay.c
index d93383a88f..74ea935593 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -95,7 +95,7 @@ static int coroutine_fn blkreplay_co_pwritev(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index fc3186bacb..59272b5faa 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -92,7 +92,7 @@ static int coroutine_fn cor_co_pwritev(BlockDriverState *bs,
 
 
 static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
-                                             int64_t offset, int bytes,
+                                             int64_t offset, int64_t bytes,
                                              BdrvRequestFlags flags)
 {
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
diff --git a/block/file-posix.c b/block/file-posix.c
index 76da620135..bfddfbb9b3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2797,7 +2797,7 @@ raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 }
 
 static int coroutine_fn
-raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
+raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      BdrvRequestFlags flags, bool blkdev)
 {
     BDRVRawState *s = bs->opaque;
@@ -2866,7 +2866,7 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
 
 static int coroutine_fn raw_co_pwrite_zeroes(
     BlockDriverState *bs, int64_t offset,
-    int bytes, BdrvRequestFlags flags)
+    int64_t bytes, BdrvRequestFlags flags)
 {
     return raw_do_pwrite_zeroes(bs, offset, bytes, flags, false);
 }
@@ -3489,7 +3489,7 @@ hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 }
 
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     int rc;
 
diff --git a/block/filter-compress.c b/block/filter-compress.c
index f2400fea37..b22e57c5f2 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -84,7 +84,7 @@ static int coroutine_fn compress_co_pwritev_part(BlockDriverState *bs,
 
 
 static int coroutine_fn compress_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int bytes,
+                                                  int64_t offset, int64_t bytes,
                                                   BdrvRequestFlags flags)
 {
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
diff --git a/block/gluster.c b/block/gluster.c
index 0aa1f2cda4..88130c3d2d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1017,19 +1017,21 @@ static void qemu_gluster_reopen_abort(BDRVReopenState *state)
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
 static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
                                                       int64_t offset,
-                                                      int size,
+                                                      int64_t bytes,
                                                       BdrvRequestFlags flags)
 {
     int ret;
     GlusterAIOCB acb;
     BDRVGlusterState *s = bs->opaque;
 
-    acb.size = size;
+    assert(bytes < INT_MAX);
+
+    acb.size = bytes;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
     acb.aio_context = bdrv_get_aio_context(bs);
 
-    ret = glfs_zerofill_async(s->fd, offset, size, gluster_finish_aiocb, &acb);
+    ret = glfs_zerofill_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
         return -errno;
     }
diff --git a/block/iscsi.c b/block/iscsi.c
index 861a70c823..c4183ef12f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1204,8 +1204,8 @@ out_unlock:
 }
 
 static int
-coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                    int bytes, BdrvRequestFlags flags)
+coroutine_fn iscsi_co_pwrite_zeroes_old(BlockDriverState *bs, int64_t offset,
+                                        int bytes, BdrvRequestFlags flags)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
@@ -1308,6 +1308,14 @@ out_unlock:
     return r;
 }
 
+static int
+coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+                                    int64_t bytes, BdrvRequestFlags flags)
+{
+    assert(bytes < INT_MAX);
+    return iscsi_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
+
 static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
                        Error **errp)
 {
diff --git a/block/mirror.c b/block/mirror.c
index 687a91e654..2d8fe6008a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1464,7 +1464,7 @@ static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 }
 
 static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_ZERO, offset, bytes, NULL,
                                     flags);
diff --git a/block/nbd.c b/block/nbd.c
index 54bce3911e..fc30514e10 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1243,7 +1243,7 @@ static int nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset,
 }
 
 static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags)
+                                       int64_t bytes, BdrvRequestFlags flags)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
@@ -1252,6 +1252,8 @@ static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         .len = bytes,
     };
 
+    assert(bytes < INT_MAX);
+
     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
diff --git a/block/nvme.c b/block/nvme.c
index db7fffe94f..ef27c7eb3c 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1103,10 +1103,10 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
 }
 
 
-static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
-                                              int64_t offset,
-                                              int bytes,
-                                              BdrvRequestFlags flags)
+static coroutine_fn int nvme_co_pwrite_zeroes_old(BlockDriverState *bs,
+                                                  int64_t offset,
+                                                  int bytes,
+                                                  BdrvRequestFlags flags)
 {
     BDRVNVMeState *s = bs->opaque;
     NVMeQueuePair *ioq = s->queues[1];
@@ -1156,6 +1156,14 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     return data.ret;
 }
 
+static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
+                                              int64_t offset,
+                                              int64_t bytes,
+                                              BdrvRequestFlags flags)
+{
+    assert(bytes <= INT_MAX);
+    return nvme_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
 
 static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
                                          int64_t offset,
diff --git a/block/qcow2.c b/block/qcow2.c
index 945554b25c..905d22e2c8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3726,7 +3726,7 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }
 
-static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
+static coroutine_fn int qcow2_co_pwrite_zeroes_old(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     int ret;
@@ -3778,6 +3778,13 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     return ret;
 }
 
+static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
+{
+    assert(bytes < INT_MAX);
+    return qcow2_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
+
 static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
                                           int64_t offset, int bytes)
 {
diff --git a/block/qed.c b/block/qed.c
index 1af9b3cb1d..fe00dbbff5 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1439,10 +1439,10 @@ static int coroutine_fn bdrv_qed_co_writev(BlockDriverState *bs,
     return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WRITE);
 }
 
-static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset,
-                                                  int bytes,
-                                                  BdrvRequestFlags flags)
+static int coroutine_fn bdrv_qed_co_pwrite_zeroes_old(BlockDriverState *bs,
+                                                      int64_t offset,
+                                                      int bytes,
+                                                      BdrvRequestFlags flags)
 {
     BDRVQEDState *s = bs->opaque;
 
@@ -1463,6 +1463,15 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
                           QED_AIOCB_WRITE | QED_AIOCB_ZERO);
 }
 
+static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
+                                                  int64_t offset,
+                                                  int64_t bytes,
+                                                  BdrvRequestFlags flags)
+{
+    assert(bytes <= INT_MAX);
+    return bdrv_qed_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
+
 static int coroutine_fn bdrv_qed_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
                                              bool exact,
diff --git a/block/raw-format.c b/block/raw-format.c
index 2537755f84..de2fef9edc 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -279,7 +279,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
-                                             int64_t offset, int bytes,
+                                             int64_t offset, int64_t bytes,
                                              BdrvRequestFlags flags)
 {
     int ret;
diff --git a/block/throttle.c b/block/throttle.c
index 28e73073e7..c1503f133f 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -135,7 +135,7 @@ static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
 }
 
 static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int bytes,
+                                                  int64_t offset, int64_t bytes,
                                                   BdrvRequestFlags flags)
 {
     ThrottleGroupMember *tgm = bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index a88e9c9ba4..2898c10fa8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2089,7 +2089,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
 static int coroutine_fn vmdk_co_pwrite_zeroes(BlockDriverState *bs,
                                               int64_t offset,
-                                              int bytes,
+                                              int64_t bytes,
                                               BdrvRequestFlags flags)
 {
     int ret;
-- 
2.21.0


