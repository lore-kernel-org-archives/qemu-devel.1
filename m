Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A7C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3EA21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMXD36Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3EA21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgTc-0007u4-NK
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRf-0006Aa-4E
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRc-0000BF-P3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRc-00008r-I1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id c6so723874wml.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L6XVojZ9d06YYw7Qa0xt+OkZV+Iz6HolpHL92sjbbUE=;
 b=SMXD36BfIHTjJWHy9gfisDuwrT/MWMlDBAWWvldMH67j0POs+IOigPjdaJb1R8c/yV
 1pnrQiqU/YcilMGhjQ9ObG85L5cZalaVUvNvkoVHEkYqoZ/jUppI55jvWOWX1BXcC7nY
 iXnWD3IYZi7rw4bXLSTxFxLgt5fRANOmYr6EPWJ1+AAXGIWF8zGwV19Afi8FCS/IN0rZ
 PVQ7JQUWGRPkKQu+/+CJ36rT03gYCEV0T20S7zb04pX6k4rvvm90w1yNcrFBVfKidFpJ
 QDGd7XCGJEAAJ9egPvG85Q3MlobVtvXVCJkXppgarFpiHzm0icVkUwjVDeaJLM+x5+zR
 AyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L6XVojZ9d06YYw7Qa0xt+OkZV+Iz6HolpHL92sjbbUE=;
 b=oWdpqS6GKN8Y/AvfJSFmdGiZW/UwX3aMG39qMiZ1z0OII7ydcA/VQQcZ263MMIquQ4
 wX5FLYJn/ty/5OGZC9xKjxHxK5C24CjtEVdcI+XcieGIFKzPJFdDMzRNhP5nZpiDRIAm
 E15DJLnBcRoGgJu0PxtaiAyj2pLjKNtzJcBl/6rSZ+SfD25FjyeIu9kGWT+VxNTpAanc
 sb++511A2K0vVSkh+6PoocSlDpKY31D6hWqXFNx061zWXwztxERhvOQW1hHhtd/N/EjN
 JkZI7ZKE+mu6RPFesE3H9F8+eo3Sw3rzrDOn+OH8i5lKu1hrMte2bKsalmo/k4FqLKcK
 Kbdg==
X-Gm-Message-State: APjAAAU4n1mvwIN6MzdnmzRWlPZLxJfAaSvRPTQEaTlYZyxsA+KVTlm3
 hgdOfraCkeFQk62lWat16JXpeQ==
X-Google-Smtp-Source: APXvYqwmJEwF2wrI6fznHj7HQukUNz6DJSFELiZnnSGtFzCqA5MHkXZ+Uha92zXvMZOYEVJLN6rm6Q==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr9323555wme.12.1560973229821; 
 Wed, 19 Jun 2019 12:40:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o8sm19763322wrj.71.2019.06.19.12.40.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4687D1FF9A;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:14 +0100
Message-Id: <20190619194021.8240-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PATCH v1 10/17] tests/vm: serial console support
 helpers
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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
---
 tests/vm/basevm.py | 86 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

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


