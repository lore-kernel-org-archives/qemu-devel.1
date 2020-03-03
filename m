Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C482C21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LROWYOLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C482C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vmx-0006Zy-Um
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkA-0000wQ-5B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vk7-00046t-S8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:05 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:38463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vk6-00046V-KP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:02 -0500
Received: by mail-pf1-x42f.google.com with SMTP id q9so559368pfs.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=B0OixvxDRun+czMvNrLEKq3Xb6qPIsVdgs0f+iZ/N/w=;
 b=LROWYOLHx5phwHtn15nNwfW3SEWM2Kod68jrhN86Lxio1eWRgbh4IOB8C+3c5qYJa3
 lk7YcGC+lHXhqXQ9VZj215HGmFSFlimvWGN9s/SJV4DlScXScMEf84Qoe1gVXmM08Eq8
 So47E9QmgEJWUMERNKsvHapJRduwL8+MOW8PGeT7K4M5aVMnw3Yu7nlIrces41Q4JRnt
 p6v26/U2OnBICiFHX7X7nUgnR1PzaHTFSi7Tb+i7agwJTuK6x7wuPP/zoJb4gXv1rm4j
 Uc1JipGc5apj7XtFuf1UA3Bh5scYw520x4dnoqmqe505IxCHA3sllC7zpBHLUqlBna8I
 IuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=B0OixvxDRun+czMvNrLEKq3Xb6qPIsVdgs0f+iZ/N/w=;
 b=f5ME/JramSWRctqrTyRz90Uq3ZQ6VUyZPS9eb97JrjeH+sEm6jlG5GmV6FPqMAXfoz
 +ixaWpj9H+3NPdfnqdfPI6zZXVrtNk378HhYoW7zMVpscM1MytnEI1XGm6Y/txXN3PiN
 io6y20zWd/ssTUVO247SUsSnqKKo3KO892eEdEOHdCXHZfpIaiqPNA0nCJlKLFLIVcvL
 2W1vTKlhPs7VgDkgg73HK6XyimgUW5pTTnQ9O77AJ7O/GN6lgYDnOlWzHtJaQSnHFpRy
 OKQqxM9KKGegsApKGD0MDlS8MB5l3kZ511TzClMZkxm1d5cFey4kYpKuG67mRzdE6q1Q
 u06g==
X-Gm-Message-State: ANhLgQ1bVodheaffswCu22U1dBW1b9FKk1d/Dzemg3scAlkVQM4Lrycs
 kdGT64C324DHJW7xjhLaF+yyMA==
X-Google-Smtp-Source: ADFU+vsllffNd3sCuj8cQAWV9aVjzlRGaKxS/MMKIeGmcqQW/QttVPy3qPeo4mmWy83HqfjrVY3RoQ==
X-Received: by 2002:a63:1404:: with SMTP id u4mr522050pgl.172.1583196541538;
 Mon, 02 Mar 2020 16:49:01 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id g20sm348025pjv.20.2020.03.02.16.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:00 -0800 (PST)
Subject: [PULL 02/38] target/riscv: Add the Hypervisor extension
Date: Mon,  2 Mar 2020 16:48:12 -0800
Message-Id: <20200303004848.136788-3-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 95de9e58a2..010125efd6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -67,6 +67,7 @@
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
+#define RVH RV('H')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
-- 
2.25.0.265.gbab2e86ba0-goog


