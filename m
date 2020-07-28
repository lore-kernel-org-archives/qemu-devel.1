Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A3C433F8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6815B204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6SlI/Ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6815B204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RAi-0007cF-HS
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9R-00064C-40
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9N-0006s0-V6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8k5wikXvPVmhblRldgoJMU2RI2i2mycBnjay7fXFw4=;
 b=d6SlI/AoTrLJCyqv7kUrQNwf//p85kwPQYbWWG7lucs9vL+1CYxIsHzxlhI6sqTUZPMvqF
 v4llxAhnN6NcOl38s1qfoBTQ0srXPrpTPcaeCBC0WN4IwCZWB7Koov78dPgFClCNRtOtxT
 YLOTKAL0xhtNRrNIrWtH7IZBJocQ7MY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-IKHxsBRGNXm6ZfUCvEiLfQ-1; Tue, 28 Jul 2020 11:04:14 -0400
X-MC-Unique: IKHxsBRGNXm6ZfUCvEiLfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBB3A10059B2;
 Tue, 28 Jul 2020 15:04:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D69DD1992D;
 Tue, 28 Jul 2020 15:04:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] block: nbd: Fix convert qcow2 compressed to nbd
Date: Tue, 28 Jul 2020 10:04:00 -0500
Message-Id: <20200728150408.291299-3-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Nir Soffer <nirsof@gmail.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

When converting to qcow2 compressed format, the last step is a special
zero length compressed write, ending in a call to bdrv_co_truncate(). This
call always fails for the nbd driver since it does not implement
bdrv_co_truncate().

For block devices, which have the same limits, the call succeeds since
the file driver implements bdrv_co_truncate(). If the caller asked to
truncate to the same or smaller size with exact=false, the truncate
succeeds. Implement the same logic for nbd.

Example failing without this change:

In one shell start qemu-nbd:

$ truncate -s 1g test.tar
$ qemu-nbd --socket=/tmp/nbd.sock --persistent --format=raw --offset 1536 test.tar

In another shell convert an image to qcow2 compressed via NBD:

$ echo "disk data" > disk.raw
$ truncate -s 1g disk.raw
$ qemu-img convert -f raw -O qcow2 -c disk1.raw nbd+unix:///?socket=/tmp/nbd.sock; echo $?
1

qemu-img failed, but the conversion was successful:

$ qemu-img info nbd+unix:///?socket=/tmp/nbd.sock
image: nbd+unix://?socket=/tmp/nbd.sock
file format: qcow2
virtual size: 1 GiB (1073741824 bytes)
...

$ qemu-img check nbd+unix:///?socket=/tmp/nbd.sock
No errors were found on the image.
1/16384 = 0.01% allocated, 100.00% fragmented, 100.00% compressed clusters
Image end offset: 393216

$ qemu-img compare disk.raw nbd+unix:///?socket=/tmp/nbd.sock
Images are identical.

Fixes: https://bugzilla.redhat.com/1860627
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-Id: <20200727215846.395443-2-nsoffer@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: typo fixes]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c    | 30 ++++++++++++++++++++++++++++++
 qemu-io-cmds.c |  2 +-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 65a4f56924ec..8934bcb47901 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1966,6 +1966,33 @@ static void nbd_close(BlockDriverState *bs)
     nbd_clear_bdrvstate(s);
 }

+/*
+ * NBD cannot truncate, but if the caller asks to truncate to the same size, or
+ * to a smaller size with exact=false, there is no reason to fail the
+ * operation.
+ *
+ * Preallocation mode is ignored since it does not seems useful to fail when
+ * we never change anything.
+ */
+static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        bool exact, PreallocMode prealloc,
+                                        BdrvRequestFlags flags, Error **errp)
+{
+    BDRVNBDState *s = bs->opaque;
+
+    if (offset != s->info.size && exact) {
+        error_setg(errp, "Cannot resize NBD nodes");
+        return -ENOTSUP;
+    }
+
+    if (offset > s->info.size) {
+        error_setg(errp, "Cannot grow NBD nodes");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int64_t nbd_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
@@ -2045,6 +2072,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_co_flush_to_os        = nbd_co_flush,
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
+    .bdrv_co_truncate           = nbd_co_truncate,
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
@@ -2072,6 +2100,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_co_flush_to_os        = nbd_co_flush,
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
+    .bdrv_co_truncate           = nbd_co_truncate,
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
@@ -2099,6 +2128,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_co_flush_to_os        = nbd_co_flush,
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
+    .bdrv_co_truncate           = nbd_co_truncate,
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 851f07e8f8b9..baeae86d8c85 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1715,7 +1715,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
      * exact=true.  It is better to err on the "emit more errors" side
      * than to be overly permissive.
      */
-    ret = blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, 0, &local_err);
+    ret = blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, 0, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
-- 
2.27.0


