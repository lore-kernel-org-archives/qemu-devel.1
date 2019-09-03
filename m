Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270EBC41514
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E132341F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6e6daJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E132341F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59O1-0000hV-ML
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i59JK-0003Nm-GV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i59JJ-0005mA-1C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:30 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836]:43315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i59JF-0005kg-88
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:27 -0400
Received: by mail-qt1-x836.google.com with SMTP id l22so7767263qtp.10
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3vBr1n1UsZgU8PgLgokhaXnjo/VGwWwRQ5hmljwJgVU=;
 b=Y6e6daJV9/1SfIAKAh6wC8Ew44SuR4x4sVPSyc1oyjfnPOXEbPpQYh6zhck3LCzwpr
 p/cTN2RXOe2Yr0mus4bA3xXKH+6eXU9l8uNJpw37V3aiyuh9uQ/979fy30spg1mGTAyK
 U3Ub3ZHx/2f95RLOP/1l4KA+hD9sRn4hEutd246RYOI7KCp92X0y6qkxDtFcGo6nPr/g
 6bskxi5ZAhB5eF188URXfRQAJyhbQMKbY2MVHxtNmPdDQwaG3wmUgX0Kn7OyWV6daYc7
 QiQSgpifsR9ofRrIXgZgN3jaZILdJ7Rzy+shim3fafqVTzTGgKifdQLeeQNyqq+4m0x8
 iarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3vBr1n1UsZgU8PgLgokhaXnjo/VGwWwRQ5hmljwJgVU=;
 b=e8K4Hu0gkA6Y9j3/KMVMvqtDJMEyIRGkGf7cKQJQbuv5h3r7Z37hzgdRlFSgHL5p78
 A2JYdfvdfpLpl8/4Eiw2YI7t1oJ2J53cis5z0jveUSIViI8wsWClevyVnzdFTywBBew6
 lNBTIar30J9j55EvpCNrIDgBD3CGpvFmXMHJkf+i+x8QExZLEQV4BHIi/qnIJsLBIwRh
 i2htPpvTGv9+t3XRzAbRTfMZQGXNUjqPGK7G+z6OO3CXOg6tO2baUZGJeUerkq0bvTMT
 dgrYxWNfVDD6uz2epzi31/esLllkz6azR15rKlO+W4hljrEVD+ymChT7R9DsX/buJgl8
 +yrA==
X-Gm-Message-State: APjAAAUVjIKXkOLA9V+Ll9f/jsJTm+cYsiOYKBHrbmWEHRLfxTleM49w
 L7e3uBI5tNeQ5TR8zdApOtSjmXvE69E=
X-Google-Smtp-Source: APXvYqwXqOzBobl+pwRFr7qAODjHZA419uA0lOXicNZIejbA58jkHlKMMTwpaNSzT2Ce59gT/8MKbw==
X-Received: by 2002:ac8:6ce:: with SMTP id j14mr33704693qth.373.1567519044204; 
 Tue, 03 Sep 2019 06:57:24 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5c9f:9471:e230:52b:8c93])
 by smtp.gmail.com with ESMTPSA id k49sm9211158qtc.9.2019.09.03.06.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 06:57:23 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 10:57:08 -0300
Message-Id: <20190903135708.21624-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903135708.21624-1-danielhb413@gmail.com>
References: <20190903135708.21624-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::836
Subject: [Qemu-devel] [PATCH v7 4/4] qemu-iotests: adding LUKS cleanup for
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
index d95d556414..8f50bd91e5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,4 +273,5 @@
 256 rw quick
 257 rw
 258 rw quick
+259 rw img quick
 262 rw quick migration
-- 
2.21.0


