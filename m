Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93735C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C22221569
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkmagZ0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C22221569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia8ya-0007Qi-4B
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x4-0005zl-2R
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x2-00047m-Td
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x2-00044l-KD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id a131so4939939wme.5
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xrRSWLQNVTbtusHhRaP5D+CbJqxAFGT8ZkvcmL+Ufpk=;
 b=HkmagZ0t+W4beS0j/E/+Ss0p1P6BCyuKahwNMIF2i8FZYZyIaOWN9AvyZGYS5x1Puz
 vOL6K7rAZa5sY+EwNygtBG2Zetlr6XmgqLg9fV40PM6C8FmOBBsstIMWIHDcdCz0yq0T
 g4kqCUbP75Znx9gc507WPmuu8tjnmcY1LUWmVQUGNK5KXwuhI8vdL6V10dFIUwq+nSno
 pyK+aDT72M8fmESKB7f6nduYuDcmp/k/utv6u35S9xxY/Q23ml6seQhIWCfhALBXSltX
 GOnNJmZdOh1/NFyCn8vG1IE7SL+V1L5o1iux0rDRWCtdGd/utY7SsD+xLHi07v3QuivF
 LhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xrRSWLQNVTbtusHhRaP5D+CbJqxAFGT8ZkvcmL+Ufpk=;
 b=D+I3Itnrhdbn7uvq9c4LSxEa8PTapcrxDua0A4MPPUMQ9dAjD8wF/shwRLlTcXQMBz
 zJ0SErXIJ9LoVSqmL/dkTTr09AZ254GAE5i3iMFilIbIEf9XRj4XFR2TBtJxvbMBBJhI
 jB+phqtow4KMf/NDyoNQ2zOXUW0QHCz9eG2SxG/p9vPxgETHSW2Ag943sOBNe1v7h86r
 G47byyNUkeOEN52hjbF3nxiCDkKc54ILDc4nikLYG5ZFiOq+2GOkcN1Yz19GzxKgmo4/
 Pg7X2/wJHbcVvjhx7dYA5QF18K5I5L1ccRZrF/HTgjEdjszZl6jIMePJIJn07K96IqiX
 5ONQ==
X-Gm-Message-State: APjAAAUdC7vSqHBkGPEr5BSHD8QN8uyAad9qAoLIzuKctUtMyL3KkBgK
 joNGhbUvlR6a3bjxfsroMQDAMg0n
X-Google-Smtp-Source: APXvYqwL4VLoeJKvhiI6zGa25OKaF0uHG+2nKuwlhIAZSptFcOKOjyb/THc3htxoXSScWs7v0DhdlA==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr7184688wmf.10.1574905834936; 
 Wed, 27 Nov 2019 17:50:34 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [NOTFORMERGE PATCH 01/10] hw/avr: Kludge to fix build failure
Date: Thu, 28 Nov 2019 02:50:21 +0100
Message-Id: <20191128015030.27543-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Incomplete rename between Michael v36/v37

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/avr_usart.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 8e9ee88bbd..87f3f54cf8 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -94,4 +94,6 @@ typedef struct {
     qemu_irq dre_irq;
 } AVRUsartState;
 
+typedef AVRUsartState AvrUsartState;
+
 #endif /* HW_AVR_USART_H */
-- 
2.21.0


