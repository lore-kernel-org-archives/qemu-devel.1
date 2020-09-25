Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C2EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3129522B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgqentZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3129522B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqg2-0002gL-Rv
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVM-0006ao-Gh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVK-0006nl-Mt
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id k15so4191666wrn.10
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VdZoU9e76kBSToXFVSJBVTmzL794wmNQ6KcV8zhQ7b4=;
 b=hgqentZ6khbnd6AymvelNIDUhwdbfYAEnXEI+BtAb1q7Rc3+kgO6ud70hOqkSq/0cl
 zHMawED5WhPTUXwa+89A8N+ZiBmCt1vbhRlA6YKk9mn9wfEaeHmjPPsMj9lHrB0j0G0n
 TdO5NadrjLPVS4VoMuNp8Fx90B+54tjMHX4WI6rx0Hc4TCjtn/4OVAnnbC3a0EqcNVFg
 WH1F+e8NfPXq/rHlRwgkreVhC0tcUONoZUyFWm0mK+4DpzYopJa42f+0WRE047jf4Eja
 EQIh7pKdiDLikGik1XJPLlYqXf0jmyOXNVH78V7+MVhgle3MoKPvDEepRVlKdKXrvw/C
 +D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VdZoU9e76kBSToXFVSJBVTmzL794wmNQ6KcV8zhQ7b4=;
 b=BYHo6VimWj3HDuBftK8FrcJRozsiwvlNo1/xiFMh+GNgJsZORiGUeNjAVy77FkBM/q
 rgSKU0XrHxBNu7msh3oZhiEw2F1kT7GCgimDSA8zs6pnAYIcsVNeKriK1juj5QU+BWAk
 7CPyi5aXL9LcyefYGX75dCbZCik0Y+x9s2ZqNJ0hVIjSogarU+3mLKLvuQPNvZPvkaDp
 eAJCkoxbZFQYGQf9StuslREnCqqG8I1zObdQfqYzaXbcF/5fipQNKTbbmqLTmu5brGt4
 /y5wjrdWxBwGu5Y876b3ECL8DopnR/JQtKSbTfXzTgVW0VmUmJ9uswdXCSzKZriD8m29
 ubbw==
X-Gm-Message-State: AOAM530GKcsX6NeVikoicw513gmuEEO7ADvzvDQLCvYkie0yxc6jiZNz
 KT6SYvw4g9v0rViNEe/kIA9LOfAT3PA6i2t+
X-Google-Smtp-Source: ABdhPJwNSMLT6kSE8jCC8mah4/1KBNfT1WZvvm9uygtr0joveaeiDV027UiFnqNDW5+S+lAT250UCw==
X-Received: by 2002:adf:a35d:: with SMTP id d29mr5326261wrb.307.1601051004929; 
 Fri, 25 Sep 2020 09:23:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/21] qapi/machine.json: Escape a literal '*' in doc
 comment
Date: Fri, 25 Sep 2020 17:23:01 +0100
Message-Id: <20200925162316.21205-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For rST, '*' is a kind of inline markup (for emphasis), so
"*-softmmu" is a syntax error because of the missing closing '*'.
Escape the '*' with a '\'.

The texinfo document generator will leave the '\' in the
output, which is not ideal, but that generator is going to
go away in a subsequent commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0ac1880e4a4..9c45b04363c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -13,7 +13,7 @@
 #
 # The comprehensive enumeration of QEMU system emulation ("softmmu")
 # targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
+# look for the \*-softmmu targets near the "--target-list" option. The
 # individual target constants are not documented here, for the time
 # being.
 #
-- 
2.20.1


