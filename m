Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66962071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrMvV3Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66962071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjSj-0002a2-03
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iZjPJ-0007ln-0c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iZjI6-0007lT-Er
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:26:39 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:46587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1iZjI6-0007kT-7y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:26:38 -0500
Received: by mail-lf1-x12c.google.com with SMTP id a17so15407867lfi.13
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 14:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+Fx+vf32likHXwrbJij7DVsy01KxeAQ/wZxvM8xQt6o=;
 b=PrMvV3Tq6Y9OzpyN+wkUc4yZKBJyCEWevt6UtsFSr/3iLSiV5zlt8A99RSRkr9Sgmu
 LULz4Ou0jFtahvqUg25nikV5Ss1gnCEaelmJWQSxTltNUXxdt9HVZPP1b2MZ5rkvcGwB
 bqWHQtuOfMAILp5tKzXMlbgD2zmu5ByvpMjAZfgYSj6qvrOWALyZoNi/4sWdZrPPy62z
 NW4/HSeCMmhxNZ2Wc7vqcMuaGDVTT+gRmplZkYekVyKiorSTeViSVQqOcdF9JrQU6rQT
 rG86sm+WhVmF6bFgQYwteGU0goa1IMPPBDxVCIvuitY4kaK5DxOe1H7qN/UaYieJYnip
 ftYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+Fx+vf32likHXwrbJij7DVsy01KxeAQ/wZxvM8xQt6o=;
 b=dn9YzVMT/whv6NIwpHKUGKNG3sKjTPzEbQZ501uzWPVCoB1QYYnnv5RI8Qeq6QdNoa
 RFwhm8AdoEUJ+AoGQ8/AmABG+g8l/5YKB87wt4gqHZn88Rslyiu0j8GFFq+XIChoDvo6
 p2n+BbiCoWTBr7eAcPKoFH6G1II5/n1Pcpg5mpYTMbH5Vt398tO33Yn3ZPig7hyOjl2w
 oyZcd045+u4zssHVwrlcaOSZRe8/LSHrg17jFN9roqFwPPZJZaQIo498TFF5MeoZdH4b
 QkYk0YLwr0cPLVXaZmHhDu3YwfDK7Sqw94IPwiqkDsvqMkdif01qYFjbFUK6p22rlza8
 Cn6Q==
X-Gm-Message-State: APjAAAWbpBID7XDl0GN5/GF+kusVvgHbMKZzcnEJUuXBZanj+CQNuEc5
 Ge9w9lrBVQJNAmHgqhIAGvvqMYEoPPU=
X-Google-Smtp-Source: APXvYqyfubyGCtH4z4W58z6ClPk9FfP/R2+O6YNFKwhhbdtvieclnDd5E5bSfVGlnZiRwT0fPnJt3A==
X-Received: by 2002:a19:f606:: with SMTP id x6mr25589663lfe.160.1574807194818; 
 Tue, 26 Nov 2019 14:26:34 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id g11sm5897127lfb.94.2019.11.26.14.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 14:26:34 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [RFC] exec: flush CPU TB cache when breakpoint address translation
 fails
Date: Tue, 26 Nov 2019 14:26:07 -0800
Message-Id: <20191126222607.25653-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12c
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a breakpoint is inserted at location for which there's currently no
virtual to physical translation no action is taken on CPU TB cache. If a
TB for that virtual address already exists but is not visible ATM the
breakpoint won't be hit next time an instruction at that address will be
executed.

Flush entire CPU TB cache when a breakpoint is set for a virtual address
that cannot be translated to physical address.

This change fixes the following workflow:
- linux user application is running
- a breakpoint is inserted from QEMU gdbstub for a user address that is
  not currently present in the target CPU TLB
- an instruction at that address is executed, but the external debugger
  doesn't get control.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/exec.c b/exec.c
index ffdb5185353b..918945f8097e 100644
--- a/exec.c
+++ b/exec.c
@@ -1024,6 +1024,8 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
         /* Locks grabbed by tb_invalidate_phys_addr */
         tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
                                 phys | (pc & ~TARGET_PAGE_MASK), attrs);
+    } else {
+        tb_flush(cpu);
     }
 }
 #endif
-- 
2.20.1


