Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BECC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B687208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffR7fiMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B687208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZLHy-0005r8-KP
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZJzo-0006fZ-Q9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZJzm-0002NW-P9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:53:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZJzl-00029u-0I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:53:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so3129946wrm.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FAAPWl2/V0iy+paRMznAnMUNuGKtzl/qFFkGtAWRKLM=;
 b=ffR7fiMemag5d+7B4EkzCu+hbr53ZIZhRI/GHNLlyL4o9A7V0WeK6O5E6dlVO4Lcxh
 PyVxvj+pXhBQ8xR2PJdoh+lANRN23iZKujSVdpVLjOtpcy236R4+kF4wXyBRoBdrJ8fJ
 6FC0MNBlARaPgYduVuxCLTcogNo82CVmM0Rn/R1cWMbhi/8ARZAkTAWyJyRdDwUotl6j
 Yl5UDRYbeO3oD3nc5SsIuYS3UUKCRPSdIUnbfVPpONvadI/KWV8Jxn8numZrgiebMZED
 TRdYTmJgtbColgNgOp+GZeB2yBo6QnwkCnIs4uMa/oY17S+ijw6mbi7mZ1bzu4RrsUKc
 lRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FAAPWl2/V0iy+paRMznAnMUNuGKtzl/qFFkGtAWRKLM=;
 b=HNF+NR5noxyhe8kjzAkO4wJezb+W3sOzu5bwhGMMhJYV8Q16MgHPoCSBpUd0c6v8EA
 6e9VYSqr61NMlERyQRafQzI7TBabtS1y3xmZYbP9U3j8d5M4MSsE5ufuhK23uGa7CkY6
 FvsyWMMiA/d/hnL5u95nYBFp70XLUPlWRexksqyEQpNK2unQJHGNU9mQW9p0tQsHT0UJ
 TLuzC5oz1lGXOu5YwD0STrujzL8vJ9djXfPLp3V2OgSD0LAksFfsyYJT1OahT5uVpvJq
 Abe8RagGzwp7s0aOHNrBOkILGW0Rr2b/bK5G/TvAt2KMAXmwjHpbKx5JDkobIVoI32g/
 EzyA==
X-Gm-Message-State: APjAAAXgan7IYro3gjd9LATpTj6GdQjMIAwSGGMx7dP4WKux2VaHADwZ
 iiVBujZfHuBMdQEvkyh2xzR38Q==
X-Google-Smtp-Source: APXvYqyS9jkHHyM1w2/YLw6ZMMSpmMKX+EXQG295F2FCRcsHJlWgdutyYmD/aWKvM9D6Scv6XyWsUA==
X-Received: by 2002:adf:f246:: with SMTP id b6mr10411033wrp.92.1559933620253; 
 Fri, 07 Jun 2019 11:53:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o15sm3451464wrw.42.2019.06.07.11.53.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 11:53:39 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4713B1FF87;
 Fri,  7 Jun 2019 19:53:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 19:53:37 +0100
Message-Id: <20190607185337.14524-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] tests/vm: favour the locally built QEMU for
 bootstrapping
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

It turns out that relying on the system installed QEMU can result in
problems especially if it has been patched. Seeing as this is a
developer tool and we should be dogfooding we favour the locally built
binary if it exists. The developer always has the option of overriding
their locally broken build with the QEMU environment variable.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
This applies on top of my PR and will get rolled into v2 if people are
happy with it.
---
 tests/vm/Makefile.include |  1 +
 tests/vm/basevm.py        | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 5e37063d32..b49e5e2f2c 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -48,6 +48,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		--build-dir $(BUILD_DIR) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d4b816be14..1a8850ba98 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -48,6 +48,9 @@ class BaseVM(object):
         "no_proxy",
     ]
 
+    # path for seaching for qemu
+    qemu_build_dir = None
+
     # The script to run in the guest that builds QEMU
     BUILD_SCRIPT = ""
     # The guest name, to be overridden by subclasses
@@ -155,6 +158,19 @@ class BaseVM(object):
                             "-device",
                             "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
 
+    def set_qemu_build_dir(self, build_dir):
+        self.qemu_build_dir = build_dir
+
+    def _find_best_qemu(self):
+        "Return a QEMU we should use. Use the locally built one if we can."
+        bin_name = "qemu-system-" + self.arch
+        if self.qemu_build_dir:
+            bin_path = "%s/%s-softmmu/%s" % (self.qemu_build_dir,
+                                             self.arch, bin_name)
+            if os.path.exists(bin_path):
+                return bin_path
+        return bin_name
+
     def boot(self, img, extra_args=[]):
         args = self._args + [
             "-device", "VGA",
@@ -162,7 +178,7 @@ class BaseVM(object):
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
         args += self._data_args + extra_args
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
+        qemu_bin = os.environ.get("QEMU", self._find_best_qemu())
         guest = QEMUMachine(binary=qemu_bin, args=args)
         guest.set_machine('pc')
         guest.set_console()
@@ -327,6 +343,8 @@ def parse_args(vmcls):
                       help="build QEMU from source in guest")
     parser.add_option("--build-target",
                       help="QEMU build target", default="check")
+    parser.add_option("--build-dir", default="flibble",
+                      help="QEMU build directory", action="store")
     parser.add_option("--interactive", "-I", action="store_true",
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
@@ -348,6 +366,7 @@ def main(vmcls):
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
                                       "Use --force option to overwrite\n"])
                 return 1
+            vm.set_qemu_build_dir(args.build_dir)
             return vm.build_image(args.image)
         if args.build_qemu:
             vm.add_source_dir(args.build_qemu)
-- 
2.20.1


