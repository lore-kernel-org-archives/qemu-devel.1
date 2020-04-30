Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA94C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174F920873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiYP9aEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174F920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBx8-0000Xt-6S
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBdW-0000Wi-Ep
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBaE-0003Gy-Bn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:02:06 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jUBaD-0003CV-UM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:41 -0400
Received: by mail-qt1-x842.google.com with SMTP id g16so1429969qtp.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YmekmIbOKaWK/Uh2GRis93ucBWqUHLXkmR51MffmvwM=;
 b=tiYP9aEsBbwABMk8frZpnVcjawPSWZUoCUeuATLvFyBCa0nOC1lfp0mCRBjgR2m/Kg
 zjzFxrR/oX3dvaevOYPdMhExohTYrUvAoAQAQJAjTzqPpFazEc5SaSn0bGuy58++MXND
 PXLlXzkfzwDdO6p3TURdXVOR6rUR8XjNKRoxoV6jnQ12Z791mqTT73RCwIn/Hrn8Up+t
 p6tvtjCnJp1KnBS++7/kh+agbWccyvFg+JbYsiYYfGIXgtzodrUuDdemUgQ92jmLv+NK
 OdBg5kbyE4OoY0m7fk7iEZP6VPTbyHgO5/Kr9zl3LqAxqzjbbkdwCDjY47eph4W1OfTa
 5aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YmekmIbOKaWK/Uh2GRis93ucBWqUHLXkmR51MffmvwM=;
 b=DHZcIgg20v86xvIfxOIxtac1nqGnVOE4GXEfFPCyjQVr1XV4WJgE1B/ILPcEyQGwWo
 9KDi1DPJ2wvvKJ0foPN663hHiWM0tWa28a8oDtPjUjZzkKNIW3Q03wsQ8zPaqkFEQcRY
 Bafoe8vvJi2/5Wl/1ZUXXEG8cHf2enkecAJ5Fx+xtdHjQqlutoR/U66p+od2KhkE79/j
 38El1RLReiN2rKUCZNbMo5Bgqj/55MhRonO1p911OEQNrUYegZr+Pl6V6I4P4aWs+Em1
 /oHcqVDRw+lscIzb1MWuacpn8bUDwlOxkFaKCUy6wa6lpbiwUxeN7aBS0CAcicP/RErZ
 TbDw==
X-Gm-Message-State: AGi0Pua57O14sRQyMXplq/UyQmf4gv4u5awzbmcMd6xuWLydI2+QWw9W
 /Q8b/4/0+tGcJpwZTH7djVXhAMIgqW75pw==
X-Google-Smtp-Source: APiQypIUnzf/rDTy6mR5DJ0qGwkV9/JstZnTJKKsi1/im7e0dZZeZ/YmvNTmZOOInHSfzjVcIVE0jA==
X-Received: by 2002:ac8:189c:: with SMTP id s28mr4380698qtj.65.1588262320546; 
 Thu, 30 Apr 2020 08:58:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:7489:3328:3806:7c3])
 by smtp.gmail.com with ESMTPSA id v16sm305254qkf.80.2020.04.30.08.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:58:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/9] tests/vm: Add ability to select QEMU from current
 build.
Date: Thu, 30 Apr 2020 11:57:13 -0400
Message-Id: <20200430155718.212-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155718.212-1-robert.foley@linaro.org>
References: <20200430155718.212-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::842
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

Added a new special variable QEMU_LOCAL=1, which
will indicate to take the QEMU binary from the current
build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 30 +++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d921ee14cf..667705a91a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -42,6 +42,7 @@ endif
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 ifeq ($(PYTHON_YAML),yes)
@@ -64,6 +65,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -79,6 +81,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -100,6 +103,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 983adbf6ff..7b86ccd018 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -87,8 +87,9 @@ class BaseVM(object):
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None, config=None,
-                 boot_console=None):
+                 boot_console=False, build_path=None):
         self._guest = None
+        self._build_path = build_path
         self._boot_console = boot_console
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
@@ -274,15 +275,15 @@ class BaseVM(object):
         args = self._args + boot_params.split(' ')
         args += self._data_args + extra_args + self._config['extra_args']
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args)
+        qemu_path = get_qemu_path(self.arch, self._build_path)
+        guest = QEMUMachine(binary=qemu_path, args=args)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
             guest.launch()
         except:
             logging.error("Failed to launch QEMU, command line:")
-            logging.error(" ".join([qemu_bin] + args))
+            logging.error(" ".join([qemu_path] + args))
             logging.error("Log:")
             logging.error(guest.get_log())
             logging.error("QEMU version >= 2.10 is required")
@@ -481,6 +482,22 @@ class BaseVM(object):
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
@@ -555,6 +572,8 @@ def parse_args(vmcls):
                            "See config_example.yaml for example.")
     parser.add_option("--boot-console", action="store_true",
                       help="Show console during boot. ")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -570,7 +589,8 @@ def main(vmcls, config=None):
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


