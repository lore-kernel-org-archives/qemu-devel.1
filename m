Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF981C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB7A2087F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4avyYIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB7A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2eb-0002zz-H2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JV-0005Wg-HW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JT-0004CE-Ut
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:21 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:38848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2JT-0004Bo-Of
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:19 -0500
Received: by mail-pg1-x52b.google.com with SMTP id a33so871721pgm.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=40U6j5jG8ujheReF1SUs50iurr4GUkD3XD9r1UeyH6c=;
 b=m4avyYIoCC6tv6qVmAExWM6m2ul1/1xEHal95C1kLvoI+3cKfXM/iigLemLyt2UWWq
 aFI+xgt6PXuSizUhQOB/1p2rDlKfuPIeESvTiWRKKtHFjuLEoS7WruuGhUcvWlpQ1fIg
 Iw95HO6IsBUV/YWDRR/82xKJesEQfQJTQtio8HtV0gJfgwMkS3+w6A9bSMLrAznDdBCf
 jKw2UPHTptHn0XeLKy3hkAf4vkGCYgmMHL43cCJW5p8pTcAsA05vwiE/+XyDMlD/hGsp
 iEZrMqPOv1oOOBqEpC9X4koi3P0bOYfJ3PAuR4p/hJ1ET4JbYHSbyRkReWjwu7JwKRYn
 AdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=40U6j5jG8ujheReF1SUs50iurr4GUkD3XD9r1UeyH6c=;
 b=U5AgY8d9fyiSg93twLPaS9ZgmcQcUdb7OGFl2GLROX5WWFpaZo7STb8PtoSdSPyRsL
 JLDCbPz2cZowX2UFmK5acO27tVFNhcXf6QKIdbkVOsopVMiK0edbRiw5lvLdzFlYZzTc
 nP8GTjJrJkF8KaT4DIf+NDmkgkv3SnjPHU3ltcWV0tPIlPTCvsNpdLsF6JQpy4b4v5to
 JJUhPKKE/jmjVcBdyA0eSjPlEBgCLwxStQXT1Zncj1IAewM8lipEcU9V/vfigbbxdpb0
 w48A/xs5lrtymOaGJdk8XgvhfboPC/gKI35I3sXojaINR7TLphuC82HLmdQvOjn1qIZF
 Iqxw==
X-Gm-Message-State: APjAAAUrwzRoUXd0k1VCeWNvZtvy49aYWP8RafQCxBsvkEzVo+p1CTpD
 PknhTTHSCWgFg5Ybazmya1od+R+RNn21qQ==
X-Google-Smtp-Source: APXvYqyLxoZbGSXeHCuIMVviR19FvvaTLPxpFzN62fCccV/9uduhOAU4c5g5AhrBekx3Ji0aTLe+6g==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr3085284pgj.53.1578455238556;
 Tue, 07 Jan 2020 19:47:18 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Wed,  8 Jan 2020 14:45:17 +1100
Message-Id: <20200108034523.17349-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All users have now been converted to cpu_*_mmuidx_ra.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 230 ----------------------------------------
 1 file changed, 230 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 0f3c49a005..cf4652bf48 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -271,236 +271,6 @@ void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
 void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
                        int mmu_idx, uintptr_t retaddr);
 
-#ifdef MMU_MODE0_SUFFIX
-#define CPU_MMU_INDEX 0
-#define MEMSUFFIX MMU_MODE0_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif
-
-#if (NB_MMU_MODES >= 2) && defined(MMU_MODE1_SUFFIX)
-#define CPU_MMU_INDEX 1
-#define MEMSUFFIX MMU_MODE1_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif
-
-#if (NB_MMU_MODES >= 3) && defined(MMU_MODE2_SUFFIX)
-
-#define CPU_MMU_INDEX 2
-#define MEMSUFFIX MMU_MODE2_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 3) */
-
-#if (NB_MMU_MODES >= 4) && defined(MMU_MODE3_SUFFIX)
-
-#define CPU_MMU_INDEX 3
-#define MEMSUFFIX MMU_MODE3_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 4) */
-
-#if (NB_MMU_MODES >= 5) && defined(MMU_MODE4_SUFFIX)
-
-#define CPU_MMU_INDEX 4
-#define MEMSUFFIX MMU_MODE4_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 5) */
-
-#if (NB_MMU_MODES >= 6) && defined(MMU_MODE5_SUFFIX)
-
-#define CPU_MMU_INDEX 5
-#define MEMSUFFIX MMU_MODE5_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 6) */
-
-#if (NB_MMU_MODES >= 7) && defined(MMU_MODE6_SUFFIX)
-
-#define CPU_MMU_INDEX 6
-#define MEMSUFFIX MMU_MODE6_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 7) */
-
-#if (NB_MMU_MODES >= 8) && defined(MMU_MODE7_SUFFIX)
-
-#define CPU_MMU_INDEX 7
-#define MEMSUFFIX MMU_MODE7_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 8) */
-
-#if (NB_MMU_MODES >= 9) && defined(MMU_MODE8_SUFFIX)
-
-#define CPU_MMU_INDEX 8
-#define MEMSUFFIX MMU_MODE8_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 9) */
-
-#if (NB_MMU_MODES >= 10) && defined(MMU_MODE9_SUFFIX)
-
-#define CPU_MMU_INDEX 9
-#define MEMSUFFIX MMU_MODE9_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 10) */
-
-#if (NB_MMU_MODES >= 11) && defined(MMU_MODE10_SUFFIX)
-
-#define CPU_MMU_INDEX 10
-#define MEMSUFFIX MMU_MODE10_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 11) */
-
-#if (NB_MMU_MODES >= 12) && defined(MMU_MODE11_SUFFIX)
-
-#define CPU_MMU_INDEX 11
-#define MEMSUFFIX MMU_MODE11_SUFFIX
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif /* (NB_MMU_MODES >= 12) */
-
-#if (NB_MMU_MODES > 12)
-#error "NB_MMU_MODES > 12 is not supported for now"
-#endif /* (NB_MMU_MODES > 12) */
-
 /* these access are slower, they must be as rare as possible */
 #define CPU_MMU_INDEX (cpu_mmu_index(env, false))
 #define MEMSUFFIX _data
-- 
2.20.1


