Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25246C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CF922525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Zxqh5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CF922525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itf94-0003Sc-AC
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6i-0001W8-Q2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6h-0005mj-ML
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6g-0005ls-Jg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:14 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so1087869wrw.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ggNBufMgUXbLDI6GhLbTQ3tPRFEaGKDyzQZkuThquYg=;
 b=V5Zxqh5tOLKl2kwDGuL0MmWulWFWBaDYPPFV2jnIc68p6OzahXCGxJJ+1/+Bqw1Tpw
 pxSzO/O0W5MmZyHiKl0F2WoT2GUVv3fxP6mn6w2iMW00O/r24al2qvGJtLSrSZoQR5jZ
 X4nwee3CQW21suNJvW9sOOxeaF0LtmNrvzhHnM2GY6bxncbGJrJpQ+QRAR+VBGXsyFNT
 sld+rojEcpZKfPG6/tfYyvHENxMl2/Dqz5HCbji3TnGltq/cQSVTBRG1JxRAY7OCOMAZ
 32oqHwECzPGjCFrLL/1lf+SYtkwB1G+oj0vl3OlaLXE/yWJqia26nsPpu4mqoMGzBArL
 UpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ggNBufMgUXbLDI6GhLbTQ3tPRFEaGKDyzQZkuThquYg=;
 b=LIXq3bh/OfUBpw3rfjsN+DpdpXEEByiWlzFqE61IrVMVEMBKQBZAdpXcbjG39fgPM5
 U9F55jXygLdYpC9QRZ3WtFlIzqhbvlHvw1MQC0ncAqqAzdBnC45lob/fZRpZmQIClAib
 qH6vgMQmWfqBBSPQhpa0McAv0/ue8xcY5uo+qvPCVfiuMR/q/fP6CUzdN6yvk0zq29sC
 EzDSVwAUtEj2gsDQBsLLKK3sw622SWhsuiN2vl2u4wOVUM5I95Ir83L18XJrRKQiq6m6
 wdW/ta/A51gxwJXxym2LYwumiZDX/JdmrwcnLOrY9p28lbQFhD+OAO8MY+5Dwl8tqgGQ
 vzYg==
X-Gm-Message-State: APjAAAVx8j2PXqZWvm7156U2T9h27sbTlUAXqppbYkAL1neqXAriP9yF
 +2qLuYteZ+MgQb0QAFt1ALdA50Ey
X-Google-Smtp-Source: APXvYqxocXpd9c4zqJUQZdMJRzAGQh/dX6aXTGofs68r2mhGU3LD65ynBurtDTn9fvX72AtqffBD4w==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr1633760wro.56.1579557673162; 
 Mon, 20 Jan 2020 14:01:13 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/18] tests/acceptance: Do not set the machine type
 manually
Date: Mon, 20 Jan 2020 23:00:52 +0100
Message-Id: <20200120220107.17825-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit ba21bde93 we don't need to set the machine type
manually, the one set by the ":avocado: tags=machine" will be used.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_avr6.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index 43501b26a3..784c287d0b 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -41,7 +41,6 @@ class AVR6Machine(Test):
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-        self.vm.set_machine('sample')
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
         self.vm.launch()
-- 
2.21.1


