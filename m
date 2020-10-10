Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743F322284
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="hShqiR5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743F322284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFWY-0006LD-Jv
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNM-0001uo-Oj; Sat, 10 Oct 2020 09:57:32 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNK-0004KF-Qp; Sat, 10 Oct 2020 09:57:32 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id BBC75C6041D;
 Sat, 10 Oct 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338224;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOcrHBo1jCCV2hHTLBCYiLIpeFKC44mDRpVy2DOXJo0=;
 b=hShqiR5yzsRDOUcA98E6fOIbziu3sgLPTblZOUM8hWWdoqlFOItny/5l1fOe71Cgyk1f6e
 6IPZCylFSIK8XklqwkYKTVPUuppf9F9XpVpidXtLsmPvE4SOgYjEuCaczflB1lqOhxPdmQ
 C+6f+ZitOfdtLOz7RRlVttrhHgbkFzTwQ4MNJv2/rybwLBsNuXe9UdmXPbuCHLedpggPdp
 P7GzpZwXAJqKJftl4Vjhp5SNH57GNiqcIug95cBno5kRbLK6I55n+k37w05uBLvmxZSxUL
 4lvPuvq8Etcz8azO9ctN1jRpWOFdgJRL7cLNpqtuD3D7MENd3RhGBxM6ksROww==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/15] hw/misc/bcm2835_cprman: implement clock mux behaviour
Date: Sat, 10 Oct 2020 15:57:55 +0200
Message-Id: <20201010135759.437903-12-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338224;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOcrHBo1jCCV2hHTLBCYiLIpeFKC44mDRpVy2DOXJo0=;
 b=QCHVdhXBfms/qj/S3fez9+ThpOCJQPQapD0ype880qal7AmJGPou2f/15dBUXPX98eAoWd
 YCH+6n048R2sTVA5odp7DPQIk9ENt+7NW23ekw089Zs9qawYA+X4iCC5qU/ZrOhzr95MNJ
 JXbhUbvjhgw3aEK5kdlFrDnX6zY2G//c6VnaPPSe0wb46oHn6H7twdXafXN/7eTFmUTYKj
 iRbzCHZZwHmzH21+zgIsOBmUt9olPIsRbGTPJ473Sh2JHGRWChRHQXLKxfAUjmM72sr2nK
 TnEm1NPX3kvvKjnvmQi29qxpH+KP0/l/KyQ+2dFpsQtVE85QqRNNzZkkjYkZwQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338224; a=rsa-sha256; cv=none;
 b=cDu2GJs5GOTuD76mPJ6uetySPL7obyave0SiuShI3PGB4cKlE+hQtCb87i4a5xBPqqwhoy1NZOcAOrDvuku2nfKFpvgBn3CsSXmkcJcfDMymTXeDhTMwqXzCtWHX16zclUf67VRlOfRX0LQ1CmU50JT33FO1xHLgJGkjTiX77MrUFmJZdPT27rgF/6FRnWiLuznLkoNGduFXGXEWS0Ojb8Rm7YQLbsuL3tGqU329Lu7+3hNol0Jt7TbJfsBQBozu+YKGxsrbPpR/vg60eXrR0eYO8lEZH0ioVg3ZNQCqwSm54pmeVo4ikwzdVYVJHOAYQTA+u47HSoVqTTkr8spK/A==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A clock mux can be configured to select one of its 10 sources through
the CM_CTL register. It also embeds yet another clock divider, composed
of an integer part and a fractional part. The number of bits of each
part is mux dependent.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/misc/bcm2835_cprman.c | 53 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index b22170f3bc..919a55aa23 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -229,19 +229,70 @@ static const TypeInfo cprman_pll_channel_info = {
 };
 
 
 /* clock mux */
 
+static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
+{
+    return FIELD_EX32(*mux->reg_ctl, CM_CLOCKx_CTL, ENABLE);
+}
+
 static void clock_mux_update(CprmanClockMuxState *mux)
 {
-    clock_update(mux->out, 0);
+    uint64_t freq;
+    uint32_t div, src = FIELD_EX32(*mux->reg_ctl, CM_CLOCKx_CTL, SRC);
+    bool enabled = clock_mux_is_enabled(mux);
+
+    *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
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
+     *
+     *         31          12 11          0
+     *        ------------------------------
+     * CM_DIV |      |  int  |  frac  |    |
+     *        ------------------------------
+     *                <-----> <------>
+     *                int_bits frac_bits
+     */
+    div = extract32(*mux->reg_div,
+                    R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits,
+                    mux->int_bits + mux->frac_bits);
+
+    if (!div) {
+        clock_update(mux->out, 0);
+        return;
+    }
+
+    freq = muldiv64(freq, 1 << mux->frac_bits, div);
+
+    clock_update_hz(mux->out, freq);
 }
 
 static void clock_mux_src_update(void *opaque)
 {
     CprmanClockMuxState **backref = opaque;
     CprmanClockMuxState *s = *backref;
+    CprmanClockMuxSource src = backref - s->backref;
+
+    if (FIELD_EX32(*s->reg_ctl, CM_CLOCKx_CTL, SRC) != src) {
+        return;
+    }
 
     clock_mux_update(s);
 }
 
 static void clock_mux_init(Object *obj)
-- 
2.28.0


