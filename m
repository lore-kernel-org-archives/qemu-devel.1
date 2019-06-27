Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504CC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA3E2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPHVs2GE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA3E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSUi-0000Cz-DI
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBC-00081q-1M
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSAt-0007Tv-Mf
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSAt-0007SO-0L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:02:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id r16so171793wrl.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6VxXUW5v3nl1AvtMlT9JwX167PirKV5StFRRwCOCgk8=;
 b=DPHVs2GE4dmjGMaSjFgsyN5GyAtGJUXNm14iPzNQhc7KKIzAATB2mQc/fGYQJpIVGL
 Wl3K2o05On62CX0qbbjEdiAl1FjWvnTft+U9/gP8iZFXOy5temTfNwlKmWyulBo/LBp9
 yrfMRt0cmruNzmb/44g0o/FhFUWGsWtaAvvYx1t6hdPYpIHIpfalTaUxYQE0lOU9sCmD
 pwX+alenkLrpJHyFKRgsaFPhkNg/l9mZPLTNg5iE75ZGFszIaVyoYM9q7VANvx3bflZ8
 kXNski3VW/wpxvhfoldtm40jMGt0q6RI0RGbkIhiPaWu6Wia43HSNdUcGFRxPW7d/Jt9
 osiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6VxXUW5v3nl1AvtMlT9JwX167PirKV5StFRRwCOCgk8=;
 b=WjtdWfGf0pg9vwEu5OlJBX55z6EIzeyNB2j8UpGYhLpxSHxZ98x0qQxkJduTvsiIe2
 ntjTYmoQVwaRdBw16NAT3f8tmEEdDZY+lD/1Fi0N7JeSZP7pzVQcj7CML95cwz12S/Jz
 E2cc2sCScA2t7cUTcpeKdqsyyEBTwEHjfUy84ylSrD/lrDcGr84jVaWFG7fWsec+2c8z
 qSWsthdgsPIp6qSQKC+gWOpcjk3iL23oiu0z93QSyrQv1njQNhDU5ARXV0120pENX8/6
 w+A9J0eFv1ZYg4NvtFKki7AktIpUwnKEmMhVMz3auiE9IozEgUZXr2ExeZM9VJJqPNfq
 ToSA==
X-Gm-Message-State: APjAAAWimD+FeB/OPdvi0098bVpTG3PNPZdby5JOrsI1eV8LmFDdTD26
 +Iq447neeaYYOj7S7KoPAatIy1XR
X-Google-Smtp-Source: APXvYqxoEhSXCEcY+b2UDci+f48+Pp/XQoXvuRjaYUFe2uDD6xUe9JqcK7fRNb8arJmM7d4g0Qp9lw==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr2993391wrw.26.1561633360980;
 Thu, 27 Jun 2019 04:02:40 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y18sm6368968wmi.23.2019.06.27.04.02.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:02:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:01:58 +0200
Message-Id: <20190627110201.1999-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627110201.1999-1-f4bug@amsat.org>
References: <20190627110201.1999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 2/5] tests/acceptance: Test Open Firmware on
 the PReP/40p
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
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 53f2d2ecf0..a0eac40d9f 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -61,3 +61,24 @@ class IbmPrep40pMachine(Test):
         os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
         self.wait_for_console_pattern(os_banner)
         self.wait_for_console_pattern('Model: IBM PPS Model 6015')
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
+        self.wait_for_console_pattern('QEMU PReP/40p')
+        fw_banner = 'Open Firmware, built  April 13, 2019 09:29:23'
+        self.wait_for_console_pattern(fw_banner)
+        prompt_msg = 'Type any key to interrupt automatic startup'
+        self.wait_for_console_pattern(prompt_msg)
-- 
2.19.1


