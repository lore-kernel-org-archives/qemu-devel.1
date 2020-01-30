Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C702CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0C920707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADsT3cDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0C920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCVM-0006tY-Mp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTj-0005Cu-I3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTi-0002mO-Iz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTi-0002lY-CB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id z3so4814441wru.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mMMzZ+kJqObYT5iMYIjH237jW2O9OAivtR4JI0BwSss=;
 b=ADsT3cDW5tT4g3EPfv3xc/Ip4oaFxBLfWD1MrLdSjEZ4dpecv/y+cFmr86s5ONopJb
 WIahDVtQY1DN8cVJBaJYOwlNMmQstokvI2oSGsSo1OTK93YLuHhUKii7wcwq48Apt5/D
 zjoLFeiTKb796J4WS3kJi4+Z4v12Lws2vOIYFx8ZZ1y/sqJDtI63U9rlaniYh5aEZ/CO
 iso9jwzB5eBFWHvvjEZ7QGZ7/v6iMELM2hrPi1m+GKeicZEC4OxWFhSEUs7MP13AXR6v
 ssU4ekvcfdOvghjx3tIr3rCGRFaN3+SShj9NZG2QDe+n+dAHPauLIInM51CW/2jUpO07
 emUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mMMzZ+kJqObYT5iMYIjH237jW2O9OAivtR4JI0BwSss=;
 b=n48JXQmvpzHbeRqQTx/jwU6Rw++z+rTCOU/4Jax/At3100pciTBFqtgZz8G1KHHal3
 6+BWnpPu92XrGWy0esYLIDWvXcRnLJidnLV8WQKdCb90QRHWoQh/pOoelqODMvzVohbA
 /FDw6v68CwEIHPmcpvww5BQ9UcGnV2QbByb71KT5Jn6TLGtMdHQqVAQAfVtWZS5EFMgN
 +JJMCiNEsIGuk8KKvVYStInWmWSFILYmwTQtpPcJXoj7nYTJg7ZgfXM2RkJrYc5epQ2u
 6rbGVOFMI/+Q0bC8o+KoDfbDsUjW0ntr05j1j+sOXj/nHSOwNZnaOrJnogqoJgIrFnYp
 Kyqw==
X-Gm-Message-State: APjAAAV2NtdHep1VfJcYoQJuWKFzys3xyxGbA0KBpmWw4BBslxdquqTj
 vXv9+0Et40w0iYXQTQVVsE4DKHBxlaQFew==
X-Google-Smtp-Source: APXvYqyLPpIASvAP9AwAIOf9Rm/Z/Jc/3Oy2SPfKkqCBZvUFS9X6hRKrqdoz7P+8wvHSqc5DdXieyg==
X-Received: by 2002:adf:81e3:: with SMTP id 90mr6181385wra.23.1580400937095;
 Thu, 30 Jan 2020 08:15:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] hw/core/or-irq: Fix incorrect assert forbidding
 num-lines == MAX_OR_LINES
Date: Thu, 30 Jan 2020 16:15:08 +0000
Message-Id: <20200130161533.8180-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

The num-lines property of the TYPE_OR_GATE device sets the number
of input lines it has. An assert() in or_irq_realize() restricts
this to the maximum supported by the implementation. However we
got the condition in the assert wrong: it should be using <=,
because num-lines == MAX_OR_LINES is permitted, and means that
all entries from 0 to MAX_OR_LINES-1 in the s->levels[] array
are used.

We didn't notice this previously because no user has so far
needed that many input lines.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200120142235.10432-1-peter.maydell@linaro.org
---
 hw/core/or-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 4bbdbcb321b..d8f3754e967 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -58,7 +58,7 @@ static void or_irq_realize(DeviceState *dev, Error **errp)
 {
     qemu_or_irq *s = OR_IRQ(dev);
 
-    assert(s->num_lines < MAX_OR_LINES);
+    assert(s->num_lines <= MAX_OR_LINES);
 
     qdev_init_gpio_in(dev, or_irq_handler, s->num_lines);
 }
-- 
2.20.1


