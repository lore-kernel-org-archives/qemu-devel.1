Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190ECC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E650821872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E650821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVnL-0000Yt-V9
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoVn3-000807-FN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoVn1-0003PQ-Bm
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:31:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:44208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hoVn0-0002sE-Rf; Fri, 19 Jul 2019 12:31:23 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hoVm8-0006pa-OT; Fri, 19 Jul 2019 19:30:28 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 19:30:14 +0300
Message-Id: <1563553816-148827-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 4/6] iotests: Valgrind fails with
 nonexistent directory
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

The Valgrind uses the exported variable TMPDIR and fails if the
directory does not exist. Let us exclude such a test case from
being run under the Valgrind and notify the user of it.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/051 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index ce942a5..f8141ca 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -377,6 +377,10 @@ printf %b "qemu-io $device_id \"write -P 0x33 0 4k\"\ncommit $device_id\n" |
 $QEMU_IO -c "read -P 0x33 0 4k" "$TEST_IMG" | _filter_qemu_io
 
 # Using snapshot=on with a non-existent TMPDIR
+if [ "${VALGRIND_QEMU}" == "y" ]; then
+    _casenotrun "Valgrind needs a valid TMPDIR for itself"
+fi
+VALGRIND_QEMU="" \
 TMPDIR=/nonexistent run_qemu -drive driver=null-co,snapshot=on
 
 # Using snapshot=on together with read-only=on
-- 
1.8.3.1


