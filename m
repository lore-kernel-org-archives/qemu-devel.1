Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899BBC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D052072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulLoCe3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D052072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgbs-0002v9-F8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUt-0002CZ-Ju
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUs-0001Cg-7g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgUs-0001BS-1Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:42 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so3783497wrn.7
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VYm/XIqEVgZC6h11WJ3979IWXTcW8fTDJ44bzexd108=;
 b=ulLoCe3N4dhpcwrDuuGTHpnGdtdb8f/O1YHNj+jqJNhTSUd8R72ym4tXo2u7pvV2+B
 xPGtC7KRkh2ql4n8/asYZPIn2YocqQIC7eXJQrGoJTJIzR5bUgAKr+JKlZtDGkM5vtHm
 oofB943Ygiq17RZc641oPYaJAvrtzzF9ayWP15EBbcXhF8KOgDR1s+qjvvRd5kWouC6M
 Fwgbp+gfX+p17UvCIBmURyMgYUi48cdVjuSesNz6EE4HhBxaolTbsRTZqSRakjHDfE93
 2sAxpri6V6xn102r70vyeO1SXRAfWZeW88R/DmV4ONSJoQVuSBdzSkXWiP9eJ8cs8BYn
 kd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VYm/XIqEVgZC6h11WJ3979IWXTcW8fTDJ44bzexd108=;
 b=D+0Sf7dAZivOmsv6PVQ1kpOROpCjas/RJhNkBipk0I8n04Lrb4GV1CjvQo4qDFTEIe
 pBxyISUG8SXr6oxr6N74Z9tcXY9Cy7wZdXgA4kUFBgvKFF3IejlQlyixuvzztzra86yO
 bAqvljqwMI16h8fVcQJ8TDHcrbHCXJHch8ZpHuIlZQ4jfuei03v6Ze463KHGhMCYuvXS
 KATwmJl9zp5SJhe4E+d5EKSIG426iIwP2bS0x4RhY37CMfCIHzv7S2Dw/GjEIlNRrPa2
 CK4DJaGqBF3tcoLWjPpUA7icc8oNNdtAmyu2GpyMXFaSWGLkGAHHZKKsIVT7qLhD380w
 m2yw==
X-Gm-Message-State: APjAAAUmwv0hovrIoNzheliWoRsL5MpGxwwMRKBlGmiq+9a9P7JEHD8I
 3lqxZ5uTE8eXi1XV8B4mY0YTsNu7QbFeHg==
X-Google-Smtp-Source: APXvYqzHRNaUTXQwJ+ncEbtxNp572WAaV3asLvATAheGadgPtdBsMwKntofRzVXCDHePUix8hGMFpw==
X-Received: by 2002:adf:f605:: with SMTP id t5mr4926845wrp.282.1576703080691; 
 Wed, 18 Dec 2019 13:04:40 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.04.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:40 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 18/22] target/avr: Add machine none test
Date: Wed, 18 Dec 2019 23:03:25 +0200
Message-Id: <20191218210329.1960-19-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.17.2 (Apple Git-113)


