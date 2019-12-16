Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A82CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E60206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjSAJ76J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E60206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoFX-0006xv-T4
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE3-0005EY-6h
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE1-0003b7-RU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoE1-0003aH-K7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id b6so6749433wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sekHCSundFwN1XwOB6e9ZV5liIqc5bIq/ABEnUutdkA=;
 b=GjSAJ76J/nGCIVqYmfN3poFlcLv/lQxivXLSlIAxgEA+gVJDcKRZcvCSG8P+pviVCG
 LfplcImINo9lInuv7MAlD1ZdJvDQZNpme/nrDOPXCHGLtVe3etZ9Nb40FaYY4tmuGlKd
 z7xgPq++vlvaEtq7+omXOT/AkI29hil+qnCtvyEcfJDhNuGWKCdsBs9S0ZlC4/IaKysx
 ll0c+fFe6YLGSPEq/qoU7wTSP3Dwlcz1LhJVZe+Jl+HERx6xi4vYf8dcfIPOYCnfp627
 UPCmE9ITthDTdqxdI9X6q5cxlXBhckd/iQId4o7ngd16XU4f7dT7FGkgw03Rc88w/CgB
 D4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sekHCSundFwN1XwOB6e9ZV5liIqc5bIq/ABEnUutdkA=;
 b=l8e/D4SjF9WmaN1Bi8HVcgrYXeNVHk4laMGUIfD744xPlal94qzOtbKi/0X3wB72nD
 +Zm8Qw7h76rtS+wVjlf3a1uUkdPe5wFJk44T7m5LSMjmOL2Kx1ugc67Rk2C17d/rjNfN
 Z93O66m4E6wwXAc/zx1fCzj9K+xewUiqeT/xDV9Q517uKZh5SyzAl3gO0ekMt7P9ysKr
 U0ckWQe2PuVku+uDEVZCUcc/gpyUEXlLMXHgiFsHRvCSo0XTAKZqUMwweI6q/JqFwWbB
 AQCHTtSX5eWkTcgdr/HQXUNMf7v3DTG4ZC3xoaS+WJsE2I6LV4Mx0g8jCBdNYNLybWix
 Wnfw==
X-Gm-Message-State: APjAAAWZ8PbRHlgiSkWsuYF8mPuXSmLp0Fh+4KhM/8/Y4+7PLHn75TUl
 e1R8/WFUGVqI5jfhdMpOMl7C8Q==
X-Google-Smtp-Source: APXvYqwIhOP0LrG9RLVNzwFEK7N3jMyhF1qRMy2FG9FI4d6i1KgL03lEuRbkCT2xtn6X1+23Kuj5+A==
X-Received: by 2002:adf:e78b:: with SMTP id n11mr29657532wrm.10.1576494460522; 
 Mon, 16 Dec 2019 03:07:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s16sm21253491wrn.78.2019.12.16.03.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8148E1FF91;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/16] iotests: Provide a function for checking the
 creation of huge files
Date: Mon, 16 Dec 2019 11:07:20 +0000
Message-Id: <20191216110732.24027-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Max Reitz <mreitz@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Some tests create huge (but sparse) files, and to be able to run those
tests in certain limited environments (like CI containers), we have to
check for the possibility to create such files first. Thus let's introduce
a common function to check for large files, and replace the already
existing checks in the iotests 005 and 220 with this function.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191204154618.23560-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/005       |  5 +----
 tests/qemu-iotests/220       |  6 ++----
 tests/qemu-iotests/common.rc | 10 ++++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 58442762fe3..b6d03ac37de 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -59,10 +59,7 @@ fi
 # Sanity check: For raw, we require a file system that permits the creation
 # of a HUGE (but very sparse) file. Check we can create it before continuing.
 if [ "$IMGFMT" = "raw" ]; then
-    if ! truncate --size=5T "$TEST_IMG"; then
-        _notrun "file system on $TEST_DIR does not support large enough files"
-    fi
-    rm "$TEST_IMG"
+    _require_large_file 5T
 fi
 
 echo
diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
index 2d62c5dcac2..15159270d33 100755
--- a/tests/qemu-iotests/220
+++ b/tests/qemu-iotests/220
@@ -42,10 +42,8 @@ echo "== Creating huge file =="
 
 # Sanity check: We require a file system that permits the creation
 # of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
-if ! truncate --size=513T "$TEST_IMG"; then
-    _notrun "file system on $TEST_DIR does not support large enough files"
-fi
-rm "$TEST_IMG"
+_require_large_file 513T
+
 IMGOPTS='cluster_size=2M,refcount_bits=1' _make_test_img 513T
 
 echo "== Populating refcounts =="
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 0cc8acc9edd..6f0582c79af 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -643,5 +643,15 @@ _require_drivers()
     done
 }
 
+# Check that we have a file system that allows huge (but very sparse) files
+#
+_require_large_file()
+{
+    if ! truncate --size="$1" "$TEST_IMG"; then
+        _notrun "file system on $TEST_DIR does not support large enough files"
+    fi
+    rm "$TEST_IMG"
+}
+
 # make sure this script returns success
 true
-- 
2.20.1


