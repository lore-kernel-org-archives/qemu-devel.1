Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC3ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691AC2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691AC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwIo-0000eK-FJ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIwG4-0004xQ-5t
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIwG3-0007Fj-3C
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iIwG0-0007CL-RS; Fri, 11 Oct 2019 10:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1BE7D3091761;
 Fri, 11 Oct 2019 14:51:04 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E31560468;
 Fri, 11 Oct 2019 14:51:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH 4/5] iotests: Skip "make check-block" if QEMU does not support
 virtio-blk
Date: Fri, 11 Oct 2019 16:50:46 +0200
Message-Id: <20191011145047.19051-5-thuth@redhat.com>
In-Reply-To: <20191011145047.19051-1-thuth@redhat.com>
References: <20191011145047.19051-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 11 Oct 2019 14:51:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch is going to add some python-based tests to the "auto"
group, and these tests require virtio-blk to work properly. Running
iotests without virtio-blk likely does not make too much sense anyway,
so instead of adding a check for the availability of virtio-blk to each
and every test (which does not sound very appealing), let's rather add
a check for this at the top level in the check-block.sh script instead
(so that it is possible to run "make check" without the "check-block"
part for qemu-system-tricore for example).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/check-block.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index 679aedec50..7582347ec2 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
     exit 0
 fi
 
-if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
+if [ -n "$QEMU_PROG" ]; then
+    qemu_prog="$QEMU_PROG"
+else
+    for binary in *-softmmu/qemu-system-* ; do
+        if [ -x "$binary" ]; then
+            qemu_prog="$binary"
+            break
+        fi
+    done
+fi
+if [ -z "$qemu_prog" ]; then
     echo "No qemu-system binary available ==> Not running the qemu-iotests."
     exit 0
 fi
+if ! "$qemu_prog" -M none -device help | grep virtio-blk >/dev/null 2>&1 ; then
+    echo "$qemu_prog does not support virtio-blk ==> Not running the qemu-iotests."
+    exit 0
+fi
 
 if ! command -v bash >/dev/null 2>&1 ; then
     echo "bash not available ==> Not running the qemu-iotests."
-- 
2.18.1


