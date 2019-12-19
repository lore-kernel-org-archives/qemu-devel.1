Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFCBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9741227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Na0l5nj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9741227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtQx-0003x3-AS
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNI-0006Z0-3b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNG-0008I2-NY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNG-0008Bu-DL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:42 -0500
Received: by mail-wr1-x432.google.com with SMTP id q6so5457391wro.9
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aKHmlXVnEdxblPaY0W1a7lGdL9lrMsXlAG76mAyvLB0=;
 b=Na0l5nj4hsrrKx0LC54oQSHzoqJeVqjZ9Zcw1rqB0PImGZkYVpu+lQ6X26MPPqI7B4
 ZyMJFZKIRmcWCylm2x4ifIZMpqzkyD+WXYgJHECowd5fEaAHwbcbyusHPnrZU99dWWy7
 oSTkQeKeSrV+k23+0+mlhO1neGnEkair68rl+0GaSN/vJqA5WUkr5eA/pCx6Eln9g/k2
 /8iJS5mMLA8DGi79vjGLeHnQQFHdbMOI1N4pCdMYoQ5XhnIoF6nHXZHqvPv7yeWTctd9
 1gG4aWZ8q6ua6L8nPD862NrFs9thsnmJLscspyRCCXQoGNts3/uaQK8LMje87cLuYsDm
 2f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aKHmlXVnEdxblPaY0W1a7lGdL9lrMsXlAG76mAyvLB0=;
 b=g+gCpogFeIVgtOMAvvoXIKe3S/nDLA8D7rGmtqJYNHwnMKf7hrgB6YVxhsKsLMJWk+
 aDcCCwv8SBuDkWJKvksVkJopHGfuT/KTX8F4yn/M76rCY49+LyiO7SCF4SZdjhC4B1J7
 bGpqidPuA1JC+oDu9arZJavgvamsCU+zBVurr6wL2SyOcJqYbT0rZmMXjw+pxkpw1a58
 oenTRnMPlMwhSb5EcYsl+DM2bm44O7886MADidKp+7PNS0MXiigzDLRf6VCIUN7/RsSy
 SVfQdigNkhWHPH2v3c2kxPX/dsmx3ueKsQe1MdOsCpoZAXsluk4wdjJTN82o/ewdiHU1
 NvNA==
X-Gm-Message-State: APjAAAWxTf0pCsDNzzVA9GPR74Rjm3vkDGLiiZFJurUgpmeVDSUrjZ13
 CUZIvGASTV+hIfA+oa7yXBiRrQ==
X-Google-Smtp-Source: APXvYqzZjg2+JW4KO66zB/EINWeWe8D1sIQqZ5/mu3IWhx6pNHu7xEfQFRfyJQHLv3fdEhjzPk55EQ==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr8330316wro.45.1576752581233; 
 Thu, 19 Dec 2019 02:49:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c195sm6275377wmd.45.2019.12.19.02.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF9CD1FF91;
 Thu, 19 Dec 2019 10:49:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/25] iotests: Provide a function for checking the creation of
 huge files
Date: Thu, 19 Dec 2019 10:49:13 +0000
Message-Id: <20191219104934.866-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


