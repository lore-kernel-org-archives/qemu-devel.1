Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5353CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EB6206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKLMru5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EB6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshjx-00062E-8N
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshiz-0004HU-7G
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:56224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshix-00042z-F3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id g75so42097641wme.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f+mo9JyjAOQaUqLAqsYtfO14+eY9TpKX1IQ4XQcaJvA=;
 b=pKLMru5Terw3NoNSYbVQESW5nNqn9aM1pUsdTDOL5pVY6TDXOxpTonURneZfTQJ7Ds
 r9kkzdQGSoM7vFhZTytWyOk9RrVSoiB6uVW4FJQSsGIEbPqPyqaZB1OmfacUe/ZzIyF/
 0HPnOSoo8TB8Shtmy8xn28BABOKmw3eE4UES6FgzJyVfwO+7+0uYwJKWLyzv59bU1cIJ
 GTxxQYxyXdlTVSo7p6tBra1dcfuejTWVHwCkHUsljujrwsXRsW70H7+6lG2SfgRyxBRL
 wVmlfVi1K89CFV+VdmGL02U0HSnA/cYHdESwYb3+BDF6PmJMgroMICxZyGgC4LwdhrmE
 oniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f+mo9JyjAOQaUqLAqsYtfO14+eY9TpKX1IQ4XQcaJvA=;
 b=A+z7SkoG5bdrcxYHdg4VEwCs+GUoOYI2fVWIs8aIelLaSb1JiW1M/WOkNZ/V1sDALm
 MOl4oU6F4y47IyNXwD88/wRoQT1H/gWCM+otjf7gffj5/jTf6TcDl+KXMK9Eo1S8YG6l
 Cyp9qP8LfnPx3RQyxGZ4ArAB34pme/KKJmKqhLpCxANL3PylSaeUb1x2oAWj+ezF9+iR
 EE1jZ31KavXx+6NXkHMQXO1zzKe9iOgqEZuo7c7R/YQ8vaNezF2c6s4JIGv3ZQI2g17l
 huN4cPZqF+UpW1op3fiZJYZp/unu4M75UpgPnEUvOoeP7hoW2qkYZYguFR2KMOiL7iXA
 MhOA==
X-Gm-Message-State: AOAM531PvmkUEXPEZARmoQko/KfZJgWGvLx5ydqylFb3rBoE9qZhtKKr
 h9xPFS1FV70OqNd+AXB9TwFHzA==
X-Google-Smtp-Source: ABdhPJwsf3rxOL/EljvOTkeOVd8Rx7fFpwkeHXTmC1XrmNokkW5hDfsjxwiVXMBd9wNVW9WzAYCgTQ==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr2611987wmf.124.1594105741756; 
 Tue, 07 Jul 2020 00:09:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v5sm26480240wre.87.2020.07.07.00.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:08:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BADF81FF8F;
 Tue,  7 Jul 2020 08:08:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/41] tests/vm: pass args through to BaseVM's __init__
Date: Tue,  7 Jul 2020 08:08:20 +0100
Message-Id: <20200707070858.6622-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Adding the args parameter to BaseVM's __init__.
We will shortly need to pass more parameters to the class
so let's just pass args rather than growing the parameter list.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-2-robert.foley@linaro.org>
Message-Id: <20200701135652.1366-6-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a80b616a08d3..5a58e6c39300 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -61,11 +61,10 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, genisoimage=None,
-                 build_path=None):
+    def __init__(self, args):
         self._guest = None
-        self._genisoimage = genisoimage
-        self._build_path = build_path
+        self._genisoimage = args.genisoimage
+        self._build_path = args.build_path
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
@@ -78,7 +77,7 @@ class BaseVM(object):
         self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
         open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
 
-        self.debug = debug
+        self.debug = args.debug
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
         if self.debug:
@@ -92,8 +91,8 @@ class BaseVM(object):
                        (",ipv6=no" if not self.ipv6 else ""),
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
-        if vcpus and vcpus > 1:
-            self._args += ["-smp", "%d" % vcpus]
+        if args.jobs and args.jobs > 1:
+            self._args += ["-smp", "%d" % args.jobs]
         if kvm_available(self.arch):
             self._args += ["-enable-kvm"]
         else:
@@ -456,8 +455,7 @@ def main(vmcls):
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs,
-                   genisoimage=args.genisoimage, build_path=args.build_path)
+        vm = vmcls(args)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.20.1


