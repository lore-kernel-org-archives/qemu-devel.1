Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A45FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3BB20752
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLp7vdgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3BB20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAfT-0001RP-UN
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAac-0000ad-TA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAab-0003TW-HG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAab-0003LB-8T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id t13so15202180wmi.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uJezzTDs3XobR7ONkeF8BKlCK+ZTZQttyc6HsBQx6+8=;
 b=mLp7vdgquFY3QNk1KOtLMNSKRH7EzMQlkUaN2McgyOalSkS+KJc6SaO0oR98fGCQzY
 I5JpT/yxVj3VYvGkNJMNK7bsdfVDb6JM73fRxoKVr3Eo8TbGoVP4lT+EdKvxsABdWaNh
 cCsGgopQEB7GT7j0Efr1867i5AN9Ap4y+HqQwWdkk5lkMhE2hb6rNRKkZS93jJFeyF2R
 T244CWZnGm4bbP5lAnsMO/2ZofqrFIVk1Ihe5Wflp25x5BQarm+69zVrDo5HOKZcXOeT
 06ZMjdzQysLUF36kcYTWm7Nv7RN0K+6+mh6iL18Ib9L/wZt0bAobUR1xZkNWuyJCZowX
 Km4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uJezzTDs3XobR7ONkeF8BKlCK+ZTZQttyc6HsBQx6+8=;
 b=qEYauY7/7n/gC1j2MfCRzxuOikA1jgoBRo8GZb1+EJyaMNzP+88UUA4zbTU6ohb5Js
 sPQOWN+aG/aN366I8PvJB0kXUuW85R4TEAwSKsh5A0FAOsEpMqvG2Tc5grD3Xl1TInJO
 TqEEAaAkIkQl8VG016dJd8TIN2HVIyBz8tNtop3KcGzyrfDMZZVQYEuZVoB+dW/kVV6Z
 ojic68TkQ/lh3CAI7AVciIjZvy7jtxnTz8/5WWrbOtg+mmQuWHuqm3LHBkRFLl7eeX+S
 8pOyZTaHDIsG3fLNo0n/nR2vnGJDWcAzdCpg05mTedtJ6r1oWe6glTLo2CjDkQKsOtJV
 QBfg==
X-Gm-Message-State: ANhLgQ1dxns75dDaI94TpG6XGDO0Xmz9zcMggaOO15A1d2/ul3o9siOg
 8BRvPy60CYiiJBo0W9Btf8LpfnVVnvQoRA==
X-Google-Smtp-Source: ADFU+vuImWy916hIC16u5l3FZrAGLs/EdluiB1K++vtpL4WBRXAMzRtfcm0H3QSxTvZWwuVO+357sg==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr4849938wmi.120.1584445252054; 
 Tue, 17 Mar 2020 04:40:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] m25p80: Improve command handling for unsupported commands
Date: Tue, 17 Mar 2020 11:40:37 +0000
Message-Id: <20200317114039.26914-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

Whenever an unsupported command is encountered, the current code
interprets each transferred byte as new command. Most of the time, those
'commands' are interpreted as new unknown commands. However, in rare
cases, it may be that for example address or length information
passed with the original command is by itself a valid command.
If that happens, the state machine may get completely confused and,
worst case, start writing data into the flash or even erase it.

To avoid the problem, transition into STATE_READING_DATA and keep
sending a value of 0 until the chip is deselected after encountering
an unsupported command.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 53bf63856f5..82270884416 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1161,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         s->quad_enable = false;
         break;
     default:
+        s->pos = 0;
+        s->len = 1;
+        s->state = STATE_READING_DATA;
+        s->data_read_loop = true;
+        s->data[0] = 0;
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", value);
         break;
     }
-- 
2.20.1


