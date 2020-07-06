Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057AB20739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH1Or2OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057AB20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOEW-00076s-7F
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0d-00059k-Lc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23916
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0Y-0004NQ-0k
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MX+rKV8s6t8HRqLNjOZtl1Zuh8zM2Fy/3MKtICjWe2E=;
 b=QH1Or2OBvI3BOsIX1yJutAGILkTwiEPGRRlhqDv5fPuFktDt+kXE/7rn1sbmdLm+70fpQe
 AQpC/DQh6LrShbXNofUJSAxeuCyh3rJMk/JZ9Jzb3k8+cXqipdMJ0PhnRf1MxK4hLJNORx
 hg3ckTq5urvE8wRZHlcTGvewBY2KPaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-XY5_28lvP1SFXJZjGaxiXg-1; Mon, 06 Jul 2020 06:05:35 -0400
X-MC-Unique: XY5_28lvP1SFXJZjGaxiXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D09818A8222;
 Mon,  6 Jul 2020 10:05:34 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DD78C0DA7;
 Mon,  6 Jul 2020 10:05:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/31] block/vpc: return ZERO block-status when appropriate
Date: Mon,  6 Jul 2020 12:04:26 +0200
Message-Id: <20200706100432.2301919-26-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In case when get_image_offset() returns -1, we do zero out the
corresponding chunk of qiov. So, this should be reported as ZERO.

Note that this changes visible output of "qemu-img map --output=json"
and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
we just mark as zero what is really zero. For qemu-io it's less
obvious: what was unallocated now is allocated.

There is an inconsistency in understanding of unallocated regions in
Qemu: backing-supporting format-drivers return 0 block-status to report
go-to-backing logic for this area. Some protocol-drivers (iscsi) return
0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
disk, read result is undefined).

BDRV_BLOCK_ALLOCATED is defined as something more close to
go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
iscsi is treated as unallocated. It doesn't influence backing-chain
behavior, as iscsi can't have backing file. But it does influence
"qemu-io -c map".

We should solve this inconsistency at some future point. Now, let's
just make backing-not-supporting format drivers (vdi in the previous
patch and vpc now) to behave more like backing-supporting drivers
and not report 0 block-status. More over, returning ZERO status is
absolutely valid thing, and again, corresponds to how the other
format-drivers (backing-supporting) work.

After block-status update, it never reports 0, so setting
unallocated_blocks_are_zero doesn't make sense (as the only user of it
is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
for unallocated areas). Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528094405.145708-5-vsementsov@virtuozzo.com>
[mreitz: qemu-io -c map as used by iotest 146 now reports everything as
         allocated; in order to make the test do something useful, we
         use qemu-img map --output=json now]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vpc.c                |   3 +-
 tests/qemu-iotests/146     |  60 ++++--
 tests/qemu-iotests/146.out | 405 +++++++++++++++++++++++++++++++++++--
 3 files changed, 436 insertions(+), 32 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index c055591641..01fcd37e3c 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -606,7 +606,6 @@ static int vpc_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
         bdi->cluster_size = s->block_size;
     }
 
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
@@ -745,7 +744,7 @@ static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
     image_offset = get_image_offset(bs, offset, false, NULL);
     allocated = (image_offset != -1);
     *pnum = 0;
-    ret = 0;
+    ret = BDRV_BLOCK_ZERO;
 
     do {
         /* All sectors in a block are contiguous (without using the bitmap) */
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 2e43abddfc..ddc3c1fd80 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -51,19 +51,25 @@ echo === Testing VPC Autodetect ===
 echo
 _use_sample_img virtualpc-dynamic.vhd.bz2
 
-${QEMU_IO} -c "open -o driver=vpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing VPC with current_size force ===
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=current_size ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=current_size,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing VPC with chs force ===
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=chs ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=chs,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 _cleanup_test_img
 
@@ -72,19 +78,25 @@ echo === Testing Hyper-V Autodetect ===
 echo
 _use_sample_img hyperv2012r2-dynamic.vhd.bz2
 
-${QEMU_IO} -c "open -o driver=vpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing Hyper-V with current_size force ===
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=current_size ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=current_size,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing Hyper-V with chs force ===
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=chs ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=chs,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 _cleanup_test_img
 
@@ -93,19 +105,25 @@ echo === Testing d2v Autodetect ===
 echo
 _use_sample_img d2v-zerofilled.vhd.bz2
 
-${QEMU_IO} -c "open -o driver=vpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing d2v with current_size force ===
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=current_size ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=current_size,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing d2v with chs force ===
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=chs ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=chs,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 _cleanup_test_img
 
@@ -121,19 +139,25 @@ echo
 echo === Read created image, default opts ====
 echo
 
-${QEMU_IO} -c "open -o driver=vpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Read created image, force_size_calc=chs ====
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=chs ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=chs,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Read created image, force_size_calc=current_size ====
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=current_size ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=current_size,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Testing Image create, force_size ===
@@ -145,19 +169,25 @@ echo
 echo === Read created image, default opts ====
 echo
 
-${QEMU_IO} -c "open -o driver=vpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Read created image, force_size_calc=chs ====
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=chs ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=chs,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo
 echo === Read created image, force_size_calc=current_size ====
 echo
 
-${QEMU_IO} -c "open -o driver=vpc,force_size_calc=current_size ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=json --image-opts \
+    "driver=vpc,force_size_calc=current_size,file.filename=$TEST_IMG" \
+    | _filter_qemu_img_map
 
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
index 1332189d87..80513cdd06 100644
--- a/tests/qemu-iotests/146.out
+++ b/tests/qemu-iotests/146.out
@@ -2,39 +2,414 @@ QA output created by 146
 
 === Testing VPC Autodetect ===
 
-126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136363130880, "depth": 0, "zero": true, "data": false }]
 
 === Testing VPC with current_size force ===
 
-127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136365211648, "depth": 0, "zero": true, "data": false }]
 
 === Testing VPC with chs force ===
 
-126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136363130880, "depth": 0, "zero": true, "data": false }]
 
 === Testing Hyper-V Autodetect ===
 
-127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136365211648, "depth": 0, "zero": true, "data": false }]
 
 === Testing Hyper-V with current_size force ===
 
-127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136365211648, "depth": 0, "zero": true, "data": false }]
 
 === Testing Hyper-V with chs force ===
 
-126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136363130880, "depth": 0, "zero": true, "data": false }]
 
 === Testing d2v Autodetect ===
 
-251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 6291456, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 10485760, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 12582912, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 14680064, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 16777216, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 33554432, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 35651584, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 37748736, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 39845888, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 41943040, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 44040192, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 46137344, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 48234496, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 50331648, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 52428800, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 54525952, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 56623104, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 58720256, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 60817408, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 62914560, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 65011712, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 67108864, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 69206016, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 71303168, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 73400320, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 75497472, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 77594624, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 79691776, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 81788928, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 83886080, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 85983232, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 88080384, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 90177536, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 92274688, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 94371840, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 96468992, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 98566144, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 100663296, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 102760448, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 104857600, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 106954752, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 109051904, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 111149056, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 113246208, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 115343360, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 117440512, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 119537664, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 121634816, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 123731968, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 125829120, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 127926272, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 130023424, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 132120576, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 134217728, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 136314880, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 138412032, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 140509184, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 142606336, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 144703488, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 146800640, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 148897792, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 150994944, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 153092096, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 155189248, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 157286400, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 159383552, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 161480704, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 163577856, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 165675008, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 167772160, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 169869312, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 171966464, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 174063616, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 176160768, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 178257920, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 180355072, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 182452224, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 184549376, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 186646528, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 188743680, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 190840832, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 192937984, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 195035136, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 197132288, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 199229440, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 201326592, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 203423744, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 205520896, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 207618048, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 209715200, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 211812352, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 213909504, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 216006656, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 218103808, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 220200960, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 222298112, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 224395264, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 226492416, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 228589568, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 230686720, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 232783872, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 234881024, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 236978176, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 239075328, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 241172480, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 243269632, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 245366784, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 247463936, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 249561088, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 251658240, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 253755392, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 255852544, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 257949696, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 260046848, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 262144000, "length": 1310720, "depth": 0, "zero": false, "data": true, "offset": OFFSET }]
 
 === Testing d2v with current_size force ===
 
-251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 6291456, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 10485760, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 12582912, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 14680064, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 16777216, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 33554432, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 35651584, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 37748736, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 39845888, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 41943040, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 44040192, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 46137344, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 48234496, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 50331648, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 52428800, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 54525952, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 56623104, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 58720256, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 60817408, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 62914560, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 65011712, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 67108864, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 69206016, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 71303168, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 73400320, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 75497472, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 77594624, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 79691776, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 81788928, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 83886080, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 85983232, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 88080384, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 90177536, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 92274688, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 94371840, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 96468992, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 98566144, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 100663296, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 102760448, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 104857600, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 106954752, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 109051904, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 111149056, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 113246208, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 115343360, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 117440512, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 119537664, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 121634816, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 123731968, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 125829120, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 127926272, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 130023424, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 132120576, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 134217728, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 136314880, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 138412032, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 140509184, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 142606336, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 144703488, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 146800640, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 148897792, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 150994944, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 153092096, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 155189248, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 157286400, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 159383552, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 161480704, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 163577856, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 165675008, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 167772160, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 169869312, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 171966464, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 174063616, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 176160768, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 178257920, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 180355072, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 182452224, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 184549376, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 186646528, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 188743680, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 190840832, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 192937984, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 195035136, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 197132288, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 199229440, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 201326592, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 203423744, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 205520896, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 207618048, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 209715200, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 211812352, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 213909504, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 216006656, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 218103808, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 220200960, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 222298112, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 224395264, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 226492416, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 228589568, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 230686720, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 232783872, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 234881024, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 236978176, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 239075328, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 241172480, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 243269632, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 245366784, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 247463936, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 249561088, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 251658240, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 253755392, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 255852544, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 257949696, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 260046848, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 262144000, "length": 1310720, "depth": 0, "zero": false, "data": true, "offset": OFFSET }]
 
 === Testing d2v with chs force ===
 
-251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 6291456, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 10485760, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 12582912, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 14680064, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 16777216, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 33554432, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 35651584, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 37748736, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 39845888, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 41943040, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 44040192, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 46137344, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 48234496, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 50331648, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 52428800, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 54525952, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 56623104, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 58720256, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 60817408, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 62914560, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 65011712, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 67108864, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 69206016, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 71303168, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 73400320, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 75497472, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 77594624, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 79691776, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 81788928, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 83886080, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 85983232, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 88080384, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 90177536, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 92274688, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 94371840, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 96468992, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 98566144, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 100663296, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 102760448, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 104857600, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 106954752, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 109051904, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 111149056, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 113246208, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 115343360, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 117440512, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 119537664, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 121634816, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 123731968, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 125829120, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 127926272, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 130023424, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 132120576, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 134217728, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 136314880, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 138412032, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 140509184, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 142606336, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 144703488, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 146800640, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 148897792, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 150994944, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 153092096, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 155189248, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 157286400, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 159383552, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 161480704, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 163577856, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 165675008, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 167772160, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 169869312, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 171966464, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 174063616, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 176160768, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 178257920, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 180355072, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 182452224, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 184549376, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 186646528, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 188743680, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 190840832, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 192937984, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 195035136, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 197132288, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 199229440, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 201326592, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 203423744, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 205520896, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 207618048, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 209715200, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 211812352, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 213909504, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 216006656, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 218103808, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 220200960, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 222298112, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 224395264, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 226492416, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 228589568, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 230686720, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 232783872, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 234881024, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 236978176, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 239075328, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 241172480, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 243269632, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 245366784, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 247463936, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 249561088, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 251658240, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 253755392, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 255852544, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 257949696, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 260046848, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET },
+{ "start": 262144000, "length": 1310720, "depth": 0, "zero": false, "data": true, "offset": OFFSET }]
 
 === Testing Image create, default ===
 
@@ -42,15 +417,15 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
 
 === Read created image, default opts ====
 
-4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4295467008, "depth": 0, "zero": true, "data": false }]
 
 === Read created image, force_size_calc=chs ====
 
-4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4295467008, "depth": 0, "zero": true, "data": false }]
 
 === Read created image, force_size_calc=current_size ====
 
-4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4295467008, "depth": 0, "zero": true, "data": false }]
 
 === Testing Image create, force_size ===
 
@@ -58,13 +433,13 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
 
 === Read created image, default opts ====
 
-4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4294967296, "depth": 0, "zero": true, "data": false }]
 
 === Read created image, force_size_calc=chs ====
 
-4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4294967296, "depth": 0, "zero": true, "data": false }]
 
 === Read created image, force_size_calc=current_size ====
 
-4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4294967296, "depth": 0, "zero": true, "data": false }]
 *** done
-- 
2.26.2


