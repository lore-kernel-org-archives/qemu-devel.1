Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD02C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1CF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5VIWqNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1CF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOF1-0006sB-4P
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO7B-0000sH-Mh
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO77-00064h-7M
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alcfv40yDu5l+TeiP/ficXJ4JagMjki+6RyJy7EZT5o=;
 b=M5VIWqNCnpyrzErSUUTizV8Y9h2/IQIy+L3JewiLA85NTHBY+mhbvZfGK5TXGmFaZUnQHb
 T7ZFEXpMuEWN7k+brM+rVCdFxHEne/AT5FMm5GEgc6QOG0Cmqwt0dVyLeSDGfPpaUZeUTl
 ANQsUz5/I/cunHZbgpmFXulAurytEyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-cyQi7yJiPE2F0-OJmSl37w-1; Mon, 22 Jun 2020 11:11:46 -0400
X-MC-Unique: cyQi7yJiPE2F0-OJmSl37w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DD21B18BFA;
 Mon, 22 Jun 2020 15:11:45 +0000 (UTC)
Received: from localhost (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7386B7168B;
 Mon, 22 Jun 2020 15:11:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/18] iotests: don't test qcow2.py inside 291
Date: Mon, 22 Jun 2020 17:10:59 +0200
Message-Id: <20200622151059.921191-19-mreitz@redhat.com>
In-Reply-To: <20200622151059.921191-1-mreitz@redhat.com>
References: <20200622151059.921191-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

820c6bee534ec3b added testing of qcow2.py into 291, and it breaks 291
with external data file. Actually, 291 is bad place for qcow2.py
testing, better add a separate test.

For now, drop qcow2.py testing from 291 to fix the regression.

Fixes: 820c6bee534ec3b
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200618154052.8629-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/291     |  4 ----
 tests/qemu-iotests/291.out | 33 ---------------------------------
 2 files changed, 37 deletions(-)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 28e4fb9b4d..1e0bb76959 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -64,8 +64,6 @@ $QEMU_IO -c 'w 1M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG bitmap --disable -f $IMGFMT "$TEST_IMG" b1
 $QEMU_IMG bitmap --enable -f $IMGFMT "$TEST_IMG" b2
 $QEMU_IO -c 'w 2M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
-echo "Check resulting qcow2 header extensions:"
-$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 
 echo
 echo "=== Bitmap preservation not possible to non-qcow2 ==="
@@ -92,8 +90,6 @@ $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
 $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
 _img_info --format-specific
-echo "Check resulting qcow2 header extensions:"
-$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 
 echo
 echo "=== Check bitmap contents ==="
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 08bfaaaa6b..9f661515b4 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -14,25 +14,6 @@ wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 2097152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Check resulting qcow2 header extensions:
-Header extension:
-magic                     0xe2792aca (Backing format)
-length                    5
-data                      'qcow2'
-
-Header extension:
-magic                     0x6803f857 (Feature table)
-length                    336
-data                      <binary>
-
-Header extension:
-magic                     0x23852875 (Bitmaps)
-length                    24
-nb_bitmaps                2
-reserved32                0
-bitmap_directory_size     0x40
-bitmap_directory_offset   0x510000
-
 
 === Bitmap preservation not possible to non-qcow2 ===
 
@@ -84,20 +65,6 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
-Check resulting qcow2 header extensions:
-Header extension:
-magic                     0x6803f857 (Feature table)
-length                    336
-data                      <binary>
-
-Header extension:
-magic                     0x23852875 (Bitmaps)
-length                    24
-nb_bitmaps                3
-reserved32                0
-bitmap_directory_size     0x60
-bitmap_directory_offset   0x520000
-
 
 === Check bitmap contents ===
 
-- 
2.26.2


