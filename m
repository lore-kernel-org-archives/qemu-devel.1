Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6665AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301332053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDuebHO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301332053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM7Z-00063e-CU
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlS-0001ko-JU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlR-0005eH-KG
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlR-0005ds-3X
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:41 -0400
Received: by mail-pf1-x444.google.com with SMTP id q5so8453221pfg.13
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nKLVZY0MmJdzh4WMbpWEWjNzr7fohAHeyzm16e0V7Wc=;
 b=wDuebHO1XKx37+4/iaHNHFKeNDPhzc2A2AtCAMKTOUaR+hhynbW1Jckegee9dxxkiG
 0ldbjFrYpk6dAyydLgY6bQ6Y5Aj4SyhKhPGlznK8KqwkrKZbY8uA83w7asN/Q2F69dWR
 5QpdpLerLFT1/aRMMpbz5a0lDUhXkwuo0TcmQUhWyOvMa+CFT0g0qXtVy5/CptwMje/2
 proSgqjF2kbTbeZepAaFQpBV/W3OviNAKKkbs/H6wzO0hMBiWzuPZNl+CwF2lEpfoEC3
 Eae34/JC6YjE67PzOvCv8Kyc+h3hCPSYPMatJIcx1EJOZGSsJnOSv2jbMdDLiiZSlr0e
 lUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nKLVZY0MmJdzh4WMbpWEWjNzr7fohAHeyzm16e0V7Wc=;
 b=JnERuUv/fqpWYLIy1pu8Yh8If7BoxjEpoFVBBXXrbI3gBPpuaiFO2vzuCFV561sc4U
 StBg2ix3SWcGYEQMe34rlK8NsgeUbITG9ydmlnz1xuprGCNUM9x55dA8qXybbsBKhZh+
 hQgeHGHKzHgAP2uIPFOVK7sdpC4HeUgGknnmVJZJIwjt8d4XYbwp5jm4uR4Jli/DLhIN
 Z7WQDmatXmGoOgEFX92CJtNBLXJbTGyFzKV+tn/WW740+m9+YnmXph+kC4PonqyF5hKy
 4ynX1B+q9Lv6ys6qT6sFrsOA2lFqZ+5owf+vXfmQGc01FR9l75a+kdzRA8bn4F+OzKNt
 hWMg==
X-Gm-Message-State: APjAAAXUe6vSDHEl3AGBXkYrdbsb3A1DwZvmV8yRBhNBtBMHf3mSZYnF
 b7RrCIb8/owDBPpSOfadu61RKGKziyE=
X-Google-Smtp-Source: APXvYqxvhEbbZQTqJhd6yhxmx33/abIphzYiJCc2eKa6B2yIhG/FIqVazU97CrGVhbb3tLARoC/O/A==
X-Received: by 2002:a63:364d:: with SMTP id d74mr31917924pga.416.1569950199704; 
 Tue, 01 Oct 2019 10:16:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/18] target/s390x: Remove ILEN_UNWIND
Date: Tue,  1 Oct 2019 10:16:14 -0700
Message-Id: <20191001171614.8405-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index e7a9a58e0f..17460ed7b3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -804,8 +804,6 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
 void s390_crw_mchk(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
-/* instruction length set by unwind info */
-#define ILEN_UNWIND                 0
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
-- 
2.17.1


