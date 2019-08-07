Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C84521E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJoPLpFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C84521E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMpY-0007jv-UR
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39062)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hvMot-0006Ev-3S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hvMor-00007y-Mi
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:39 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:34417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hvMor-00007o-Ip
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:37 -0400
Received: by mail-qt1-x82e.google.com with SMTP id k10so19333669qtq.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NwJ4uWjVtM+26b3Wt3huTtV/qJaSrXNc+otrwh9eGR4=;
 b=eJoPLpFPnGtP6/gNG6bsKghxb7SVMFTEX8Gyfc7NOYGV56e5i4g3euyrzq863WzpEt
 YfYbtNyphMvv9Vr08aIl4mCkNi2cSrUCdinVMX59HgrlgwljxVxrwZ0/Y9sFqpP/fUR2
 n4sCV/1HmoLJ0JK+4sFNFw6Ye/MYlmMscFGb3kcpF9BP8OKOgnPjTvtuzArsCEl9fU0R
 u7jCbbAn0om+CmN5WU7HWENdv7XINgGx9nisRda964IaM3FMoSjC6aimzX4iSjoPIcwM
 nmUdX8kUtSDokegc7rsafuxX4lFVnOXszK0rHiMOMEmjcZDOzgBFcxP2JnucasAihRl8
 w34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NwJ4uWjVtM+26b3Wt3huTtV/qJaSrXNc+otrwh9eGR4=;
 b=IrBUp9dB8dDd0kD6h4/6Lg4UZ2tFeCeFVYui6vdM0XCKj/FVgtuoZEi86S5k09veAo
 Ice2J6ycgsWEL6cY7WAzLgnNbOuc+hrvNEvmznXKvm5POf5wi5K36Iy+RSWBQaM8aJCV
 yaB9fs3fAIu5aVVVoVgylHxkMAxZA0IJEgbtuiGgct/D9tynIOubo9qpA+iIX5ldIEXL
 ScV8aVgnE78Rl33Ub9X9FLMiPHdR6qpm1LWOh6/J2D6FdKEdnPDzf9Zxg77P6J+bPzN+
 4fzbwophSZrEhfX8Eg24CbdBll2XxOQKG3GiKbJKruU1T1U54MA4QZ1L00IlsCt9Qpey
 nUdQ==
X-Gm-Message-State: APjAAAUjF+tbu7PAr7cCueWXgFbXzl+QAsla1UMGTbHMLuHohU5y9Eoi
 uFboof0S5yW9TY+mxL2j4UMUCMgW
X-Google-Smtp-Source: APXvYqw8vkfOvWKMox19ZE3JTlAn8g1D117j1IKGGwdItmwLHR+QNT9yb7R/S98STFLaqjUtWOYckg==
X-Received: by 2002:ac8:2f43:: with SMTP id k3mr8416162qta.179.1565187696773; 
 Wed, 07 Aug 2019 07:21:36 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc])
 by smtp.gmail.com with ESMTPSA id e18sm31472034qkm.49.2019.08.07.07.21.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:21:36 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 11:21:14 -0300
Message-Id: <20190807142114.17569-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807142114.17569-1-danielhb413@gmail.com>
References: <20190807142114.17569-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82e
Subject: [Qemu-devel] [PATCH v5 4/4] qemu-iotests: adding LUKS cleanup for
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
secret is used.

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
index 0000000000..cb362598b4
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
+echo "== Pre-existing image file should also be deleted after the error =="
+if test -f "$TEST_IMAGE_FILE"; then
+    exit 1
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
new file mode 100644
index 0000000000..3803933571
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
+== Pre-existing image file should also be deleted after the error ==
+ *** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f13e5f2e23..ae7bb89642 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -271,3 +271,4 @@
 254 rw backing quick
 255 rw quick
 256 rw quick
+257 rw auto quick
-- 
2.21.0


