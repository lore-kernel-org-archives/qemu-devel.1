Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E61C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EAD20656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EAD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaU0-0004pg-4E
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:03:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP6-0000nr-Kq
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00038Q-NA
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:55286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP4-00036H-Ck; Mon, 22 Apr 2019 10:58:42 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP2-0003k3-ED; Mon, 22 Apr 2019 17:58:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 22 Apr 2019 17:58:38 +0300
Message-Id: <20190422145838.70903-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 9/9] qemu-img: use buffer-based io
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422145838.kQUzHzYJInVpoSLbskA6KDLD-R5IQtUIIXfqICO9ftU@z>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f1ea..c40a4e8b83 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1671,7 +1671,6 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
                                         int nb_sectors, uint8_t *buf)
 {
     int n, ret;
-    QEMUIOVector qiov;
 
     assert(nb_sectors <= s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1687,11 +1686,10 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
         bs_sectors = s->src_sectors[src_cur];
 
         n = MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset));
-        qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
 
-        ret = blk_co_preadv(
+        ret = blk_co_pread(
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
-                n << BDRV_SECTOR_BITS, &qiov, 0);
+                n << BDRV_SECTOR_BITS, buf, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1710,7 +1708,6 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                                          enum ImgConvertBlockStatus status)
 {
     int ret;
-    QEMUIOVector qiov;
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
@@ -1738,10 +1735,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
-                qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
-
-                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov, flags);
+                ret = blk_co_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
+                                    n << BDRV_SECTOR_BITS, buf, flags);
                 if (ret < 0) {
                     return ret;
                 }
-- 
2.18.0


