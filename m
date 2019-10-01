Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E366C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BB82053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMyW5teI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BB82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM67-00054G-EX
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlO-0001jZ-OY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlN-0005cI-Qu
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlN-0005bj-Ln
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id e1so4578367pgj.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v4OWbCEYlAnhjvj+x+7Ps/UFUWQ5DVP1AWFH0GWe8MY=;
 b=BMyW5teIwagEVueis7ud2R9qnHWp3oYb/nHK+tFOgAYpwx0hBqUKTF0Dv6INyuJ/gF
 /PAMqwn+kK/DQ1uJD6ag5sq2D/LFAEAf4q2VeiFH1kZvAkmEGA4rOtSgm1/sDTuz3HS8
 Mv5HWl7mOoEaPP56KAVXq/gvwAhhCOJcradFj/2wwsZRQqqZureKIBdqQAbkm6K9tb+p
 OXeVeTBJ5LwHoeTcglcENpqwLLWb6XCq14YHA9CkkHKd4RllFOMGkaZ+EW19KkKSxiF4
 rmm9/3N1cMS6x/HlJCTRIy6kBCufcg8LmqRqX+ORFzKzlj+vSHPsArYpgr4KsOAoefVW
 uC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v4OWbCEYlAnhjvj+x+7Ps/UFUWQ5DVP1AWFH0GWe8MY=;
 b=A4cenpFqRx0cCBocvSdcvU6rI0XBbXcrdjfSJJKgTnQ/juCjiRpo4cxjep2OHPVKjd
 1v6Rk0cHkd9m0sYEt0PFLZ0nmGrmDpo17m5N7PF1nsyE3j9uqDn6Fs2NtQZ7+1tUJXlU
 pONtSLRis7vVT194f0LRHx3QMzaI/QPF8qnfcGBdmkviRqlKG7Mtt5al8CBmiM6gc/Nz
 NYXsJUih43nF57H19A+lQA8Y8BcxCB03zhUzS2Fz433pZ3Wt50XsWaB0c/XHXd4nf5Tm
 NdAQApYUkN+r28ZHht92W6KQj8EK85i+VpYvo8df4f0c9HWxGunetg6x7lFxw3GWhiGZ
 m82Q==
X-Gm-Message-State: APjAAAV9WZbJky7HR59bV/Cbdu+AJFqLPnqa9shG+Lw5X752CNcOY4i5
 sY/lvdHuxtlbLz74YtXgn7piKJrEaWI=
X-Google-Smtp-Source: APXvYqwngxzVcEsPfT5+tPCPbAKX6HQa8y6gSG6a276ZmPO/SmO23nNT1WhArO6hu2wiHYruGmdO+w==
X-Received: by 2002:a17:90a:c096:: with SMTP id
 o22mr6910982pjs.29.1569950195996; 
 Tue, 01 Oct 2019 10:16:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/18] target/s390x: Remove ILEN_AUTO
Date: Tue,  1 Oct 2019 10:16:11 -0700
Message-Id: <20191001171614.8405-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This setting is no longer used.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h         | 2 --
 target/s390x/excp_helper.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 18e7091763..e7a9a58e0f 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -806,8 +806,6 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 /* instruction length set by unwind info */
 #define ILEN_UNWIND                 0
-/* automatically detect the instruction length */
-#define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 8ce992e639..c252e9a7d8 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -196,9 +196,6 @@ static void do_program_interrupt(CPUS390XState *env)
     LowCore *lowcore;
     int ilen = env->int_pgm_ilen;
 
-    if (ilen == ILEN_AUTO) {
-        ilen = get_ilen(cpu_ldub_code(env, env->psw.addr));
-    }
     assert(ilen == 2 || ilen == 4 || ilen == 6);
 
     switch (env->int_pgm_code) {
-- 
2.17.1


