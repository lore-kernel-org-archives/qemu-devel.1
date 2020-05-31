Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F21C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D062074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhf4PI9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D062074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRCc-0004XS-M0
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0m-0003fU-1C
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46318
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0h-00074l-MF
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8Rk2ct1SwmXVJV/wHXYbsX6rV3XnYQXBZW0Chu6BIg=;
 b=fhf4PI9vs31LS+Iorxow1wFT3sP1epGkjO9aNJLC/M80DKYrIFjn/+9HdF9s4TAEH5WGtq
 9w67YAWh3r9qKmQNBay4nCzaev6+qPmmkH4Wz2fFHdtTgyABd1drMQeUljGAh5jZphjYyL
 fuHmNQ+bEVlfS6yyuw7Ee/0IRYurVLU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-rwSre_RkM3u_yhMWRe1QpQ-1; Sun, 31 May 2020 12:40:27 -0400
X-MC-Unique: rwSre_RkM3u_yhMWRe1QpQ-1
Received: by mail-wr1-f71.google.com with SMTP id c14so3604197wrm.15
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s8Rk2ct1SwmXVJV/wHXYbsX6rV3XnYQXBZW0Chu6BIg=;
 b=FAXGJek6jaDPCo0056xRg9/SufTADAbQJdcto7y+/pd1Taam6+A/JvR+TEl+nA+qQn
 TUCyfmO/WlLBHt7Q05l39Off7Y2gYIsda871n8+Z1qlsGc79obMfC3XKUvGcTBwie+eY
 xqrKtGvtpGKxGYzStKN7HjzwwBHdUVubzIAEPTPddMOmKzC+x3qEO+ZaqUAZinYfG8OA
 3XpJEmJVv82EF2uXlm0MrD1OAOaKmuuNY1DKtRjUVRhKf35d+2xUDRcKZYKZcIlpKkUW
 1SbawOF7nMHoGltahuCoV3L3SI+MKZCibnZfquAwQxEQzzpdzdG/mC9eLSQ1QmoUXgr0
 r7NA==
X-Gm-Message-State: AOAM531B2GVo/bsNITlEjnH9nhKDqjMDj3MqtXfiPPpqul6M84uyO4Fr
 ctocKF7I3rhTND3+F2klr1Nz16BIkJI1zKyjvxAnkToTuoIy5YELzUB9MdGQhwo/AQhmt8Dl8dD
 nRpiEtBLXf+9KzMY=
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr19211122wrr.410.1590943226362; 
 Sun, 31 May 2020 09:40:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze0FR0rffg96Z21CHxAOunsqXM7ThaI5OCZlRFyIOIHJ0snfCaqtZZHfecy2V9OYUxse0UKA==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr19211104wrr.410.1590943226147; 
 Sun, 31 May 2020 09:40:26 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id y25sm9023876wmi.2.2020.05.31.09.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/25] tests/vm: Add ability to select QEMU from current build
Date: Sun, 31 May 2020 18:38:40 +0200
Message-Id: <20200531163846.25363-20-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Robert Foley <robert.foley@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Added a new special variable QEMU_LOCAL=1, which
will indicate to take the QEMU binary from the current
build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200529203458.1038-6-robert.foley@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 28 +++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 80f7f6bdee..a253aba457 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -41,6 +41,7 @@ endif
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 
@@ -57,6 +58,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
+		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -71,6 +73,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -92,6 +95,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a2d4054d72..5a3ce42281 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -61,9 +61,11 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, genisoimage=None):
+    def __init__(self, debug=False, vcpus=None, genisoimage=None,
+                 build_path=None):
         self._guest = None
         self._genisoimage = genisoimage
+        self._build_path = build_path
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
@@ -184,15 +186,15 @@ def boot(self, img, extra_args=[]):
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
         args += self._data_args + extra_args
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args)
+        qemu_path = get_qemu_path(self.arch, self._build_path)
+        guest = QEMUMachine(binary=qemu_path, args=args)
         guest.set_machine('pc')
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
@@ -391,6 +393,19 @@ def gen_cloud_init_iso(self):
 
         return os.path.join(cidir, "cloud-init.iso")
 
+def get_qemu_path(arch, build_path=None):
+    """Fetch the path to the qemu binary."""
+    # If QEMU environment variable set, it takes precedence
+    if "QEMU" in os.environ:
+        qemu_path = os.environ["QEMU"]
+    elif build_path:
+        qemu_path = os.path.join(build_path, arch + "-softmmu")
+        qemu_path = os.path.join(qemu_path, "qemu-system-" + arch)
+    else:
+        # Default is to use system path for qemu.
+        qemu_path = "qemu-system-" + arch
+    return qemu_path
+
 def parse_args(vmcls):
 
     def get_default_jobs():
@@ -421,6 +436,9 @@ def get_default_jobs():
                       help="build QEMU from source in guest")
     parser.add_option("--build-target",
                       help="QEMU build target", default="check")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory, "\
+                           "for using build tree QEMU binary. ")
     parser.add_option("--interactive", "-I", action="store_true",
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
@@ -439,7 +457,7 @@ def main(vmcls):
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs,
-                   genisoimage=args.genisoimage)
+                   genisoimage=args.genisoimage, build_path=args.build_path)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.21.3


