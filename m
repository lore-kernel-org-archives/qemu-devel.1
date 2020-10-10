Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C98C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A778722283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="DzlKUovN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A778722283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFOi-0003XU-Bg
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMz-0000wd-Dc; Sat, 10 Oct 2020 09:57:09 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMv-0004IH-QJ; Sat, 10 Oct 2020 09:57:09 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 46240C6015A;
 Sat, 10 Oct 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaCzO636ACRdji0tNZeGIPhvB1Q/Jymj/673A6eSpG4=;
 b=DzlKUovNJ5upMw/LDjR8KxykvnTAgZNYZhEu+paT2Aaev3zPvOxga6ndKdbMMLTesb94Q/
 AVwu6B/lQS7Il7HjmykrnFadQsYheK5yMzUTezC7O8eThKuGZwLsGYJnJeV5Njfpv78r/T
 tyAkITgRAiksELr7lWbervFa4a9o9GaIthlrqN8GXZ10NKEn2thr1z21lpHP2riPAKFnh6
 2nmVaU/IBl5OrtqdFvWJ/lEfIwgYUIfKUXk156x08w1CggXmLSbpNKeAi8kkTCt9/aDW6T
 F1Cus+lAhXi07oa98XqBIab5corqcC4NJnKiebr7sm4rCbCTkKWxHAYiFs5VJQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/15] hw/core/clock: trace clock values in Hz instead of ns
Date: Sat, 10 Oct 2020 15:57:46 +0200
Message-Id: <20201010135759.437903-3-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaCzO636ACRdji0tNZeGIPhvB1Q/Jymj/673A6eSpG4=;
 b=BYquxj+hzg6zZJAQR61dKxt9jYRXv/VR1IN4VbExaNT9ZkhDul/8jBSauOpo5pOk1OJVDr
 eyrL68xMYTd+T4MjaAnzO8sAbgfKfgWdU/qNNTn4zX38xPUT4+5wlKvI9KGCnbgqEz+pr7
 ybnsi3Gd5987wy+qfwt2S2qY0ynpCNneT8AgHVPJeIlPoIpVY0G3hEDFAZKLZgiFBlydTN
 rwQ9grYwNTNWkStPLmXJlYZ0zWOeMODgJDZ3tRQpDEBIpUWxCB60zgn9YVwXM5dTGOfMr0
 fCmKZECbXTQRzfP5KDerE+qtGtJQnxmK5l1s4YmMP/4EFcNoaueN+1dPNOtSvg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338223; a=rsa-sha256; cv=none;
 b=MjMfdUO3I+EwfJh3VsJhcl5X4XAxgyrYjs3Rheiw6/KfvqI6Pyld/tULgUQUKB1gzSv+RmhU4gb0ft7SEdP9NFtMBokcsd1L946Y4OQvCteZBTRrTKJYnY0eFLFD4NB+B0yuMDxfcSj4L0+b1mHNyLFTUWypXurNATv/5XnfvLcPN1A9SJyWmoVTIZVteq95AtScgl3Z8gwD4QHEWE/c92xhs9B5LqTkMyUfh0M5sUOafUC0UpBJQ2mVbH/evdv+TAEs31vf0r/KHUJkTkZ4tXAg7u33aj/uNgP9Y7g5Q/PjRW190/j5gaGhSYvtfoRINCfLFPOx8+fjWpJEqwMNIg==
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


