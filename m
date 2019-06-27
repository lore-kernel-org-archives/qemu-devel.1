Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3BFC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DA82080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISEBy71G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DA82080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSf1-0000eM-Jz
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBr-0008IW-SO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBX-0007yP-PR
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBX-0007wg-Im
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id r16so174265wrl.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oHKbdSUx4lNwWHvHnLfhGRkYGRci8p92i4tciWRLKis=;
 b=ISEBy71GHdE9uP167tbQ9Xq26w48gU8yxzwpg7svUgpoUaVxUBecUV6EZfIl0vyILw
 OtiW9Q1Mrl7oBabcodV2xFw1rEOUGXNykBSbO0bJ0lSYF33IBruHUkaRopVs8LWOtS38
 kWfrbZn6f1mGG0gXn/nkXVnV+rBoRuwFVrtmf3ZUaJTsSGaRuVb5W5BILDUY0OCSOY48
 kYrApO9huDOJ5NR534zjUM7XRsGsRWLMpShoXQCnCGk2rEfd23vZ/uX2JHBTUv+1I2Nm
 l8Q5vS50Nh/ENGBMTPgCVQ5SX2X2UCKxhykARGlC6EQDdqE79GC+zgO5PHKxzSHKTTGD
 P6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oHKbdSUx4lNwWHvHnLfhGRkYGRci8p92i4tciWRLKis=;
 b=iqh3aKUNFmcYSDibhPnx8ATiahoDoWublVWXZ4ltdtGZig1i97BgmlH+m5ApBZrKMI
 w7Sy68ToQQsHBmrvd1u/iHMyS4FepH1Trm8Ac087kl1K/+59x3uBAM2GJn4hjqmFwotS
 HUVVsDfwi1Ne35UOvMTnVHml+0p16ibCnVUtX6+5uJJpG2b2q0c7F1ZHUqoh2SF2dUW3
 w4oXGgFhJJfY5X654cgSEfh5yJzCHi5QvDZ/CdglnD07ZG4IW/fyTBbpnSEJLOUYoHeU
 DbblMrbmJYJhh83ryH5m20loJ74SIFXE5M24ASxKvzEItiCWvdhXzpCYhZ5nT1ENN2Cy
 A8zQ==
X-Gm-Message-State: APjAAAUVpDip9bFEmxXQBCMARGbU5j8Oa4Toy88JiXLlLqsuRnfPFne6
 6mYrz6L1Kp87EmGiEWFN17dIEfCg
X-Google-Smtp-Source: APXvYqxF5FeZxVJdwmej3/f7wYuqn4JK3amMCHL7hsZGospOlW9Y6DwIKyAiMO5/jX5FOJEpzrxfPw==
X-Received: by 2002:a5d:4849:: with SMTP id n9mr2757917wrs.139.1561633400338; 
 Thu, 27 Jun 2019 04:03:20 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y18sm6368968wmi.23.2019.06.27.04.02.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:02:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:01:59 +0200
Message-Id: <20190627110201.1999-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627110201.1999-1-f4bug@amsat.org>
References: <20190627110201.1999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 3/5] tests/acceptance: Test OpenBIOS on the
 PReP/40p
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
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index a0eac40d9f..87b5311b89 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -82,3 +82,35 @@ class IbmPrep40pMachine(Test):
         self.wait_for_console_pattern(fw_banner)
         prompt_msg = 'Type any key to interrupt automatic startup'
         self.wait_for_console_pattern(prompt_msg)
+
+    def test_openbios_192m(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-m', '192')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('>> OpenBIOS')
+        self.wait_for_console_pattern('>> Memory: 192M')
+        self.wait_for_console_pattern('>> CPU type PowerPC,604')
+
+    def test_openbios_and_netbsd(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+                     'NetBSD-7.1.2-prep.iso')
+        drive_hash = '78734c1bdda79778f0b6f391969ad2458ed8981c'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('NetBSD/prep BOOT, Revision 1.9')
-- 
2.19.1


