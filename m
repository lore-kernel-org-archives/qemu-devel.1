Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34D5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B055C206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmMQa0Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B055C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jossz-0000nY-TN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrs-0007YL-A4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:28 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrk-0001Jp-Jc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id j18so9641198wmi.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m68QvK0yLbiDVQVnhRt3C913qF+3j7rcYCrzMUVv6YU=;
 b=BmMQa0WjCv74C0ervZBTXu9ZJ6d8grFMYqKdGh8XxhJkD6+34gxdBITVRkj0G3LPgL
 kV3FkPYyGHmYARs03+OxVJrtWnfC0KpAeEbKaitt/IEIdhm/b+xQgCLVq3Fnmv2U2cze
 HxMD5Q076s2YymLq243ZnqXZXW4SvbFrOCSvTyiKexV4DZi60+kc4mTzWa6zRXW2+H84
 s4jgz7+9bT6gcBzm7kLPFiMzKVO762gxA6a+pGdoAop8IRE+HWGSycUDf7FXnxUs5uy9
 FBWm8TojOPDtZ7TVv3PuMk2g0Gp0mXWwz4LuQijB3p3VFPS5ARQHM3aVsVsebnAZnnIx
 jPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m68QvK0yLbiDVQVnhRt3C913qF+3j7rcYCrzMUVv6YU=;
 b=Uut4vEp4dNpo+EpFR9pSWjGSRPgtVwPsuwr97EFwwxfmNtG9dyAxXy0WSTo4/tac6d
 zD/O7AKPepUUOxZw0GXQjebq+9dvVyI6ZbVrvCpZy/JHnTPKT89cDTry51qyZifpIbb6
 UatGFMiOapGzhBd+rfdpnb0DLb8Jy55nedkoOcmVGD2tMWQd+h6mKNFmffQiHMhZ5CAr
 Xzl6fzm2ZvZdi2yh8YcrG9OwwzrZwQ+uNEPpYb4+Lsh7WUBdzvEwoMT42FoCLe0Czpwu
 /1DuYumLZGj49n2LzAnRybBALnHoZxQq8XCf6Y3p5OpD5bPz9U0TyB5RYsF/+UeGjaab
 VMiQ==
X-Gm-Message-State: AOAM532xvE5p5/YLx3iVzaHssCyGblKlzYPTZHTAKCJ4end4aTpF3dBi
 tbyvO9RegzEYHba6tcfB/qa3mg==
X-Google-Smtp-Source: ABdhPJzVHW6qsV9qe616Ic3VUnnTJGErmZDFCQiCZtBDX8hhsjZ8CtElhPVvMVKrZ7ZA4ycZQI7SvQ==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr4836523wmj.180.1593195257581; 
 Fri, 26 Jun 2020 11:14:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a81sm18474931wmf.30.2020.06.26.11.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:14:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 230461FF9A;
 Fri, 26 Jun 2020 19:14:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 12/30] tests/vm: switch from optsparse to argparse
Date: Fri, 26 Jun 2020 19:13:39 +0100
Message-Id: <20200626181357.26211-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

optparse has been deprecated since version 3.2 and argparse is the
blessed replacement. Take the opportunity to enhance our help output
showing defaults when called.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Robert Foley <robert.foley@linaro.org>

---
v2
  - add explicit parser.add_argument("commands", nargs="*")
---
 tests/vm/basevm.py | 93 ++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 45 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 04d083409a5..890bbc5549a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -23,7 +23,7 @@ from qemu.accel import kvm_available
 from qemu.machine import QEMUMachine
 import subprocess
 import hashlib
-import optparse
+import argparse
 import atexit
 import tempfile
 import shutil
@@ -556,54 +556,57 @@ def parse_args(vmcls):
         else:
             return 1
 
-    parser = optparse.OptionParser(
-        description="VM test utility.  Exit codes: "
-                    "0 = success, "
-                    "1 = command line error, "
-                    "2 = environment initialization failed, "
-                    "3 = test command failed")
-    parser.add_option("--debug", "-D", action="store_true",
-                      help="enable debug output")
-    parser.add_option("--image", "-i", default="%s.img" % vmcls.name,
-                      help="image file name")
-    parser.add_option("--force", "-f", action="store_true",
-                      help="force build image even if image exists")
-    parser.add_option("--jobs", type=int, default=get_default_jobs(),
-                      help="number of virtual CPUs")
-    parser.add_option("--verbose", "-V", action="store_true",
-                      help="Pass V=1 to builds within the guest")
-    parser.add_option("--build-image", "-b", action="store_true",
-                      help="build image")
-    parser.add_option("--build-qemu",
-                      help="build QEMU from source in guest")
-    parser.add_option("--build-target",
-                      help="QEMU build target", default="check")
-    parser.add_option("--build-path", default=None,
-                      help="Path of build directory, "\
-                           "for using build tree QEMU binary. ")
-    parser.add_option("--interactive", "-I", action="store_true",
-                      help="Interactively run command")
-    parser.add_option("--snapshot", "-s", action="store_true",
-                      help="run tests with a snapshot")
-    parser.add_option("--genisoimage", default="genisoimage",
-                      help="iso imaging tool")
-    parser.add_option("--config", "-c", default=None,
-                      help="Provide config yaml for configuration. "\
-                           "See config_example.yaml for example.")
-    parser.add_option("--efi-aarch64",
-                      default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
-                      help="Path to efi image for aarch64 VMs.")
-    parser.add_option("--log-console", action="store_true",
-                      help="Log console to file.")
-    parser.disable_interspersed_args()
+    parser = argparse.ArgumentParser(
+        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
+        description="Utility for provisioning VMs and running builds",
+        epilog="""Remaining arguments are passed to the command.
+        Exit codes: 0 = success, 1 = command line error,
+        2 = environment initialization failed,
+        3 = test command failed""")
+    parser.add_argument("--debug", "-D", action="store_true",
+                        help="enable debug output")
+    parser.add_argument("--image", "-i", default="%s.img" % vmcls.name,
+                        help="image file name")
+    parser.add_argument("--force", "-f", action="store_true",
+                        help="force build image even if image exists")
+    parser.add_argument("--jobs", type=int, default=get_default_jobs(),
+                        help="number of virtual CPUs")
+    parser.add_argument("--verbose", "-V", action="store_true",
+                        help="Pass V=1 to builds within the guest")
+    parser.add_argument("--build-image", "-b", action="store_true",
+                        help="build image")
+    parser.add_argument("--build-qemu",
+                        help="build QEMU from source in guest")
+    parser.add_argument("--build-target",
+                        help="QEMU build target", default="check")
+    parser.add_argument("--build-path", default=None,
+                        help="Path of build directory, "\
+                        "for using build tree QEMU binary. ")
+    parser.add_argument("--interactive", "-I", action="store_true",
+                        help="Interactively run command")
+    parser.add_argument("--snapshot", "-s", action="store_true",
+                        help="run tests with a snapshot")
+    parser.add_argument("--genisoimage", default="genisoimage",
+                        help="iso imaging tool")
+    parser.add_argument("--config", "-c", default=None,
+                        help="Provide config yaml for configuration. "\
+                        "See config_example.yaml for example.")
+    parser.add_argument("--efi-aarch64",
+                        default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
+                        help="Path to efi image for aarch64 VMs.")
+    parser.add_argument("--log-console", action="store_true",
+                        help="Log console to file.")
+    parser.add_argument("commands", nargs="*", help="""Remaining
+        commands after -- are passed to command inside the VM""")
+
     return parser.parse_args()
 
 def main(vmcls, config=None):
     try:
         if config == None:
             config = {}
-        args, argv = parse_args(vmcls)
-        if not argv and not args.build_qemu and not args.build_image:
+        args = parse_args(vmcls)
+        if not args.commands and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
         config = parse_config(config, args)
@@ -619,12 +622,12 @@ def main(vmcls, config=None):
         if args.build_qemu:
             vm.add_source_dir(args.build_qemu)
             cmd = [vm.BUILD_SCRIPT.format(
-                   configure_opts = " ".join(argv),
+                   configure_opts = " ".join(args.commands),
                    jobs=int(args.jobs),
                    target=args.build_target,
                    verbose = "V=1" if args.verbose else "")]
         else:
-            cmd = argv
+            cmd = args.commands
         img = args.image
         if args.snapshot:
             img += ",snapshot=on"
-- 
2.20.1


