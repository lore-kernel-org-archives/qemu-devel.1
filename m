Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76BEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EBA216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjWONevP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EBA216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia5XB-0000fV-DQ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 17:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia5SD-0005dK-Ta
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia5SB-0002LF-TR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:33 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ia5S9-0002IA-SI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:31 -0500
Received: by mail-lj1-x244.google.com with SMTP id m6so18788918ljc.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 14:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qc4fhvPidiFroBnj333xYm85MsYpPPDW+ASOMqwu3Z0=;
 b=hjWONevPmqr9P1/CJKMb5zNbQDTcZUL9RIaDEIj3ZieeKU+/yQ1Biae4yJ9YkpjR9p
 so+EXmmmVRFKxJ1T85Xh77aQyncWBVkP5cEGR8YMpionVvxViV1mP+Otm8mW5KKw6jVk
 0YjUnsoCFVkBB58a+5NQbtY8tcQkBz55fE9KlnzdxCFCBhMYbwX+zWl5Y3RII3PT7iRC
 e4CsBitaIHKEgoZ+bio/0Ksl1a6hRAFupex6/aiulfq3Sc7Vha7B70n2vHoXU/TDDKOk
 9XtE4sHjggmxEWqSo+v+7HRTCa51j7iY9bMYxEHvgJ/teoO+XqQ0qPeUR5XgrUmkaczq
 dILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qc4fhvPidiFroBnj333xYm85MsYpPPDW+ASOMqwu3Z0=;
 b=fX6HZuudsgrpUE1BxNGv9oRnkpoVCegXEz9PZ5IY1XBp76cOsQWPbIvksrbul8qhye
 rgt0TglVJAitXDMavKjiFEVOQLVLiC5dIyRJwBcvoSCbbpM2DmWoa4EpcIlDc2d1sgFH
 qIxyP7vQdsGHUnF4Oa1ulfYF2c1hGTAQfm3WppMsErOP7rU3Mm1bBUlQws18DlVvksCK
 xF2vuDnpRyrzUB3VNlqp/IRuiPhOH9hyM4rHlL+eDq9gerqgs5fioLyeh4KgW5Ube9JK
 5pnk0Ohumx0w8vUYCp4N7SQkWHv7XoJr+4UHkTRBX9gObrZqGxQ0PdEAvsiVXDoY4NWf
 u1ww==
X-Gm-Message-State: APjAAAVHuTh5AgUcd4tnADNj/oxpM54wQcnnpJi81apx8yimGiV495rV
 ZUqjsbjSrHZdc5Bd+6d0+1goL3BV+mk=
X-Google-Smtp-Source: APXvYqwrGIwLftk3VwmkyoE+XhsV58yTxHWQ1KqG2ZvSF83+fvJgtxwbbyXI0hQUsPdWni5MXx40mA==
X-Received: by 2002:a2e:898a:: with SMTP id c10mr31965170lji.177.1574892386973; 
 Wed, 27 Nov 2019 14:06:26 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id r7sm7655611ljc.74.2019.11.27.14.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 14:06:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] exec: flush CPU TB cache in breakpoint_invalidate
Date: Wed, 27 Nov 2019 14:06:01 -0800
Message-Id: <20191127220602.10827-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127220602.10827-1-jcmvbkbc@gmail.com>
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a breakpoint is inserted at location for which there's currently no
virtual to physical translation no action is taken on CPU TB cache. If a
TB for that virtual address already exists but is not visible ATM the
breakpoint won't be hit next time an instruction at that address will be
executed.

Flush entire CPU TB cache in breakpoint_invalidate to force
re-translation of all TBs for the breakpoint address.

This change fixes the following scenario:
- linux user application is running
- a breakpoint is inserted from QEMU gdbstub for a user address that is
  not currently present in the target CPU TLB
- an instruction at that address is executed, but the external debugger
  doesn't get control.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes RFC->v1:
- do tb_flush in breakpoint_invalidate unconditionally

 exec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index ffdb5185353b..1709b760edc1 100644
--- a/exec.c
+++ b/exec.c
@@ -1017,14 +1017,13 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
 
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
-    MemTxAttrs attrs;
-    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    if (phys != -1) {
-        /* Locks grabbed by tb_invalidate_phys_addr */
-        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
-                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
-    }
+    /*
+     * There may not be a virtual to physical translation for the pc
+     * right now, but there may exist cached TB for this pc.
+     * Flush the whole TB cache to force re-translation of such TBs.
+     * This is heavyweight, but we're debugging anyway.
+     */
+    tb_flush(cpu);
 }
 #endif
 
-- 
2.20.1


