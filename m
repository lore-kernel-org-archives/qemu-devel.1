Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B94CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24147222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJ6i1SZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24147222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFo3-0004a3-Ud
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf1-0000yA-79
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFez-0004Ht-LQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:06 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFez-0004Fk-9G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:05 -0500
Received: by mail-pj1-x1042.google.com with SMTP id v93so442978pjb.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GvGCU+3iqgPT0dthIniMLE/ga9WOcGpwXeWfFW4ZBaM=;
 b=WJ6i1SZMXS2p9d2iApMMGqu9IoeDY9ndc0s6mFIUtRz8IYKOOvhF5ZBMVZ/fCpaT41
 6m8UGtUfvyFe6lz3h2NZMhhywFZOYrOlgfoMcs5YId5koz80EMMh5jeatGXnU/n01eDz
 bYCjyXPHIV98wjJyvEfN9ap18zIUYfH0KUfTZAl17AxuVqSVRw8yLTFKX5tN+fDVfovi
 W2tcMyN1mLEZ7TT8ucmnpVOt4/Dd48VTjoJ3kARrjlPwLgyJTIgeMEPrXCwZBkFPSkCy
 7SmodnNdPM9hpkfqxOpNoWciV5qFtSphvEEZCCnBBreJRvhgn4BP7WgE4+jR0s6Qj7TZ
 vw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GvGCU+3iqgPT0dthIniMLE/ga9WOcGpwXeWfFW4ZBaM=;
 b=Xmn9wUaGjEhf4jOspDdVBckvTEECZJ9eCtWiSGY9NhVWp3c8FXdisQLpXRfNOVlm+c
 hp4aX0eCSGIiCKcI8ffkoGQMtwfC8/QRmebllITzO7zbho8HuXTVwRAuSsjX2h1HI5Ua
 crFCutnWhyeaUkwfjaYQ6PWU+TSC2uQIuYwJ/Te+KRrirT4jWNVrNT7FfIv7X6aYdivP
 rudRMA/bOEZBbfyQj7QsNOStGTAk3BwU92s9lKjkGFrepz4wVjnDVrQSIS/r94nxQOjJ
 eYOlhvZ6c/Hse4CWmKQcuhC6JR3JOoL/Mg3myu3PGOBCng43FdTVs3neeFLqytajAg0v
 IGrg==
X-Gm-Message-State: APjAAAUdFJoMPBsBpxDWEK45TGCgVLinqwtpYlyHegugptSaoVISfyNQ
 2JJlyCJQyJmcxsfJAOQmCYt0PzW65G8=
X-Google-Smtp-Source: APXvYqwQPvJH5gIi4xKim3QyNOlMlnL42h0K+tJkr/q2fRgYeKUqILUoZF8yFDwYxBqUjva45Rm95A==
X-Received: by 2002:a17:902:b095:: with SMTP id
 p21mr7149383plr.313.1576123263746; 
 Wed, 11 Dec 2019 20:01:03 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/28] target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:29 -0800
Message-Id: <20191212040039.26546-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cde2a16b94..6a8228df4f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1949,9 +1949,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
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


