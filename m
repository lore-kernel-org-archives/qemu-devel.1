Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34CC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854AB20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qj/EJkKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854AB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLY7-0004Li-DO
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG2-0005Rk-1Z
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG1-000857-15
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:29 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLG0-00081V-Qn
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:28 -0500
Received: by mail-pl1-x642.google.com with SMTP id c13so13208314pls.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s2sFyKQc0KML7nsHeLOyCy6ccvVe4EAb+zDftLMFs6Y=;
 b=qj/EJkKiwFRRFVX3hOK94ImapsNG7x25YrOTzK76uFNOAvHa4ViFzH9dB7ZkTepxK4
 k5+WflrcteloMJFaoKYZ/SS+gbf9KWE4490L9q7gkYcZj360a2XUSwSRMA4dUOlvsgAK
 wFkAoFd+PCtgpAaG+NJ3El7M3yeBvUqa0mQMM6d0helHIWCCWGj6cBwJDBmAU1FQURtR
 LMivEHpOmles4WVULZJhmRh8+VHRRjeIapjEhbU6ICi+aTUjdeJDbljdhnPBs9/gmt0a
 zi0kFuB2ASfGQLOmm+lI4Qfg4wBjc4+j2vVV+xCXGT4m13Va6S4qSCL1b9pRsdMUmg3E
 Q8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s2sFyKQc0KML7nsHeLOyCy6ccvVe4EAb+zDftLMFs6Y=;
 b=mZlqbQGo9Xj4e0IJQRemZ8YsgCcLqPC0CWKbio15ibW7Pmys+LQMTFAQLjUg/YuD9c
 F2VWiatoZ0i3QBWiI3bZkePMrK2Y7KArtpeRetT5+CfzRiGYHG4H8R7WbScVGxHbni8n
 Uk3KR+ccLJ4xl6Kzv5MVpAVXopx1Qx5XwwSWJVtqJ97DoNho+BjQFG2SDbvqdQhYtKhs
 KRXg6n8DSPuishpLDJVwAqSIQ/e53RH85Dw4dSFt+SbRRW4EEwXNDNwiAkDGxe+aga8Y
 9+E6X2YXdbW4/DaFNmh9QM1JxHiRr0TCn/vjnouFF/PYIhdNYCVzBSM7KuLxF5/aDYHM
 PkVw==
X-Gm-Message-State: APjAAAUkDXR0ms8fVNE28kgjD2ePOAMof31nb5mqgTr+8Jovz4+N4L9j
 Yj1YxxrX2onZdqOtgu8bwBmH8SQnJ6Y=
X-Google-Smtp-Source: APXvYqw6FrdQxm7hCBzX3p8hUBG/iSbsSjt1t6IRgUfGwLRYEblTLzV+SiIAw4xpazkW5szbZxwo5w==
X-Received: by 2002:a17:902:8481:: with SMTP id
 c1mr30749960plo.319.1577574747661; 
 Sat, 28 Dec 2019 15:12:27 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/29] target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:14 +1100
Message-Id: <20191228231124.18307-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index af282936a7..1b4b90556c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1952,9 +1952,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _ksmap
-#define MMU_MODE1_SUFFIX _user
-#define MMU_MODE2_SUFFIX _knosmap /* SMAP disabled or CPL<3 && AC=1 */
 #define MMU_KSMAP_IDX   0
 #define MMU_USER_IDX    1
 #define MMU_KNOSMAP_IDX 2
-- 
2.20.1


