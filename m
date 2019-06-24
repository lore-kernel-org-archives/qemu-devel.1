Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA79C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B49F212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9I3fhZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B49F212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPeg-0007DB-Ng
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41612)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGK-0006jS-3d
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007h3-VV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007JP-KV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id 207so12881921wma.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IGs3kzw+BI2fE8Ae88LzkdFhpv0ghN5hux8Z4DaX/+I=;
 b=t9I3fhZd8bxzsfpVLvbf+GRhcegKRKVkyCFmIEOQfttF9JdlBaOFguPFWWeFXxhwnN
 uZ0UtWOrq9N14fQSnSPMacMm+pptgGjmoVbnVOKPDM9N6uOupAjbphAGArrNnhq7ftAV
 62j7Ph06MzvKX0gv1UKy9j3JeuBGuQffvXiqqw/k3TQu3faAMxsWvh138BEhzaHsmc0/
 tiAgRLJA3IStTt17SEAGYDoiV/B0gb9RNPkwW+jfItKbx1agwGv8NPcGedNFrO1q6Mj8
 QodjTwZeexqH+2YLhwinIz8xO8fPTlJ15zkRHJjYpukyjl8u271RVDmlBHSFA0/fADHc
 /PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IGs3kzw+BI2fE8Ae88LzkdFhpv0ghN5hux8Z4DaX/+I=;
 b=P8P352zW5nU7k0g3mN0hZuWpSeaCcwUW/URLzyZmyELtvnU03EU7Z9nS2+WLYefVv6
 dGNTTy7lX5B1+g3OWue1fzdOMgk3IqFkTZjTJ//LdOuHFwYFaYnDkU5Hg9HxUkp6Nmgo
 uMLQfKDfrUHqPGg5rKvwso+IMF0CJ33U8MqTnc5c3SoqGroHzEc/bFrJhkFVyKo6LGS9
 vXCEsb1YKSak1seAdChhzLowl4+4BqqjUqLVZFtCHt/XuuDZ/k3f0CJ+shdPQl5PJHbH
 PC6t7Cw26THHTs1vo9J740PTm48LC3Hc5HgmLfoEg16W4+l8nEXCgY5YlCstq4UifNim
 4ifw==
X-Gm-Message-State: APjAAAU1NQOhQSUIcl44c4BvzcCNp3qibxETxFlU+9vvAJWsvjfPPSO4
 +kQVoAHNYkit79XqW2rxl9MFhw==
X-Google-Smtp-Source: APXvYqw5BO3qXdUfNiTzbnKk7PDdW8d7X2UURPk1v8RVMbg84aWmvddu2p5A3XzefBHUGPLz1C2W6A==
X-Received: by 2002:a05:600c:204c:: with SMTP id
 p12mr16171881wmg.121.1561383819494; 
 Mon, 24 Jun 2019 06:43:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h1sm10498779wrt.20.2019.06.24.06.43.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA1EF1FF8F;
 Mon, 24 Jun 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:20 +0100
Message-Id: <20190624134337.10532-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 02/19] tests/vm: avoid image presence check and
 removal
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

Python's os.rename() will silently replace an existing file,
so there's no need for the extra check and removal.

Reference: https://docs.python.org/3/library/os.html#os.rename

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190613130718.3763-3-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/centos b/tests/vm/centos
index b00b46a8dc..53976f1c4c 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -77,8 +77,6 @@ class CentosVM(basevm.BaseVM):
         self.ssh_root_check("systemctl enable docker")
         self.ssh_root("poweroff")
         self.wait()
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
         return 0
 
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 5575c23a6f..091be1a065 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -36,8 +36,6 @@ class FreeBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
 
 if __name__ == "__main__":
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index d0508f4465..ee9eaeab50 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -36,8 +36,6 @@ class NetBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
 
 if __name__ == "__main__":
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 87ec982489..28c7d25e29 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -38,8 +38,6 @@ class OpenBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
 
 if __name__ == "__main__":
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index a22d137e76..12867b193f 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -80,8 +80,6 @@ class UbuntuX86VM(basevm.BaseVM):
         self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
         self.ssh_root("poweroff")
         self.wait()
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
         return 0
 
-- 
2.20.1


