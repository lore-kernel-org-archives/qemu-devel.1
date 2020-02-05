Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1374CC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CCC2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwOr4EJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCC2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSNX-0005eJ-1Z
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSJB-0005ff-A1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSJ9-0006TF-Rp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:05 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:45580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSJ9-0006RW-L8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:03 -0500
Received: by mail-pf1-x432.google.com with SMTP id 2so1860290pfg.12
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q+lXVoFe6aYIoxKIqqudPU6MusUvHE0l2Wqhqs9iBy0=;
 b=wwOr4EJ30YU5NlmkSpXCuasNmB5P4zuqaL3w9ypCLTaUkVEjJDHkfHRud6KmaBzdsX
 uNhRXj/KSnY4LejTiKpA/GZexPNrlK+ULu6S0ISeMywIfqhqjIoKuXSebd5iHXUc4Boq
 MDmsQqfBcb2baGxkN9K3L/DuJndI8jYhVsOg0Eo5g5HduOLJV8VTvT+UY9B4ikd9Jz42
 ok+0TANO0LfxGq7KRhi1VAeSIjKWRy279Lvy6lt2yvYcUcWzVtdc/OCKBR26FZGrtqT1
 BCrV2ehaU1vYzn0PSwoGIw2W7KFgsFp/rOzImXyN+jcwf4JL8kvMqBtoYfr4vObRtwv6
 oqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q+lXVoFe6aYIoxKIqqudPU6MusUvHE0l2Wqhqs9iBy0=;
 b=bPjUhIbG1B6vStg7vSk8Dj5coo/lmIjzxC+3Oou+1KSRa5YBXd0XvV5oeP+x9WeTtX
 iZNy2YlFpBxIULLsIbrrXohkrEAFUGIUpI+fw0hBqeHOGGFdmdXdLzyS64xBhW5vHDfF
 SOFtPWcflUIIo6E/Xpfe0AwG2LxfnsuTux6VbV/7OEGDUNt1MDC9J2NMxm31Ywlj3hli
 AqOuOSw/fIzloZE+Ht9z3llFVl6WdDfkLWihKcxGsSnIdRfV2+bHcso0cK7SaQaOj24C
 bwdxOiJSCRvhNLX2idGmUHrcj5rlmz9ueUviUwsy1KE6+iG+bGlVkyECiOrf3P9mFUAJ
 R2pw==
X-Gm-Message-State: APjAAAWxmUmYd3D7TMeXmrbcFbQf9P775Awnw7zAq42hEkGWK0kP9c+S
 SXxM/xCNU8u0m8j2YsWhBWnFzhkH8A8=
X-Google-Smtp-Source: APXvYqzObYbyYWFzXBHJ5VqVFpwyHFTEu6ZpN/Hd08+hgLQF62OXvYE5eIyWUQ1OPnCDX5SHoXSMmg==
X-Received: by 2002:a62:2cd8:: with SMTP id
 s207mr38531950pfs.247.1580938442172; 
 Wed, 05 Feb 2020 13:34:02 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:34:01 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/14] tests/vm: add --boot-console switch
Date: Wed,  5 Feb 2020 16:29:15 -0500
Message-Id: <20200205212920.467-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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
index e9ed33226d..d72babd5bf 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -32,6 +32,7 @@ vm-help vm-test:
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
@@ -50,6 +51,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -64,6 +66,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -84,6 +87,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index f488d4103c..b99ab0f20a 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -96,9 +96,11 @@ class BaseVM(object):
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     console_logfile = "console.log"
-    def __init__(self, debug=False, vcpus=None, config=None):
+    def __init__(self, debug=False, vcpus=None, config=None,
+                boot_console=None):
         self._guest = None
         self._console_fd = None
+        self._boot_console = boot_console
         self._socket_thread = None
         self._console_timeout_sec = self.socket_timeout
         # Allow input config to override defaults.
@@ -563,6 +565,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--boot-console", action="store_true",
+                      help="Show console during boot. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -577,7 +581,8 @@ def main(vmcls, config=None):
         config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
+                   boot_console=args.boot_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
@@ -597,6 +602,8 @@ def main(vmcls, config=None):
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


