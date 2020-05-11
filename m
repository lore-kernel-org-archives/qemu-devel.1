Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC71C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A665E206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcjRCcyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A665E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY90P-0004qP-PL
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY8xM-000109-5h
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:58:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY8xL-0000L5-5Y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589205534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IA4Do2TJDdAuQaSZbnYSPcabo2S+4K3cC+1S3twC7B8=;
 b=UcjRCcyYYvp+PqEq6vgMNL0f8x23Sg6StGfhjQdcCZJrbBxT/DXWiXv2PGckvyQXD+KWW5
 u9UZrCxEZlXVIphv1qXTozo0cDQkOoELlEI2k+zyMHXy7bVSJm31+yLanFey2QvkIRAN5v
 sm8gIeOVhjiauzYGCcAWh2pzTYgUJWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-mpXlcVQKN7m9Csa3UxzU-A-1; Mon, 11 May 2020 09:58:50 -0400
X-MC-Unique: mpXlcVQKN7m9Csa3UxzU-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49B01107ACCD;
 Mon, 11 May 2020 13:58:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1D8F1002382;
 Mon, 11 May 2020 13:58:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/4] iotests/229: Use blkdebug to inject an error
Date: Mon, 11 May 2020 15:58:23 +0200
Message-Id: <20200511135825.219437-3-kwolf@redhat.com>
In-Reply-To: <20200511135825.219437-1-kwolf@redhat.com>
References: <20200511135825.219437-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

229 relies on the mirror running into an I/O error when the target is
smaller than the source. After changing mirror to catch this condition
while starting the job, this test case won't get a job that is paused
for an I/O error any more. Use blkdebug instead to inject an error.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200507145228.323412-2-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/229     | 15 +++++++++++----
 tests/qemu-iotests/229.out |  6 +++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 866168b236..a5d4e5d4f2 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -33,6 +33,7 @@ _cleanup()
     _cleanup_test_img
     _rm_test_img "$TEST_IMG"
     _rm_test_img "$DEST_IMG"
+    rm -f "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -49,11 +50,10 @@ _supported_os Linux
 
 DEST_IMG="$TEST_DIR/d.$IMGFMT"
 TEST_IMG="$TEST_DIR/b.$IMGFMT"
+BLKDEBUG_CONF="$TEST_DIR/blkdebug.conf"
 
 _make_test_img 2M
-
-# destination for mirror will be too small, causing error
-TEST_IMG=$DEST_IMG _make_test_img 1M
+TEST_IMG=$DEST_IMG _make_test_img 2M
 
 $QEMU_IO -c 'write 0 2M' "$TEST_IMG" | _filter_qemu_io
 
@@ -67,11 +67,18 @@ echo
 echo '=== Starting drive-mirror, causing error & stop  ==='
 echo
 
+cat > "$BLKDEBUG_CONF" <<EOF
+[inject-error]
+event = "write_aio"
+errno = "5"
+once = "on"
+EOF
+
 _send_qemu_cmd $QEMU_HANDLE \
     "{'execute': 'drive-mirror',
                  'arguments': {'device': 'testdisk',
                                'format': '$IMGFMT',
-                               'target': '$DEST_IMG',
+                               'target': 'blkdebug:$BLKDEBUG_CONF:$DEST_IMG',
                                'sync':   'full',
                                'mode':   'existing',
                                'on-source-error': 'stop',
diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
index 22350d75d7..fdcd249642 100644
--- a/tests/qemu-iotests/229.out
+++ b/tests/qemu-iotests/229.out
@@ -1,6 +1,6 @@
 QA output created by 229
 Formatting 'TEST_DIR/b.IMGFMT', fmt=IMGFMT size=2097152
-Formatting 'TEST_DIR/d.IMGFMT', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/d.IMGFMT', fmt=IMGFMT size=2097152
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {'execute': 'qmp_capabilities'}
@@ -8,7 +8,7 @@ wrote 2097152/2097152 bytes at offset 0
 
 === Starting drive-mirror, causing error & stop  ===
 
-{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': 'IMGFMT', 'target': 'TEST_DIR/d.IMGFMT', 'sync': 'full', 'mode': 'existing', 'on-source-error': 'stop', 'on-target-error': 'stop' }}
+{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': 'IMGFMT', 'target': 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/d.IMGFMT', 'sync': 'full', 'mode': 'existing', 'on-source-error': 'stop', 'on-target-error': 'stop' }}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "testdisk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
@@ -21,5 +21,5 @@ wrote 2097152/2097152 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152, "offset": 2097152, "speed": 0, "type": "mirror"}}
 *** done
-- 
2.25.3


