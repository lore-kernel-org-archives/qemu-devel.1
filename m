Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573CE20723
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573CE20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5WG-0003Ox-Kl
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FG-0007mJ-Ot
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:50 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FF-0008Mc-3i
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:50 -0400
Received: by mail-ej1-f65.google.com with SMTP id rk21so39684366ejb.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4M97oq1oAnOxEabEZEJ5kDDiZxswj4Hr2MVOSprbph0=;
 b=EOEhPdzstFzvmCkIP4bRyFHst9t/nNjlMnf0hR6xRPYb9Ky/9PjcXopuKkrb1LKjIZ
 zkisWykOSJA/pAgsZgdD12X0Z65vgc9i/fWpEujfedh/sRmBMxQC9jymPgaxkI8z22fL
 DtQPw5HwkUdhg9dWXB4pDhbfI5svruHGh6Prs01yl9CDfexuEX5A/iv7PcCY+BzLLfZq
 0h2ibSGDMssRqn6pWv8R2/IcvtXuCsaBVQZwQkg9ZgmnawIC7Q7k41bsAbeHkuOca4Kv
 oyeof9dkBq9qFSd4kEuTS5d65vV95b7LwLnT/780gHsWgs/1Cl07pKek26XobH9Hd3X3
 8L6Q==
X-Gm-Message-State: AOAM532eh2XchuHZnM9tY1izQNIk4kfMeOhJZQXA+pDwQ/9oduron25U
 GmqrHlJosXt/WyOSNXnH8cDVvNVz
X-Google-Smtp-Source: ABdhPJzf5c05wndNc32EQ4z/pGIaeccZKX8VMZ9t/C0sI75oAcDlyHGL5dd6zv/FQWOHPVPYnqwv4A==
X-Received: by 2002:a17:906:d116:: with SMTP id
 b22mr16184459ejz.250.1593957827554; 
 Sun, 05 Jul 2020 07:03:47 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:47 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 27/30] tests/machine-none: Add AVR support
Date: Sun,  5 Jul 2020 16:03:12 +0200
Message-Id: <20200705140315.260514-28-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.65; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add a single code line that will automatically provide 'machine none'
test.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 tests/qtest/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 8b7abea8af..57107f1aec 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.26.2


