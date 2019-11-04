Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75B120869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uowx1xlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75B120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgOD-0004gH-39
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHq-0006KF-Ej
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHp-00012I-2u
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRgHo-00011o-T9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id o28so18086287wro.7
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UKELr7H/B5Ts3z9XAEXzo8WE46skVmRep8vckbpovok=;
 b=uowx1xlXe13ntJqjBhgMeym7vDOhndHAvgnz+R+J8c1cu53Liy88Gvl215WNcZiYHY
 /ujvdwh1xV4gO8qQTW3i4uqCHyKtcNUihL9lL36XyLnU9IA3b8ws5losEjmhpBMsZI8Y
 gdVcg0oP3o8/WhvLDeBXuyblIX2VTLYOFI4ZYXVcP1u2+iNoC9cFn7hEmkSRKAZUzciM
 k/CcfsI+1RBnwyWGwl0x/4TYbPQix3shqVYJdC0dNDh2timISyJ6VrgpycfP3qMpAiaf
 HJK3ketZTBPSjwpYAdSsV7fglxNj2mRIU7UCWxNLCCk90NaJ0EHUCOm43XyKChyq/ghR
 NnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UKELr7H/B5Ts3z9XAEXzo8WE46skVmRep8vckbpovok=;
 b=DmuPUQA7KkMrCc/gQWh13PS1A8ISnuqtOWQyo0/eoX0yNvqocjZVW/xeD/PokK4lEK
 IRYp0svXeUnLvsE3g50oGL1smuqjb69Qz4pcmPg3fwIFsAVcb5GnE9aSp0b25yNYjGwt
 6wfuMPAXH6+P7MFGHTy4h7vq9dnYQOE7JJe0p3Pl95/Q9AbTi8T1bpqeglDgsrK2bv+4
 gM5iKWUZhhJTvZaw7/GkQHzI1hw1TqcU9bExJDPxeS0cpxfe5qAPrcZRuT5MCAYkbSjp
 dYsK2iwBXLwc7QA86nEthmg1sJfXbgoCWtyhI9cWE2qYyIRra6ftkCFIZNgN5+JZKJE6
 sOKA==
X-Gm-Message-State: APjAAAUc3WvlpPGVOelYLTb5z+K9ts1FducZjrz7eSVI0YYsFEa7ao4p
 b0MXa97iUz+xjnZtssOSoJa/Xg==
X-Google-Smtp-Source: APXvYqxr1B12CCr5U9KpM96Cil7RLJjAnM5arpa8h2pucicmdy+LkDScWIX7HVclR3OUWnIq3gIvlw==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr22452624wrj.84.1572889023801; 
 Mon, 04 Nov 2019 09:37:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q11sm15765727wmq.21.2019.11.04.09.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:37:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5FC921FF93;
 Mon,  4 Nov 2019 17:36:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 6/6] tests/vm: support sites with sha512 checksums
Date: Mon,  4 Nov 2019 17:36:54 +0000
Message-Id: <20191104173654.30125-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104173654.30125-1-alex.bennee@linaro.org>
References: <20191104173654.30125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NetBSD project uses SHA512 for its checksums so lets support that
in the download helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 10 ++++++++--
 tests/vm/netbsd    |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

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
index 33779402dd1..89390e99fdd 100755
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


