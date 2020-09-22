Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4348EC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8037A208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gva83zgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8037A208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfxl-0007Mm-Fp
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsP-0000as-Oa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55681
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsL-0000c5-LJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0+mbpy7TGMFbJ2dlBNKv31mcrtHShg9gJHn2HPnyPQ=;
 b=gva83zgtW3HvDee08UlDg6kgpF55rcStzj4TYoHyfchzBnOoLa+/x0msmIj86Bhksccti/
 huwDlBGi6ZGDvtNh383XRom/ROT2QCD7WCWydcQMNy6TRcD9mD1yVC4mBxQrU5ygnlj7YC
 ZadAcvEG/JpZWgq7hgkEnJM3OqORn2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-Ji-blN25NsaVotPGqm11IQ-1; Tue, 22 Sep 2020 06:50:17 -0400
X-MC-Unique: Ji-blN25NsaVotPGqm11IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E096C57053;
 Tue, 22 Sep 2020 10:50:15 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FC06610AF;
 Tue, 22 Sep 2020 10:50:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 09/20] iotests: Use convert -n in some cases
Date: Tue, 22 Sep 2020 12:49:21 +0200
Message-Id: <20200922104932.46384-10-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-img convert (without -n) can often be replaced by a combination of
_make_test_img + qemu-img convert -n.  Doing so allows converting to
protocols that do not allow direct file creation, such as FUSE exports.
The only problem is that for formats other than qcow2 and qed (qcow1 at
least), this may lead to high disk usage for some reason, so we cannot
do it everywhere.

But we can do it in 028 and 089, so let us do that so they can run on
FUSE exports.  Also, in 028 this allows us to remove a 9-line comment
that used to explain why we cannot safely filter drive-backup's image
creation output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/028     | 14 ++++----------
 tests/qemu-iotests/028.out |  3 +++
 tests/qemu-iotests/089     |  3 ++-
 tests/qemu-iotests/089.out |  1 +
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 6dd3ae09a3..864dc4a4e2 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -116,16 +116,10 @@ else
     QEMU_COMM_TIMEOUT=1
 fi
 
-# Silence output since it contains the disk image path and QEMU's readline
-# character echoing makes it very hard to filter the output. Plus, there
-# is no telling how many times the command will repeat before succeeding.
-# (Note that creating the image results in a "Formatting..." message over
-# stdout, which is the same channel the monitor uses.  We cannot reliably
-# wait for it because the monitor output may interact with it in such a
-# way that _timed_wait_for cannot read it.  However, once the block job is
-# done, we know that the "Formatting..." message must have appeared
-# already, so the output is still deterministic.)
-silent=y _send_qemu_cmd $h "drive_backup disk ${TEST_IMG}.copy" "(qemu)"
+TEST_IMG="$TEST_IMG.copy" _make_test_img $image_size
+_send_qemu_cmd $h "drive_backup -n disk ${TEST_IMG}.copy" "(qemu)" \
+    | _filter_imgfmt
+
 silent=y qemu_cmd_repeat=20 _send_qemu_cmd $h "info block-jobs" "No active jobs"
 _send_qemu_cmd $h "info block-jobs" "No active jobs"
 _send_qemu_cmd $h 'quit' ""
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index 5a68de5c46..e580488216 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -468,6 +468,9 @@ No errors were found on the image.
 
 block-backup
 
+Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=IMGFMT size=4294968832
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) drive_backup -n disk TEST_DIR/t.IMGFMT.copy
 (qemu) info block-jobs
 No active jobs
 === IO: pattern 195
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 66c5415abe..03a2ccf1e8 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -62,7 +62,8 @@ TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
 $QEMU_IO -c 'write -P 42 0 512' -c 'write -P 23 512 512' \
          -c 'write -P 66 1024 512' "$TEST_IMG.base" | _filter_qemu_io
 
-$QEMU_IMG convert -f raw -O $IMGFMT "$TEST_IMG.base" "$TEST_IMG"
+_make_test_img $IMG_SIZE
+$QEMU_IMG convert -f raw -O $IMGFMT -n "$TEST_IMG.base" "$TEST_IMG"
 
 $QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE \
          -c 'read -P 42 0 512' -c 'read -P 23 512 512' \
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 15682c2886..c53fc4823a 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -9,6 +9,7 @@ wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 512
-- 
2.26.2


