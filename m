Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C232C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346152070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcQ2GtFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346152070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltoz-0005Uf-FH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkc-0005Go-3f
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltka-0004pw-CG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzPJeQjRBK5+iZmxJ5Gvby7lMszzXaOztv0gMLtPjmw=;
 b=JcQ2GtFpmw+Tkn0g3xJpBEbgpON3HOBbgclvaVBoUXzkbKn+8dcwrXF32FclFV6DUZz/0j
 0nIc+WJbPuhL/19GU8HkO3wQtIQ00Q+x2hje0s2IntsdOb/U5xS9UEqm7a2SNsq0/oJNBU
 kPTR/sfTj3PQkisLkBZOf/MVox8noUc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-lDJRLiSVMKaRCnlsJ8aF3g-1; Thu, 18 Jun 2020 08:34:34 -0400
X-MC-Unique: lDJRLiSVMKaRCnlsJ8aF3g-1
Received: by mail-wm1-f71.google.com with SMTP id r1so2529574wmh.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RzPJeQjRBK5+iZmxJ5Gvby7lMszzXaOztv0gMLtPjmw=;
 b=uXzPtMJfWM0QSSnVGoynpBoYulU2VskhFU7KBQH2zW6Qf4tVgqv5KvC4uMpfAxv1ZA
 Vyu1foH3N/9pV5aWvpjtoFw6BdOyFAGnDNG7SOGcffgeFd1ywjtC6nRhWANYPKhrsaF/
 ORWcCBMS3RwgwowZnnqMeyTyhcoomZAg5x/ML7nMY8ZNW0tD84HnL2Es78Wq07hQSVWu
 Dk9dRg9zitZbS7S0R2tkPEPCbEl54Qn0svWgMqtl63H09oMz5tRoFZDNvZBwjXooNw8f
 k1Dn0t/MFGkOsJGan2aK9nAMHuA4p7YoFeFJHdnV0y8WE2eezq1xbQxF6i57MaU4k8tV
 LebA==
X-Gm-Message-State: AOAM530CpgR+z1dMJbWioCzfa1U5kPyucPxV+suGty0a7VXW5BdU5kbd
 ksnMta62IR3Ze7CcgJd6FNKtzHThzPseQ45DvYB9RU1ZCg2op7f6uszS0HrGKM0bxU8tCfIFecw
 5mKe4QWuzYdafKAg=
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr3654854wmh.175.1592483672338; 
 Thu, 18 Jun 2020 05:34:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzlLqdcux/CQX940jC6Ga0ULC25jufXytTVmEmQ+wiaSMpBccQkZfTd9qcrxEiKY4PInWbBw==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr3654832wmh.175.1592483672113; 
 Thu, 18 Jun 2020 05:34:32 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id 185sm3385139wmz.22.2020.06.18.05.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:34:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/10] accel/tcg: Add stub for probe_access()
Date: Thu, 18 Jun 2020 14:33:42 +0200
Message-Id: <20200618123342.10693-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The TCG helpers were added in b92e5a22ec3 in softmmu_template.h.
probe_write() was added in there in 3b4afc9e75a to be moved out
to accel/tcg/cputlb.c in 3b08f0a9254, and was later refactored
as probe_access() in c25c283df0f.
Since it is a TCG specific helper, add a stub to avoid failures
when building without TCG, such:

  target/arm/helper.o: In function `probe_read':
  include/exec/exec-all.h:362: undefined reference to `probe_access'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.21.3


