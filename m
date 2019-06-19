Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B86C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B02214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="os/VqEbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B02214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgXb-0002qU-Vl
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRY-00066e-JC
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRX-0008Vo-H4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRX-0008Te-AN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so440261wrw.13
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xvCzdluYnrwYcHghSKZ/rlY7/FmiKtd1c7t0G93SmmQ=;
 b=os/VqEbQx1wcOOru7EslrS0uy3sCxZpv4+20JudtT0TuXAeNfVuIhP4G3rpa7GR07y
 iBDi5ZT+Hkd06yHL9qs5AlDiF4X/zglUIQ6V0xH8HKWdAFaQAL/SLFoJsmuk+F5eLDTl
 eWMaVgLz9ku1v+3lWuESwEqXaC6lGaqDV8n6OvInmMVu+mByVgDbEwSBNDxk1OT5802y
 xEnikeNJ/QZIx1U1WfU2HU/IALmwWoyu+XIngM0tYSK6+nBJ13aNSOvpIHmza1QIiV5S
 F247UCvSwpg+RlhcKCYj0SGmiNpqFDQbZwlti0h+C9jG82Ke2fJB+3mFLWPuWCtVlh0j
 wLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xvCzdluYnrwYcHghSKZ/rlY7/FmiKtd1c7t0G93SmmQ=;
 b=ctF2/egF0zbJXiTsz55ZhJyLHSQ3bZA1RPMy2F2iiVWgIAK4vaoq8UDLb0AyV6M+ee
 glYrf8I9Wm5j0ATS2y7zjjBWkzSM5+PRCgzhzVM/JhugKq76GTXrXnMAj+jzJeK5QQyE
 MgzVUdv9qiz9JvtwUGhGrukdZZbGf54bIHa/KZjwKvR+MJvwRcTjwyKBax6Fs3RsZvrK
 25TAWODR5SvIBBl4AjixSZzdsHSP1KZUCMZ83jrEcPEM3L0dzMMXGFZh4Ay3jxBZakhM
 tfJ031J8ujhSHYnVY9LYyeCwKCfnWiV5WjnMT5HylyKiaE34Rq1GcEnEHAcqPGgHH8uV
 W0xA==
X-Gm-Message-State: APjAAAV2w7j2y+F0RzyaCsgQzYZrQWTQw7nX9QCABjeM6Nm8JgugtRhd
 NdWZaPDK4BpFOW3iTWkKh+PXAA==
X-Google-Smtp-Source: APXvYqzTCeAMareyZ/SX9QZ1NkkIAr5M6YMh4MYhr5aaWAgWG3i5D3QvJZB9JKhmSPO3MisvlTqIUA==
X-Received: by 2002:a5d:5510:: with SMTP id b16mr53368161wrv.267.1560973226051; 
 Wed, 19 Jun 2019 12:40:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 72sm15113657wrk.22.2019.06.19.12.40.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F01371FF93;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:10 +0100
Message-Id: <20190619194021.8240-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 06/17] tests/vm: use ssh with pty
 unconditionally
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

Allways ask ssh to run with a pseudo terminal.
Not having a terminal causes problems now and then.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-3-kraxel@redhat.com>
[AJB: added PMD's r-b/t-b tags]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5e30bac661..395eefaec9 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -107,16 +107,14 @@ class BaseVM(object):
         os.rename(fname + ".download", fname)
         return fname
 
-    def _ssh_do(self, user, cmd, check, interactive=False):
-        ssh_cmd = ["ssh", "-q",
+    def _ssh_do(self, user, cmd, check):
+        ssh_cmd = ["ssh", "-q", "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
         for var in self.envvars:
             ssh_cmd += ['-o', "SendEnv=%s" % var ]
-        if interactive:
-            ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
         ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
@@ -128,9 +126,6 @@ class BaseVM(object):
     def ssh(self, *cmd):
         return self._ssh_do(self.GUEST_USER, cmd, False)
 
-    def ssh_interactive(self, *cmd):
-        return self._ssh_do(self.GUEST_USER, cmd, False, True)
-
     def ssh_root(self, *cmd):
         return self._ssh_do("root", cmd, False)
 
@@ -284,9 +279,9 @@ def main(vmcls):
         return 2
 
     if args.interactive:
-        if vm.ssh_interactive(*cmd) == 0:
+        if vm.ssh(*cmd) == 0:
             return 0
-        vm.ssh_interactive()
+        vm.ssh()
         return 3
     else:
         if vm.ssh(*cmd) != 0:
-- 
2.20.1


