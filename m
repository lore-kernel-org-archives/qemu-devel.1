Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50316C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFB72086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HH1sWJ4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFB72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZW2-0000t1-71
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTl-0005mr-2v
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTi-00049L-11
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTh-00045q-Oi
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so13503215wrt.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YAolMHbVRc4z4JgtOBFldRu9cUtp/1u8OxuIdSNhw1w=;
 b=HH1sWJ4sQ+0T8BkfjmGLV4oOGm+e01IArqCqdQcoh9FCju7AAyVpVXJdoxsXxVZNcJ
 NUjpADGCP9igs4hUmzM+5W387e//3UA8NKpFuJNYKM/IixnyEoUrGxjI23/1ImToOFY+
 BmZRl+cCugFMS7osvgoGohXXV+2Asf+OoryznAwSeUvtHSlwP1iV5XAdd1RAokIvF52A
 0LXN0Wx8lVO0p98TYhxEfIbDjVvSHags2Tmac7BJYYUFUHXeWE3rcxRXfQ5XIWbFNfRb
 RdhNFo6Bzxp07MucbBylAc/37YTUon+XTxyRpJ2a44rFnhd1Zi1j6XBCEGpnIwemrxAT
 /j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YAolMHbVRc4z4JgtOBFldRu9cUtp/1u8OxuIdSNhw1w=;
 b=UJd6lrgxIbOj6/os9KYOMjBFmqgFV4C+CLAMeMRdfV0HyZeM7nUzLtMyKQMKKb1B+I
 2Sr3bREdDRvykiyDL+NeGpUbzqpDdvFybM+oLPdOtNzHOIMVAJzHymtOE1ipBgJ6bWhs
 IpUTkLL5fiMZg0IDmNekCSEfqVCN0Hrk1VUJOTgw0TtjO2sfS0G3Plnl7wHhQatQT5S5
 htwsXqFGM6YQ+ScUOhTmdDAvvWmHJ9T9eV3wmQHl4nHOmSiZ73ACYNWT3eNcfV0UGCLy
 uYn+qedownD5cKu7knW++bN5PW5ajyZII/Ag7rPW3B4PgeyFEptoksBcTh4lthWVcCgq
 yFtg==
X-Gm-Message-State: APjAAAUj1zhdLPP8hUQUjCy8hAICyFCRjq/kwgLANOYvJ4S5kxnYlGLG
 Cp24VHFjF336PxTjPVlsabImzw==
X-Google-Smtp-Source: APXvYqwrY8r5WhKbTn3uwATca/3gfRJylcJjf4cw1Fb5FZo4BOYfvg/MWeYwuiFa1UyTNxrpan4ehw==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr10209600wrh.371.1581442660645; 
 Tue, 11 Feb 2020 09:37:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/13] target/arm: Implement ARMv8.1-PMU extension
Date: Tue, 11 Feb 2020 17:37:22 +0000
Message-Id: <20200211173726.22541-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARMv8.1-PMU extension requires:
 * the evtCount field in PMETYPER<n>_EL0 is 16 bits, not 10
 * MDCR_EL2.HPMD allows event counting to be disabled at EL2
 * two new required events, STALL_FRONTEND and STALL_BACKEND
 * ID register bits in ID_AA64DFR0_EL1 and ID_DFR0

We already implement the 16-bit evtCount field and the
HPMD bit, so all that is missing is the two new events:
  STALL_FRONTEND
   "counts every cycle counted by the CPU_CYCLES event on which no
    operation was issued because there are no operations available
    to issue to this PE from the frontend"
  STALL_BACKEND
   "counts every cycle counted by the CPU_CYCLES event on which no
    operation was issued because the backend is unable to accept
    any available operations from the frontend"

QEMU never stalls in this sense, so our implementation is trivial:
always return a zero count.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9537785104e..c896ad0b7ee 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1124,6 +1124,24 @@ static int64_t instructions_ns_per(uint64_t icount)
 }
 #endif
 
+static bool pmu_8_1_events_supported(CPUARMState *env)
+{
+    /* For events which are supported in any v8.1 PMU */
+    return cpu_isar_feature(any_pmu_8_1, env_archcpu(env));
+}
+
+static uint64_t zero_event_get_count(CPUARMState *env)
+{
+    /* For events which on QEMU never fire, so their count is always zero */
+    return 0;
+}
+
+static int64_t zero_event_ns_per(uint64_t cycles)
+{
+    /* An event which never fires can never overflow */
+    return -1;
+}
+
 static const pm_event pm_events[] = {
     { .number = 0x000, /* SW_INCR */
       .supported = event_always_supported,
@@ -1140,8 +1158,18 @@ static const pm_event pm_events[] = {
       .supported = event_always_supported,
       .get_count = cycles_get_count,
       .ns_per_count = cycles_ns_per,
-    }
+    },
 #endif
+    { .number = 0x023, /* STALL_FRONTEND */
+      .supported = pmu_8_1_events_supported,
+      .get_count = zero_event_get_count,
+      .ns_per_count = zero_event_ns_per,
+    },
+    { .number = 0x024, /* STALL_BACKEND */
+      .supported = pmu_8_1_events_supported,
+      .get_count = zero_event_get_count,
+      .ns_per_count = zero_event_ns_per,
+    },
 };
 
 /*
@@ -1150,7 +1178,7 @@ static const pm_event pm_events[] = {
  * should first be updated to something sparse instead of the current
  * supported_event_map[] array.
  */
-#define MAX_EVENT_ID 0x11
+#define MAX_EVENT_ID 0x24
 #define UNSUPPORTED_EVENT UINT16_MAX
 static uint16_t supported_event_map[MAX_EVENT_ID + 1];
 
-- 
2.20.1


