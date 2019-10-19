Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A0CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD30222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbe6W6Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD30222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56637 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqZ1-0003Vc-MO
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNy-0001KA-SS
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNw-00077H-VN
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNw-00075w-Fp
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so3948662wrr.10
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IrxCFtZN7IWMU6h2qOEBlnQRpVoXjxguCXHm8vL6MOI=;
 b=Kbe6W6HmdS+fWJQDjRBnkcyA22Z71off/MNopVmr33yzT/vr3VDiUEChO9R4faNU2w
 foK9Eu+onYZw9llsLkml6R7KJuWYyFZRxk1s427pStiv29LQ6tB8VC1QDu06W9obpF42
 KwTQKEZkIc7bnl2aA+C5Czt9Z48Ga/sY89gxNJsq7fx8hpwUbCvWbxvDRccHgI4Uum6l
 M/fZQTh6qgQCGiTrgtV4Mh7SDZ1fQ6DTc9SjbqGcCMwhsWo9+ArfW6Yd2WfTGw/6+Oco
 qFEqmsdrISx0JagmVcUfgb9+gV9uGjdjXgjAi1SXOO24avsZOQRWn7JeixrrtpRVoCpQ
 2Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IrxCFtZN7IWMU6h2qOEBlnQRpVoXjxguCXHm8vL6MOI=;
 b=EiteRxy4YqjfgxN+QdMRzkFu9RzzU+PvEDtgfEV1OfjJTL6t8euhY5h3fF04SEWMvF
 azVFqBnUu/bo3qGq2DrMoQ7OaDyoNjUwbjDQXdf3SbIAnZ4A851X/JPSgGVhISm94vQe
 Y2FmFU+hUiJM+h8yY1+d/WF8QdMqe3cA7mWWrDbOHbvWvsUTgoSL5MEO+jLEBiw70Ika
 pCS6wTGG9TpCV4Ny5oJfL1JNX1amUAYnFXX3lbc6SeZ1FUFfRoJbJ0V6XOe4C/KpLM4B
 Hwu3n4nWe0NOeZ6CrfIA1Yd2LS3aRXhFqM6QHrlL54IH26m/xoD6S0eGQnfOVTk2Ey+T
 nmJQ==
X-Gm-Message-State: APjAAAWsEggzHszBy4CtAGOHbkoeNuYOqggc2PnqX8WtYVn2x4BJtoVU
 5jITIkn49raC8+wm3oxxxjQKbvnS
X-Google-Smtp-Source: APXvYqzIqkc1+/1rmHXfLUTaYeNF7Q9ko6dkLFDuG0FA2P7sMdWLUgTSnjjbc/wfrniQRBJAeItUow==
X-Received: by 2002:adf:a506:: with SMTP id i6mr11985631wrb.159.1571497874934; 
 Sat, 19 Oct 2019 08:11:14 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] tests/ssh_linux_malta: Refactor how to get image/kernel
 info
Date: Sat, 19 Oct 2019 17:10:57 +0200
Message-Id: <20191019151058.31733-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qcow and kernel images use a similar pattern regarding they
are for big/little endianess, or 32/64 bit.
Refactor using more dictionary keys.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 75 ++++++++++++++----------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index 822b0553ff..2139c80f5f 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -26,15 +26,44 @@ class LinuxSSH(Test):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     VM_IP = '127.0.0.1'
 
+    BASE_URL = 'https://people.debian.org/~aurel32/qemu/'
     IMAGE_INFO = {
-        'be': {'image_url': ('https://people.debian.org/~aurel32/qemu/mips/'
-                             'debian_wheezy_mips_standard.qcow2'),
-               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5'},
-        'le': {'image_url': ('https://people.debian.org/~aurel32/qemu/mipsel/'
-                             'debian_wheezy_mipsel_standard.qcow2'),
-               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802'}
+        'be': {'base_url': 'mips',
+               'image_name': 'debian_wheezy_mips_standard.qcow2',
+               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
+               'kernel_hash': {
+                   32: '592e384a4edc16dade52a6cd5c785c637bcbc9ad',
+                   64: 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'}
+              },
+        'le': {'base_url': 'mipsel',
+               'image_name': 'debian_wheezy_mipsel_standard.qcow2',
+               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
+               'kernel_hash': {
+                   32: 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a',
+                   64: '6a7f77245acf231415a0e8b725d91ed2f3487794'}
+              }
+        }
+    CPU_INFO = {
+        32: {'kernel_release': '3.2.0-4-4kc-malta'},
+        64: {'kernel_release': '3.2.0-4-5kc-malta'}
         }
 
+    def get_url(self, endianess, path=''):
+        qkey = {'le': 'el', 'be': ''}
+        return '%s/mips%s/%s' % (self.BASE_URL, qkey[endianess], path)
+
+    def get_image_info(self, endianess):
+        dinfo = self.IMAGE_INFO[endianess]
+        image_url = self.get_url(endianess, dinfo['image_name'])
+        image_hash = dinfo['image_hash']
+        return (image_url, image_hash)
+
+    def get_kernel_info(self, endianess, wordsize):
+        minfo = self.CPU_INFO[wordsize]
+        kernel_url = self.get_url(endianess,
+                                  'vmlinux-%s' % minfo['kernel_release'])
+        kernel_hash = self.IMAGE_INFO[endianess]['kernel_hash'][wordsize]
+        return kernel_url, kernel_hash
 
     @skipUnless(ssh.SSH_CLIENT_BINARY, 'No SSH client available')
     @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
@@ -79,8 +108,7 @@ class LinuxSSH(Test):
         return stdout_lines, stderr_lines
 
     def boot_debian_wheezy_image_and_ssh_login(self, endianess, kernel_path):
-        image_url = self.IMAGE_INFO[endianess]['image_url']
-        image_hash = self.IMAGE_INFO[endianess]['image_hash']
+        image_url, image_hash = self.get_image_info(endianess)
         image_path = self.fetch_asset(image_url, asset_hash=image_hash)
 
         self.vm.set_machine('malta')
@@ -172,7 +200,10 @@ class LinuxSSH(Test):
             'md5sum /dev/mtd2ro',
             '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
 
-    def check_mips_malta(self, endianess, kernel_path, uname_m):
+    def check_mips_malta(self, uname_m, endianess):
+        wordsize = 64 if '64' in uname_m else 32
+        kernel_url, kernel_hash = self.get_kernel_info(endianess, wordsize)
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
 
         stdout, _ = self.ssh_command('uname -a')
@@ -188,12 +219,7 @@ class LinuxSSH(Test):
         :avocado: tags=endian:big
         :avocado: tags=device:pcnet32
         """
-        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
-                      'vmlinux-3.2.0-4-4kc-malta')
-        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.check_mips_malta('be', kernel_path, 'mips')
+        self.check_mips_malta('mips', 'be')
 
     def test_mips_malta32el_kernel3_2_0(self):
         """
@@ -202,12 +228,7 @@ class LinuxSSH(Test):
         :avocado: tags=endian:little
         :avocado: tags=device:pcnet32
         """
-        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
-                      'vmlinux-3.2.0-4-4kc-malta')
-        kernel_hash = 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.check_mips_malta('le', kernel_path, 'mips')
+        self.check_mips_malta('mips', 'le')
 
     def test_mips_malta64eb_kernel3_2_0(self):
         """
@@ -216,11 +237,7 @@ class LinuxSSH(Test):
         :avocado: tags=endian:big
         :avocado: tags=device:pcnet32
         """
-        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
-                      'vmlinux-3.2.0-4-5kc-malta')
-        kernel_hash = 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.check_mips_malta('be', kernel_path, 'mips64')
+        self.check_mips_malta('mips64', 'be')
 
     def test_mips_malta64el_kernel3_2_0(self):
         """
@@ -229,8 +246,4 @@ class LinuxSSH(Test):
         :avocado: tags=endian:little
         :avocado: tags=device:pcnet32
         """
-        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
-                      'vmlinux-3.2.0-4-5kc-malta')
-        kernel_hash = '6a7f77245acf231415a0e8b725d91ed2f3487794'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.check_mips_malta('le', kernel_path, 'mips64')
+        self.check_mips_malta('mips64', 'le')
-- 
2.21.0


