Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4D7C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C665820853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Vb5un0nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C665820853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX2o-0002Fh-SJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZv-00045C-HS; Mon, 05 Oct 2020 15:55:23 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZo-0007S5-Rp; Mon, 05 Oct 2020 15:55:23 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 8306EC60F1A;
 Mon,  5 Oct 2020 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927714;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaCzO636ACRdji0tNZeGIPhvB1Q/Jymj/673A6eSpG4=;
 b=Vb5un0nc6YpHz755fDHYY2AshuGfmGlMGfXCF3NTIrVmqnYjxjT3bYLXxaJm+RmI2EhhNK
 s8BogKGK61UdSKKh0SDq6LXYiQiKqzct0ab7ik50qDF8iEatr2EEfH3Vfvuz/XkVoMbIlP
 r1erEz09c9oesNli8sAODy7HVGACnlIH2m/pudXf9VLf+s5JMtdzoXPR2E7EAzlBU+Jszz
 Vb92o1KBZFcVE8NiFTxl4s0ldicAEcFDxiNYoGnuZTG+/UwD1wFm5TNPgxqWF01Fw/aqDm
 PryBONM8UTT9RErVSuuPAVs/ykYFrVKz+29YYShkGb581/JRFXiNeFFlJuObjQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] hw/core/clock: trace clock values in Hz instead of ns
Date: Mon,  5 Oct 2020 21:55:59 +0200
Message-Id: <20201005195612.1999165-3-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005195612.1999165-1-luc@lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927714;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaCzO636ACRdji0tNZeGIPhvB1Q/Jymj/673A6eSpG4=;
 b=e608ulAEdpgOIeHk51L1Qg9gjxKtCbbq/NrIR1GS8XrsAE2hLE97YNfoFDkuDw6RUmoW2S
 FZORCvdSsK7SEbbMFk7mLToRNSzmfoK1o+eIQChcXt7pqCGPdobnNgq0MmS0/+L0E6K+Il
 f8XVJaF6mRlmzOX66adYhNY5g8LzUmMs1QpcEpzXPXrq0L7QH8ci5H2JruYnsbYWTJP8Mu
 TcGo1x7kRJgDqLojB4rOMQKzxmxF0QZAzzwmBQbmE1GxpwTIwBZBfYidRst2osPY5da2t1
 DtS+DIVL78+TS/GQwYqpvR582EkKAkk/cBKnEJ0EDAvhNN7ChGVD+nEq4YMlNQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927714; a=rsa-sha256; cv=none;
 b=MORRtgKQMO/jhmdpMrKNRjyNRWf8uitsvMiY/+ioJbSeP4VDaQa7TPJVmYPcqLzxOXvMylIVnYj0XLhFayLd36GWP6Snih9ucZkrccgHDvSA2Ek9fOHOvHXcPV/7sg4gYiWvvgMC1EcH2giKWg+/c23wg205s48GJghfAUEGn98D72tShldA6pt8/1ewOAx2pPgmvElfUYixMmvTM5J2/At9lnueU8EAV7MuehkpBvf26jejZ4ZW6nNzfOotF4cFCyvwdGVS1+/w/EWz8yuHaC8bXQB3/yNKQWzT677/edIfcckpPejWcDZk44XqAZpW4UhWMRSN+ZHRIi27ZlO0pg==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nanosecond unit greatly limits the dynamic range we can display in
clock value traces, for values in the order of 1GHz and more. The
internal representation can go way beyond this value and it is quite
common for today's clocks to be within those ranges.

For example, a frequency between 500MHz+ and 1GHz will be displayed as
1ns. Beyond 1GHz, it will show up as 0ns.

Replace nanosecond periods traces with frequencies in the Hz unit
to have more dynamic range in the trace output.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/core/clock.c      | 6 +++---
 hw/core/trace-events | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index 7066282f7b..81184734e0 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -37,12 +37,12 @@ void clock_clear_callback(Clock *clk)
 bool clock_set(Clock *clk, uint64_t period)
 {
     if (clk->period == period) {
         return false;
     }
-    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
-                    CLOCK_PERIOD_TO_NS(period));
+    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_HZ(clk->period),
+                    CLOCK_PERIOD_TO_HZ(period));
     clk->period = period;
 
     return true;
 }
 
@@ -52,11 +52,11 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
 
     QLIST_FOREACH(child, &clk->children, sibling) {
         if (child->period != clk->period) {
             child->period = clk->period;
             trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
-                               CLOCK_PERIOD_TO_NS(clk->period),
+                               CLOCK_PERIOD_TO_HZ(clk->period),
                                call_callbacks);
             if (call_callbacks && child->callback) {
                 child->callback(child->callback_opaque);
             }
             clock_propagate_period(child, call_callbacks);
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 1ac60ede6b..360ddeb2c8 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -29,8 +29,8 @@ resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%
 resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
 
 # clock.c
 clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
 clock_disconnect(const char *clk) "'%s'"
-clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
+clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', %"PRIu64"Hz->%"PRIu64"Hz"
 clock_propagate(const char *clk) "'%s'"
-clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
+clock_update(const char *clk, const char *src, uint64_t hz, int cb) "'%s', src='%s', val=%"PRIu64"Hz cb=%d"
-- 
2.28.0


