Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB53AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F39206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9bdz97O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F39206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdGF-0000nY-Mn
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEX-0007uW-4t
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEW-0001f7-5U
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdrVeOAvahDTbY9HxGuu2s9MxsnHYSSwYIwchklt6RY=;
 b=Y9bdz97OPek8buC1rDSYpZSM1rmhDAzHkh4lKVMIyYsUdb057mn+ouSOlOIRwBkIk2ILLa
 8YPKbM5PnnQZKxryfNXYjXUSPuw+NzcuSgoGA+n3UMdt2g+ZrV4NqB9ZlWMuyIPrY688J2
 3FWhH0zrsMMmEIWiPmr0e3qL3CiWZzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-mQxN0Vh0PC6S_o9R7SK3kw-1; Fri, 15 May 2020 12:30:45 -0400
X-MC-Unique: mQxN0Vh0PC6S_o9R7SK3kw-1
Received: by mail-wr1-f70.google.com with SMTP id r14so1429707wrw.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DdrVeOAvahDTbY9HxGuu2s9MxsnHYSSwYIwchklt6RY=;
 b=n4l7IaR02bCG1J9/RPMmfBkLbbnOrevtF70rhF/OllnCUoUplQxnE0N1TShQXXR6Ef
 1hv5f0TCHh6qwpF/Sae9aJHykA7AEdPx5tCu8+XbaZ+P4YoGhLwbSSagLNFwzQIdNi95
 Jcmf483Itg3tAKUt7FFPLiSJlz48G2GfRG7qR60X+LnVqLMqJH5QVHT0SpbwTe3wnfuZ
 gH1AmL+U+93QyJEfb0Yia/P3dLcmnV4+qyKWGlBKUFaVR+aUFlur9dviObiLvarRBfTk
 g4CdJupSc4DUfQZdnzl8E1UOItZreiKeiRCQhnMzMwxf+PH7UynhuBdE2WneN5367wzI
 Xt0w==
X-Gm-Message-State: AOAM531bncDvRyruhSa6YzKSXTy6jB4lp7T6T7PMFEQn7FoEXOE19YZu
 Et2XLtCd+McK8XepNOSynUv72CCQWG2ZPJqShIuoLgwd9vKfpQRfn4d/QohhqVtwR9QKd8XDR8D
 5LAGPz4RPy9jeYHA=
X-Received: by 2002:a5d:6504:: with SMTP id x4mr5568364wru.340.1589560242756; 
 Fri, 15 May 2020 09:30:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOkueaxS8BIkrwHvvav0MY2tYgpt6eKemUiMQh74BAnyGEwrCbuV8Frj6wIbuhwwxFReJWYQ==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr5568337wru.340.1589560242560; 
 Fri, 15 May 2020 09:30:42 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q18sm4130744wmk.28.2020.05.15.09.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 09:30:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] tests/vm: Remove flex/bison packages
Date: Fri, 15 May 2020 18:30:26 +0200
Message-Id: <20200515163029.12917-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515163029.12917-1-philmd@redhat.com>
References: <20200515163029.12917-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: use 'does not', removed bison in OpenBSD VM (Claudio)
---
 tests/vm/fedora      | 1 -
 tests/vm/freebsd     | 1 -
 tests/vm/netbsd      | 1 -
 tests/vm/openbsd     | 1 -
 tests/vm/ubuntu.i386 | 2 +-
 5 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/vm/fedora b/tests/vm/fedora
index bd9c6cf295..a9195670f4 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -32,7 +32,6 @@ class FedoraVM(basevm.BaseVM):
     pkgs = [
         # tools
         'git-core',
-        'flex', 'bison',
         'gcc', 'binutils', 'make',
 
         # perl
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 298967fe9c..f87db2b126 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -38,7 +38,6 @@ class FreeBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "flex", "bison",
 
         # libs: crypto
         "gnutls",
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index b10c9d429d..cdac502dad 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -36,7 +36,6 @@ class NetBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "flex", "bison",
 
         # libs: crypto
         "gnutls",
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 0b705f4945..13e7f9a6d5 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -35,7 +35,6 @@ class OpenBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "bison",
 
         # libs: usb
         "libusb1",
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 1570775335..24527cc78c 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -52,7 +52,7 @@ class UbuntuX86VM(basevm.BaseVM):
         self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
-        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
+        self.ssh_root_check("apt-get install -y libfdt-dev language-pack-en")
         self.ssh_root("poweroff")
         self.wait()
         os.rename(img_tmp, img)
-- 
2.21.3


