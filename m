Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB63C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778E820663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAGn4r79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778E820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42379 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOua-0004lf-K7
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrO-0007MA-Qu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrM-0006aO-2m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jCOrL-0006Zd-BW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:51 -0400
Received: by mail-pl1-x644.google.com with SMTP id j20so2735306pll.6
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zu55w57Oui8Xur6dOmzXIZRXCZIx7GGCMyc1jtFJeG4=;
 b=zAGn4r79ip/B04Fud+G21ePfSvS07yQoL95NXayfbaaaElhRM/PqwAQfZVVohem9JH
 yO6Ef/gxSqWVBGjdOi/pR7rbDiweswvXo1dPcRX7TT8CpKCMnIHFqfRxpmel+r1PQVbB
 JC9nXy4+xUqSVnpnsmlGlzLDuFGe8NXBG9PWUINlzqLucXhFsYZGRu2AGC/w9ypZxRVM
 krBPK1uFWc1F8pVuMDWiKrPXwVLZqDQtgmTy5pCldsGV3TJimI1TQPe/2LMqmuCaGtSd
 s6I4JoMKJ9USseNpBTuc4PQhC48P0/KlNvZ7izxA+OqQMVt9qU4IN4sQOLKXRU2yNDXv
 Z9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zu55w57Oui8Xur6dOmzXIZRXCZIx7GGCMyc1jtFJeG4=;
 b=jhreq3CmYd/VKgCFdG4alywwO9ItWOn6sSJV/gQe1YsHVB7qgBVdlSoRDjxAiLcUW2
 e7+VAETQZHLNo6y+0EFKY4v8j9623i6a3FkZZcjU2e+rEVpSrIv2PvAA9GzxnHIIYJQW
 Yvg5jMEQneCdOSUnp4eJFkwBFXNPbuNf8Rl73q6jBSds0Rm4IiS2Z6UPhRlxP7h5fxiO
 T0PoGeeatwImtDxPD0Z2A/iDeuLzlWsx1zQGUMPkb0iiLhg5p1oYKXvI6At6dBKrZUEO
 7JXkomXEZR0F5gaYmWaBfdfFCkZEe6qt/2EP/Gq+eg/e4VFW1J+gXXQRrpsXL9YQqaAt
 uRKA==
X-Gm-Message-State: ANhLgQ3YFA1BVIFCOy8pv2/6TWqrC88izsUYWbxqbAOW8ku72iYvEvZT
 Q3GDAKAapD3lSG5EuuAGsjHLSqE09nI=
X-Google-Smtp-Source: ADFU+vuw0vIJoBXTur5txz8MWUz9W/jKNCpbv/UINY3eLSGppJOuO3GGN9y82Q6mZOGVWXyBNnzlsg==
X-Received: by 2002:a17:902:9a4c:: with SMTP id
 x12mr7797042plv.297.1584023449658; 
 Thu, 12 Mar 2020 07:30:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:845e:b9f6:81a6:8f5e])
 by smtp.gmail.com with ESMTPSA id 63sm14832651pfx.132.2020.03.12.07.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 07:30:49 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/10] tests/vm: change scripts to use self._config
Date: Thu, 12 Mar 2020 10:27:27 -0400
Message-Id: <20200312142728.12285-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142728.12285-1-robert.foley@linaro.org>
References: <20200312142728.12285-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
index a0727d7058..bd4a1f9639 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -170,13 +170,6 @@ class BaseVM(object):
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
@@ -226,13 +219,13 @@ class BaseVM(object):
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
index 4843b4175e..6a7023eb71 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -108,20 +108,20 @@ class FedoraVM(basevm.BaseVM):
 
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
@@ -139,7 +139,7 @@ class FedoraVM(basevm.BaseVM):
             if good:
                 break
             time.sleep(10)
-            self.console_send("r\n" % self.GUEST_PASS)
+            self.console_send("r\n" % self._config["guest_pass"])
 
         self.console_wait_send("'b' to begin install",     "b\n")
 
@@ -150,12 +150,13 @@ class FedoraVM(basevm.BaseVM):
 
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
index 86770878b6..43f14f102d 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -113,9 +113,9 @@ class FreeBSDVM(basevm.BaseVM):
 
         # post-install configuration
         self.console_wait("New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Retype New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("Network Configuration", "\n")
         self.console_wait_send("IPv4",                  "y")
@@ -134,9 +134,9 @@ class FreeBSDVM(basevm.BaseVM):
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
@@ -148,9 +148,9 @@ class FreeBSDVM(basevm.BaseVM):
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
@@ -164,12 +164,12 @@ class FreeBSDVM(basevm.BaseVM):
 
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
index 55590f4601..e953fcd161 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -131,24 +131,24 @@ class NetBSDVM(basevm.BaseVM):
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
@@ -181,12 +181,13 @@ class NetBSDVM(basevm.BaseVM):
 
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
index ab6abbedab..445ea78516 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -98,9 +98,9 @@ class OpenBSDVM(basevm.BaseVM):
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
@@ -108,13 +108,13 @@ class OpenBSDVM(basevm.BaseVM):
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
@@ -135,12 +135,13 @@ class OpenBSDVM(basevm.BaseVM):
 
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


