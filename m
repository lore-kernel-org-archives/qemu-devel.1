Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83081C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C67224125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnsTMDS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C67224125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQCH-0000Bo-MJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzY-0002Eg-HN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzQ-0002FV-4u
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:59 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzO-0002As-Et
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:51 -0500
Received: by mail-pg1-f170.google.com with SMTP id b9so372666pgk.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sWy6ew470qvSaw8Jq0fvu1J9Zew3/muZE4ujCcxF/is=;
 b=EnsTMDS4kOWaWKcBX72GHXD21OPgCaLCGiBCEnZm6ZVH1/NaVhJdxhO/+2yXevRYrJ
 o6L0cBTxb9deMdkBXlsWdvwz75OtgQGgW2+ITNxlVS+KnI83i5/gTPIjcjqHhz0aXYr4
 ywHp376Ja3ylPuU7wvgOfH5R0fLkqzivN4KfOdFUuZ9iVbKtBLM+WhvivcksYGaUo3MK
 VZr0gyaIrFOhttDhiuD9gUZBei4Ufvca6lvopYgRGj8/HRvpMmnnLOksu2yFD5DCvrc0
 ZfJk6ftjtdqiHyzR2Ls9dBjNGyxkaOMVNqF8+AQWEIoX2MPTBK/spCpViNb5lZdDQN5G
 UPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sWy6ew470qvSaw8Jq0fvu1J9Zew3/muZE4ujCcxF/is=;
 b=ASeqNQdodTMeATb87QOVbLEiFadxJg2kVSMMNvo+Bt2H2Fk3B7yypLbQukCQswDIen
 kX2pEOJUli0/5vdNrWF0NPwuDuGtfmsG2eChPXmZVLcmxC6FdGmchqngfrfbMx69M59P
 M7yqlYIV0K9OAOCRgnDQERtznwsGHZbHQs7/y8+fFnv95RbxoyNTAdovWB0ZEULDX07V
 XMUjg4AhpOzBxCythhIgI+QnEeHFNkMJaE9vsi0aT1QFnVJLxuAwSoZ9fZVi4zG8/h9d
 n4x0bl/bPVkOVp8K5kI6DMtb+E6yhVH6Q2oiM/ySRJ2nLHxtUhE3eNR6EPhNz6gBHjZN
 d2IQ==
X-Gm-Message-State: APjAAAWdQ4Fm6h6gMgVPLF4CchpNZKA81h7Vq3LPqdedIwI52Cdt8Cel
 7pH7e1ssiagvzRlWI55rlMEpWvSmIOs=
X-Google-Smtp-Source: APXvYqwY1Q8DWmlLphF5lmMf2904JzS8u8ns3T0nmj3Xi2bZRnh1k6x/5tJiPXWvri0NTcVu/JnWqA==
X-Received: by 2002:a62:f243:: with SMTP id y3mr5082766pfl.146.1579737824319; 
 Wed, 22 Jan 2020 16:03:44 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 14/24] target/avr: Add section about AVR into QEMU
 documentation
Date: Wed, 22 Jan 2020 14:02:57 -1000
Message-Id: <20200123000307.11541-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.170
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39f950471f..515aacfae9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1741,6 +1741,7 @@ differences are mentioned in the following sections.
 * Microblaze System emulator::
 * SH4 System emulator::
 * Xtensa System emulator::
+* AVR System emulator::
 @end menu
 
 @node PowerPC System emulator
@@ -2514,6 +2515,56 @@ so should only be used with trusted guest OS.
 
 @c man end
 
+@node AVR System emulator
+@section AVR System emulator
+@cindex system emulation (AVR)
+
+Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based machine having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and xmega7.
+
+As for now it does not support any real MCUs. However, it does support a "sample" board for educational and testing purposes. This "sample" board hosts USART & 16 bit timer devices and it's enought to run FreeRTOS based applicaton (like this @url{https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf,,demo})
+
+Following are examples of possible usages, assuming program.elf is compiled for AVR cpu
+@itemize
+
+@item Continious non interrupted execution
+@example
+qemu-system-avr -kernel program.elf
+@end example
+
+@item Continious non interrupted execution with serial output into telnet window
+@example
+qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -nographic
+@end example
+and then in another shell
+@example
+telent localhost 5678
+@end example
+
+@item Continious non interrupted execution with serial output into stdout
+@example
+qemu-system-avr -kernel program.elf -serial stdio
+@end example
+
+@item Debugging wit GDB debugger
+@example
+qemu-system-avr -kernel program.elf -s -S
+@end example
+and then in another shell
+@example
+avr-gdb program.elf
+@end example
+and then within GDB shell
+@example
+target remote :1234
+@end example
+
+@item Print out executed instructions
+@example
+qemu-system-avr -kernel program.elf -d in_asm
+@end example
+
+@end itemize
+
 @node QEMU User space emulator
 @chapter QEMU User space emulator
 
-- 
2.20.1


