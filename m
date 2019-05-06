Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8BCC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3152082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtmpCYW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3152082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhhi-0004Ep-5B
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:47:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVO-0001F1-0I
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVK-0001St-P7
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVK-0001RD-HR
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:18 -0400
Received: by mail-pf1-x443.google.com with SMTP id 13so6822231pfw.9
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PvlwPcZPY/FWFYh3k49LzzqKgqvSGwd1QF+0Yp8Ixq4=;
	b=FtmpCYW2i5ojok4k2vEbCXHVQi8yP6K+LoxD05vBTGP6vq75Rr8lHdm28xNtI1ZI0u
	a0G9OW/fI7O5IQuKSpA3guGEmMDdUH21sF11J4eRhjs76Yrp55Roy25FjdjbYRv0CWo5
	JFo8CizPG2FVHATM80gGMAmsFljmdbsAhXj9NON++vRlBEBYmkvrfP/XOCUp3cBZpTD1
	GcX4okn94qath5pIaWbNh7r09RU+zJj8m23PaCQpKDpFEzrRGw71AjjBSnje0eXiEdvC
	773e4TxrfZR5ltJqobbxmuSo3we4hj1v6IlxPLzKEp9qxVW0YO6p6s7G9BkfyaLIBT08
	muAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PvlwPcZPY/FWFYh3k49LzzqKgqvSGwd1QF+0Yp8Ixq4=;
	b=o2BWax92tK7qkT120zorgOalvVrKxDe6ls/Uzi6+rGxveGuZ+umA/Wsbr6zbUWcfEy
	nSlBmR5NXvSm0jR8hoG2MHQkXzQcpNEtOUtzNBXI/C13qb8cDREYmz6B0YfsBV1qfXyv
	QzZph5eLil0MHAZJtujBN9TlQC9d+dXrGImX/SXZ59/VWGO7YYPxcldQlNFwQXEjOW00
	oh1pX8ec3PaX6vyZs5IEiTpveMJd+V5ug1aQqQp7fZx3NsPJOD5X+xporRoZyTWoUPKb
	NBAcUBMN+6SWeHYamMC63BZjx399dh9qkU3o6aHVSvTLFAKp/l1ikrleCMb4k8lHI4Fd
	n6dw==
X-Gm-Message-State: APjAAAXYYkRcPkDER5Mwtgtr0iIDlgcAnO5rlWuaWyEs1tkGn0k35j8l
	U5SGCpv7uxQkFuRu61AuCq7IdQJb5OQ=
X-Google-Smtp-Source: APXvYqwyglYmLflS5AuzZ7Q0XBNsgS9lDw//MGo0iw6KzYXydZvhXu2jG6uUb9t27DyHW17B3tee8A==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr2434449pfn.213.1557164056133; 
	Mon, 06 May 2019 10:34:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:46 -0700
Message-Id: <20190506173353.32206-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 17/24] aspeed/scu: Use
 qemu_guest_getrandom_nofail
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of rolling our own error handling locally.

Cc: qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/aspeed_scu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c8217740ef..ab1e18ed4b 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 #include "trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
@@ -157,14 +157,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
 
 static uint32_t aspeed_scu_get_random(void)
 {
-    Error *err = NULL;
     uint32_t num;
-
-    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
-        error_report_err(err);
-        exit(1);
-    }
-
+    qemu_guest_getrandom_nofail(&num, sizeof(num));
     return num;
 }
 
-- 
2.17.1


