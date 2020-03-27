Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A84C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7140E206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvDaZKWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7140E206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHldj-0005Bh-Kp
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcd-0003NO-GI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcc-0003iL-Jj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlcc-0003gA-D8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id z18so10746827wmk.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OZ5+uHHTVpcB1oDwgp/gP+r+CwoI6bpOzQcnXUvRt7M=;
 b=nvDaZKWsPycaLMQ1RALZosCGJIKvemRNj59SqxKFKLnKx5ecNnh1lnaWABMhX4fFNj
 9mh56d58nUUZrPR8BYWE9VbEDk2mGbOsG1ezrz0pbLATi/3/1aWVlytLFFbfc+wnsS7/
 lR3EgpDX6+J4xh/8tIjGzmCAY9iJZcWfYpkL1Rl2707f7AbkKw0jHTtzHNftHB3LZ9OH
 JFITs9PZkea+q8bvt607m0Vp3Fo/P/yywcMy9nsiJzmNVYd8JGhHl3wNnfuo3asR3HSW
 ukRq/cIBqIC3mJFuJuTJLV5xc8FBOWMZaLNovcQEIZ7+mustAOZzR5TRW2E61ayMeveR
 HtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZ5+uHHTVpcB1oDwgp/gP+r+CwoI6bpOzQcnXUvRt7M=;
 b=CgqFeOBb1F9yNcl8Jn+Cuga70eStqdRuAxdakTq2Vd26pv1sDfqjZKw4YQGBpiNjjX
 K0UgznqmzWvKj9gB1o6IMDVJnFScJv0MRrvlxyV3jf1V47mxIXbTCGYg4TL9qabj1jb8
 ZBY6XmLGFQwcn070oTOUfqufjKTGi7cC5tXk88DPmzQe7PxxtcNrbY9b/HXw52QQidWC
 pTvXZUVaP+cFdxR+IaysoLzIJ1d285AvFWMu58UUJvIqRfmNWbs7JQbS2itX51ss452N
 v7MfTLkP4sIQq+pnaMEYTQMeY9/y7OyG/qSKMLNxLCUQbvTw2jbkiUj9D3JU3K8HMOsW
 ZDnw==
X-Gm-Message-State: ANhLgQ1K65wcXPcys2rY2WVjWwbaRIKqkyNSuYumGTHMQipj/Yy1de9a
 4sFubf7v45spKw9+eNA4QrmrGrjTcNI=
X-Google-Smtp-Source: ADFU+vuAcWwrS4ZRUCgnGd0L7d5mzvotLCKvp8zCW/3NXcGEJ/L0I3ns+3L0hgJ0ZAeYH/E+tRoaow==
X-Received: by 2002:a1c:6285:: with SMTP id w127mr4720362wmb.133.1585302589326; 
 Fri, 27 Mar 2020 02:49:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c189sm7367293wmd.12.2020.03.27.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:49:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 78A731FF87;
 Fri, 27 Mar 2020 09:49:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/7] elf-ops: bail out if we have no function symbols
Date: Fri, 27 Mar 2020 09:49:39 +0000
Message-Id: <20200327094945.23768-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327094945.23768-1-alex.bennee@linaro.org>
References: <20200327094945.23768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's perfectly possible to have no function symbols in your elf file
and if we do the undefined behaviour sanitizer rightly complains about
us passing NULL to qsort. Check nsyms before we go ahead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/elf_ops.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index a1411bfcab6..b5d4074d1e3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -170,8 +170,13 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
         }
         i++;
     }
-    syms = g_realloc(syms, nsyms * sizeof(*syms));
 
+    /* check we have symbols left */
+    if (nsyms == 0) {
+        goto fail;
+    }
+
+    syms = g_realloc(syms, nsyms * sizeof(*syms));
     qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
     for (i = 0; i < nsyms - 1; i++) {
         if (syms[i].st_size == 0) {
-- 
2.20.1


