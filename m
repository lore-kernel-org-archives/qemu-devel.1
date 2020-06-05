Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A054420772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2MSNl6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A054420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8kg-0002us-SJ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jd-0001Dc-QM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20832
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jc-0004c5-Vy
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtHXc08cU2h+YYoVzqMY8ITi4IAZMxthxIEDG0nzDUM=;
 b=P2MSNl6iL4Sif9v01wcTp23wGPbzj/C1ZLW8ShouEqaruu2t65NQHReMXkXRwAkuScfX6R
 jCMH5NwAUrGq92eLVWqY2SqyyjWu0+/8p0k1ZMLduPDv4DSy1mIqH1b76e0+FihFSkW7wO
 f75iS+1Vz3GBmWGq8Jw+fLHMM21Eugc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-vm1EU1ywOVu783GQoZuQFg-1; Fri, 05 Jun 2020 05:33:54 -0400
X-MC-Unique: vm1EU1ywOVu783GQoZuQFg-1
Received: by mail-wm1-f72.google.com with SMTP id v23so2813796wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EtHXc08cU2h+YYoVzqMY8ITi4IAZMxthxIEDG0nzDUM=;
 b=ZvNdxripsWhFifAh4on/6rI5LBqOEcXJ+N5xXQDvd3yByds8vdOBlbj5HirKmX89rW
 +BXkDEVKTCTTqqRFEVKjJ9dzy7Z6tHZJFmRddaA3jvN1/odjryyQq5lpvLUFaJW/b71M
 L/oDTNIf7tV3nH/lFCiCa2OXhEjFwmZEcUHJx7Pmc/4ITv8KRIIAkYQJ40fdiTJq7MWK
 EE3jdvNZEiLo2uZX78LOrcu3l7D5NNC09LR1nFgp/0cVr5EyXePXHGXq5wq1WOMCQylj
 wJGEmIYQT15snKxUDXhowe4N9zeuWbN8K0YIIPDvppz0GOyK5CO3sPWfY7pil1MgvNJm
 Da7g==
X-Gm-Message-State: AOAM5332MnE4Gj1MYaDGTusNBpFApVesye74wk+NKhomBvhTk30D8wDg
 B4ZTrcE0Qr8a1k87AyfRx5x5Ie7fF2ed6fTWsQlUaU+f3Ikg3qUUwshMR8msEgAPoFbQYayXB2q
 WPzIQlzFM57m3cuM=
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr1880238wmf.39.1591349633227; 
 Fri, 05 Jun 2020 02:33:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI+cTjnHVA5mX2eH/xmWP4N7Npk31SudfA0EC9OZMoJ39RugNubPmQh30H88XiveGB/Dnylw==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr1880211wmf.39.1591349632964; 
 Fri, 05 Jun 2020 02:33:52 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d18sm11283522wrn.34.2020.06.05.02.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/11] accel/tcg: Add stub for probe_access()
Date: Fri,  5 Jun 2020 11:32:56 +0200
Message-Id: <20200605093256.30351-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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


