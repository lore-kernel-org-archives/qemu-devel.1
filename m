Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0AB20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF2SNiVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0AB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwqP-0004WA-TX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juwp6-00035F-0w
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:40:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juwp4-0002Y7-8D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594640437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLoitUtUpX0el5EXQ/6ot/CD+l9Xy8V/XhJmFJoXwqE=;
 b=fF2SNiVyWqnPhT082f4Vgbqw+iehdyDNHLSXw2NiQvQno58q2C+oGf4LB++bRmEZA2xARU
 x4NNwxmLdoI17CHiicStsbJkF94slxVOqssedGOvWPWF16btozORvAnuVP6i61K/yuz3nE
 ykSO0beP31T2JAloUN5f/iPgKcc5dVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-R3YKZyiGNqWZXfvhzRqNfA-1; Mon, 13 Jul 2020 07:40:36 -0400
X-MC-Unique: R3YKZyiGNqWZXfvhzRqNfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09ED019200D1;
 Mon, 13 Jul 2020 11:40:35 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A506060C84;
 Mon, 13 Jul 2020 11:40:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] fixup! iotests: Specify explicit backing format where sensible
Date: Mon, 13 Jul 2020 06:40:31 -0500
Message-Id: <20200713114031.137846-1-eblake@redhat.com>
In-Reply-To: <20200709121713.283092-1-kwolf@redhat.com>
References: <20200709121713.283092-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org,
 "open list:Block layer core" <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max spotted that I didn't test -qed...

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/024     | 2 +-
 tests/qemu-iotests/024.out | 1 -
 tests/qemu-iotests/043     | 5 +++--
 tests/qemu-iotests/043.out | 4 ----
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 3c5d57310e94..12aceb2d41f6 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -180,7 +180,7 @@ $QEMU_IMG rebase -f "$IMGFMT" -b "$BASE_NEW_OREL" -F $IMGFMT "$OVERLAY_WREL"
 popd >/dev/null

 # Verify the backing path is correct
-TEST_IMG=$OVERLAY _img_info | grep '^backing file'
+TEST_IMG=$OVERLAY _img_info | grep '^backing file:'

 echo

diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index f4fd77fd5b4d..973a5a371119 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -158,7 +158,6 @@ wrote 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 backing file: t.IMGFMT.base_new (actual path: TEST_DIR/subdir/t.IMGFMT.base_new)
-backing file format: IMGFMT

 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index e4022b7044de..3271737f69cc 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -82,11 +82,12 @@ _make_test_img -b "$TEST_IMG.2.base" -F $IMGFMT $size

 echo
 echo "== finite chain of length 3 (human) =="
-_img_info --backing-chain
+# Exclude backing format, since qed differs from qcow2 on what gets stored
+_img_info --backing-chain | grep -v '^backing file format:'

 echo
 echo "== finite chain of length 3 (json) =="
-_img_info --backing-chain --output=json
+_img_info --backing-chain --output=json | grep -v 'backing-filename-format'

 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index 7251e26d4ff9..63ecb2181690 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -25,14 +25,12 @@ file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.2.base
-backing file format: IMGFMT

 image: TEST_DIR/t.IMGFMT.2.base
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.1.base
-backing file format: IMGFMT

 image: TEST_DIR/t.IMGFMT.1.base
 file format: IMGFMT
@@ -42,7 +40,6 @@ cluster_size: 65536
 == finite chain of length 3 (json) ==
 [
     {
-        "backing-filename-format": "IMGFMT",
         "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT",
         "cluster-size": 65536,
@@ -52,7 +49,6 @@ cluster_size: 65536
         "dirty-flag": false
     },
     {
-        "backing-filename-format": "IMGFMT",
         "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT.2.base",
         "cluster-size": 65536,
-- 
2.27.0


