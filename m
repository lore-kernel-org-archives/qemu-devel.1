Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8D9ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E61320820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADQ8sDvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E61320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9nf-0008NT-39
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91I-0001It-5a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91G-0006eP-OR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91G-0006dr-I0; Thu, 17 Oct 2019 12:52:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id m18so3295253wmc.1;
 Thu, 17 Oct 2019 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h/AjXKthzEaJ9ywjgYGWUdG8iYtl0YGTmNhIboeeBpw=;
 b=ADQ8sDvFKNbN/I/LJnaIJriI3HDEYuCOfnjjdpxqHp6CZtAy5Ej5n25CyScA7KYSS5
 p607MhVsWsdVtA3FMU1lZ6XiOMN+Y+ytJgJ7wOdP+Zv37XkyCz/RXT7+ZQfpOJCakyBV
 yBvIFTrVyR5YScRks5HGpD5oI4H14P2pspV9lGK7+JW04V00LPO2c28truKQ0a+rljSC
 ZElvmT0X/8pvs5e2gs0igMM/zWHHLDs2LTWDBqBSj8fSTKvmPX8VNYtuYniqP1GDjtT2
 9eVlvptNV87mUSPJVIyyczSQ3FIP7lssJG0A3xQM59z0XH0tOs0gHx4S78bDZQbIgFKR
 tJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h/AjXKthzEaJ9ywjgYGWUdG8iYtl0YGTmNhIboeeBpw=;
 b=BIyUSa5j6KDdhqrlNE0f7b+HpDnvGclLkWCz0J7YZYNdNVMAlNz8tlFRafqicOUSOo
 atEu5p3Grkfc+Xu4zsnucxq+HwxI0xUPoheaTmCS7eP3XrGH7SyXdhUgYMk3UrpGGalf
 k4MwF8WxyK6sSeZUz8aU+1qY48NUaWqCk8LOU1DpS6CyhLbH9XpQQHb86ngg5tGnnH46
 ukdLriPt8T0ZhOVo2Cl4c5QV9imxmO70VReDyYuQBF8tw/FlICOKS5jrbMJzm2kb4dh2
 LqSHQ6NIiLULirlya+uw8AkMps8jpBlW/zkoD5Igw9YBwv74CJ5GMXaGavMT3JbTS6Nf
 kLEg==
X-Gm-Message-State: APjAAAUVWjJOOTBsQHssqSi6BFy7WwA3jtIakAbL2LK0ihTNRl/eXlN5
 B5I99QlsicWyJdAPIAGhdosnMN8M5/I=
X-Google-Smtp-Source: APXvYqxrpBbOeApsMl8jwqgvIP76x92LdKIvMs31i+QTWrhxFz+zCuTK/mAc+Sej6Vu/ayiIiRx9oA==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr3588313wmh.56.1571331176086;
 Thu, 17 Oct 2019 09:52:56 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:52:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] tests/acceptance: Add test that runs NetBSD 4.0
 installer on PRep/40p
Date: Thu, 17 Oct 2019 18:52:35 +0200
Message-Id: <20191017165239.30159-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of this commit, NetBSD 4.0 is very old. However it is enough to
test the PRep/40p machine.

User case from:
http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Installers after 4.0 doesn't work anymore, not sure if this is a
problem from the QEMU model or from NetBSD.

v3: use avocado_qemu.wait_for_console_pattern (Cleber)
---
 MAINTAINERS                      |  1 +
 tests/acceptance/ppc_prep_40p.py | 43 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tests/acceptance/ppc_prep_40p.py

diff --git a/MAINTAINERS b/MAINTAINERS
index fe4dc51b08..83ec5cbf42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1068,6 +1068,7 @@ F: hw/timer/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/timer/m48t59.h
 F: pc-bios/ppc_rom.bin
+F: tests/acceptance/machine_ppc_prep_40p.py
 
 sPAPR
 M: David Gibson <david@gibson.dropbear.id.au>
diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
new file mode 100644
index 0000000000..2978416b02
--- /dev/null
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -0,0 +1,43 @@
+# Functional test that boots a PReP/40p machine and checks its serial console.
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+import logging
+
+from avocado import skipIf
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+
+
+class IbmPrep40pMachine(Test):
+
+    timeout = 60
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_factory_firmware_and_netbsd(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        :avocado: tags=slowness:high
+        """
+        bios_url = ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
+                    '7020-40p/P12H0456.IMG')
+        bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
+        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
+        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
+                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
+        drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-bios', bios_path,
+                         '-fda', drive_path)
+        self.vm.launch()
+        os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
+        wait_for_console_pattern(self, os_banner)
+        wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
-- 
2.21.0


