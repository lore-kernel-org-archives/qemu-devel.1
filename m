Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D75CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC4421D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="G2msWkse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC4421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkrq-0007Z8-EE
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknK-00019X-VO; Fri, 25 Sep 2020 06:17:38 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknJ-0007SE-7j; Fri, 25 Sep 2020 06:17:38 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id AAAA6C60F22;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOuCNbOOvSsStZNfbQT6hnxWhxzA58znlB/MmjZ2y5Y=;
 b=G2msWksehXz8+B/Ovvn/E5LRViL4pvyLW1sALYAcTxj/PZimXJtVomTYV9Soz80kz0jWpl
 99USxdF3nWyh7ZQbcdPxoP0X6sPmeNkiDtJBAt2Iygu17s62FX2v7wMxk0TIJEhPc41y/e
 hhTG7Rhr5hI1f683WUkbsLJoYChY87cpEcAtM/xn5kR3rtJM/FYSmBVSwNCKoRszooNlBH
 7mFE+lUzE4sRlAIvS0HGD6NOd+fkjASL3r48PXvcU4jhaRSu1Gt48zkzuW0FjopmBN4Gtn
 qd/rw6q2AWoOWVlVAdo38mcs4Xkw8LeU3eDLDJuqnFvlJcbNqnXGlzldoR0Luw==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/14] hw/misc/bcm2835_cprman: implement clock mux behaviour
Date: Fri, 25 Sep 2020 12:17:27 +0200
Message-Id: <20200925101731.2159827-11-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOuCNbOOvSsStZNfbQT6hnxWhxzA58znlB/MmjZ2y5Y=;
 b=bo65Qd9oZX9y5njzIvy/q/o7FobEiPuAX8wXitUrkGEQNS11R9Hf6bO8kxDEqAV3nAhRTB
 6T2fnpDuWcg9KJZjMp8Y81UZKyK5A2aOaHs8QIhWhuDshZOlTe3wR5yAmH7IMBjmbdGm5d
 29ejZSqzmVV4XrEInL/0SvDHmiRD/1O2hdiLuWYNEOsVkcxVE+7qdDggQBSKfGQaAbrYuX
 QDJ8HbLKkvhHR0eVZUBfLSyAdGi9vkFvsCusS+wrs4wqxIZ1e9VFjOBdI5TbabFNKQfDVu
 yqdHMAUbUW5c/ZSeKgXOsJ9sPo4cexS95VKaZtkw3rcg2Frgzy0WZtBoL+idPQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=GGDkSOnTdXoBFQ9yRk9piF5O1J/EAg7hbZwHfCxkXhQ+b1DbGL3OaiyGSm/2d0+YYkfAHJuSpw1JXVU6hlyXxHVnDYccaxmEqWf314fihXJp5mkS5meMyGmcDpUC0Ukx79Jo5uOHCbG1J1Cukf7T2Css9BhP6MBgfW34cbtNFkmKXAcK5MHnDaOdMpXeTdppk/0xFfYb50Iao6rARHpMqZkEkjBFNyCro5h7dDjDNw82qm+tYSa+78QR/Q2xKNfYSjWXVJz7yrLC0Ht0SDL5Hml8pjTf7NzGHdB8JXyHjBcVQrv/9juVniTOPhFjEhRytrj2Pi7ibyDCWkRbLpoGvw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A clock mux can be configured to select one of its 10 sources through
the cm_ctl register. It also embeds yet another clock divider, composed
of an integer part and a fractionnal part. The number of bits of each
part is mux dependant.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/misc/bcm2835_cprman.c | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 8df2db0fd9..75bc11939b 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -229,19 +229,60 @@ static const TypeInfo cprman_pll_channel_info = {
 };
 
 
 /* clock mux */
 
+static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
+{
+    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
+}
+
 static void clock_mux_update(CprmanClockMuxState *mux)
 {
-    clock_update(mux->out, 0);
+    uint64_t freq, div;
+    uint32_t src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
+    bool enabled = clock_mux_is_enabled(mux);
+
+    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
+
+    if (!enabled) {
+        clock_update(mux->out, 0);
+        return;
+    }
+
+    freq = clock_get_hz(mux->srcs[src]);
+
+    if (mux->int_bits == 0 && mux->frac_bits == 0) {
+        clock_update_hz(mux->out, freq);
+        return;
+    }
+
+    /*
+     * The divider has an integer and a fractional part. The size of each part
+     * varies with the muxes (int_bits and frac_bits). Both parts are
+     * concatenated, with the integer part always starting at bit 12.
+     */
+    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
+    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;
+
+    freq = (freq << mux->frac_bits) / div;
+
+    clock_update_hz(mux->out, freq);
 }
 
 static void clock_mux_src_update(void *opaque)
 {
     CprmanClockMuxState **backref = opaque;
     CprmanClockMuxState *s = *backref;
+    CprmanClockMuxSource src = backref - s->backref;
+    uint32_t current_src;
+
+    current_src = FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC);
+
+    if (current_src != src) {
+        return;
+    }
 
     clock_mux_update(s);
 }
 
 static void clock_mux_init(Object *obj)
-- 
2.28.0


