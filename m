Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE44C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410BC213F2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReagwXuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410BC213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPTs-0002jE-E7
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGK-0006jR-3V
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007gp-V5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007U0-JO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id k11so14008959wrl.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4V5durOY/x3+0X/wiER2jyd9YT6J94WuCw52pgi+pLM=;
 b=ReagwXuvID5elncENxLBDxvRAHCo0mRVCrZnmEp4kOovVhKQC+Iy7pZLnZ+IglOFx1
 Wf+n9vdsWFSN6BA5B3/E7dtYBZRKhH6UYNLHX6g1qJe97L73ZePkLokXw1TvqHctuz88
 25RPhUwzd23HZ/WNgoU23VLj/mXaXAkVHCjknYXm3GIak1unzN+FTdpey8YH6AR7T1PC
 vulhYtw07B9qzFMGi05ho6PRF9TR62N86wLvAO0tzPVEyVeB3t1yp2o+gsj86X9QPyBx
 vr7RctfDYx1MbWs/weicqjB8GF6WXIlAcd5ioni2kNV7HW9V/ZBN+01RXDjhDjJnqCEx
 51NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4V5durOY/x3+0X/wiER2jyd9YT6J94WuCw52pgi+pLM=;
 b=tgNZIt29fZqBHjjQ41tVLAUwfX+F3tA7i0Or1ep6WXVu0RNncVORWluDJziJQtjsGd
 6TTeoiRbdBujan3rHGxl7beMxfGWd+G1WjGWgl/P3UXHi06pQ40bQlHqGvwRG1NMhD2p
 FkBEDpoci0j1ROddHJB/xk3SdQ3KRO1Mf8UTnF2xIK2g03Bdyd/5Ng4MaWwOOaRZv+Hh
 8yobaKh20+ZaAqrDHYfGXe7Gm+Pzsi0K+5ZV8uLDK2jUkRQZOJ9QFLdVmG4prkRMrnnD
 NhDKKymh/nFEmPLmMi64shp4csIEIz2jyyiJwDmQGGI2qExzMQhKVSF4vBLzQc6nnHYj
 Lndw==
X-Gm-Message-State: APjAAAUGS5Yi4GgPz6U1SkXcnxcryKV3bT85QAI7kyeVN3ErUzLjD2v2
 MsJqngGbPdLZzPh6J17XmOHIiQ==
X-Google-Smtp-Source: APXvYqy2EejcZFiq2QQkwcvc+OQDCaJynL1YeBo8wIeaErW1i/u9FMwp89EUbGDgUoZpk2xguBoTgg==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr23355987wrr.324.1561383827800; 
 Mon, 24 Jun 2019 06:43:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t63sm11034068wmt.6.2019.06.24.06.43.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A9671FF9A;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:28 +0100
Message-Id: <20190624134337.10532-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 10/19] tests/vm: serial console support helpers
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

Add a bunch of helpers to talk to the guest using the
serial console.

Also drop the hard-coded -serial parameter for the vm
so QEMUMachine.set_console() actually works.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-7-kraxel@redhat.com>
[AJB: added tags]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index f27178f3c7..592a344773 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -2,10 +2,11 @@
 #
 # VM testing base class
 #
-# Copyright 2017 Red Hat Inc.
+# Copyright 2017-2019 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
+#  Gerd Hoffmann <kraxel@redhat.com>
 #
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
@@ -13,7 +14,9 @@
 
 from __future__ import print_function
 import os
+import re
 import sys
+import socket
 import logging
 import time
 import datetime
@@ -79,8 +82,7 @@ class BaseVM(object):
             "-cpu", "max",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
-            "-vnc", "127.0.0.1:0,to=20",
-            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
+            "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
             self._args += ["-smp", "%d" % vcpus]
         if kvm_available(self.arch):
@@ -162,6 +164,8 @@ class BaseVM(object):
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
+        guest.set_machine('pc')
+        guest.set_console()
         try:
             guest.launch()
         except:
@@ -184,6 +188,82 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
+    def console_init(self, timeout = 120):
+        vm = self._guest
+        vm.console_socket.settimeout(timeout)
+
+    def console_log(self, text):
+        for line in re.split("[\r\n]", text):
+            # filter out terminal escape sequences
+            line = re.sub("\x1b\[[0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\([0-9;?]*[a-zA-Z]", "", line)
+            # replace unprintable chars
+            line = re.sub("\x1b", "<esc>", line)
+            line = re.sub("[\x00-\x1f]", ".", line)
+            line = re.sub("[\x80-\xff]", ".", line)
+            if line == "":
+                continue
+            # log console line
+            sys.stderr.write("con recv: %s\n" % line)
+
+    def console_wait(self, expect):
+        vm = self._guest
+        output = ""
+        while True:
+            try:
+                chars = vm.console_socket.recv(1)
+            except socket.timeout:
+                sys.stderr.write("console: *** read timeout ***\n")
+                sys.stderr.write("console: waiting for: '%s'\n" % expect)
+                sys.stderr.write("console: line buffer:\n")
+                sys.stderr.write("\n")
+                self.console_log(output.rstrip())
+                sys.stderr.write("\n")
+                raise
+            output += chars.decode("latin1")
+            if expect in output:
+                break
+            if "\r" in output or "\n" in output:
+                lines = re.split("[\r\n]", output)
+                output = lines.pop()
+                if self.debug:
+                    self.console_log("\n".join(lines))
+        if self.debug:
+            self.console_log(output)
+
+    def console_send(self, command):
+        vm = self._guest
+        if self.debug:
+            logline = re.sub("\n", "<enter>", command)
+            logline = re.sub("[\x00-\x1f]", ".", logline)
+            sys.stderr.write("con send: %s\n" % logline)
+        for char in list(command):
+            vm.console_socket.send(char.encode("utf-8"))
+            time.sleep(0.01)
+
+    def console_wait_send(self, wait, command):
+        self.console_wait(wait)
+        self.console_send(command)
+
+    def console_ssh_init(self, prompt, user, pw):
+        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
+        self.console_wait_send("login:",    "%s\n" % user)
+        self.console_wait_send("Password:", "%s\n" % pw)
+        self.console_wait_send(prompt,      "mkdir .ssh\n")
+        self.console_wait_send(prompt,      sshkey_cmd)
+        self.console_wait_send(prompt,      "chmod 755 .ssh\n")
+        self.console_wait_send(prompt,      "chmod 644 .ssh/authorized_keys\n")
+
+    def console_sshd_config(self, prompt):
+        self.console_wait(prompt)
+        self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        for var in self.envvars:
+            self.console_wait(prompt)
+            self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
+
+    def print_step(self, text):
+        sys.stderr.write("### %s ...\n" % text)
+
     def wait_ssh(self, seconds=300):
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
-- 
2.20.1


