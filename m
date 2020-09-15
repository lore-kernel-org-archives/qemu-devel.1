Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BDF206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVC7LKxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BDF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8Xk-0005ju-VQ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UE-0000WU-GL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8U9-0004Y6-QW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNGMP0NumDmnPL1tkTdKMGI4YuPdVPiFI8BlpV+dcbg=;
 b=eVC7LKxmEHkJH+wPa4+o9ZPgfY5ypzwzW6NBdg2Fki9dXQGs5r4gN0wDcZut2aPgzTJ3Ir
 T/M7OWyCmFVrRXwayqcRNI/cAPk5J5W0qKFriodoq6DeCiChBhakUn0DIDUYf12T+ZMFkd
 NgaQEI5PSR5404PZtYhkM1gK0ss/sAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-FCI-NTJ4MkqRaRpKSp7OCw-1; Tue, 15 Sep 2020 06:46:46 -0400
X-MC-Unique: FCI-NTJ4MkqRaRpKSp7OCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A04F1084D64;
 Tue, 15 Sep 2020 10:46:45 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF45319C4F;
 Tue, 15 Sep 2020 10:46:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/22] qemu-img: avoid unaligned read requests during convert
Date: Tue, 15 Sep 2020 12:46:12 +0200
Message-Id: <20200915104627.699552-8-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Lieven <pl@kamp.de>

in case of large continous areas that share the same allocation status
it happens that the value of s->sector_next_status is unaligned to the
cluster size or even request alignment of the source. Avoid this by
stripping down the s->sector_next_status position to cluster boundaries.

Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <20200901125129.6398-1-pl@kamp.de>
[mreitz: Disable vhdx for 251]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c             | 22 ++++++++++++++++++++++
 tests/qemu-iotests/251 |  7 +++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d0b1c97562..37365d06fa 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1666,6 +1666,7 @@ enum ImgConvertBlockStatus {
 typedef struct ImgConvertState {
     BlockBackend **src;
     int64_t *src_sectors;
+    int *src_alignment;
     int src_num;
     int64_t total_sectors;
     int64_t allocated_sectors;
@@ -1732,6 +1733,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     if (s->sector_next_status <= sector_num) {
         uint64_t offset = (sector_num - src_cur_offset) * BDRV_SECTOR_SIZE;
         int64_t count;
+        int tail;
         BlockDriverState *src_bs = blk_bs(s->src[src_cur]);
         BlockDriverState *base;
 
@@ -1772,6 +1774,16 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
         n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
 
+        /*
+         * Avoid that s->sector_next_status becomes unaligned to the source
+         * request alignment and/or cluster size to avoid unnecessary read
+         * cycles.
+         */
+        tail = (sector_num - src_cur_offset + n) % s->src_alignment[src_cur];
+        if (n > tail) {
+            n -= tail;
+        }
+
         if (ret & BDRV_BLOCK_ZERO) {
             s->status = post_backing_zero ? BLK_BACKING_FILE : BLK_ZERO;
         } else if (ret & BDRV_BLOCK_DATA) {
@@ -2410,8 +2422,10 @@ static int img_convert(int argc, char **argv)
 
     s.src = g_new0(BlockBackend *, s.src_num);
     s.src_sectors = g_new(int64_t, s.src_num);
+    s.src_alignment = g_new(int, s.src_num);
 
     for (bs_i = 0; bs_i < s.src_num; bs_i++) {
+        BlockDriverState *src_bs;
         s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
                                fmt, src_flags, src_writethrough, s.quiet,
                                force_share);
@@ -2426,6 +2440,13 @@ static int img_convert(int argc, char **argv)
             ret = -1;
             goto out;
         }
+        src_bs = blk_bs(s.src[bs_i]);
+        s.src_alignment[bs_i] = DIV_ROUND_UP(src_bs->bl.request_alignment,
+                                             BDRV_SECTOR_SIZE);
+        if (!bdrv_get_info(src_bs, &bdi)) {
+            s.src_alignment[bs_i] = MAX(s.src_alignment[bs_i],
+                                        bdi.cluster_size / BDRV_SECTOR_SIZE);
+        }
         s.total_sectors += s.src_sectors[bs_i];
     }
 
@@ -2708,6 +2729,7 @@ out:
         g_free(s.src);
     }
     g_free(s.src_sectors);
+    g_free(s.src_alignment);
 fail_getopt:
     g_free(options);
 
diff --git a/tests/qemu-iotests/251 b/tests/qemu-iotests/251
index 7918ba3559..294773bdc1 100755
--- a/tests/qemu-iotests/251
+++ b/tests/qemu-iotests/251
@@ -46,8 +46,11 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
     # We use json:{} filenames here, so we cannot work with additional options.
     _unsupported_fmt $IMGFMT
 else
-    # With VDI, the output is ordered differently.  Just disable it.
-    _unsupported_fmt vdi
+    # - With VDI, the output is ordered differently.  Just disable it.
+    # - VHDX has large clusters; because qemu-img convert tries to
+    #   align the requests to the cluster size, the output is ordered
+    #   differently, so disable it, too.
+    _unsupported_fmt vdi vhdx
 fi
 
 
-- 
2.26.2


