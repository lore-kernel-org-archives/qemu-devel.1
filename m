Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88EFC47254
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DF72076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5q1pEd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DF72076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBms-00089C-76
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBdU-0000UU-Gg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBaC-0003CJ-Tu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:02:04 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jUBaC-0003Bs-Eg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:40 -0400
Received: by mail-qt1-x844.google.com with SMTP id e17so5377787qtp.7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7n0OEOUcViSoi8lDFmvS1FDdqucfcjXxY1zrvZFIRGA=;
 b=h5q1pEd1IHxUeE3X2QUkC6hHBI/quzW+osUrMvXMbkP26ag2wX+Rpys/RU1awmfLXZ
 vEhMmZz2odSY3BefYjilamPgqGPyLWO5R3S697pgNocfh2TIlzoMQDn7Pqo0iJr1p+Kh
 Q2F8QWja/Hz+X8EpKENKbq8NHroiMtV4eBcibLr2aLojHL1qu9AlNfqP6mdrzYMeKKq0
 6TWWpNsXdFPDX32TmgAOE4hxDV4JxNGdO3JdYHvNzu3lO3p8vJwQ/pLtwrnT7Jr46N4f
 SkLhAyCGaHEh8+2RgImqvslORwIp0XtBhJY8P+2LJcjQMpB0cLruNhypHbDknXGxrGYi
 oduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7n0OEOUcViSoi8lDFmvS1FDdqucfcjXxY1zrvZFIRGA=;
 b=OS6OvI2j5NI9OHbJ0lK3gFQ344/4VfhCnhayo2sDf775ynn411bhzR9BeyFLPxH7fo
 cN5x84NXqH2erL6e/XUqhDGzpyXnaGiouG+iK7rmGeIBZvDo9vJKdME2gGPgMsoVO8o4
 BEw7xgt80YOVuMXCqrh9yE3brA4n9g1ZLY4eo48qm/QKVo4mFp/J3E/TzvvDQpumhSlq
 pS7Ltc/0gP7Cn6/A5kKv4S//1GAdutNEPovWmCQKCXzYXGHJAbEpRcOvj3EnqbSfmAs4
 ma7m7uCaDzuR6B8shn0Xh/nwaAEKVYcs88ry+M81wmYjtezJTmhqx9WkwqkXBg1fqb/p
 V2kQ==
X-Gm-Message-State: AGi0PuZrFq1nyvYVvAJC6iu1iZ0jqr32eHAVQfaDwzaxNtWNcAMwcClF
 4bszj+Bg3SBGKsCOE49X2DIGPMK7lPfj0w==
X-Google-Smtp-Source: APiQypJhZKwtSGjR7Jrs14z2utCtaA2QY8s3pbxTEWpJMLZ4QMW5+xJE80iR85jaouamSrApYhG58Q==
X-Received: by 2002:aed:3bda:: with SMTP id s26mr4329055qte.261.1588262319113; 
 Thu, 30 Apr 2020 08:58:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:7489:3328:3806:7c3])
 by smtp.gmail.com with ESMTPSA id v16sm305254qkf.80.2020.04.30.08.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:58:38 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/9] tests/vm: add --boot-console switch
Date: Thu, 30 Apr 2020 11:57:12 -0400
Message-Id: <20200430155718.212-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155718.212-1-robert.foley@linaro.org>
References: <20200430155718.212-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::844
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
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
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
index 97f8ac4218..983adbf6ff 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -86,8 +86,10 @@ class BaseVM(object):
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
@@ -551,6 +553,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--boot-console", action="store_true",
+                      help="Show console during boot. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -565,7 +569,8 @@ def main(vmcls, config=None):
         config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
+                   boot_console=args.boot_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
@@ -585,6 +590,8 @@ def main(vmcls, config=None):
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


