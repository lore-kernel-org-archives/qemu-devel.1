Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52182C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168C72065F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H99QbdYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168C72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAmo-0001A2-9y
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAhD-0007iF-6j
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAhC-0002X7-74
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gy7eiStux+gIOMgnul3BY8RTTpwPoXMNvRdb9ailA+g=;
 b=H99QbdYZlw5jYNXmjJfzp1+0hRDiUvT0HvBOEUQuSJ55e6vhjfRnU3ekGmsawH01PrwHHN
 TQn3DCcyZEC+nzc70+RgCAsbxrKO6HeXtrwY4Q7kzDNC8DLfwMWHEce8jqtsoZ6r1/XAhU
 Y577WQQpl4qHPKysJ9wgPEZDTF0R3GA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-vKG6kTqIMCyLiCzVyUl6IA-1; Fri, 22 May 2020 12:38:52 -0400
X-MC-Unique: vKG6kTqIMCyLiCzVyUl6IA-1
Received: by mail-wm1-f69.google.com with SMTP id f9so4332386wml.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gy7eiStux+gIOMgnul3BY8RTTpwPoXMNvRdb9ailA+g=;
 b=gNq8kdNNcwE/RZ94obd3qA2TU2lQ/wIILA6O/bFdML+GjrJ6vcKBDb3LeQcm5o/1fB
 477oyeD4N0BpPdj7L8w/Kn1/69ZuLj6RpgVejDgvFYy44clIkMpAb6u4/olrYkr7bQs9
 z8OHAx1xd0gSIQK5PwzNXNvcS1Ai5j8cFXtGG4n6G06WxUEo89Asb3Ix1zzclR1gmxjH
 gbWz0cQxYtVkC4PgvCL0Ys2YKYxnzBz8DeA5N1Vrmyir/URs+33a8yFE5Vb/dOq/x5qK
 /8ZYljO4crAf3z8Y7OiGhVB3waBnePjY0/6tD128AOKrvI0bX4APegGFEYAu8bt4r4xS
 aZJQ==
X-Gm-Message-State: AOAM531fJNZK1RB7jwnFTUQK+cveBQjGCtXTzbY6DAU2VR4wXM1m2aDK
 36wYG4k3Zqc3+P9d2fd3KCaODocfLsOQ/YoDPrQiK0vfsCkpJJSh4VVe8YWbKwsF+3vlqKbfRAe
 cwdVMCnufdQtQTvA=
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr13388033wmi.37.1590165530643; 
 Fri, 22 May 2020 09:38:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVYmEkRhzhPHCzQmfXXsn/7a9w8Kd259MLPAv7zAsclWAkAaaGrfJT4Wok/II0vyc826SRFw==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr13388022wmi.37.1590165530496; 
 Fri, 22 May 2020 09:38:50 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b65sm10556819wmc.30.2020.05.22.09.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/11] accel/tcg: Add stub for probe_access()
Date: Fri, 22 May 2020 18:37:59 +0200
Message-Id: <20200522163759.11480-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The TCG helpers where added in b92e5a22ec3 in softmmu_template.h.
probe_write() was added in there in 3b4afc9e75a to be moved out
to accel/tcg/cputlb.c in 3b08f0a9254, and was later refactored
as probe_access() in c25c283df0f.
Since it is a TCG specific helper, add a stub to avoid failures
when building without TCG, such:

  target/arm/helper.o: In function `probe_read':
  include/exec/exec-all.h:362: undefined reference to `probe_access'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.21.3


