Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAFE20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1KkF/sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAFE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7btF-0002iR-NB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bki-0003KY-Vm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkh-0006Hy-N5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkh-0006H3-Fj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id l11so18361477wrx.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KDgxLmV9jVX5RP5KnrkpNStJOerKcWSl/8g+dS8UE6M=;
 b=v1KkF/sPspWW2Ysrrka2Ve23e/7jaXrViTHbCnDciHiCW4xmE4rJHaOfcV5aCLuXxx
 8Va8MvNQlIW8SUOv3cvCeDPSDuTEvubMB61NuWp8Gu/FEUghVOiTxAZ3TyYu4JoODuq8
 etcziCWLJxQlK7pbFIYaUYUEVsgCojCos9xS6Bcf8tbnExCR1a1aHBpP7irxXICM8sZ/
 GZIiKPxs6mZT5W6ZBe5gRpMTmxfuWyvUX6kdpKCq0vfsnDqIN/1oUqbawVoVVMjM7Cdm
 8QZjstABrwgClOPIY+b4nrlaw8NtdhZS51ql9JCQyd9PAfcwAWt2lsUCIDgW8X7/NT5e
 jtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KDgxLmV9jVX5RP5KnrkpNStJOerKcWSl/8g+dS8UE6M=;
 b=YHyR1iORF3nm6OpDo2nnuupOXm0GdMCFY3EnYBL5+IUbs8e2ZIMnUArqFMU44MJLVg
 wb6T3+XFdVcwPx9X6L5IxuCYc2Rur6EfiCmDPYb1rZw0c5U6oNBXf4VmBdirzHqGls0F
 JLZkiKSrZeXYv/otAJOlvKmmGgZlhXVV6EQxF1XlZ4kJU9CojwsaqlX02spflvYvc3fl
 grO7an6Vz7Wj7G5AvPGPdzi19wlj5wPVZKxHVZgpIRnYDI1+RGI0x0KAw/hRTaW6kEQg
 Jv47PhLhj2bwRLgQO0oKgVhhyyfsLQlP6h3PG76EbWIJZaatwnby+2NSf8kvTbwaas+X
 VfGQ==
X-Gm-Message-State: APjAAAVDth8YlRlwHVqaBUt99RzbzBWmo5UpX0ErmVRBip1T25fuiCX3
 2cOG423a5DfC6G+lJhLAbqoQOQ==
X-Google-Smtp-Source: APXvYqwuyJAZAcQphSVuso4ZPR4MdgJnG6O8ADgCZEKPRMluaNfe82JPwv1+DsAe8KCkfBIdbw3jYw==
X-Received: by 2002:adf:a382:: with SMTP id l2mr23749721wrb.194.1568105033594; 
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm3476630wma.7.2019.09.10.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C52871FF91;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:08 +0100
Message-Id: <20190910084349.28817-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 04/45] tests/docker: fix "cc" command to work
 with podman
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

Podman requires a little bit of additional magic to the uid mapping
which was already done for the normal RunCommand. We simplify the
logic by pushing it directly into the Docker::run method to avoid
instantiating an extra Docker() object and ensure the CC command
always runs as the current user.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 064026c8af8..1620293ac84 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -318,10 +318,18 @@ class Docker(object):
             return False
         return checksum == _text_checksum(_dockerfile_preprocess(dockerfile))
 
-    def run(self, cmd, keep, quiet):
+    def run(self, cmd, keep, quiet, as_user=False):
         label = uuid.uuid1().hex
         if not keep:
             self._instances.append(label)
+
+        if as_user:
+            uid = os.getuid()
+            cmd = [ "-u", str(uid) ] + cmd
+            # podman requires a bit more fiddling
+            if self._command[0] == "podman":
+                argv.insert(0, '--userns=keep-id')
+
         ret = self._do_check(["run", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
                              quiet=quiet)
@@ -364,13 +372,8 @@ class RunCommand(SubCommand):
                             help="Run container using the current user's uid")
 
     def run(self, args, argv):
-        if args.run_as_current_user:
-            uid = os.getuid()
-            argv = [ "-u", str(uid) ] + argv
-            docker = Docker()
-            if docker._command[0] == "podman":
-                argv.insert(0, '--userns=keep-id')
-        return Docker().run(argv, args.keep, quiet=args.quiet)
+        return Docker().run(argv, args.keep, quiet=args.quiet,
+                            as_user=args.run_as_current_user)
 
 
 class BuildCommand(SubCommand):
@@ -554,8 +557,6 @@ class CcCommand(SubCommand):
                             help="The docker image in which to run cc")
         parser.add_argument("--cc", default="cc",
                             help="The compiler executable to call")
-        parser.add_argument("--user",
-                            help="The user-id to run under")
         parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
                             help="""Extra paths to (ro) mount into container for
                             reading sources""")
@@ -569,11 +570,10 @@ class CcCommand(SubCommand):
         if args.paths:
             for p in args.paths:
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
-        if args.user:
-            cmd += ["-u", args.user]
         cmd += [args.image, args.cc]
         cmd += argv
-        return Docker().command("run", cmd, args.quiet)
+        return Docker().run(cmd, False, quiet=args.quiet,
+                            as_user=True)
 
 
 class CheckCommand(SubCommand):
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index 73b5626fc5f..210f8428237 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -41,7 +41,7 @@ ifneq ($(DOCKER_IMAGE),)
 # We also need the Docker make rules to depend on
 include $(SRC_PATH)/tests/docker/Makefile.include
 
-DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
+DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc \
 		--cc $(DOCKER_CROSS_COMPILER) \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
-- 
2.20.1


