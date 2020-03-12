Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3197C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7477820663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCjXo7OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7477820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOss-0000Uw-JQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrJ-0007Ie-Cw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrI-0006Y4-0J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:34143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jCOrH-0006Xo-Pm
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id 23so3372940pfj.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YcJtreTuJf2SK2XtbK4xe8EoCvPleFPj5jx6jA6C+SI=;
 b=HCjXo7OM3TsJd/RzpatmNGnyd6EHNKZYLx84oF+ghnMIIegQr6lnJdOgudJ0pVZCHG
 pesKRxODpJo5V3AC468zUfNrC26qskBT2OKLQmvm6ezkA8xm7tdwE2mQ1XSs8JFU+cTu
 s3iXo/d3Gj0bBC0GDPAzg7nsTCL/pPydYfF6fTLAm+wu+nIY1AaNWngomX5+XkKvOr5P
 wcE/LXDFev7dUhWEjtsAUAmyZy6HO2stjF+YJm/1e8X/wcHX3cQtWLDqyuPhgWd0wNlf
 de/FwdeGk8Vk1vF/sd+p/98ycvw/CoD9Bgal9Oy87pv7oAM/33Ar+h1vRnWdP+3ptTi8
 yQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YcJtreTuJf2SK2XtbK4xe8EoCvPleFPj5jx6jA6C+SI=;
 b=OwAgLOGCbg5EiFsVvMMeq6rQ5oPiVDDoFIph1f/rm4FG3xkmBC1cfiZO8xoRKIOfLg
 Btj9jzmUj5UqSo9P9CkqP5ndzedH8e2rOUMBsmdHMY4ev7fCJXlrjt9FOk0vdWO0uEBf
 GOPxKpE5/S6OsiL+foffE1B5MFDNbXifpzC4zSKDQQOMVusX5/DHO5+0xAEhknZmj41M
 CVnTh8WVLaYhNEyIm5QYYlrmcejZCbFDQpg+haxqCAp6HFQNjd70JaZu3zQNvGVRiUc9
 jQL0ii4SLkzpaImnrdZmuwEUMAvCtAkWKTfovS4R2cFkbwKlOF7tt3vTvqy96tvmcYGf
 +WBw==
X-Gm-Message-State: ANhLgQ30pk6sICJl3tv9G3vdvEQDpmhiOePzraWSbIuZ7fvibf2qzTN0
 UR4KlCql6W/oWG6CEWKKEVTo9i5iSKE=
X-Google-Smtp-Source: ADFU+vuGm7UJzYliZTAYgUFXNmWV67X2YNxQKid59IIWn2Atx1+U56XSiWjudWakd3+ByomRRBK89A==
X-Received: by 2002:aa7:8055:: with SMTP id y21mr8298190pfm.151.1584023441664; 
 Thu, 12 Mar 2020 07:30:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:845e:b9f6:81a6:8f5e])
 by smtp.gmail.com with ESMTPSA id 63sm14832651pfx.132.2020.03.12.07.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 07:30:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/10] tests/vm: Add ability to select QEMU from current
 build.
Date: Thu, 12 Mar 2020 10:27:23 -0400
Message-Id: <20200312142728.12285-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142728.12285-1-robert.foley@linaro.org>
References: <20200312142728.12285-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
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
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

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
index aab3d98edf..3562a33ffa 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -86,8 +86,9 @@ class BaseVM(object):
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
@@ -264,8 +265,8 @@ class BaseVM(object):
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
@@ -465,6 +466,22 @@ class BaseVM(object):
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
@@ -539,6 +556,8 @@ def parse_args(vmcls):
                            "See config_example.yaml for example.")
     parser.add_option("--boot-console", action="store_true",
                       help="Show console during boot. ")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -554,7 +573,8 @@ def main(vmcls, config=None):
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


