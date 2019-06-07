Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1010C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BAC208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ21quUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BAC208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZB5I-0008Hk-OH
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp5-00049e-I7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp3-0004bE-I9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAp1-0004Tt-N9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id z23so1125750wma.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1dKkut+uCfwlAn3zScZi3hqAXXCijPCSIcimV4mZPU4=;
 b=fQ21quUUtSkH6czkTNF2HL8KksSz6YYwc8GIMCDUXjCPgqAFUiwFbZ9BICRDH1YB6J
 D1bjOB1iTrT5ntEM7XD/9K9zwWWqhVV+ND7ZwlQsVRK5KQqEbNQrZWIW/K86+OdK5XgF
 m8+WxuwXN0F+8lOxvPEoylggxPpqEafv/DkeesFSoGw+lLOK6W43olCYe0uSUGTUCDt4
 LbZs+2UYdroMh5etp9WeQBCAh8g/1f2KQfzDQFHikggKnuF8v46OxoMAHoA+BTcW7nJK
 Etl4lwAFZN5SyaYN/EhgcKxznf88TItc4pUXBD2KgL5A/Xv5aMEY/kDq23pwEKCanN/T
 Z43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1dKkut+uCfwlAn3zScZi3hqAXXCijPCSIcimV4mZPU4=;
 b=e73fM+3pZKy+c+uYIrXiGp9s3sz0oNQu7gi1V2dYHUPZJEvdU8DKImDVrhdgDQt/Jn
 bppl29qEH4dJwgFgnAaKEztePIATqF0TZREP5EJCpwU/07JbuHOFZe/cBPBEvyDMiStX
 WLT0XrSvScdyZxxLtFidVGzXJt3nXjbK2oDJk0QBUv0Diu6M0os83PHQnUVnI3Vp1KKZ
 QHeW3RYVUbi5LvB6ea7WOC484aCJCcoSEZFuxb3hbmUtD3UyrFWE7b73m3P5M9ZpOypT
 65s/6+P9wd4oUhAFuHA8gyZxVd2pxQDcT5Kmsy5Rk+y0UHJu9ihUmRt3mf3KvBSjBMfb
 YJhQ==
X-Gm-Message-State: APjAAAV4KOcsyKOlti1sVk7hPu5PGvGzB05F07HwFgTPzjp8/O66nYf2
 mZ1jY4TmyTBSaJciLIJnQ7RWdA==
X-Google-Smtp-Source: APXvYqxMCfe13Ui/4ND/lE/PEt3nd9N3tuL8FNIRUXp7xfjeR+wJtUmscPfwF75RVxUoJa8//y/pFw==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr3028525wmi.50.1559898362395;
 Fri, 07 Jun 2019 02:06:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o14sm1312338wrp.77.2019.06.07.02.05.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:58 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C0FC1FFA3;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:16 +0100
Message-Id: <20190607090552.12434-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 17/52] tests/vm: proper guest shutdown
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

When not running in snapshot mode ask the guest to poweroff and wait for
this to finish instead of simply quitting qemu, so the guest can flush
pending updates to disk.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-7-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 395eefaec9..f27178f3c7 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -51,6 +51,8 @@ class BaseVM(object):
     name = "#base"
     # The guest architecture, to be overridden by subclasses
     arch = "#arch"
+    # command to halt the guest, can be overridden by subclasses
+    poweroff = "poweroff"
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -202,6 +204,10 @@ class BaseVM(object):
     def wait(self):
         self._guest.wait()
 
+    def graceful_shutdown(self):
+        self.ssh_root(self.poweroff)
+        self._guest.wait()
+
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
@@ -278,11 +284,13 @@ def main(vmcls):
         traceback.print_exc()
         return 2
 
-    if args.interactive:
-        if vm.ssh(*cmd) == 0:
-            return 0
+    exitcode = 0
+    if vm.ssh(*cmd) != 0:
+        exitcode = 3
+    if exitcode != 0 and args.interactive:
         vm.ssh()
-        return 3
-    else:
-        if vm.ssh(*cmd) != 0:
-            return 3
+
+    if not args.snapshot:
+        vm.graceful_shutdown()
+
+    return exitcode
-- 
2.20.1


