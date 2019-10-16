Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF10FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F2521928
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F2521928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmD0-0004dO-Vq
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKmAf-0002XA-Ss
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKmAe-000847-Df
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:29:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:51296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKmAe-00081L-5u; Wed, 16 Oct 2019 12:29:08 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKmAZ-0002B1-6Q; Wed, 16 Oct 2019 19:29:03 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v4 3/4] tests/qemu-iotests: add case to write compressed data
 of multiple clusters
Date: Wed, 16 Oct 2019 19:28:52 +0300
Message-Id: <1571243333-882302-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the test case to the iotest #214 that checks possibility of writing
compressed data of more than one cluster size.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/214     | 35 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out | 15 +++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 21ec8a2..0003dc2 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -89,6 +89,41 @@ _check_test_img -r all
 $QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 $QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
+echo
+echo "=== Write compressed data of multiple clusters ==="
+echo
+cluster_size=0x10000
+_make_test_img 2M -o cluster_size=$cluster_size
+
+echo "Uncompressed data:"
+let data_size="8 * $cluster_size"
+$QEMU_IO -c "write -P 0xaa 0 $data_size" "$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IMG info "$TEST_IMG" | sed -n '/disk size:/ s/^ *//p'
+
+_make_test_img 2M -o cluster_size=$cluster_size
+let data_size="3 * $cluster_size + ($cluster_size >> 1)"
+# Set compress=on. That will align the written data
+# by the cluster size and will write them compressed.
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c "write -P 0xbb 0 $data_size" --image-opts \
+         driver=$IMGFMT,compress=on,file.filename=$TEST_IMG \
+         2>&1 | _filter_qemu_io | _filter_testdir
+
+let offset="4 * $cluster_size"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c "write -P 0xcc $offset $data_size" "json:{\
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'file',
+        'filename': '$TEST_IMG'
+    },
+    'compress': true
+}" | _filter_qemu_io | _filter_testdir
+
+echo "After the multiple cluster data have been written compressed,"
+$QEMU_IMG info "$TEST_IMG" | sed -n '/disk size:/ s/^ *//p'
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
index 0fcd8dc..09a2e9a 100644
--- a/tests/qemu-iotests/214.out
+++ b/tests/qemu-iotests/214.out
@@ -32,4 +32,19 @@ read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4194304/4194304 bytes at offset 4194304
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Write compressed data of multiple clusters ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+Uncompressed data:
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+disk size: 772 KiB
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+wrote 229376/229376 bytes at offset 0
+224 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 229376/229376 bytes at offset 262144
+224 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+After the multiple cluster data have been written compressed,
+disk size: 268 KiB
 *** done
-- 
1.8.3.1


