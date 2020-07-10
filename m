Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0317EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8D42077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KkjlVoop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8D42077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsib-0000aY-14
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqc8-0004tD-0o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:44450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqc5-0006MP-7Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id w17so2088976ply.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AVzzG3mHFPsuqM2JRCy5Jzl40BEHC7YkQgKLxYxD8UQ=;
 b=KkjlVoop46PW20Jlca2ZJMHvKd0stl0hZl0cMf7qsNO4xpDd+ls1z+6Qh3KA3obeyf
 8fSAiaiz6ZZRFr1QpBc7CM+LVFAHnKh0n5NwQ5f6uRVhSiIQPC9gFcazs9zB1vVvX+xH
 cCN5UnTjPWt2IGCxgzv025cFjk9cG9Wqg4dTyB3SqbQx55hSOk21NWrJuZZ2rQTK1K4c
 6vNwGbLKMCEUk6lVq5JLj6kOZUISNC2YJyT6DcRdzIn4E/LvMKvVvB0EfVCgbNPemoN/
 66gisARJlqxFI3UY7mPvi17YHcZ0SLiJ4hgEAy+R6NcTJ9wnfDcaSQF1TnJM+V1Bn5lU
 IxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AVzzG3mHFPsuqM2JRCy5Jzl40BEHC7YkQgKLxYxD8UQ=;
 b=hqi+58iZcOOzRevRyASH4xfzTJ6KYCzJORxex9V2or01FZk7Sy3Dsf28jbFwKo+N4E
 F6Fl60AgNOA/bGu9CrdtpHox4GZrBHTiPWlkDD04I6yV5AJ3sWo+Sn8gikObW5SX0L+q
 BTTg6pquHT6Ba41IwpN+PjqfhoZ+POrEO3BIJn7e4SGbzF9Q+cKrvMFdSu14COHSp01m
 Agu0nu+vKCksVrdQIbX4OZ9UsxA3zejQUyRLAtcBxSnW5IxDzxgRzrAMfh8PnsROkMxz
 f7O5DCcxh7yufkqGCAhQcvgv3jcGAmhEhu6ZqxIE6q+25enfbFAAbF3IDd9cCnjhtYVC
 9B9w==
X-Gm-Message-State: AOAM530GhHIiQ2Pwh47H03V7DnnrS0rf49s4jIpGlMiKlBaReS8PvprM
 0Rr0Fv3X/eEKQ1zHSjhXjavey22s1Dn5vQ==
X-Google-Smtp-Source: ABdhPJzwO4Pdnm1rqKNT6GXb4lB9o6CmT/jfYAOOUvNJm3Ebvdx8hv7ZawjmoyReWAlTs3qOT7DmJQ==
X-Received: by 2002:a17:90b:4d06:: with SMTP id
 mw6mr5326424pjb.190.1594378239856; 
 Fri, 10 Jul 2020 03:50:39 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:50:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 04/65] target/riscv: fix vill bit index in vtype register
Date: Fri, 10 Jul 2020 18:48:18 +0800
Message-Id: <20200710104920.13550-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

vill bit is at vtype[XLEN-1].

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eef20ca6e5..a804a5d0ba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -98,7 +98,7 @@ FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
 FIELD(VTYPE, VEDIV, 5, 2)
 FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
-FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 2, 1)
+FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
 
 struct CPURISCVState {
     target_ulong gpr[32];
-- 
2.17.1


