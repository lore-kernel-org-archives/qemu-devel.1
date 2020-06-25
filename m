Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A65C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3AF208C9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoUds5Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3AF208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUB9-0007e4-Dk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTit-0006Iy-0s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTio-0001Gk-4x
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQUia8OoMgalBsALIOPf4VeyZUKjuCFth09x2HxRiII=;
 b=XoUds5HgMKdV99GlGMkdtT/XZyKUCagjdKwXWE+xX0Y8M34mr1u5/aR2urt/TCHh1nD4Bl
 xLpg3K1/COH2fthFphxtLUFDfYDuIdP31JA9AsOn17CR6ruwmUy5Av+PFr3fpwcV6579mY
 UWOPqdkN5tB4PhYVvX5chd9p518VxGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-qWKZUqPcONCRpvIXjNfdeA-1; Thu, 25 Jun 2020 11:23:21 -0400
X-MC-Unique: qWKZUqPcONCRpvIXjNfdeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC9B6A0BD7;
 Thu, 25 Jun 2020 15:23:20 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52F7F5C296;
 Thu, 25 Jun 2020 15:23:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 28/47] block/null: Implement bdrv_get_allocated_file_size
Date: Thu, 25 Jun 2020 17:21:56 +0200
Message-Id: <20200625152215.941773-29-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is trivial, so we might as well do it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/null.c               | 7 +++++++
 tests/qemu-iotests/153.out | 2 +-
 tests/qemu-iotests/184.out | 6 ++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/null.c b/block/null.c
index 15e1d56746..cc9b1d4ea7 100644
--- a/block/null.c
+++ b/block/null.c
@@ -262,6 +262,11 @@ static void null_refresh_filename(BlockDriverState *bs)
              bs->drv->format_name);
 }
 
+static int64_t null_allocated_file_size(BlockDriverState *bs)
+{
+    return 0;
+}
+
 static const char *const null_strong_runtime_opts[] = {
     BLOCK_OPT_SIZE,
     NULL_OPT_ZEROES,
@@ -277,6 +282,7 @@ static BlockDriver bdrv_null_co = {
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_co_parse_filename,
     .bdrv_getlength         = null_getlength,
+    .bdrv_get_allocated_file_size = null_allocated_file_size,
 
     .bdrv_co_preadv         = null_co_preadv,
     .bdrv_co_pwritev        = null_co_pwritev,
@@ -297,6 +303,7 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
     .bdrv_getlength         = null_getlength,
+    .bdrv_get_allocated_file_size = null_allocated_file_size,
 
     .bdrv_aio_preadv        = null_aio_preadv,
     .bdrv_aio_pwritev       = null_aio_pwritev,
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index b2a90caa6b..8659e6463b 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -461,7 +461,7 @@ No conflict:
 image: null-co://
 file format: null-co
 virtual size: 1 GiB (1073741824 bytes)
-disk size: unavailable
+disk size: 0 B
 
 Conflict:
 qemu-img: --force-share/-U conflicts with image options
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 3deb3cfb94..28b104da89 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -29,7 +29,8 @@ Testing:
             "image": {
                 "virtual-size": 1073741824,
                 "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
-                "format": "throttle"
+                "format": "throttle",
+                "actual-size": SIZE
             },
             "iops_wr": 0,
             "ro": false,
@@ -56,7 +57,8 @@ Testing:
             "image": {
                 "virtual-size": 1073741824,
                 "filename": "null-co://",
-                "format": "null-co"
+                "format": "null-co",
+                "actual-size": SIZE
             },
             "iops_wr": 0,
             "ro": false,
-- 
2.26.2


