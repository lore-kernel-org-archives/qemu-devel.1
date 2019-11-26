Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DCAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0F820656
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0F820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZc4j-0006wZ-Ia
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iZc3u-0005xb-Dg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iZc3s-0003w2-U7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:43:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:47916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iZc3s-0003vL-M8; Tue, 26 Nov 2019 09:43:28 -0500
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iZc3j-0004JL-GT; Tue, 26 Nov 2019 17:43:19 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v9 3/3] tests/qemu-iotests: add case to write compressed data
 of multiple clusters
Date: Tue, 26 Nov 2019 17:43:18 +0300
Message-Id: <1574779398-88772-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the case to the iotest #214 that checks possibility of writing
compressed data of more than one cluster size. The test case involves
the compress filter driver showing a sample usage of that.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/214     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out | 14 ++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 21ec8a2..aacf66f 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -89,6 +89,49 @@ _check_test_img -r all
 $QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 $QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
+echo
+echo "=== Write compressed data of multiple clusters ==="
+echo
+cluster_size=0x10000
+_make_test_img 2M -o cluster_size=$cluster_size
+
+echo "Write uncompressed data:"
+let data_size="8 * $cluster_size"
+$QEMU_IO -c "write -P 0xaa 0 $data_size" "$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+sizeA=$($QEMU_IMG info --output=json "$TEST_IMG" |
+        sed -n '/"actual-size":/ s/[^0-9]//gp')
+
+_make_test_img 2M -o cluster_size=$cluster_size
+echo "Write compressed data:"
+let data_size="3 * $cluster_size + $cluster_size / 2"
+# Set compress on. That will align the written data
+# by the cluster size and will write them compressed.
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c "write -P 0xbb 0 $data_size" --image-opts \
+         "driver=compress,file.driver=$IMGFMT,file.file.driver=file,file.file.filename=$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+
+let offset="4 * $cluster_size + $cluster_size / 4"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c "write -P 0xcc $offset $data_size" "json:{\
+    'driver': 'compress',
+    'file': {'driver': '$IMGFMT',
+             'file': {'driver': 'file',
+                      'filename': '$TEST_IMG'}}}" | \
+                          _filter_qemu_io | _filter_testdir
+
+sizeB=$($QEMU_IMG info --output=json "$TEST_IMG" |
+        sed -n '/"actual-size":/ s/[^0-9]//gp')
+
+if [ $sizeA -le $sizeB ]
+then
+    echo "Compression ERROR"
+fi
+
+$QEMU_IMG check --output=json "$TEST_IMG" |
+          sed -n 's/,$//; /"compressed-clusters":/ s/^ *//p'
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
index 0fcd8dc..9fc6728 100644
--- a/tests/qemu-iotests/214.out
+++ b/tests/qemu-iotests/214.out
@@ -32,4 +32,18 @@ read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4194304/4194304 bytes at offset 4194304
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Write compressed data of multiple clusters ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+Write uncompressed data:
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+Write compressed data:
+wrote 229376/229376 bytes at offset 0
+224 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 229376/229376 bytes at offset 278528
+224 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+"compressed-clusters": 8
 *** done
-- 
1.8.3.1


