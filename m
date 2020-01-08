Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27FC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D982620848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcOjsdsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D982620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Zs-0003M0-EI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IL-0003px-N1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IJ-00030f-P4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:09 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2II-0002yB-KK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:06 -0500
Received: by mail-pf1-x42f.google.com with SMTP id n9so885712pff.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3sJKl8Kqo9iJWsY7dUcwVH9r5rdr0o0t2wlvfjyFaBQ=;
 b=NcOjsdsDpeQfvoCjMr8B29U9jayzfw91l1xlVezz25ShU7yj7exQsrnhnjQmOK1amy
 K+7cHn2L4oHj0fqDf3Y5I9949eFj7lnqr6GgmJiZ3WUzHXjtZHzjVoGr3/bQ5tZCpNDj
 zzIyA+7gfvjhrp3U+Q8i/uFhSOldfZ7S+fThI+/cMMPkCn2EosShAohzRRjdUVrRBp4Z
 YISac+NfQsD/JaUyman56PinZXZaLyGWw2OTpbBBkHG3m/+yHkkR7UpP2AMQvViv/h6n
 7P5EmHEMk4j+PLzbze5lPxjKBSV24BFh37llcis1VqTfPVxCfD67P3KxWpfBWNGPRXV1
 lVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3sJKl8Kqo9iJWsY7dUcwVH9r5rdr0o0t2wlvfjyFaBQ=;
 b=PSRraMxlR2MniM8LFqfEy7UfmH+KR3v3JzdHS3FQBkPV2cB0F2++ByYaLMPl9WlvJh
 oaaoAS7gbn3hMKGnBccOs5Y6HXo7Q5uUUhjfsWeWZ0eRAStR83jEFqDlI/Pl1G+DdSAI
 eTXk74gI2DHave4S7+mvOZ0QIxBW5ll65YPZDewL1BYDrFLRj2mhQa51UZINnIjvZGep
 QBZytEz/pG1bmI3HbWwlPTLjeuOUY7gIJJhbkEDxujidrB7f7qxCLad3WCMpUQ/NNWuX
 fVCN+Y1u3JLN02pJYN0OJKXt8MlDvvmMcRXnBj61RS++a5BqbqlKI5QfkZU63bKpBLFl
 qVjA==
X-Gm-Message-State: APjAAAUwasHoBTTBgdlQTpC6E2ZnW6DBJOD17BiVvEtp7oP4QiOGfhu1
 TzQIbHBM/DxyJOc+pPrEj3PvEdMWMmBLsA==
X-Google-Smtp-Source: APXvYqwEvbSPTpT0V/2oPLQjgJBzORh5/zAh5+/7oYIKEOf6ZrHCAX+jwFpD6xG92dTXpsjv/ScChQ==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr2934491pfp.0.1578455165520;
 Tue, 07 Jan 2020 19:46:05 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] target/arm: Include tcg.h in sve_helper.c
Date: Wed,  8 Jan 2020 14:44:54 +1100
Message-Id: <20200108034523.17349-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Cc: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fc0c1755d2..83cc7f5bb5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "tcg.h"
 
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
-- 
2.20.1


