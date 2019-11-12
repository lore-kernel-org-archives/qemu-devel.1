Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B22C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB9D20656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eh4Liq78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB9D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXZf-00006p-Gb
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVC-0003X9-LD
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVB-00036j-Af
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:42 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXVB-00035s-3v
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:41 -0500
Received: by mail-wr1-x436.google.com with SMTP id l7so7265691wrp.6
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OuBID0cJqkigSPofx9+aC0NVHfNM9AtTCEr/b96Ovls=;
 b=eh4Liq78aWKNj3ut3flg/QtyGPjidZUrYm/7rObzK7AEItIjVFcq2nEAgXUGIm6nzE
 olyra1ItCQjBgNIq2Q32/ogAwZlUix/0t8HlMoEfvmgi8GkRpYjYXvONrrH1V4M78pX1
 Z/jV5ij7ZShlM4Q3gpmwOLcrwX1oe+mbD6p+jfq7R2wegnRTAKKCe+702lic+JqcHT4n
 1038Iv+LbXafXLFe4usUOaS9Kg9zBZ4h/63ccbpO5FC+ND804KJ+HazhZsqw+kRIZScZ
 OwmdFuaww9VJfr/l8/TkH09Du9fGu4dIXsZwNNmzt55vvw1UHnqr2mcNBM6JO4iUkMzF
 okxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OuBID0cJqkigSPofx9+aC0NVHfNM9AtTCEr/b96Ovls=;
 b=LUkiKEvhr8XVDrsAlM2Bq9tNTwWrWJ9Ab9HwLVTHSAFuphKau+/4qekOMRnlaj8BTy
 2MTYftPXYR3jwdKTXSuk2Ki20KsCGUm8qiIdCy2FoewbBIa/7wqdmo84Jc2zys8epcbS
 AfLB99OXq3RdRHv7+ZoWhUIUChmGHnCMcXI0nSl9IzshbkflMpdIbtMWwWb2ibIj1OP2
 cGLMi+dMcINCwX4I8bT/6OGYoaG/ZG1p2BhdmVTq1MjysFJ25opp0oO+220cjLsgndGo
 nrUWaPHeeKjYxZIb7NmdzUkcz6SfKhM31Uvz4JKm3eaJmDwgJ8ZC1B3FQFLJcahbCSHe
 2XOg==
X-Gm-Message-State: APjAAAXTytTTc9pUZ1zMyIuOz2+4skHX2uvtW0DBBMuRAHCdNvqYz/fL
 6WRVL47voEa/Xmf9bGzIXEyy/Q==
X-Google-Smtp-Source: APXvYqzBdxMKEK4v7nZeNMQgzL7UBpGRb8+TPOcfwwiagNsffbMGBeT2aqtw00npxSjcxfFF9pLVdw==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr26944129wri.378.1573570238599; 
 Tue, 12 Nov 2019 06:50:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm18905974wrr.82.2019.11.12.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E4131FF93;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 6/8] tests/vm: support sites with sha512 checksums
Date: Tue, 12 Nov 2019 14:50:26 +0000
Message-Id: <20191112145028.26386-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NetBSD project uses SHA512 for its checksums so lets support that
in the download helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 086bfb2c66d..91a9226026d 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -95,19 +95,25 @@ class BaseVM(object):
             logging.info("KVM not available, not using -enable-kvm")
         self._data_args = []
 
-    def _download_with_cache(self, url, sha256sum=None):
+    def _download_with_cache(self, url, sha256sum=None, sha512sum=None):
         def check_sha256sum(fname):
             if not sha256sum:
                 return True
             checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
             return sha256sum == checksum.decode("utf-8")
 
+        def check_sha512sum(fname):
+            if not sha512sum:
+                return True
+            checksum = subprocess.check_output(["sha512sum", fname]).split()[0]
+            return sha512sum == checksum.decode("utf-8")
+
         cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
         if not os.path.exists(cache_dir):
             os.makedirs(cache_dir)
         fname = os.path.join(cache_dir,
                              hashlib.sha1(url.encode("utf-8")).hexdigest())
-        if os.path.exists(fname) and check_sha256sum(fname):
+        if os.path.exists(fname) and check_sha256sum(fname) and check_sha512sum(fname):
             return fname
         logging.debug("Downloading %s to %s...", url, fname)
         subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"],
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c48c60853e7..611e6cc5b5c 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -23,6 +23,7 @@ class NetBSDVM(basevm.BaseVM):
     arch = "x86_64"
 
     link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetBSD-8.1-amd64.iso"
+    csum = "718f275b7e0879599bdac95630c5e3f2184700032fdb6cdebf3bdd63687898c48ff3f08f57b89f4437a86cdd8ea07c01a39d432dbb37e1e4b008f4985f98da3f"
     size = "20G"
     pkgs = [
         # tools
@@ -70,7 +71,7 @@ class NetBSDVM(basevm.BaseVM):
     ipv6 = False
 
     def build_image(self, img):
-        cimg = self._download_with_cache(self.link)
+        cimg = self._download_with_cache(self.link, sha512sum=self.csum)
         img_tmp = img + ".tmp"
         iso = img + ".install.iso"
 
-- 
2.20.1


