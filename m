Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB5C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFF42083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMkOEByA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFF42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgwvp-0005Z0-M6
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 15:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoS-0000gl-VL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoP-0000yg-M9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:36 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:45202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hgwoP-0000xZ-Fl
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:33 -0400
Received: by mail-qk1-x72e.google.com with SMTP id s22so5876095qkj.12
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ERGUElZlTYh7HYWiUP5pCt+6UgNRD2a1NhzEKHWJLUY=;
 b=oMkOEByAS+tWexLBQIxOJLYY3x9467f3WEbuea5kx3ZdIGvCrDXKWa/n/f0+Eul3IW
 yWOzfG6Y6IqbPEdnLwjZyKfs5zbWafYf7MyigfEtrJ2TSUkDlf4QhBEE4cx11kClMUnM
 qHSIOzVxrB7Qdf/cO1XnlDxK1cSVd/OADEpPsgaeKxWzjXnDlSzvufITi//ffnQUpeef
 GYfiMLkHyhOqHNb4zdRvrhJuIBZZZMSlo8kUJ1rn/9/Ti8BLWpqFFCC9naefnq5K6scS
 eI3nBiI1IWIZptrUd1CS1A5sdWJH3El7MoF9ho778PReOeHme899L5YljwHkGMiVK+we
 tdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ERGUElZlTYh7HYWiUP5pCt+6UgNRD2a1NhzEKHWJLUY=;
 b=NkskaaloMb1zjRUYIBZmuzfZEeXUMM7Sz11tIqKSrY1/pQ6y7l2yiR6hXtgntyYPQA
 fW8T+WK9uuFmIc/H/+03m4bUz3Cw8aAfgQolZ9JD6j9oPerZP/OkP5jkwUcZgqwTUxpV
 mGea+ddXl19sXXHAKmbmy4BPyAXoHxFXHMfKS5jzuGtcQuMhCj/0chInVyJxMv6moKvF
 zW6wB5oAapbg0lsyCnro0SUksfdu9+THFmgLT5WNIQbt4m075O0ffEiie3QKszBBYmtQ
 lCkyU70Nh9X+bcSg2ofwb+8jvfi9tW8Xrecxo2KC3LCVwyKrMwkbhBnl3fHq0WflqmbD
 n9Lg==
X-Gm-Message-State: APjAAAVMvsAXMaTs08Bsev8OenyYD4KewH7muZOsktH90YvCeU4vOfjY
 7vmf7cOk+BRJLckbWSCpgehR8tz4
X-Google-Smtp-Source: APXvYqwBc0O8YBBgu0oC6qdTr5qqvdkPsSy3Li0BjP5MwnAB5OLjVFb/YNjD2uYIzB82ZnW7zWIleg==
X-Received: by 2002:a37:5cc3:: with SMTP id q186mr10123699qkb.74.1561751132091; 
 Fri, 28 Jun 2019 12:45:32 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:927e:501b:7135:21ca:8a87])
 by smtp.gmail.com with ESMTPSA id b69sm1602288qkg.105.2019.06.28.12.45.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 12:45:31 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 16:45:12 -0300
Message-Id: <20190628194512.21311-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628194512.21311-1-danielhb413@gmail.com>
References: <20190628194512.21311-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72e
Subject: [Qemu-devel] [PATCH v4 4/4] qemu-iotests: adding LUKS cleanup for
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
Cc: kwolf@redhat.com, jsnow@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, berrange@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new test file, 257, to exercise the case where
qemu-img fails to complete for the LUKS format when a non-UTF8
secret is used. If using an existing image file, do not erase it.
If the file was created by the failed qemu-img call, clean it up.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/qemu-iotests/257     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/257.out | 11 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
new file mode 100755
index 0000000000..2402217619
--- /dev/null
+++ b/tests/qemu-iotests/257
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
+echo "== Pre-existing image file can not be deleted after the error =="
+if ! test -f "$TEST_IMAGE_FILE"; then
+    exit 1
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
new file mode 100644
index 0000000000..5efeb1ed29
--- /dev/null
+++ b/tests/qemu-iotests/257.out
@@ -0,0 +1,11 @@
+QA output created by 257
+== Create non-UTF8 secret ==
+== Throws an error because of invalid UTF-8 secret ==
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
+Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+== Image file should not exist after the error ==
+== Create a stub image file and run qemu-img again ==
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
+Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+== Pre-existing image file can not be deleted after the error ==
+ *** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b34c8e3c0c..00fbfefc8e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -269,3 +269,4 @@
 254 rw auto backing quick
 255 rw auto quick
 256 rw auto quick
+257 rw auto quick
-- 
2.20.1


