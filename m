Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 21:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349E5206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 21:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCtyFNuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349E5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpeuF-0003ZF-8L
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 17:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Cwz5XgsKCgYnyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1jpet6-00038M-1i
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 17:30:56 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:47505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Cwz5XgsKCgYnyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1jpet4-00059R-Aa
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 17:30:55 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id j3so16956423yba.14
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=uLL04vSdIeweojbiDvxiWNtO7+zmi7y/Fue203k5Mik=;
 b=qCtyFNuvLa0hujbVg605BwHgEDE9CqClhXToKw1DmDFV+859oJxtXwMMpaPaMkmKOB
 nkoPNfrXEKP+DAkyTjiem9BxPvd7CCmgxD3FF9rjD2dDzdBuuQoIHnpUmgQHBXMd9M4g
 a/sMW2Cmlg6RZwkdfx5kk8Z0yX1hQTBC30jE4df+W5ZbYDKgzuxiqEWWGV/F/p3N2mtg
 uzTQyoecevSnmjhvi+ZAoMZXUSM2fhNfMkOCjA3atqPseEeY7jxxpw8WG7TwNXHg6JqG
 d+vZ4kGsLYVJ0MJY88ZqOBMLnxrNfVxi4hQLqDdQVW93YzIvMzvvDn31fxm8wZr1FaQH
 MjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=uLL04vSdIeweojbiDvxiWNtO7+zmi7y/Fue203k5Mik=;
 b=lt7ouwVZF1TQ5Px/6/lM/GVIXUeCozNcoZ2/PLh5yUqa7CZEG/3THFW/f3tPeVNz0c
 DVL9J0qij2JD1FgaYgjd3QkmFiP90TIuHHTX200LSyOMHTb0qBEobzBvEYf7B5oEs4Yh
 zMA3U6MHmHn1E3WGkyqHeLnzAdn4BgnOFLGtha94dPiSJvVeUYPlmesdXHrIQTnhVeRm
 hzT8DdR0xKYtEOBRnSK2h9jilrLMC5KhmKy9Gd5uJ5vwWPe3t5inTqkGNzM/GopVYRVs
 JHjh9amyFX9Zne4G5Ot7pd1jjmkrNau5fGRvM/klio+sbl56TUJzBpmzLRL41VUSOlQa
 lxEA==
X-Gm-Message-State: AOAM533sTKfa9VRWNmDgBUUCDIGNRq0gNC4Ag8RZbT0h4ogNnoSFu8vm
 db5MTlIfH/1gGCtXZotdPpWpG7adfGUNt6dLw626qtYtvgXnqq8cqJB+943zo341KZOFucGi0hA
 ArxlQa90+1Clz8swegTj1F7bHGwUVsWTG2GJaWtC77J27L9UywxYzAnY9NHK/l5ikuGjT3+Zz4g
 ==
X-Google-Smtp-Source: ABdhPJzbZmYZv61schRjQBCS9z+Ju1Ur0LqHXkbvNRKm1fJjgO69RjJX4SmSk06iXBU/p9Pk3ZGf2Jd9bI3cYnWDLQ==
X-Received: by 2002:a25:fd5:: with SMTP id 204mr21104384ybp.294.1593379851683; 
 Sun, 28 Jun 2020 14:30:51 -0700 (PDT)
Date: Sun, 28 Jun 2020 14:30:46 -0700
Message-Id: <20200628213046.2028271-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] tests: Inject test name also when the test fails
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Cwz5XgsKCgYnyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a test is unsuccessful, the result is "not ok", which does not match
the regex because it includes a space.

This regex matches both "ok" and "not ok".

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f4448a20b..09df2d3f86 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -637,7 +637,7 @@ define do_test_tap
           { export MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} $2; \
             $(foreach COMMAND, $1, \
 	      $(COMMAND) -m=$(SPEED) -k --tap < /dev/null \
-	      | sed "s/^[a-z][a-z]* [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
+	      | sed "s/^\(not \)\?ok [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
 	      | ./scripts/tap-merge.pl | tee "$@" \
 	      | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only), \
 	  "TAP","$@")
-- 
2.27.0.212.ge8ba1cc988-goog


