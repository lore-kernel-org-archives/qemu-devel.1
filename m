Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF29C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF982133F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kanAamLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF982133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPOI-0004HY-EB
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0006fm-Cs
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGE-0007d2-E5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGC-0007J7-Gu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id x15so12848967wmj.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kG7TibQlzrXHGeVA/kaiY4pLQv/EwI9FVJyG9q9KK+o=;
 b=kanAamLUH/KjSYgigeWC3w9zqYxCkDdbhY35YtMRFvB0f5IBXMFZUL2lHxoZMMazOl
 WboT7gNPfYZ1b5hti25DJpDeo+yaUUHycyALVTzge2nlcpLtlZKbPaNH41fIM8kAPD32
 kqhDll7XDffw+UsqOWzCBGQDcCyCgi2RBtU6B+PVRjqTkJfFEXIkcoTMw48yOkyRMssM
 K20bzQjiF8dDouI43hs4NierTMU317YxQ7jwtIMNO5pm9gSLsJwEOBxd4/YoQLWBHwVM
 S3GBshIAexk5DEShMhpe1TG7W2cflKBqCzdsriORPyFWBYYn5A/bBsviP0+dwz8Z4ghQ
 JduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kG7TibQlzrXHGeVA/kaiY4pLQv/EwI9FVJyG9q9KK+o=;
 b=QJLiQaDMVyvDBU3WArIjvQC4ZCaVP2IOWzyo+MiQSxkPwoN6n6TTesDP3qr1rptqfx
 q2G2t2/ON9G44SKJLAHe1nTAk+NZ/of2FmlCL+QGlsSQmz+Y4ZQgbhzrM+8sPoNokffd
 TcvVFXhkp6DKUaElcYcNiH7MzLmyckSaHv74QDCIfJ5ipG+nz3Nxei6RZj7urwJgu9PQ
 BWpSBhwy5b3xMp9VYBzRmcFnd5uT2AexhJR07KCxmn5gzKWw88Xix3K3lvMUxMdoOd5V
 CBuT+SYtQ56gRhKT/u7GimAo7c1CzAzeWNzTANd7V8U3XtikRywrVMlMKhcZQsme0opW
 aohQ==
X-Gm-Message-State: APjAAAVy0N6/IqOLSJrbB/AjE2+p2Km5WFgh0YQvphq/Cy9BWzIU7pIy
 7NGmWAqEnAdRPTHS7L/z1b++xfRffvM=
X-Google-Smtp-Source: APXvYqxixADqBuwEvB/UrG4M8ETE6+HRu8Ml2IYiOnaMvWW4B3zKzLmeu9lqWjo29l7mmv40uplkPQ==
X-Received: by 2002:a1c:e356:: with SMTP id a83mr16695414wmh.38.1561383818949; 
 Mon, 24 Jun 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l16sm10803321wrw.42.2019.06.24.06.43.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F2A61FF8C;
 Mon, 24 Jun 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:19 +0100
Message-Id: <20190624134337.10532-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 01/19] tests/vm: avoid extra compressed image
 copy
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

The image copy is only really needed because xz doesn't know to
properly decompress a file not named properly.  Instead of
decompressing to stdout, and having to rely on a shell, let's just
create a link instead of copying the file.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190613130718.3763-2-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/centos b/tests/vm/centos
index 7417b50af4..b00b46a8dc 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -66,8 +66,8 @@ class CentosVM(basevm.BaseVM):
         cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
-        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
         self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
         self.wait_ssh()
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b0066017a6..5575c23a6f 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -34,8 +34,8 @@ class FreeBSDVM(basevm.BaseVM):
         img_tmp_xz = img + ".tmp.xz"
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 4c6624ea5e..d0508f4465 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -34,8 +34,8 @@ class NetBSDVM(basevm.BaseVM):
         img_tmp_xz = img + ".tmp.xz"
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2105c01a26..87ec982489 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -36,8 +36,8 @@ class OpenBSDVM(basevm.BaseVM):
         img_tmp_xz = img + ".tmp.xz"
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
-- 
2.20.1


