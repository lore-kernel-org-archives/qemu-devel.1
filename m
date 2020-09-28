Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA56C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7B221D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYgFVU8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7B221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtNY-0004ni-Ku
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMskW-0003c5-3n
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMskU-0008Qv-C6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:59:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601297961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNLoWuf3VWBMLbz8iFaGpHLsud63gIf1tGgS+8bafOY=;
 b=AYgFVU8JRVl+5HPS1Dtlc9sB+d0XXxBX4Dt7ZLzQwUinQOaXKU6ZKtNM0U/I7e3fwayq2N
 XQ4p39nixTqQ1re6y3CG6hp1SwFc9Qd0kNa+ecU0GTdRyJi+vxmj8JAK4qM5aTKx0+bDY0
 P/kegB7KDrM/7UnxShE7VNjwGsMb5lg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-NqNJUSGEM5WjiqJ6gcZdQQ-1; Mon, 28 Sep 2020 08:59:19 -0400
X-MC-Unique: NqNJUSGEM5WjiqJ6gcZdQQ-1
Received: by mail-wm1-f70.google.com with SMTP id c204so321396wmd.5
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 05:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lNLoWuf3VWBMLbz8iFaGpHLsud63gIf1tGgS+8bafOY=;
 b=LuEOCphDNLoYYtKNyZYxy3PJPab0blazhIMbYGSJogR8+3EfEraI/vlcNx2Z1jFRML
 lZ8pPGS9qfHnQPJ3Z7j7nIH+XPpusDECQWCEtJEtNmiQj+nMEXVkv9Ri2zLGOvZw/BQo
 C93zUeQ1MlJSqKg/gNuGzM7G9aO+TteGvA2PQITKytb2q2HcaDJRPbtQqJhNW+6Rra5p
 r4aMdvCyGDk335Ju+Ltip6BT6P7k7mNiazseSypP+FDJqmfGa0zhnrR1Q2rfPIjeCUrZ
 cnFbLneBQGqlsRbmSdNwJj7J1PIwNIrEn44Hfoi3KN3WYg4FxsrSBd6omLvIQJASkGKn
 4DUg==
X-Gm-Message-State: AOAM531CqDg3JZ5Jm7vzIJw6TyC261KrjZS9Wk7Q2Ui0jo1gkREuFI15
 9N4IrjbsEVfyGMD6y1zHBnM21zCzUeECYsordFxnuB+RTbkHXnPOaJWNSw9TSvKW0y4b4yS21on
 23yLjhfuXr3OQSEA=
X-Received: by 2002:a5d:5602:: with SMTP id l2mr1710765wrv.410.1601297957999; 
 Mon, 28 Sep 2020 05:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Dv01edvAvpJmhJDT9ncCo9xT2GQjpsNpprD/jVFhfQiV2PfWTdwUtIcF6CUX0ulciThpQg==
X-Received: by 2002:a5d:5602:: with SMTP id l2mr1710753wrv.410.1601297957839; 
 Mon, 28 Sep 2020 05:59:17 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h204sm1227917wmf.35.2020.09.28.05.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 05:59:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] accel/tcg: Remove special case for GCC < 4.6
Date: Mon, 28 Sep 2020 14:58:59 +0200
Message-Id: <20200928125859.734287-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928125859.734287-1-philmd@redhat.com>
References: <20200928125859.734287-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit efc6c070aca ("configure: Add a test for the
minimum compiler version") the minimum compiler version
required for GCC is 4.8.

We can safely remove the special case for GCC 4.6 introduced
in commit 0448f5f8b81 ("cpu-exec: Fix compiler warning
(-Werror=clobbered)").
No change for Clang as we don't know.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e10b46283cc..bf149bb824e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -703,7 +703,7 @@ int cpu_exec(CPUState *cpu)
 
     /* prepare setjmp context for exception handling */
     if (sigsetjmp(cpu->jmp_env, 0) != 0) {
-#if defined(__clang__) || !QEMU_GNUC_PREREQ(4, 6)
+#if defined(__clang__)
         /* Some compilers wrongly smash all local variables after
          * siglongjmp. There were bug reports for gcc 4.5.0 and clang.
          * Reload essential local variables here for those compilers.
-- 
2.26.2


