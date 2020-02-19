Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B35DC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6B62464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EL+vRzOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6B62464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Scl-0002XC-U0
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOU-0003d5-Cm
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOS-0008Df-9C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:14 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOS-0008DJ-11
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:12 -0500
Received: by mail-pj1-x1043.google.com with SMTP id dw13so292731pjb.4
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3orctIoixlh5zMRLtfbiaWjCyd2poMVCy6JL4hja3+4=;
 b=EL+vRzOxwE9gWOY+DLLo+81dkJ0kke98FH2J1yK26LA+l1GwNavFm6e88MnGklSdx8
 F70jtCaX4eTkH9Zh4wvZK065KNh0WozAXVfICMeuEHiF7Q7aQDdvmaAIR+k+mhwKTFlg
 7tzzxE2rHMlsoIH+uN3QG968LC/ubvWEdSTZEh/Z4jAS9jVTvUdKTcx8eZf2C9B0+JZD
 7Mb9Bq5to4eqqlzwEQ6gB/xL4Lmyi5oteLPe3lbkg2wCPo9x1Y+0RAbiaicWa4TQ9VUm
 pduKV17ppqRgmjy0rEW/nRZHkrxDtWudMbVIFsfugECwYza5ftY56MJGcKDtFXVt63G1
 GZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3orctIoixlh5zMRLtfbiaWjCyd2poMVCy6JL4hja3+4=;
 b=Lkvpl+OGHgooAOSAx/k9Z8ffUjTSmn035Yh2Y66uA+CJ+dP9GawKkTbNJS3rsi2Mka
 EteNCo+MrHKETPohaqjf3YoeBwHUQhUnPwifMsGwfYOzPAW5Mty8aTClVuoEjLxGH4UO
 5OX/unF/GUFjCeCSFVMV+Ule/vet+MSCLRrDDSxUXwq1x8M3qO8yAsNxjyLOcTBUXG2o
 /mAaxa9CxOCCDrqBO8jMrNs/AZ+eQamUEEFaWqNTJOcKMOp3AfKlV2+MQzQruB3RYy1E
 7zl3lClJpqLRLIvgoQivOfbLBmJc7B5fB1tKo1hDFF56WFkJ5P35Yq9ewXq7hrbtnvh/
 ekHw==
X-Gm-Message-State: APjAAAUdLUzP7jlYS+KAK8ztdx4wvnxrAo2yvKT4BQ5rEdZhfE3TV5YE
 /wljFR0WcUWZVe+vAuu/eGc4p6lTpxM=
X-Google-Smtp-Source: APXvYqzhBpEhlsO5j5ysL65hCOS+dMS4PLmBUw3UDfrvrKCDm+SEPyc6WDAwQV5fTAl1UpIYEonhlg==
X-Received: by 2002:a17:90a:8b08:: with SMTP id
 y8mr9146605pjn.87.1582130410474; 
 Wed, 19 Feb 2020 08:40:10 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:40:09 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/14] tests/vm: change scripts to use self._config
Date: Wed, 19 Feb 2020 11:35:37 -0500
Message-Id: <20200219163537.22098-15-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

This change converts existing scripts to using for example self.ROOT_PASS,
to self._config['root_pass'].
We made similar changes for GUEST_USER, and GUEST_PASS.
This allows us also to remove the change in basevm.py,
which adds __getattr__ for backwards compatibility.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 11 ++---------
 tests/vm/fedora    | 17 +++++++++--------
 tests/vm/freebsd   | 16 ++++++++--------
 tests/vm/netbsd    | 19 ++++++++++---------
 tests/vm/openbsd   | 17 +++++++++--------
 5 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6ed04a2a4b..ad04789bcf 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -178,13 +178,6 @@ class BaseVM(object):
         self.console_init(timeout=timeout)
         self.console_wait(wait_string)
 
-    def __getattr__(self, name):
-        # Support direct access to config by key.
-        # for example, access self._config['cpu'] by self.cpu
-        if name.lower() in self._config.keys():
-            return self._config[name.lower()]
-        return object.__getattribute__(self, name)
-
     def _download_with_cache(self, url, sha256sum=None, sha512sum=None):
         def check_sha256sum(fname):
             if not sha256sum:
@@ -234,13 +227,13 @@ class BaseVM(object):
         return r
 
     def ssh(self, *cmd):
-        return self._ssh_do(self.GUEST_USER, cmd, False)
+        return self._ssh_do(self._config["guest_user"], cmd, False)
 
     def ssh_root(self, *cmd):
         return self._ssh_do("root", cmd, False)
 
     def ssh_check(self, *cmd):
-        self._ssh_do(self.GUEST_USER, cmd, True)
+        self._ssh_do(self._config["guest_user"], cmd, True)
 
     def ssh_root_check(self, *cmd):
         self._ssh_do("root", cmd, True)
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4d7d6049f4..60195ddc46 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -105,20 +105,20 @@ class FedoraVM(basevm.BaseVM):
 
         self.console_wait_send("7) [!] Root password",     "7\n")
         self.console_wait("Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Password (confirm):")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("8) [ ] User creation",     "8\n")
         self.console_wait_send("1) [ ] Create user",       "1\n")
         self.console_wait_send("3) User name",             "3\n")
-        self.console_wait_send("ENTER:", "%s\n" % self.GUEST_USER)
+        self.console_wait_send("ENTER:", "%s\n" % self._config["guest_user"])
         self.console_wait_send("4) [ ] Use password",      "4\n")
         self.console_wait_send("5) Password",              "5\n")
         self.console_wait("Password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Password (confirm):")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait_send("7) Groups",                "c\n")
 
         while True:
@@ -136,7 +136,7 @@ class FedoraVM(basevm.BaseVM):
             if good:
                 break
             time.sleep(10)
-            self.console_send("r\n" % self.GUEST_PASS)
+            self.console_send("r\n" % self._config["guest_pass"])
 
         self.console_wait_send("'b' to begin install",     "b\n")
 
@@ -147,12 +147,13 @@ class FedoraVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = " ~]$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"],
+                                      self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = " ~]#"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup virtio-blk #1 (tarfile)
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index fb54334696..735fb5f794 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -110,9 +110,9 @@ class FreeBSDVM(basevm.BaseVM):
 
         # post-install configuration
         self.console_wait("New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Retype New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("Network Configuration", "\n")
         self.console_wait_send("IPv4",                  "y")
@@ -131,9 +131,9 @@ class FreeBSDVM(basevm.BaseVM):
         # qemu user
         self.console_wait_send("Add User Accounts", "y")
         self.console_wait("Username")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait("Full name")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait_send("Uid",                   "\n")
         self.console_wait_send("Login group",           "\n")
         self.console_wait_send("Login group",           "\n")
@@ -145,9 +145,9 @@ class FreeBSDVM(basevm.BaseVM):
         self.console_wait_send("Use an empty password", "\n")
         self.console_wait_send("Use a random password", "\n")
         self.console_wait("Enter password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Enter password again:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait_send("Lock out",              "\n")
         self.console_wait_send("OK",                    "yes\n")
         self.console_wait_send("Add another user",      "no\n")
@@ -161,12 +161,12 @@ class FreeBSDVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = "$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"], self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "root@freebsd:~ #"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup serial console
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c5069a45f4..d4ad3525e3 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -128,24 +128,24 @@ class NetBSDVM(basevm.BaseVM):
         self.console_wait_send("d: Change root password",  "d\n")
         self.console_wait_send("a: Yes",                   "a\n")
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Retype new password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("o: Add a user",            "o\n")
         self.console_wait("username")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("to group wheel")
         self.console_wait_send("a: Yes",                   "a\n")
         self.console_wait_send("a: /bin/sh",               "a\n")
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Retype new password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
 
         self.console_wait_send("a: Configure network",     "a\n")
         self.console_wait_send("a: vioif0",                "a\n")
@@ -178,12 +178,13 @@ class NetBSDVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = "localhost$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"],
+                                      self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "localhost#"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup virtio-blk #1 (tarfile)
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 22cd9513dd..dbef216853 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -95,9 +95,9 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Which network interface", "done\n")
         self.console_wait_send("DNS domain name",         "localnet\n")
         self.console_wait("Password for root account")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Password for root account")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait_send("Start sshd(8)",           "yes\n")
         self.console_wait_send("X Window System",         "\n")
         self.console_wait_send("xenodm",                  "\n")
@@ -105,13 +105,13 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Which speed",             "\n")
 
         self.console_wait("Setup a user")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait("Full name")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait("Password")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Password")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
 
         self.console_wait_send("Allow root ssh login",    "yes\n")
         self.console_wait_send("timezone",                "UTC\n")
@@ -132,12 +132,13 @@ class OpenBSDVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = "$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"],
+                                      self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "openbsd#"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup virtio-blk #1 (tarfile)
-- 
2.17.1


