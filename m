Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D49C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792A32064A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZEYU8elH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792A32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Hv-0004Ve-LU
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78V-00073D-SA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU770-0005Gi-6E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:47 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:22328 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75s-0003Xs-7s; Thu, 30 Apr 2020 07:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSaFWrDSZMfzakb8COsVmE+ByOkrQH5n1WtI7hQYS/n0ixv6caCcimub0vPKLHZUlXswHDj4eXKaISA6ZMwmEFFt5INUqUgUpWllMfluFw4iI+eXdWXLRcFx5o2M/RRTGMYkjzhuc0zKAaqxNIxPzl949ttj2VWaOds8Uu5M2P081BU/09hFwwqIOZn5QeGB1Hk/G0IRIYo6cJ8hNE3LfaGu9OP5HBj/y2JBCqmZu5HRFWMvclN06hKDLJp45dqX4Iv2a5SuE7NUh4N6DM1dxu2dQ+FvN4BiEc+03Zkn9qffFzjhg+V4LpqFI3+/AEZGFsxXZYveXQooUxmtsA5dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUkTTDThD4tWgPkpzYZLn22MWCM4YFEnWTss8BuYshQ=;
 b=DsXLG3wrxxk8570KNN10r6UaQMDpQuFoywaw51qg2CzihFgPBj0tgZBA4LfxBCD9MNsmtu3lO/uYYXe3qF5yXIMhKPz/XjLntkUhn7+YhbR+X4Ec29mVyowxyxGiL4Pul5DmTWf6gUYee9L9NEDJZMy4/UORJxjlh1lVvmPwSace+YF0drrh9a7QhUWEq+z+nOxlV/zA/L+B4mCwzZ7a+5Rjw//IOYd+MPSoS5dN4JJ8p6ZAoC8ctCo3lU8rWHHFkprQ18QXbt+aIpdZwxybpS5X9ffdwSvnuu4w/AzElcIflkSyX4fmoL6RewDNx356Y1Dg9EFlDaedKK+33SG6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUkTTDThD4tWgPkpzYZLn22MWCM4YFEnWTss8BuYshQ=;
 b=ZEYU8elH0yDzD4HrDkeFei4ZSmVc/pyodAx+z530ZbHlzPiBgXdIGaxrSXerdK/bxrGxbhAcGvMOE36K8Gk4mWZXj8ZnfX0o8JNta7TQhf3FhWwN3mBUc5yYxHL08BfgyGHH9ctU1H7WlDGfjvXW2/h/K1MhdPKXyOeNxBkGAnA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:11:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/17] block/io: support int64_t bytes in bdrv_co_p{read,
 write}v_part()
Date: Thu, 30 Apr 2020 14:10:25 +0300
Message-Id: <20200430111033.29980-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf97130-7f46-4d37-d3e4-08d7ecf72a91
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5447B52D65C6E903286F00B2C1AA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(66556008)(6512007)(107886003)(316002)(6506007)(26005)(52116002)(186003)(478600001)(956004)(2616005)(16526019)(66476007)(2906002)(86362001)(5660300002)(66946007)(6486002)(6916009)(7416002)(36756003)(8936002)(1076003)(6666004)(8676002)(4326008)(142933001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p1ll+HZDYnbQIFy9/7nql2W2nqo4/TG1KxJ3ZBt5xyhax+WEFqT7+yaoid9tnK/wuhrmOHDKDd4SSVfVkULgmLz8J+GrdiYjVSQsLCxhRmM+tikjGn9QhVT3NI8tpyR1VDEO9cyb/jXFi7ctMH41kU6lzEWXxFPPp0h6roD3Yn5uAqJ7amtIxwLku1CxDo+DoT54egqt8/wSF36T2cG/IXNLm2JgOlQnTz+jPxEmDu8znnNC6k1t0/DwtIofq1APn4DtOaTBilqo5DpSbFD/Gk6KII+D7DXSBMRGvtU5CXBSqNrTdUimrZ36SUwb1JOFrgvahbww0xGlN30EMJYgx5C1sASEMIYFB2Nw1h2lNN4oMOVeiBwDDttwNxYNLDx1Zx9aa64WnDkj5jyxoJSn5gCeKB5vURTrePVT+MrAuWPKAKOioFbKiNpOLQjt3odtZ6r0qeSEdBy4x6Vo5xhBET6aeOIWtnYbopjQWQMI2c4K0SsvrN4UiRVVhRHZCDY
X-MS-Exchange-AntiSpam-MessageData: 7PpwTfxPSw239q6I/fPJJbsgSHKQDGeN5ku0RE0o4asfPKrebyYEI1WixJIPSSGeF9IamtC3PJYnxuQYgmD2kdI9vbUe94R/+mkX4Rf9VcNEwFtRCTQ7wCJn+gQi+hSnFqE1Jgv83nicWhLQodjPiY6OcKaycQL1mxVzuJfJcqq2fngP2gzbT7uHBMa1O8NCL3ePf+iT/kC2zJCHQmWT0yDMJkLVB1etSIqXHE8pN1m10hoXpI2I3gl/HObLTfQ/OCRVjTy2ioW7r1J+BK8fMYR5oA5OOx7B/fc3p7nuCqTu3jRpyupCJ6acuymh1B4Tl4mpd0goAKB/35vsDdohrmvjggRe6zvzFkbLb51Z2lRDWh2GY7931VVp04FGmHeILRE0MqzifjB0sg2yQNHn/Qmg1hWA8odgs4lPS9sA2eipwtC2nYViy8Ov4+478Vyl612WZXLxr+v31JIzzCKm0prINt4qqPgEgdMB6k3muEmQh6qD9BP/oLS38/hy9aFvG4xHYhnJAM1hw6ZlOvcbPE3SQ8t1e9ISQGOr4b+R+ReiZ2uXCgPjXxBsuc9nACHnIERyRgDpK1YtncrfPNudS9X4e1nptewl3VyzfVDc24Xfw+Tphpzii1BzFTzmDWhn9E65nX4kvBFvftItSuSLoZ9IgKLwoJABb12vPCm0xvvdiyOIXSGXho15tjDfzptruTjvXu/4md/Zhvt9dEXTbqP+H2CtDnb4XOwjuQ6abHEqVNkiZj/iztCQUX0f+mNX9rB6MfwRRaCrLzTTDU/D3W8XIY+3Pr57LuAXvx6CuVU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf97130-7f46-4d37-d3e4-08d7ecf72a91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:01.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltZRwFaBGu8o83Vju7i2V+Uf7rlrEVWMEtZp/opbKvLVEZNtKCfRX9ET8pIqtJxtCxCeIgfNssX0VZAN4vVa6lM8hStpWnmYMJmr/s74AA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.6.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:11:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.129
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
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

So, prepare bdrv_co_preadv_part() and bdrv_co_pwritev_part() and their
remaining dependencies now.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  4 ++--
 block/io.c                | 16 ++++++++--------
 block/trace-events        |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index c8daba608b..3c2a1d741a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -975,13 +975,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
diff --git a/block/io.c b/block/io.c
index d336e4e691..d7fd429345 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1488,7 +1488,7 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
  */
 static bool bdrv_pad_request(BlockDriverState *bs,
                              QEMUIOVector **qiov, size_t *qiov_offset,
-                             int64_t *offset, unsigned int *bytes,
+                             int64_t *offset, int64_t *bytes,
                              BdrvRequestPadding *pad)
 {
     if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
@@ -1515,7 +1515,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
 
 /* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
@@ -1524,7 +1524,7 @@ static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
     BdrvRequestPadding pad;
     int ret;
 
-    trace_bdrv_co_preadv(bs, offset, bytes, flags);
+    trace_bdrv_co_preadv_part(bs, offset, bytes, flags);
 
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
@@ -1562,7 +1562,7 @@ static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
 }
 
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
@@ -1866,7 +1866,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 
 static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
                                                 int64_t offset,
-                                                unsigned int bytes,
+                                                int64_t bytes,
                                                 BdrvRequestFlags flags,
                                                 BdrvTrackedRequest *req)
 {
@@ -1941,7 +1941,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
 /* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
@@ -1950,7 +1950,7 @@ static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
     BdrvRequestPadding pad;
     int ret;
 
-    trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
+    trace_bdrv_co_pwritev_part(child->bs, offset, bytes, flags);
 
     if (!bs->drv) {
         return -ENOMEDIUM;
@@ -2009,7 +2009,7 @@ out:
 }
 
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
     int ret;
diff --git a/block/trace-events b/block/trace-events
index 179b47bf63..dd367a9b19 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -11,8 +11,8 @@ blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 
 # io.c
-bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
-bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
+bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
+bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-- 
2.21.0


