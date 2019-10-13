Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27707C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F53206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIb76VCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F53206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmOe-0003Zp-ED
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJF-0006Yu-HC
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJE-0000q3-HS
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:53 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:37883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJE-0000pk-CS
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id p1so8931858pgi.4
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sv1evknX8Peb+IcRUAjULJcxFSuTafe0C9v6FcPm5oM=;
 b=uIb76VCsl1soWpb1qxPnZH+6sTOZPftCWQMLh9nPBYuZkqHvfNbsK26XqWMMY5PTaA
 fuuepYcnSazkcApfmBUS2qxtEQrR5eHP+Dslv1c49alGf+QIjxkpCT08ver32at1pbOW
 6mvwsYUhCh9uZH2ujTgiJkGZB74YNJgl7vsbv2A91lWfLSBBc03r9TA+nEflsGdgLDuk
 oVoTlvajf3pmo+I5IYHZS/5qwPZek7OE6U+0Q5FCPofzi7AlN0IEk2YDczsxbhzQMkjO
 T0JgjP4Sdx7CUUz20hMT8w8ofQs53+CNuAtBG7/kHurHRQfvJzmYr+/AeiUIF6i1TnaH
 zB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sv1evknX8Peb+IcRUAjULJcxFSuTafe0C9v6FcPm5oM=;
 b=CLve6UlgyLNgJcvCq5thX5jqiUfkEb8i+afymgTRWBsrr6W4LEKe+rzelaEvP7lH5c
 K4llJEMZyzMfL3iTbbJ7jheFTPslI8A6TkF2Ba2f/mW4SA/L7tWtQk2OntJ0ifzkMbKc
 yoMlsjtLaNXThyhNTT5j2SOBaWCL9XKogWuqf30Pd0A/z/qt8IAIiWAsu6uNScS8qY0T
 4IJSqrZdGJKNjXp2oEYw8rYLamORNWtNIS5Ulces2JDHUgY7UsVZjmdmLfEhLMqAeDB5
 65Crepp2euNS6auFTbjRm9R0J6/ZpuFlQR0EagVZqQMbIbDJK2GzvlPsyLYDXqMXgNFY
 N+0w==
X-Gm-Message-State: APjAAAVohbMQs4ITTK4SYy4sEBJFH7bdmXQ9ffoUdfJx4VPPRMFJQ15h
 mMr2sjq8XL2xMHgJcDDVdKiy8C4G0ug=
X-Google-Smtp-Source: APXvYqzeDLoX4r6EeapVf3iNoQRK1zJNKKLJi87zK7mVWBwbpgaUOvkopUjJb66al+DJxFkLdLoTGA==
X-Received: by 2002:a17:90a:fd83:: with SMTP id
 cx3mr32280029pjb.64.1571005551124; 
 Sun, 13 Oct 2019 15:25:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
Date: Sun, 13 Oct 2019 15:25:24 -0700
Message-Id: <20191013222544.3679-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce macros VRT(), VRA(), VRB(), VRC() used for encoding
elements of Altivec instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8dc5455600..4aad5d2b36 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -473,6 +473,11 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define MB64(b) ((b)<<5)
 #define FXM(b) (1 << (19 - (b)))
 
+#define VRT(r)  (((r) & 31) << 21)
+#define VRA(r)  (((r) & 31) << 16)
+#define VRB(r)  (((r) & 31) << 11)
+#define VRC(r)  (((r) & 31) <<  6)
+
 #define LK    1
 
 #define TAB(t, a, b) (RT(t) | RA(a) | RB(b))
-- 
2.17.1


