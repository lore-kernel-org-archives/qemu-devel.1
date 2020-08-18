Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD005C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760492075E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAVcuND8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760492075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zbp-0003cG-Ma
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zWE-0003dA-Gs; Tue, 18 Aug 2020 07:11:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zWC-0007SW-EC; Tue, 18 Aug 2020 07:11:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB2Nmj114780;
 Tue, 18 Aug 2020 11:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Xl9pABGR1nyB5o6Ja5FOhvnuFABb/wAme5EUSs4qVWE=;
 b=EAVcuND8oCUsmM4GiILFwCRL1TD6LzZyu2J8AFqL4FpV2EwMkh6MLHbIwnE6IBAMltuL
 aiIOPZKnfyDDMH/O0oeE0UtwzLehi2xUzkZCUMGXASTO+fiwgP6QgslHE2kCAxUVGdaz
 Y6ErwzJiVWl2RHIriWoxHlEWrKNw6MupNHsWNY8j7+DXKM+olylmHzUQnU6fs4tCFjYr
 3anmtVqIXHp9BuoOHSo31md7l7/F32r0EofDc8v78dCUdW1rkcQ38UBejfuAomH19RpN
 E6uy78R+qmGojXtc1r/GaiHdlxOWv5hL2tsqq6dpfadcXrTGDPis+dajY439NVfHpUQp pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 32x74r43pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:10:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8t9Q036241;
 Tue, 18 Aug 2020 11:08:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 32xsmx3atc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:56 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IB8rp3014272;
 Tue, 18 Aug 2020 11:08:53 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:53 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 73bd8737;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/9] block/curl: Tracing
Date: Tue, 18 Aug 2020 12:08:39 +0100
Message-Id: <20200818110845.3825105-4-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818110845.3825105-1-david.edmondson@oracle.com>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=1 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180079
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=david.edmondson@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 07:11:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some more trace functions to the IO path.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c       | 10 +++++++++-
 block/io.c         |  4 ++++
 block/linux-aio.c  |  6 ++++++
 block/trace-events | 13 ++++++++++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index d0c74d7de5..d2f4de46c9 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -299,6 +299,8 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
         {
             char *buf = state->orig_buf + (start - state->buf_start);
 
+            trace_curl_pending_hit(qemu_coroutine_self(),
+                                   start, len);
             qemu_iovec_from_buf(acb->qiov, 0, buf, clamped_len);
             if (clamped_len < len) {
                 qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
@@ -316,6 +318,8 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
         {
             int j;
 
+            trace_curl_pending_piggyback(qemu_coroutine_self(),
+                                         start, len);
             acb->start = start - state->buf_start;
             acb->end = acb->start + clamped_len;
 
@@ -328,6 +332,8 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
         }
     }
 
+    trace_curl_pending_miss(qemu_coroutine_self(), start, len);
+
     return false;
 }
 
@@ -894,7 +900,7 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64,
              s->offset + start, s->offset + end);
-    trace_curl_setup_preadv(acb->bytes, start, state->range);
+    trace_curl_setup_preadv(qemu_coroutine_self(), start, acb->bytes);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
     if (curl_multi_add_handle(s->multi, state->curl) != CURLM_OK) {
@@ -923,10 +929,12 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
         .bytes = bytes
     };
 
+    trace_curl_co_preadv(qemu_coroutine_self(), offset, bytes);
     curl_setup_preadv(bs, &acb);
     while (acb.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
+    trace_curl_co_preadv_done(qemu_coroutine_self());
     return acb.ret;
 }
 
diff --git a/block/io.c b/block/io.c
index ad3a51ed53..f816a46bf0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1194,6 +1194,8 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
         return -ENOMEDIUM;
     }
 
+    trace_bdrv_driver_pwritev(qemu_coroutine_self(), offset, bytes);
+
     if (drv->bdrv_co_pwritev_part) {
         ret = drv->bdrv_co_pwritev_part(bs, offset, bytes, qiov, qiov_offset,
                                         flags & bs->supported_write_flags);
@@ -1253,6 +1255,8 @@ emulate_flags:
         qemu_iovec_destroy(&local_qiov);
     }
 
+    trace_bdrv_driver_pwritev_done(qemu_coroutine_self());
+
     return ret;
 }
 
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 3c0527c2bf..811e9ff94c 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -15,6 +15,7 @@
 #include "qemu/event_notifier.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 #include <libaio.h>
 
@@ -391,6 +392,8 @@ int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
         .qiov       = qiov,
     };
 
+    trace_laio_co_submit(qemu_coroutine_self(), offset, qiov->size);
+
     ret = laio_do_submit(fd, &laiocb, offset, type);
     if (ret < 0) {
         return ret;
@@ -399,6 +402,9 @@ int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
     if (laiocb.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
+
+    trace_laio_co_submit_done(qemu_coroutine_self());
+
     return laiocb.ret;
 }
 
diff --git a/block/trace-events b/block/trace-events
index 9158335061..0b52d2ca1d 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -17,6 +17,8 @@ bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p off
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
+bdrv_driver_pwritev(void *co, uint64_t offset, uint64_t bytes) "co %p writes 0x%"PRIx64" + 0x%"PRIx64
+bdrv_driver_pwritev_done(void *co) "co %p done"
 
 # stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
@@ -196,7 +198,12 @@ curl_sock_cb(int action, int fd) "sock action %d on fd %d"
 curl_read_cb(size_t realsize) "just reading %zu bytes"
 curl_open(const char *file) "opening %s"
 curl_open_size(uint64_t size) "size = %" PRIu64
-curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %" PRIu64 " at %" PRIu64 " (%s)"
+curl_co_preadv(void *co, uint64_t offset, uint64_t bytes) "co %p requests 0x%" PRIx64 " + 0x%" PRIx64
+curl_co_preadv_done(void *co) "co %p done"
+curl_setup_preadv(void *co, uint64_t offset, uint64_t bytes) "co %p requests 0x%" PRIx64 " + 0x%" PRIx64
+curl_pending_hit(void *co, uint64_t start, uint64_t len) "co %p finds 0x%" PRIx64 " + 0x%" PRIx64
+curl_pending_piggyback(void *co, uint64_t start, uint64_t len) "co %p pending 0x%" PRIx64 " + 0x%" PRIx64
+curl_pending_miss(void *co, uint64_t start, uint64_t len) "co %p misses 0x%" PRIx64 " + 0x%" PRIx64
 curl_close(void) "close"
 
 # file-posix.c
@@ -222,3 +229,7 @@ sheepdog_snapshot_create_inode(const char *name, uint32_t snap, uint32_t vdi) "s
 
 # ssh.c
 sftp_error(const char *op, const char *ssh_err, int ssh_err_code, int sftp_err_code) "%s failed: %s (libssh error code: %d, sftp error code: %d)"
+
+# linux-aio.c
+laio_co_submit(void *co, uint64_t offset, uint64_t bytes) "co %p writes 0x%"PRIx64" + 0x%"PRIx64
+laio_co_submit_done(void *co) "co %p done"
-- 
2.27.0


