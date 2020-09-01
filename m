Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D04C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A4B2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8JhaX4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A4B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7ho-0000bo-VJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Nj-0000dy-AO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Nf-0007H4-80
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSSFZEpCJ9ko3lxvLMqMh1CTnQB++uCOABe1rGA2x1o=;
 b=B8JhaX4iJtdc9kHp+890FbCRI5ecTRPOrG0PvY5K0W0C8vwhYNFof3NcB3/MA+nC7DO5Cg
 ivZr5MNWSelhHGvoDnaQjBeoPk4rWIaHQSLdFVz4Zi/gYGccUPwHYVB1OtxA4tZqQL4qNf
 f60h2KvVD/dmL8ZII6207UXO+AFiL5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-WAFSMjHGNbaiU4WyrRfDlw-1; Tue, 01 Sep 2020 10:35:23 -0400
X-MC-Unique: WAFSMjHGNbaiU4WyrRfDlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E49A10ABDAA;
 Tue,  1 Sep 2020 14:35:22 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E09135C1A3;
 Tue,  1 Sep 2020 14:35:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 24/43] block/null: Implement bdrv_get_allocated_file_size
Date: Tue,  1 Sep 2020 16:34:05 +0200
Message-Id: <20200901143424.884735-25-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is trivial, so we might as well do it.

Remove _filter_actual_image_size from iotest 184, so we get to see the
result in its reference output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/null.c               | 7 +++++++
 tests/qemu-iotests/153.out | 2 +-
 tests/qemu-iotests/184     | 3 +--
 tests/qemu-iotests/184.out | 6 ++++--
 4 files changed, 13 insertions(+), 5 deletions(-)

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
index 8a79e1ee87..fcaa71aeee 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -464,7 +464,7 @@ No conflict:
 image: null-co://
 file format: null-co
 virtual size: 1 GiB (1073741824 bytes)
-disk size: unavailable
+disk size: 0 B
 
 Conflict:
 qemu-img: --force-share/-U conflicts with image options
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 33dd8d2a4f..eebb53faed 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -45,8 +45,7 @@ do_run_qemu()
 run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
-                          | _filter_qemu_io | _filter_generated_node_ids \
-                          | _filter_actual_image_size
+                          | _filter_qemu_io | _filter_generated_node_ids
 }
 
 test_throttle=$($QEMU_IMG --help|grep throttle)
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 3deb3cfb94..dec4017ad5 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -29,7 +29,8 @@ Testing:
             "image": {
                 "virtual-size": 1073741824,
                 "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
-                "format": "throttle"
+                "format": "throttle",
+                "actual-size": 0
             },
             "iops_wr": 0,
             "ro": false,
@@ -56,7 +57,8 @@ Testing:
             "image": {
                 "virtual-size": 1073741824,
                 "filename": "null-co://",
-                "format": "null-co"
+                "format": "null-co",
+                "actual-size": 0
             },
             "iops_wr": 0,
             "ro": false,
-- 
2.26.2


