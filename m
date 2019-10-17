Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F9ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D558E21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvvG2D+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D558E21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9jo-00049W-Vs
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91I-0001JU-HC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91H-0006eW-AQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91H-0006eJ-4O; Thu, 17 Oct 2019 12:52:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id o15so2742305wru.5;
 Thu, 17 Oct 2019 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0CG2FzQa4cGE4e9qhNAZwZAlRFWE+HE6jkMUue3YYdc=;
 b=fvvG2D+1VddywUfDPUSOVDKV7H4AXZDbY28I64NyJGYrr5+xHUTpnNdW+GnVJqumsx
 dG6OWnokpH6X6nOsPf+z8OTUdY31bBrMI0aIwPkOMmjeqUpsgk2dpP8QuQ9ZknJf2F4A
 zopeiCuwillomMywK2EQJC8Q/NZ1OID+0oJoAU4/J73TnsTAS+m48hIiskejfVqejO6I
 77UV8YQfU2jvSlraFSzKyJt+jDAcESfR/MhgAW5sT5hDXT0zgpwSbCEmwoGRtJVzjR/l
 TpCaHxBZJntmWd9fg0vm05aI55dQzeIX5UxHZarvbKhiRCvZNjug9uhPlvklrwMi0xLE
 iHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0CG2FzQa4cGE4e9qhNAZwZAlRFWE+HE6jkMUue3YYdc=;
 b=ngpCNii53Xu5qIZyN1JaizUSUYM6yd0dAQwNargu6q4KZxbblo2NvpmmQ9TS5dT8JN
 syIIC9P4ojGbwnto75Whd/kPxRrqNi+64KP/JZgiwf828T1qJC2KU0Zc4boXyjpCuos9
 0wTD7lO8RiWHl4Iae0SLge472NSVwcfYslURF07MUFz4Nt+NczCWzxjniwC2PhYaGm0+
 /DxZAcI42AY7nF2fVRUK9er1I+YEpnJ7UxBAMhOQFKyWu2byfNeESolkKmGoaWwTYX5L
 UgnuE9yPv7zm+SvNgYbyrZjiSoKlwbz5JkeJIECSb2wX3pJcmbUOOjgfWeyXOSCWK7gZ
 94Qw==
X-Gm-Message-State: APjAAAUunBSBlblwvCAzuIBbYqUBRl1vstbNbsgvYnfgvV7+eJLUqtZx
 NK8EC2w0az6eqMbe4mvqNr1Ugyw2/Wg=
X-Google-Smtp-Source: APXvYqwP0vqdsDFcN7nTROxIvCv2Gdqje/P2b3/oJlRLQF4R7mut5/fYPJts7B4SXojxh9EbAW4ypw==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr141670wrx.90.1571331177797; 
 Thu, 17 Oct 2019 09:52:57 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:52:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] tests/acceptance: Test Open Firmware on the PReP/40p
Date: Thu, 17 Oct 2019 18:52:36 +0200
Message-Id: <20191017165239.30159-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

User case from:
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: use avocado_qemu.wait_for_console_pattern (Cleber)
---
 tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 2978416b02..7b8d0e55a9 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -41,3 +41,24 @@ class IbmPrep40pMachine(Test):
         os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
         wait_for_console_pattern(self, os_banner)
         wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
+
+    def test_openfirmware(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        bios_url = ('https://github.com/artyom-tarasenko/openfirmware/'
+                    'releases/download/40p-20190413/q40pofw-serial.rom')
+        bios_hash = '880c80172ea5b2247c0ac2a8bf36bbe385192c72'
+        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-bios', bios_path)
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU PReP/40p')
+        fw_banner = 'Open Firmware, built  April 13, 2019 09:29:23'
+        wait_for_console_pattern(self, fw_banner)
+        prompt_msg = 'Type any key to interrupt automatic startup'
+        wait_for_console_pattern(self, prompt_msg)
-- 
2.21.0


