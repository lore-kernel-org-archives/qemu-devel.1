Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD89920673
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD89920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15A5-0004C5-Uw
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 04:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i159D-0003iq-Co
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i159C-0000cc-Fc
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i1598-0000bb-Jc; Fri, 23 Aug 2019 04:42:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1472011A00;
 Fri, 23 Aug 2019 08:42:09 +0000 (UTC)
Received: from thuth.com (ovpn-116-236.ams2.redhat.com [10.36.116.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60711600CD;
 Fri, 23 Aug 2019 08:42:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Aug 2019 10:42:03 +0200
Message-Id: <20190823084203.29734-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 23 Aug 2019 08:42:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/check-block: Skip iotests when
 sanitizers are enabled
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sanitizers (especially the address sanitizer from Clang) are
sometimes printing out warnings or false positives - this spoils
the output of the iotests, causing some of the tests to fail.
Thus let's skip the automatic iotests during "make check" when the
user configured QEMU with --enable-sanitizers.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/check-block.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index c8b6cec3f6..679aedec50 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -21,6 +21,11 @@ if grep -q "TARGET_GPROF=y" *-softmmu/config-target.mak 2>/dev/null ; then
     exit 0
 fi
 
+if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
+    echo "Sanitizers are enabled ==> Not running the qemu-iotests."
+    exit 0
+fi
+
 if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
     echo "No qemu-system binary available ==> Not running the qemu-iotests."
     exit 0
-- 
2.18.1


