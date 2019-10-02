Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E393C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431DA2133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfcM-00020Y-4T
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFfWx-0005hf-6q
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFfWv-0005bN-Ku
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:23:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:53312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFfWv-0005Zj-Br; Wed, 02 Oct 2019 10:23:01 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFfWr-0003C3-Gf; Wed, 02 Oct 2019 17:22:57 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 2/6] tests/qemu-iotests: add case of writing compressed
 data to multiple clusters
Date: Wed,  2 Oct 2019 17:22:42 +0300
Message-Id: <1570026166-748566-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
 jsnow@redhat.com, armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the test case to the iotest #214 that checks possibility of writing
compressed data to more than one cluster.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/214     | 9 +++++++++
 tests/qemu-iotests/214.out | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 21ec8a2..5f437e4 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -89,6 +89,15 @@ _check_test_img -r all
 $QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 $QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
+echo
+echo "=== Write compressed data to multiple clusters ==="
+echo
+# Create an empty image and fill three and half clusters with compressed data.
+_make_test_img 2M -o cluster_size=0x10000
+data_size=3*0x10000+0x8000
+$QEMU_IO -c "write -c -P 0x11 0 256k" "$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
index 0fcd8dc..2b908f6 100644
--- a/tests/qemu-iotests/214.out
+++ b/tests/qemu-iotests/214.out
@@ -32,4 +32,10 @@ read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4194304/4194304 bytes at offset 4194304
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Write compressed data to multiple clusters ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+wrote 262144/262144 bytes at offset 0
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
1.8.3.1


