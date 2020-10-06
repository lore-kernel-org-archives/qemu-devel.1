Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8EDC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600AE20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob51tosD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600AE20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhbE-0001QL-Cl
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ6-0002S9-AJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ4-0001Od-RT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id z1so12223703wrt.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XxU4JUy0D8PVTLSMbq2V+3PgAaQreqZ5rvwSi2NUvwk=;
 b=Ob51tosDyW2KApUJTZUWjhiBmWvKH4VpcNnK9j6A+zQrWhTnE/lqCn7Ai/Tlw3M+ZW
 0KALosaH8ZxMro6bv4Rguwc+WyUai6h2ebtzAdpSj2bDqAzHLiBJp1p3ciTF85FgwmtN
 4iKa8pjkuPopMM7jtz9NPFL7uiqrQTipbwKtMdB/Ru6XVwHYH1PlB70WmE0oTsllDEIQ
 coIAzU7CFjt4H2k1OXZLwjoohPxCr2RDfqTas0owc+zDgJ1NGHXC8eJ7F/iVegmHI6ni
 PUZWLyk8ZChQ2Urp0WB1i0VgWG48tvTcxNPxgEB3bI+lpK/+l2XLaPkxwTJv72iLuwXQ
 O6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XxU4JUy0D8PVTLSMbq2V+3PgAaQreqZ5rvwSi2NUvwk=;
 b=JLy3LdL9CWeXyYu6EVZSIoyT0SlWWzXCB8qvClS4XQd6SCpRB6PMf/EqZhSzhWUyiB
 LquO7NRY3GzTFfcB+n3K8i7lDkgxi/AlfCxVFgw63dEalsMpIaQ7PLoOS0+TkIYx6Iib
 F7JtSjIHKczMm5OW18X5qsYjLq9L3FTEi1dKsJi3s5/7D8Qb/NMeQdH4tUyL0giITTdh
 oprbBADlPFA3dytxSaylxS/aXFhzbbfIi7UK3Wwz8RYYlzgxD/d26r2DPz9Lo4rQDZ+q
 yeaTItO/qVqYh/6ZR491aZfpeJa7Q8S7ZycHWXlldk/i+poA0cWOXBAsWE6kjFcOePZ6
 o5YQ==
X-Gm-Message-State: AOAM531F8UqnW0KqHXsF5LVIue6de9EWVTvWbn7GrlTOuN+AG20ZOpfz
 gvjCFqiBVyfJ4yYYNpkNtW18rTyqfQ8=
X-Google-Smtp-Source: ABdhPJzaxJ9eQ6RMMm1H6MLLJwHvmI1z9xvwMN7+Xo1+uQDn1Xa2ZvZiC+qQF2Am+tO2BtPX2kVcLg==
X-Received: by 2002:adf:f552:: with SMTP id j18mr3536256wrp.128.1601969395331; 
 Tue, 06 Oct 2020 00:29:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/37] cpus: cleanup now unneeded includes
Date: Tue,  6 Oct 2020 09:29:20 +0200
Message-Id: <20201006072947.487729-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/cpus.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index adc20eb3de..1180103ede 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -29,20 +29,13 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
-#include "sysemu/tcg.h"
 #include "exec/gdbstub.h"
 #include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
 #include "exec/exec-all.h"
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
 #include "sysemu/cpus.h"
-#include "qemu/main-loop.h"
-#include "qemu/option.h"
-#include "qemu/bitmap.h"
-#include "qemu/seqlock.h"
 #include "qemu/guest-random.h"
-#include "tcg/tcg.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
-- 
2.26.2



