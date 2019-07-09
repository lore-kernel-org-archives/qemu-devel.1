Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF881C606D7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D89F214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saez24hH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D89F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmM6-0002NO-U5
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJS-00070r-W7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJR-0001ym-14
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:26 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:35762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkmJP-0001wI-3O
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:24 -0400
Received: by mail-io1-xd32.google.com with SMTP id m24so32165953ioo.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RngKFqfhqHf/c/CCpGl+L7AgkqksgPe6OGO3ZGF2urY=;
 b=saez24hHd8iicEmlHJ4fN3ejAZ+9GHS4NWTCDaH0fTTTG8oFJB4OTnp8F2t13HANyM
 Cwgr5cGCc8CdH5e5T5H7L24UeIqjSgq7c1qpJd9NbpVzI6vPoC7r+G9rnB8LjXAeCXXK
 RS9PFdddDtZw+Zho+ZzrJa5gOYoTR1kxTzNyBclXVRbGtbmSobcGpxGqugRowoHVW0wz
 CtAkCWO1G0Elo6l7HdtHp+HW9X7dMHfKvXFm6C1l7FostlHEaEIORmoVaWmcwweqNibS
 E0+Q/9fBTLM0y76+Yu1G/+K4ODVw8kfbR7JKWgEeoEvrJhxlyE8yWfljv+1rqPEYYzU7
 R3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RngKFqfhqHf/c/CCpGl+L7AgkqksgPe6OGO3ZGF2urY=;
 b=oBMN1HueneJWDiJgC6AErL80Ti3CpX1+LYphLTU0+lh2FQV0F1GAC8y7gbYsg5fkQ9
 XHh0SYQkvL+OUPobrR9zdJw3hPzEMNNjiWbnLOhTlHH89Y/mGZ1FYGbQeoy5zHkqf6aB
 Qkm4z54Xxn7U7aZLHlaHb91dnxFWxra0OB5dNjalcmwYSLD3d/sWCNWqIe3Ho9pqApYN
 dG158Q7mLXyU1KFqlQYkfMX0dR+ana10d9OyRMP3j5bGetmLDbAOguwfVkdpW0MbhiSa
 I9B+/KDsHl4s+fjtby/7dihOIVBkbjQOQauMpDq8dG6JjpZyC13YVsyzvZ1Q/zd1VHah
 qP1g==
X-Gm-Message-State: APjAAAU9nrT36YP5h/mkSeAUFYaeypVkaBL6UPZY2tNxt9K4EiRJxHB6
 bT4tk2vBmgQpg9DmWlSDhFLyYSBfKlw=
X-Google-Smtp-Source: APXvYqyBqLpFLoXDJnQF76+k/Ql0lBVmGQNA6t6pfbAWgLVt6/F5LAHxcH+MT5Xw2TUkQ1zuRxJXFg==
X-Received: by 2002:a5d:87da:: with SMTP id q26mr24457621ios.193.1562664080384; 
 Tue, 09 Jul 2019 02:21:20 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id c17sm17613817ioo.82.2019.07.09.02.21.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:21:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 11:20:48 +0200
Message-Id: <20190709092049.13771-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709092049.13771-1-richard.henderson@linaro.org>
References: <20190709092049.13771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d32
Subject: [Qemu-devel] [PATCH 4/5] tcg: Remove duplicate #if
 !defined(CODE_ACCESS)
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code block is already surrounded by #ifndef CODE_ACCESS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_useronly_template.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 8c7a2c6cd7..d663826ac2 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -118,11 +118,9 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-#if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, true));
-#endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
 
-- 
2.17.1


