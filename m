Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB54C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743262071B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoHMkWn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743262071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOyh-0003I0-Ku
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrC-0007Cc-PO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrB-0006V8-Ei
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:33049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jCOrB-0006Ug-8i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:41 -0400
Received: by mail-pg1-x536.google.com with SMTP id m5so3181182pgg.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Kg9peQoC2sg52IZVPinKGbMeesGBXCKH6J+N63DQI98=;
 b=IoHMkWn41ef7kLpALelhVQFIr///zjCkq9DW4VuiBLnY/7XyjVca5xJWIjNJSorfja
 go02LBeI/WFIg8fNltG35vTGmbwka2XnMf2G2Ak+PB4uW8Y8I8xQkM/SkZnYLKuYpZoN
 3dYfKtoVcQK57A/GHGDuRVJ7JUgfgIFlzlq/sFXaGYcnRvjbXx5TPgqBwztXqKbeAzkU
 gBvlJY4oRzdEfRuHA3vZ2vWSX91Cv9ontzwL0vGsgecAHQSaZMrd5JilOW71WwuGmDwq
 6A5nvgZeOiPccA1JqAaSKFq6XxJKEcBl4+km7gjA3wShSNtL2dsfcjF5W0IEbv6VHuFf
 SjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Kg9peQoC2sg52IZVPinKGbMeesGBXCKH6J+N63DQI98=;
 b=kwrtbo/SM4pIZNc2JvZFUvCNWZ3c6RSFtKpetCbuYOuKyirv6mVXmyjF9lhqgnBbG4
 pqIiiIgUIoQif4Aj3rCjidbtWLbICxQcJg7opAlH0iLbho6E4AIV9ecVVO5TO1ZBuJc1
 oHk1z4ltEDM5oGp7t8giHtq2qIvH+AP0cLB0WkGu8414qeAkNr5PWIqF0wWUrAGb0pM7
 FWPs4y2F4lxtkLG9FIWgyFHuLu/lIiSzcNoKq5kUdWWQkj6w5iADbhTnuetvHMKO/NHv
 yrvFzvXhk8rSXDlIRoLCF982bD7UGNXjgkRkGZ3Z/i5iZFve3Izqv/hW79USwQcrWKrX
 hiRg==
X-Gm-Message-State: ANhLgQ26MsPb3ALaMs5QXxhbJUWOUJEIlM8YwW/gGEWKE15yrOAmWKHv
 1TshqHllPXvUrqEkncjIvRlTK9AHAP0=
X-Google-Smtp-Source: ADFU+vvBSrr0+50YAKeTo2ApxdMcWSvfSm5B4wJ9+dvUPLppJ6YbT0jJjhqGe1/UmaAAjzuh4LOOOg==
X-Received: by 2002:a05:6a00:48:: with SMTP id i8mr6714715pfk.20.1584023439896; 
 Thu, 12 Mar 2020 07:30:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:845e:b9f6:81a6:8f5e])
 by smtp.gmail.com with ESMTPSA id 63sm14832651pfx.132.2020.03.12.07.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 07:30:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/10] tests/vm: add --boot-console switch
Date: Thu, 12 Mar 2020 10:27:22 -0400
Message-Id: <20200312142728.12285-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142728.12285-1-robert.foley@linaro.org>
References: <20200312142728.12285-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added ability to view console during boot via
--boot-console switch to basevm.py.  This helps debug issues that occur
during the boot sequence.
Also added a new special variable to vm-build:
BOOT_CONSOLE=1 will cause this new --boot-console switch to be set.
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 78a2de1f82..d921ee14cf 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -40,6 +40,7 @@ endif
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
@@ -62,6 +63,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -76,6 +78,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -96,6 +99,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index dd545d3d1d..aab3d98edf 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -85,8 +85,10 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, config=None):
+    def __init__(self, debug=False, vcpus=None, config=None,
+                 boot_console=None):
         self._guest = None
+        self._boot_console = boot_console
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -535,6 +537,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--boot-console", action="store_true",
+                      help="Show console during boot. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -549,7 +553,8 @@ def main(vmcls, config=None):
         config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
+                   boot_console=args.boot_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
@@ -569,6 +574,8 @@ def main(vmcls, config=None):
         if args.snapshot:
             img += ",snapshot=on"
         vm.boot(img)
+        if vm._boot_console:
+            vm.wait_boot()
         vm.wait_ssh()
     except Exception as e:
         if isinstance(e, SystemExit) and e.code == 0:
-- 
2.17.1


