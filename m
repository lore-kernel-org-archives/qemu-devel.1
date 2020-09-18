Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD8C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0D72084C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXezOkx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0D72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIXw-0005aQ-UL
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kJIOa-0003fY-N2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kJIOU-00059O-KJ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600443228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b8GsGdkX/K8PrOYWKImvdC6s3sTCqssArJZqWfYcZyw=;
 b=JXezOkx/M9FqBUmTy843EpbfEhxGV99AP7hxq6yFx7J1O1wcStlXc3UjH5gzIL+oeQqAg1
 8WX1WmI3FKBSVl8HAL0UQjH3YAwsC+/YxpoBI+u8lfEZmZXGNSdz+Z80Q3rRCZhghVP+8g
 jRxUcV3rShpw7a4fczQUCOtY+8QBDME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-hqX0TPYRNuyTM0DybJp39w-1; Fri, 18 Sep 2020 11:33:45 -0400
X-MC-Unique: hqX0TPYRNuyTM0DybJp39w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07CB78B94CA;
 Fri, 18 Sep 2020 15:33:26 +0000 (UTC)
Received: from localhost (ovpn-113-209.ams2.redhat.com [10.36.113.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7394410013C1;
 Fri, 18 Sep 2020 15:33:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/046: Filter request length
Date: Fri, 18 Sep 2020 17:33:23 +0200
Message-Id: <20200918153323.108932-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For its concurrent requests, 046 has always filtered the offset,
probably because concurrent requests may settle in any order.  However,
it did not filter the request length, and so if requests with different
lengths settle in an unexpected order (notably the longer request before
the shorter request), the test fails (for no good reason).

Filter the length, too.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
This has annoyed me for quite some time now, but when rebasing (and
testing) my FUSE export series, it became apparent that on a FUSE export
qcow2 images with -o compat=0.10 always fail this test (because the
first 56k request settles before its accompanying 8k request), so now
I'm forced to do something about it.
---
 tests/qemu-iotests/046     |   3 +-
 tests/qemu-iotests/046.out | 104 ++++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index ed6fae3529..17e71c4b5e 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -186,7 +186,8 @@ EOF
 }
 
 overlay_io | $QEMU_IO blkdebug::"$TEST_IMG" | _filter_qemu_io |\
-	sed -e 's/bytes at offset [0-9]*/bytes at offset XXX/g'
+    sed -e 's/[0-9]*\/[0-9]* bytes at offset [0-9]*/XXX\/XXX bytes at offset XXX/g' \
+        -e 's/^[0-9]* KiB/XXX KiB/g'
 
 echo
 echo "== Verify image content =="
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index 66ad987ab3..b1a03f4041 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -71,74 +71,74 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR
 == Some concurrent requests touching the same cluster ==
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset XXX
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset XXX
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 32768/32768 bytes at offset XXX
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 57344/57344 bytes at offset XXX
-56 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset XXX
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 32768/32768 bytes at offset XXX
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-discard 65536/65536 bytes at offset XXX
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 57344/57344 bytes at offset XXX
-56 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset XXX
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset XXX
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-discard 65536/65536 bytes at offset XXX
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 57344/57344 bytes at offset XXX
-56 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 98304/98304 bytes at offset XXX
-96 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 8192/8192 bytes at offset XXX
-8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 81920/81920 bytes at offset XXX
-80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 blkdebug: Suspended request 'A'
 blkdebug: Resuming request 'A'
-wrote 32768/32768 bytes at offset XXX
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 98304/98304 bytes at offset XXX
-96 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == Verify image content ==
 read 65536/65536 bytes at offset 0
-- 
2.26.2


