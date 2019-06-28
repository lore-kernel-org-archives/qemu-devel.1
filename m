Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C13EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3680208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3680208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgreI-0001Vr-6b
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hgrCo-0002QG-1k
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hgrCm-0004lI-Jx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:46:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:41266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hgrCm-0004hz-9t; Fri, 28 Jun 2019 09:46:20 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hgrCi-0008NT-BS; Fri, 28 Jun 2019 16:46:16 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 28 Jun 2019 16:46:09 +0300
Message-Id: <1561729574-530879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561729574-530879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1561729574-530879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 2/7] iotests: exclude killed processes from
 running under Valgrind
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 The Valgrind tool fails to manage its termination when QEMU raises the
 signal SIGKILL in the multi-threaded process. The bug has been
 reported to the Valgrind maintainers. Let's exclude such test cases
 from running under the Valgrind because checking for the memory issues
 is covered by other test cases.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/039 | 5 +++++
 tests/qemu-iotests/061 | 2 ++
 tests/qemu-iotests/137 | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 0d4e963..95115e2 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -65,6 +65,7 @@ echo "== Creating a dirty image file =="
 IMGOPTS="compat=1.1,lazy_refcounts=on"
 _make_test_img $size
 
+VALGRIND_QEMU="" \
 $QEMU_IO -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
     | _filter_qemu_io
@@ -100,6 +101,7 @@ echo "== Opening a dirty image read/write should repair it =="
 IMGOPTS="compat=1.1,lazy_refcounts=on"
 _make_test_img $size
 
+VALGRIND_QEMU="" \
 $QEMU_IO -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
     | _filter_qemu_io
@@ -118,6 +120,7 @@ echo "== Creating an image file with lazy_refcounts=off =="
 IMGOPTS="compat=1.1,lazy_refcounts=off"
 _make_test_img $size
 
+VALGRIND_QEMU="" \
 $QEMU_IO -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
     | _filter_qemu_io
@@ -151,6 +154,7 @@ echo "== Changing lazy_refcounts setting at runtime =="
 IMGOPTS="compat=1.1,lazy_refcounts=off"
 _make_test_img $size
 
+VALGRIND_QEMU="" \
 $QEMU_IO -c "reopen -o lazy-refcounts=on" \
          -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
@@ -163,6 +167,7 @@ _check_test_img
 IMGOPTS="compat=1.1,lazy_refcounts=on"
 _make_test_img $size
 
+VALGRIND_QEMU="" \
 $QEMU_IO -c "reopen -o lazy-refcounts=off" \
          -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index d7dbd7e..5d0724c 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -73,6 +73,7 @@ echo
 echo "=== Testing dirty version downgrade ==="
 echo
 IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
+VALGRIND_QEMU="" \
 $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_io
 $PYTHON qcow2.py "$TEST_IMG" dump-header
@@ -107,6 +108,7 @@ echo
 echo "=== Testing dirty lazy_refcounts=off ==="
 echo
 IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
+VALGRIND_QEMU="" \
 $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_io
 $PYTHON qcow2.py "$TEST_IMG" dump-header
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 0c3d2a1..a442fc8 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -130,6 +130,7 @@ echo
 
 # Whether lazy-refcounts was actually enabled can easily be tested: Check if
 # the dirty bit is set after a crash
+VALGRIND_QEMU="" \
 $QEMU_IO \
     -c "reopen -o lazy-refcounts=on,overlap-check=blubb" \
     -c "write -P 0x5a 0 512" \
-- 
1.8.3.1


