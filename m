Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F013C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6993921569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8WvuPXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6993921569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRW1N-0004aI-IC
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRW0Z-0003h3-2A
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRW0Y-0008GE-Fw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:10:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRW0Y-0008Fh-3I
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:10:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so5497903wrs.9
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F8NopE3w5D4U8gKqvRC5FCkmgSEttj6BKclmVszN6JY=;
 b=n8WvuPXz61hrCmhLNRZiuZdGAhgI2oQhzvVYBhrSGVZSoVMqkDyFfSJ7Vbvn7c53s9
 6Wt6nV93o/krxfXSEmTCcqHpH+VQyTg6yTPU+6+Gib+yerVQtuZ/dWnN9K520hFqzxBg
 VficsYVbKG54aqSC34YuzdApdgMaijO0pPnbKcyYfCDsqXpVFr2CQ3Z2Ka/LQRULizAS
 R/2kVJir3FiTqcwHjQR2Y7MK0cyPkIoYLT2PfvtU+OUuOIJq2LTPt66WLYpvGvfkvUgQ
 e1aTErUjDgFKS5a8OhxQXuHhkrZy58/V2bjJARDq+2st6TZCWUbneoApa5x95CPiBNVg
 +qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=F8NopE3w5D4U8gKqvRC5FCkmgSEttj6BKclmVszN6JY=;
 b=FyKUk3nEZXcJdH94Jlhuf/FzzPVNMZgf709fTWX8WQNfQaa+Y2wesCPpg0DJDhOBSj
 1/khwOGtWTD8eEXQk15zyNQuZn6s7KqH03U9TdjyEvTYlmSMmC3CXPehQl1akDyD7UCn
 zBnGFcn3YbsczKqSOndNmGFQrPsmDGgjdM0dbHBk8Jc+ToXTdeUIygCHaS9uw8geTyI8
 x46+70t1lb4TyC0fZhCjzLZuB/eKwNP5+UFdVWgQthFkabPE7OebdPaWFXeDUUWUahuT
 5cgW3/9qqAKRz46yPH2CQhTb/5xAuHd7JpDl7HXK1ZtpWTimcijAsIwD2tzUlAepePiU
 p4HA==
X-Gm-Message-State: AGi0PuZnvWG3tjiZXbn1Zer6l2eT6D6Na08Kg1R0qcUfBghJAlxaGYt5
 1cQPOphKP5/IDuhmohT3AXGoq0JA
X-Google-Smtp-Source: APiQypIik3AtPEdrFyB+GCkOBemL75Y9OyAYkPdZ2WgsRg3LRyX9QXC1RAoizsCoahqdbjE3mjcEgw==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr3193588wrc.20.1587625848201; 
 Thu, 23 Apr 2020 00:10:48 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o129sm2367583wme.16.2020.04.23.00.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 00:10:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/tcg: Add stub for probe_access()
Date: Thu, 23 Apr 2020 09:10:39 +0200
Message-Id: <20200423071039.7010-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TCG helpers where added in b92e5a22ec3 in softmmu_template.h.
probe_write() was added in there in 3b4afc9e75a to be moved out
to accel/tcg/cputlb.c in 3b08f0a9254, and was later refactored
as probe_access() in c25c283df0f.
Since it is a TCG specific helper, add a stub to avoid failures
when building without TCG, such:

  target/arm/helper.o: In function `probe_read':
  include/exec/exec-all.h:345: undefined reference to `probe_access'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: Emilio G. Cota <cota@braap.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
---
 accel/stubs/tcg-stub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 677191a69c..e4bbf997aa 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -22,3 +22,10 @@ void tb_flush(CPUState *cpu)
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
+
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+     /* Handled by hardware accelerator. */
+     g_assert_not_reached();
+}
-- 
2.21.1


