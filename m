Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC6C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEDE2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwQslVBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEDE2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Sgu-0002dW-69
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOK-0003Es-76
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOJ-00086I-1f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:04 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:36881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOI-00085o-Pv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:02 -0500
Received: by mail-pj1-x102f.google.com with SMTP id m13so295733pjb.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NVtYYcA86qI8H+IkdoM3WPRii1ViHqB0RBWen0zzsK8=;
 b=GwQslVBxRCVMfrcvu8lCsen1zU+6Lg4ioTdLGsf4+4WJvKeN7yvl+bPlQqlTJ4g6dC
 3cpG7Ok4+QipnhY5B7Fucek3+UTdTNaXNeqn9GQ+z+6p01GdepsafN0ZvR1noSSbrXew
 ZWGMw2cJA8caR0F0rnSR5ziOnY82cgTUNZ20XIvT8eQW+oFFb4L7F5QGcYNW3rPQvREe
 7vd4NpXbgQDLJyABCAFqr8Y4T5QIDSmrE+BLwto5FJoFTSamvoXVf8AhUeQ3V5YIS5G5
 M3X3ThTb6cfaG55Ku8HWrwrfNenSiq2rd6s1q5MtYFx170BtiphkrQy3NBqFLSwblHU0
 sozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NVtYYcA86qI8H+IkdoM3WPRii1ViHqB0RBWen0zzsK8=;
 b=BfjxaJTjG6TaP1ZQA8pxmOb+3O6wfnwopeHNumJkSJk6P0EBFtujnCK2RjiA5Z8HBA
 50RPXtiW+s9k54RUhW6bO8rwl17nb/onoJQbZ7derGr65yIXcfZSv5SY91CsaApaxPkd
 jFyXH+RyrU7UMvVyKnVoU30co/8yZUh8ALfcpOUNXXtZDEdyupMbSFsLVtX3/G1ilDf+
 2bRKir0b6xocAMQ/fCgz3Erty54xo0UUFEtPXZ3TrJTI0kWruNHMPYMkx+ZV2rZIq46S
 xR6fHD3coIAY3S/hJJrz5GkgfV4EQ+krUKmQf8wyC3KPwxrZt2N7r7jJLYEAH+5NxorQ
 3Qmw==
X-Gm-Message-State: APjAAAUzotjc8cCc95e9TuOHUAMpUYQwkfUMvy2lQHNgA1Kx10He5TJT
 4vTOe4rlLrry5sv/VzL2nxZnV8w/RmI=
X-Google-Smtp-Source: APXvYqzw0U9+DbhzEMsD8562Nk+2QYMAfHN6MlZ2hwXaJOPwm0Yrtt6DnCLc52Vx8H7sQQLgdHetDA==
X-Received: by 2002:a17:902:82cc:: with SMTP id
 u12mr24677029plz.342.1582130401447; 
 Wed, 19 Feb 2020 08:40:01 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:40:00 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/14] tests/vm: add --boot-console switch
Date: Wed, 19 Feb 2020 11:35:32 -0500
Message-Id: <20200219163537.22098-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102f
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
index e19072f303..d1444c99f5 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -32,6 +32,7 @@ vm-help vm-test:
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
@@ -52,6 +53,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(LOG_CONSOLE),--log-console) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -67,6 +69,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(LOG_CONSOLE),--log-console) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -88,6 +91,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(LOG_CONSOLE),--log-console) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a24ce090c7..dc94d1988e 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -89,8 +89,10 @@ class BaseVM(object):
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None, config=None,
-                 log_console=False):
+                 log_console=False,
+                 boot_console=None):
         self._guest = None
+        self._boot_console = boot_console
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -539,6 +541,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--boot-console", action="store_true",
+                      help="Show console during boot. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -554,7 +558,8 @@ def main(vmcls, config=None):
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
-                   log_console=args.log_console)
+                   log_console=args.log_console,
+                   boot_console=args.boot_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
@@ -574,6 +579,8 @@ def main(vmcls, config=None):
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


