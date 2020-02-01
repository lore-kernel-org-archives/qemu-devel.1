Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D708DC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 17:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B0E205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXsJaLrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B0E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixwUu-0000j5-OA
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 12:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixwTx-0008He-QA
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 12:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixwTw-0006jY-8t
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 12:22:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixwTw-0006ii-1d
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 12:22:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so12527341wrq.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fC/5NngXo7ihzURtVBqb67XcSQ/rnWBHfJf1QtKSsic=;
 b=YXsJaLrlLvOpa/L9Qg8l/nntdec7J0xbs6KizkdpduEh7VrRc0F0BMIU6qLAnlem5g
 g5+u3c39P/eHOQTns/q96xLhhFkOS+Ou07OFOU91c1EnbRits/PVm10Yi6B0YqW4AvOk
 JI9zYSwFuR7+VovrIaa0kMYsq/h0SZfwuIcRUtvy8NuF+qm8UiHuAkg7wPohnsbMXTva
 FrdsUyAvxWf/mRvxyCJBfOUXiy9QZ5o36bPgoeecY7NU0ApNxIrBjgxNvBfX5KxhMny7
 l/KoX+Eo/0hW/IZpfbWBXc997BexpKd7+735WwHuwNUbCC6xbFpe33S3EOBdG7rhLOkg
 jpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fC/5NngXo7ihzURtVBqb67XcSQ/rnWBHfJf1QtKSsic=;
 b=jTQADI2fnu+o1UhyNZHBkD3bqawqKBJdh3lTcqjWqXuAnyGF8GIX/Dfa5nweTsLh/l
 xVXj2xg/kRKJLqueZ5mRR9myMLcnLr85vrvCV5xXxbtOGIY3Yog0FTaLLAznMPvikmWI
 ExI1Oxuj7GToVb4aqsNLWwd3NLbsszDkwz03bsmTdokSrg/B+XnPnmDANNuy1mQZTbAX
 E5juDsecwg4nglzaJJJYE+dPJxGL1Z9fFiBgDhoskmIx+Qbi5PaBW20cjU5RxjT8gSOc
 /XfkXBT+XrOriBD4QbkdbHUC0pyNYmqBQEcMz9PwzmUZHT2Ya/L1Gmdk25lofJy+Gxsl
 hdBg==
X-Gm-Message-State: APjAAAUNsEuV5BGDmGwagaEsRoG04MrVC+PxJb/HWzwziZ3KyWEOOXLt
 ydJd3ayw2bcrB277nIIVq9W+8hLg7lhZ/g==
X-Google-Smtp-Source: APXvYqy/kMJMoTqMd0dNoE9/iUcXO/cN0DS84gX16VZi6EXWriy22TRVSgTGYdrvONq2sSboDwNstA==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr5637772wrn.124.1580577774615; 
 Sat, 01 Feb 2020 09:22:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v17sm16735836wrt.91.2020.02.01.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 09:22:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Remove support for CLOCK_MONOTONIC not being defined
Date: Sat,  1 Feb 2020 17:22:52 +0000
Message-Id: <20200201172252.6605-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some older parts of QEMU's codebase assume that CLOCK_MONOTONIC
might not be defined by the host OS, and have workarounds to
deal with this. However, more recently (notably in commit
50290c002c045280f8d for qemu-img in mid-2019, but also much
earlier in 2011 in commit 22795174a37e0 for ui/spice-display.c)
we've written code that assumes CLOCK_MONOTONIC is always
defined. The only host OS anybody's ever noticed this on
is OSX 10.11 and earlier, which we don't support.

So we can assume that all our host OSes have the #define,
and we can remove some now-unnecessary ifdefs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've left in the runtime-check in init_get_clock(), as it's
less easy to see if the fallback there is ever used.
---
 include/qemu/timer.h     |  5 +----
 util/qemu-timer-common.c | 11 ++++-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 85bc6eb00b2..6a8b48b5a9d 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -838,14 +838,11 @@ extern int use_rt_clock;
 
 static inline int64_t get_clock(void)
 {
-#ifdef CLOCK_MONOTONIC
     if (use_rt_clock) {
         struct timespec ts;
         clock_gettime(CLOCK_MONOTONIC, &ts);
         return ts.tv_sec * 1000000000LL + ts.tv_nsec;
-    } else
-#endif
-    {
+    } else {
         /* XXX: using gettimeofday leads to problems if the date
            changes, so it should be avoided. */
         return get_clock_realtime();
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
index 06d084d3646..baf3317f745 100644
--- a/util/qemu-timer-common.c
+++ b/util/qemu-timer-common.c
@@ -49,14 +49,11 @@ int use_rt_clock;
 
 static void __attribute__((constructor)) init_get_clock(void)
 {
+    struct timespec ts;
+
     use_rt_clock = 0;
-#ifdef CLOCK_MONOTONIC
-    {
-        struct timespec ts;
-        if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
-            use_rt_clock = 1;
-        }
+    if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
+        use_rt_clock = 1;
     }
-#endif
 }
 #endif
-- 
2.20.1


