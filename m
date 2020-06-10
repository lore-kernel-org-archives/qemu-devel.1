Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AADBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141632072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I8+Cj2Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141632072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixdr-00044I-B6
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaZ-00088E-Ds; Wed, 10 Jun 2020 06:04:07 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:48963 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaY-0005xb-9k; Wed, 10 Jun 2020 06:04:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STXvjjBe2oJ1kVMfF2i2kopxRwKvG1rWiRjPx9HIVSa4DQ4wIM35puSU0XawaUV2vAjtsUx7Q3pG9aHQMxYvlaldOOBGB3Za6bq0KNGaQAMeRXcyQV6/Cd0IsxyFjYrS+sDI8v56mxyhtdCpl+024YWY3Kc+kYU8aK38Y9pP00AKeR3FQkg/+vg6MYjdv7Wg2eFMZrOfNo1nn+ynE8NaQIBaDun9rtt2jPYHBy3qei9+QCBKsr8UPijlWIe12Mhwa9aJHWAALy4QQUgN5jXBG5T0JedSe1tHaO4BPz9uO8dTvzWPR2FIBzKoxbg6OYq4ftRY09EBb7LDCci8rfLx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjvoL2TpYskDQLKlnYqUmcA1MmhlqZWY29eYVJaKHN0=;
 b=I/OFFsioZt1wAz7RcHyEJ33tYL7TDAiw4PxA7OxQ1DMPmH/7BLTUxYznKhYPdydWVKDkmWhVgPwqWHn8WzjIMfNsE9HfqVgZQIYz7b82EPJWeYQpj0Qos5XyFPgvL5fEqHfB/iQoTOfqQNqGZlyFxeI6uvbEuk2lP6798e/AnklzutAd53fJWuA6EdHt9m7u8ynIdD79ORr2XUj98BqAV0ZsbFxxDmMuXSRq8Ht2/HqxSzdi7KG6iRn41Kmueyxvi/wOqHjvMFeZ74L/QyZFUA46VijnnYsdmb/FMGVApQt6RN2fqO3aV/ChJxE7REirfcyYll11vptYn4mJ0a86Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjvoL2TpYskDQLKlnYqUmcA1MmhlqZWY29eYVJaKHN0=;
 b=I8+Cj2UutJoPTLup2b24X38gcCf2h+xAgdyuhksOOnwZGCZ4/L/LXHbFjpk7pEUaYx63TXKTy0s1+PHcDx50sVV7okCDgm7Moexd9ELoellNxaKDVgCRroYeIo6GS0GEacFl3b94Tk9OL9QRscAhpkx+zYztifdHTSzHtSD1eqI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:04:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:04:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 6/7] block: drop bdrv_prwv
Date: Wed, 10 Jun 2020 13:03:35 +0300
Message-Id: <20200610100336.23451-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610100336.23451-1-vsementsov@virtuozzo.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:208:14::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.166) by
 AM0PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:208:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:04:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4cfacf1-2086-496c-aa99-08d80d259a04
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54967CBBFD8535A370687FCCC1830@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcB9Nqoyn4UEG0gHEQRjsNxhvcxVxyZp/Y8o+yl1iss0AF8p/l2mStY2TGXSdALwHNeaquiHyLIuCS4J65+152kPJtMfeNlSx+9EOMr3Bekwdo/rAS2EqHzSc8JBnXOBYRd2xMeGnDcLp5rV7Q28qDgDnkCkhXnphfk30fkOtr4+Aip9GytvUtr+1VtUrXqEF1zRn/bhUdiPTPH9feza9yE+YWXWDCgvDcLQJhI7K7hF+7FsumdJcCcU9BCrB7sxkzCqirg9Edd5PaARGk488kSXE3sAG7yEfMXeQoG0NK4BPR+G/m1fFqL4oX2kuRh7k09HdIvPVHiEIjL56n0gZBMENcogxAfcraP7XhDFQZ5yvks2bu9W5oeYLyjwUf9T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39850400004)(6486002)(316002)(8676002)(107886003)(8936002)(86362001)(52116002)(6916009)(478600001)(6512007)(6666004)(1076003)(4326008)(66556008)(83380400001)(5660300002)(66946007)(66476007)(16526019)(36756003)(69590400007)(26005)(2906002)(956004)(6506007)(2616005)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: k8ya13tVxUgHORJ0vX4p0yNc3gGD3f1dh6FPgdxuCI2h5+MP9KkmB1K7sZfI+swlGMkn5IWMhImzaALKGfHDlmwIDdfIUVLdUDA/DY846V/5TSLemfxSm1bEbYf6n0LHx3DCOXiChdpYgqOurW8UjsGcpGCjlm6h1q4vu4TNkKSHv7bgxPjJEpU/RztiTVtTbkJpZIrVA3sJmdl0mZ759YA/gXP9NbtQ/hygMiszNEMHxt8hgP5bkMb2bahtnCJHpNlYmF1ZKW0yTomuW+ElSKxKvOc9Jy4X/Lb9EYQmvOFIRY+ipMFrqB7cFumhzuawqNhTLyf8EAOycln3ZsOJ6Ka8u7iynJe6Lc4mCPBIfJ5lcNBPzVYYpgVxSza/IwLG22shNzLHLDQ2aPz6pO2tj4MLmGGkmQgmXzaP7UKIfnnixpexUIJJ0gWQ3wLQX1En7Pe3/OS18HrTfdIgJcjHDC4VOr84RnUUTLZO18qxPHU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cfacf1-2086-496c-aa99-08d80d259a04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:04:02.5417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2myC0GeI+BrzClvMT1XN2SQwH6fV/0Zm5KF8nxEx7pVGbBi5006qGNKT6htM5XIzI3ekWkC6eM4JXaCKi7Ubo9l/c58WxnJem6inRKZUDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.22.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 06:04:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we are not maintaining boilerplate code for coroutine
wrappers, there is no more sense in keeping the extra indirection layer
of bdrv_prwv().  Let's drop it and instead generate pure bdrv_preadv()
and bdrv_pwritev().

Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
success, auto generated functions will instead return zero, as their
_co_ prototype. Still, it's simple to make the conversion safe: the
only external user of bdrv_pwritev() is test-bdrv-drain, and it is
comfortable enough with bdrv_co_pwritev() instead. So prototypes are
moved to local block/coroutines.h. Next, the only internal use is
bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
success.

Of course, it would be great to convert bdrv_pread() and bdrv_pwrite()
to return 0 on success. But this requires audit (and probably
conversion) of all their users, let's leave it for another day
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h      | 10 ++++-----
 include/block/block.h   |  2 --
 block/io.c              | 49 ++++++++---------------------------------
 tests/test-bdrv-drain.c |  2 +-
 4 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index c62b3a2697..6c63a819c9 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -31,12 +31,12 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                BdrvCheckResult *res, BdrvCheckMode fix);
 int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 
-int coroutine_fn
-bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
-             bool is_write, BdrvRequestFlags flags);
 int generated_co_wrapper
-bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
-          bool is_write, BdrvRequestFlags flags);
+bdrv_preadv(BdrvChild *child, int64_t offset, unsigned int bytes,
+            QEMUIOVector *qiov, BdrvRequestFlags flags);
+int generated_co_wrapper
+bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
+             QEMUIOVector *qiov, BdrvRequestFlags flags);
 
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
diff --git a/include/block/block.h b/include/block/block.h
index 9f94c59057..280cf2a7d5 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -385,9 +385,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes);
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
                      const void *buf, int count);
 /*
diff --git a/block/io.c b/block/io.c
index 36fbf9e1fa..3060c7e6ed 100644
--- a/block/io.c
+++ b/block/io.c
@@ -890,23 +890,11 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
-                              QEMUIOVector *qiov, bool is_write,
-                              BdrvRequestFlags flags)
-{
-    if (is_write) {
-        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
-    } else {
-        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
-    }
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
-
-    return bdrv_prwv(child, offset, &qiov, true, BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_pwritev(child, offset, bytes, NULL,
+                        BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
@@ -950,41 +938,19 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
     }
 }
 
-/* return < 0 if error. See bdrv_pwrite() for the return codes */
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret = bdrv_prwv(child, offset, qiov, false, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
 /* See bdrv_pwrite() for the return codes */
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
+    int ret;
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    return bdrv_preadv(child, offset, &qiov);
-}
-
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
+    ret = bdrv_preadv(child, offset, bytes, &qiov,  0);
 
-    ret = bdrv_prwv(child, offset, qiov, true, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
+    return ret < 0 ? ret : bytes;
 }
 
 /* Return no. of bytes on success or < 0 on error. Important errors are:
@@ -995,13 +961,16 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 */
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
+    int ret;
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    return bdrv_pwritev(child, offset, &qiov);
+    ret = bdrv_pwritev(child, offset, bytes, &qiov, 0);
+
+    return ret < 0 ? ret : bytes;
 }
 
 /*
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 1107271840..1595bbc92e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1872,7 +1872,7 @@ static int coroutine_fn bdrv_replace_test_co_preadv(BlockDriverState *bs,
         }
         s->io_co = NULL;
 
-        ret = bdrv_preadv(bs->backing, offset, qiov);
+        ret = bdrv_co_preadv(bs->backing, offset, bytes, qiov, 0);
         s->has_read = true;
 
         /* Wake up drain_co if it runs */
-- 
2.21.0


