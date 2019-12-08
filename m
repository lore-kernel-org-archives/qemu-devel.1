Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F50C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FCB205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7exxtb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FCB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1o0-0007qR-LF
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0002Mj-BD
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003NQ-DD
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003Eg-Vt
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id c20so11028159wmb.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VYm/XIqEVgZC6h11WJ3979IWXTcW8fTDJ44bzexd108=;
 b=p7exxtb622H3AWMBsjcjtxW4TQq4bRx1VwkV/bFadnxcEux4FF7DBOYsrjDirBeh6q
 Bq6PJmRzFL0IVNMJtjvJHcFiGGeGcHnD8LBJXSCyVBfDJr9LO4QzWoghI668nbbYROBf
 F7rKh2owszE9pVk0bfXRsE0iut55HqClTk3vYZ83hVY0cRTMhofJ6wgEY+t6b8abBEbO
 xi3dHpLFYmeVbIXPa8U5HhEozOMlkts3Kfe1FFM90U/3l+WiPQKvnI1EYJ6QKMF/dAp3
 LE1WyKjeaKHu3w7EYzq9z6Ku+fS0pTFliVOsKXAvd/aQhJ05bsY/Le+m3UiN9uGt6fEt
 mEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VYm/XIqEVgZC6h11WJ3979IWXTcW8fTDJ44bzexd108=;
 b=t1b/fDuV0vKSWu22aTceaf8496LxqVPyU4mCpAGTrbi8jx2SW0PhG5SCUX/0cJCTTo
 2Nl6ttT+bDVogO+NHEl5TCSms1QwPNhlPqoNcY9NuZPgQPwqLPbcy0PtKFYumQEL8moJ
 DY9TkEFAJZfCDc3bvUnojjRDC7vukrXnn/6sB9cpg0xS/osJRTqTgj5KgTF6Q3LqejKo
 HBRrX0Ea31HRo3/DODkPvpicMD6aMC/v5971eI1KaFtMrtHBT0Txa9N1CJByzw/1tZFp
 H9f5C1lnRiUi9Ogxa4YLeL07do+jVxJjukpW8BuM2VMKW8QBz3XACfUY3rjipcSQVr4r
 +Y8g==
X-Gm-Message-State: APjAAAUbK0cHBgZtj+48zahB061vwFALPKKB8UgQe7ADDeUWzbCyzFux
 l6thrTKjqACHx9B0cQqT0UCoJkkX+QSiBEo/
X-Google-Smtp-Source: APXvYqyT1Cm/VTB/giL9GCsE0pjsH1+62TpeADTvpziEJMl2LU6SrLkXecKZpWxto2OHWNynewo4KQ==
X-Received: by 2002:a05:600c:24ce:: with SMTP id
 14mr1967163wmu.122.1575830425110; 
 Sun, 08 Dec 2019 10:40:25 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:24 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 18/22] target/avr: Add machine none test
Date: Sun,  8 Dec 2019 20:39:18 +0200
Message-Id: <20191208183922.13757-19-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


