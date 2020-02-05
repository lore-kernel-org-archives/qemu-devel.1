Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC657C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EB420720
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuzTDzCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EB420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSPc-000087-U4
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSJD-0005k4-2z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSJB-0006Xi-Kg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:06 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:42159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSJB-0006Vp-DR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:05 -0500
Received: by mail-pg1-x535.google.com with SMTP id w21so1590348pgl.9
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F7wIuakRPzV81cpEyf3HEY4sa2Mhg8c8varfC5JwemE=;
 b=JuzTDzCQDxlGTiWhwyaJRq5AOwxfKcoppt/lPWxDN7uIKOOIv8II2vJ7HCeGlH3B9g
 IhgmzFjcoilg/Fkg0nXuJBgNL0Xv45DDX/2v4HRaXKTP/7HUoBLt5PMYeO0J8MseR+OE
 PHkxF1XAjdeIZ0Obwxbndz0a3eEhMXJh+FGzYr5QhnUkNg8srgz5KeZDdfOx0r4cWJwJ
 usxQ1HJ10w9+WruxfapT3Cvhv9XVA3G5SL2gi9EyVmiZ9ag1aEaTgg7p2WbFSg+xSXGv
 bMXrn4fO9kUywpQcUdBVvrCWjiyl5/KaSpnPI57RpzYcxfvY0me1HUZn3X1e+eeqaoOz
 YZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=F7wIuakRPzV81cpEyf3HEY4sa2Mhg8c8varfC5JwemE=;
 b=gUZNpr53f+AkctYX7EqBlK7AoFSgCAFhNVMNpFjnybWY9ycQdbIvSL8top8xvHzCjS
 6kgjDRmbXNSXVIlsBwUfrwtxprDyfGFTU57FlxXfawSU8w8dSF/WtaZyPIQQ/cR9tN1R
 NO1YWJASQoLWLQWggm0ZJC54IDRo41yqwDyL1kyuZYqTT4ZzTVagRwoHiwQdJ/kPy//V
 1qyVNEJZRpvrvFeKpRUS94Xy3hp63i+rGMAYtINv4xuJIyTxJrpJodVbeLUgGCnyyOZC
 6pffzUxZAeOHGOjTwSUzMIybHSh5cmsqXTst53iC78xkZQCm9HxYfWlXm9P1/ILimJ0M
 fYXw==
X-Gm-Message-State: APjAAAUh4NS8ygmXnvF/kTvcgBz4jByYBYKhYIwBw++S6OH1KJ9YtC/I
 uyYD0doMsDAIA0pV45W+lAyI6MDjggo=
X-Google-Smtp-Source: APXvYqyxGhHLRbvnQUOtDldmCd0tRqAPNUfW5Lhb5KHiPIkR5uQ6qU0J6Hkbd4EFobjKC2gNUZRDdA==
X-Received: by 2002:a63:3853:: with SMTP id h19mr35087277pgn.199.1580938444082; 
 Wed, 05 Feb 2020 13:34:04 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:34:03 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/14] tests/vm: Add ability to select QEMU from current
 build.
Date: Wed,  5 Feb 2020 16:29:16 -0500
Message-Id: <20200205212920.467-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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

Added a new special variable QEMU_LOCAL=1, which
will indicate to take the QEMU binary from the current
build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d72babd5bf..f67438c552 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -34,6 +34,7 @@ vm-help vm-test:
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
@@ -52,6 +53,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -67,6 +69,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -88,6 +91,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index b99ab0f20a..97d55f8030 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -97,9 +97,10 @@ class BaseVM(object):
     tcg_ssh_timeout_multiplier = 4
     console_logfile = "console.log"
     def __init__(self, debug=False, vcpus=None, config=None,
-                boot_console=None):
+                boot_console=None, build_path=None):
         self._guest = None
         self._console_fd = None
+        self._build_path = build_path
         self._boot_console = boot_console
         self._socket_thread = None
         self._console_timeout_sec = self.socket_timeout
@@ -287,8 +288,8 @@ class BaseVM(object):
         args += self._data_args + extra_args + self._config['extra_args']
         args += ["-device", "VGA"]
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args)
+        qemu_path = get_qemu_path(self.arch, self._build_path)
+        guest = QEMUMachine(binary=qemu_path, args=args)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
@@ -505,6 +506,22 @@ class BaseVM(object):
                                stderr=self._stdout)
         return os.path.join(cidir, "cloud-init.iso")
 
+def get_qemu_path(arch, build_path=None):
+    """Fetch the path to the qemu binary."""
+    qemu_local = os.environ.get("QEMU_LOCAL", 0)
+    # If QEMU environment variable set, it takes precedence
+    if "QEMU" in os.environ:
+        qemu_path = os.environ["QEMU"]
+    elif qemu_local:
+        if not build_path:
+            raise Exception("--build-path option required with QEMU_LOCAL")
+        qemu_path = os.path.join(build_path, arch + "-softmmu")
+        qemu_path = os.path.join(qemu_path, "qemu-system-" + arch)
+    else:
+        # Default is to use system path for qemu.
+        qemu_path = "qemu-system-" + arch
+    return qemu_path
+
 def parse_config(config, args):
     """ Parse yaml config and populate our config structure.
         The yaml config allows the user to override the
@@ -567,6 +584,8 @@ def parse_args(vmcls):
                            "See config_example.yaml for example.")
     parser.add_option("--boot-console", action="store_true",
                       help="Show console during boot. ")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -582,7 +601,8 @@ def main(vmcls, config=None):
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
-                   boot_console=args.boot_console)
+                   boot_console=args.boot_console,
+                   build_path=args.build_path)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


