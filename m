Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F2FC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52A521881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXOea6Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52A521881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tVb-00020n-Rt
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 17:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPg-0005ts-OC
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPf-0004PJ-BX
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:59:00 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:46060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i4tPf-0004Om-84
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:59 -0400
Received: by mail-qk1-x731.google.com with SMTP id z67so744942qkb.12
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u9G4IYIbYDj0k9bcX3iHzHaFezRpdzekc5r3iFKBM9A=;
 b=FXOea6Fzqk8z9B82LH0nnAtVHBnHVinX6vqaEqZ2ZhZ7/cOw1Qble8mDEWbI5Nkb8M
 5n8zvoSgOK5AVggmbwMFBqsISZgeqGyjkLtqCAHPK71FI1XMC8ho16x27/KzGI0TJ2ca
 R5+gIF2JqsOxb/FXmV/u/EFTGI+LSjdDYhUdLWDYDoagqz10xJqJwsmOrYjBZ+JFrOkv
 qXvJ4rFZHixcMHKQTq1s79Ek3VP07J+QmworPEVaMn6JRfU+tOy1oihEf8/rHjW2dQOg
 vLHjRXSKqydePUxklvjU1+7v8t3Hlq4mEpMjrLc1unawAv3cOWemr5FXKVqoxNi8viLu
 vQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u9G4IYIbYDj0k9bcX3iHzHaFezRpdzekc5r3iFKBM9A=;
 b=rEQIHoTa0If+zpkH2Cv9KCFiYvN9Rc1jJC1hEZIVaDm5QvfBTxXccHs7xfYCz4wGL0
 lGP49dvHgwuNCsNAV0aEsvr4QdZDaVJ2bvYMvjQqoSFMRgUB5Dyj5ZmxaueHSkJm986b
 u5WWivhqcXzY6olSboKCzxYu5x26XKKwUhVvOXyUol7dvxGIOXTNIvc91Zp94vtN619S
 n09xIDuQHPEtyLpRSF15S6j8qm8yWgkdEDheb/xSlxt5jsM6NaxncQD3uuKSK0P6A7/e
 WzI/d1sGkP1cil/4dRfs+dFfvyCRbnrZoLIzvOGukcyTwjtHypp3drmg6UWafY9RK0B4
 2kcw==
X-Gm-Message-State: APjAAAXxrjclQe0rpYCbfu2sLuzTfqMiy4hb8xVOSTDg0uMKOUpdAp1y
 KzBoY1GJkxLHeaKDw1lnPmcdqN/y
X-Google-Smtp-Source: APXvYqyxXl+g/BVjWlYYEzchUJPbT8zY/ID1e/zOPzQ5T3wbW2QCRDwL5MrDDSKDdwuNLDExCOFL1g==
X-Received: by 2002:ae9:f707:: with SMTP id s7mr3749476qkg.195.1567457938646; 
 Mon, 02 Sep 2019 13:58:58 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id w80sm4604038qka.62.2019.09.02.13.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 13:58:58 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:58:42 -0300
Message-Id: <20190902205842.1884-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902205842.1884-1-danielhb413@gmail.com>
References: <20190902205842.1884-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::731
Subject: [Qemu-devel] [PATCH v6 4/4] qemu-iotests: adding LUKS cleanup for
 non-UTF8 secret error
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new test file, 257, to exercise the case where
qemu-img fails to complete for the LUKS format when a non-UTF8
secret is used.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 11 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

diff --git a/tests/qemu-iotests/259 b/tests/qemu-iotests/259
new file mode 100755
index 0000000000..cb362598b4
--- /dev/null
+++ b/tests/qemu-iotests/259
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img file cleanup for LUKS when using a non-UTF8 secret
+#
+# Copyright (C) 2019, IBM Corporation.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+TEST_IMAGE_FILE='vol.img'
+
+_cleanup()
+{
+  _cleanup_test_img
+  rm non_utf8_secret
+  rm -f $TEST_IMAGE_FILE
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt luks
+_supported_proto generic
+_unsupported_proto vxhs
+
+echo "== Create non-UTF8 secret =="
+echo -n -e '\x3a\x3c\x3b\xff' > non_utf8_secret
+SECRET="secret,id=sec0,file=non_utf8_secret"
+
+echo "== Throws an error because of invalid UTF-8 secret =="
+$QEMU_IMG create -f $IMGFMT --object $SECRET -o "key-secret=sec0" $TEST_IMAGE_FILE 4M
+
+echo "== Image file should not exist after the error =="
+if test -f "$TEST_IMAGE_FILE"; then
+    exit 1
+fi
+
+echo "== Create a stub image file and run qemu-img again =="
+touch $TEST_IMAGE_FILE
+$QEMU_IMG create -f $IMGFMT --object $SECRET -o "key-secret=sec0" $TEST_IMAGE_FILE 4M
+
+echo "== Pre-existing image file should also be deleted after the error =="
+if test -f "$TEST_IMAGE_FILE"; then
+    exit 1
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
new file mode 100644
index 0000000000..6b0188111c
--- /dev/null
+++ b/tests/qemu-iotests/259.out
@@ -0,0 +1,11 @@
+QA output created by 259
+== Create non-UTF8 secret ==
+== Throws an error because of invalid UTF-8 secret ==
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
+Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+== Image file should not exist after the error ==
+== Create a stub image file and run qemu-img again ==
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
+Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+== Pre-existing image file should also be deleted after the error ==
+ *** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d95d556414..67c3faf80f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,4 +273,5 @@
 256 rw quick
 257 rw
 258 rw quick
+259 rw auto quick
 262 rw quick migration
-- 
2.21.0


