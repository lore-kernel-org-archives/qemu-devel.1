Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54F120BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCS1bedU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54F120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7r2-0003Y0-Pb
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7OO-0001nP-8T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7OM-0007Ui-5g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulimzNEL0OebYKLchj/jnvciYR7O1dWP7X6ueYqVugk=;
 b=KCS1bedUXcVDdddgp2Ge0Mntjpw/wPrr3ykBtl8547/0CnI9LMCJucFdIgCNMROb6BhI7L
 r26A2tx3FA3d0qkHFvGLRyfY05jE3CqHphY3o7dw+P90b1oHArPcj/sUAwz8GKRBD+OQcn
 k/3dkf4feg9u+BpRLMNMi2N84Glg74c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-xeyiFwbcPn66DHjPqtzHfw-1; Tue, 01 Sep 2020 10:36:00 -0400
X-MC-Unique: xeyiFwbcPn66DHjPqtzHfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D57C818BA283;
 Tue,  1 Sep 2020 14:35:59 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72DA47C564;
 Tue,  1 Sep 2020 14:35:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 38/43] iotests: Test that qcow2's data-file is flushed
Date: Tue,  1 Sep 2020 16:34:19 +0200
Message-Id: <20200901143424.884735-39-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Flushing a qcow2 node must lead to the data-file node being flushed as
well.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/244     | 49 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/244.out |  7 ++++++
 2 files changed, 56 insertions(+)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index efe3c0428b..f2b2dddf1c 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -217,6 +217,55 @@ $QEMU_IMG amend -f $IMGFMT -o "data_file=blkdebug::$TEST_IMG.data" "$TEST_IMG"
 $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
 $QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
 
+echo
+echo "=== Flushing should flush the data file ==="
+echo
+
+# We are going to flush a qcow2 file with a blkdebug node inserted
+# between the qcow2 node and its data file node.  The blkdebug node
+# will return an error for all flushes and so we if the data file is
+# flushed, we will see qemu-io return an error.
+
+# We need to write something or the flush will not do anything; we
+# also need -t writeback so the write is not done as a FUA write
+# (which would then fail thanks to the implicit flush)
+$QEMU_IO -c 'write 0 512' -c flush \
+    -t writeback \
+    "json:{
+         'driver': 'qcow2',
+         'file': {
+             'driver': 'file',
+             'filename': '$TEST_IMG'
+         },
+         'data-file': {
+             'driver': 'blkdebug',
+             'inject-error': [{
+                 'event': 'none',
+                 'iotype': 'flush'
+             }],
+             'image': {
+                 'driver': 'file',
+                 'filename': '$TEST_IMG.data'
+             }
+         }
+     }" \
+    | _filter_qemu_io
+
+result=${PIPESTATUS[0]}
+echo
+
+case $result in
+    0)
+        echo "ERROR: qemu-io succeeded, so the data file was not flushed"
+        ;;
+    1)
+        echo "Success: qemu-io failed, so the data file was flushed"
+        ;;
+    *)
+        echo "ERROR: qemu-io returned unknown exit code $result"
+        ;;
+esac
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index dbab7359a9..7269b4295a 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -131,4 +131,11 @@ Offset          Length          Mapped to       File
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 Images are identical.
 Images are identical.
+
+=== Flushing should flush the data file ===
+
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Success: qemu-io failed, so the data file was flushed
 *** done
-- 
2.26.2


