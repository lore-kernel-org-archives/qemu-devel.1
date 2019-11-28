Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63875C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F338215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTbovwGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F338215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia913-0002Ba-8z
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x6-000604-0h
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x5-0004Cs-2o
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x4-0004Ah-T3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:39 -0500
Received: by mail-wm1-x342.google.com with SMTP id j18so6198824wmk.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nkiNRcAB3EX8YKP0tQWkOyykB73B9upJcB4fmS8DPoY=;
 b=QTbovwGUVf6V5BMmh853yEY9NnGOtjoK+iVN5Vj+m9Cx/2LWgF2Bzt2vXJ//o3BtPu
 9vD2FU5CWaB8cuB5TFOI+EgMn8XK8/A8XgFLeZQIJn9ZhFD0HNJbU0vhsZCv3QVlMevP
 Fjx950nB9QDaotwWn7SusSQ81bgTFrKVOnDXUPTtwbRkJXz3+v3wqAwGHumk62Y7iLtP
 9s/KlCBfu0gLKWe5J4m3pMFEQnuSiHyqcGn/T70K056gmWvgTcYMN0kABb6/2fsP19bf
 30HoMBjmViqdmGMvWK7wlGJfT8x7M/5ErOqnbCgDipyYs1tb2aBZqrZ7fRfAc5YgXK3G
 20WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nkiNRcAB3EX8YKP0tQWkOyykB73B9upJcB4fmS8DPoY=;
 b=KUrblnanumX6G66o4p3trXI9TrNj7Z2J1qDWfcYlZ5O/3YudrsC24jaSGorliYHkVa
 QOigCGyLqCOzOlXwwwAsOkhsWPWFYodGr6OWKAvhXQp6P+lHhjI9+FCpjEzOXmkYpICr
 R440tEocKZnvlT7xweoTeHOVnkn9PSqYBfILj3m5CIFtDSSF0yC7Ow8NxYCNdKMBYwV5
 nlLNNlmwIhZMuDGv4s/T5av11TDdl3CNCZgKuAFNXr/f7lMHTs5uRrTq67N3wFtit47Z
 /4gnhzTVC3k5tOPD3GUDJM7KM6OGSAMY+f8i6j/3yqywQE+xelzP2vtliRJdZMfWMZAy
 w3NA==
X-Gm-Message-State: APjAAAWdMRRmiRUP14HXQrin//6CVyXUlAfiFY3lV0udhL/HvJ44y2kf
 gyc7mE/krJziJdxx4F5rMprwi5qj
X-Google-Smtp-Source: APXvYqyzPkZ7OeQaxO22F3HKGwFNm+0WCCsdpTHgf9jGgPueBRm8YE/Tj/Y1nZu6g+nxz47yD+7dhQ==
X-Received: by 2002:a1c:984f:: with SMTP id a76mr7405710wme.64.1574905837637; 
 Wed, 27 Nov 2019 17:50:37 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 03/10] target/avr: Add missing definitions
Date: Thu, 28 Nov 2019 02:50:23 +0100
Message-Id: <20191128015030.27543-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a3e615a1eb..c1448a865f 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -26,6 +26,8 @@
 
 #define TCG_GUEST_DEFAULT_MO 0
 
+#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_AVR_CPU
 
 /*
-- 
2.21.0


