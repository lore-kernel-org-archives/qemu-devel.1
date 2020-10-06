Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F558C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028BA20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxEZhLFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028BA20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhYs-0005uh-Vn
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQD-0002kh-Ku
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQB-0001R2-UQ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id h7so8607216wre.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UkhUWSEpBOxaKVYckqggA+lLHZxUS/KpnMFT6sdHjJM=;
 b=UxEZhLFNuUmrddxiuKs+XcUO4W8jnpIq0RABzM757Iet3kp82ueINWu/UxQReNhf/1
 xzu9thUOHlLI8l51OrYSB3dWgpPoYMusgNuElgF4vg5hVZG8fxg9EwmQ5wOjhfuC6TSi
 D2/62W5LZx+4I4lYDEfkLMCRH0QEHfRq2GdSO9IpKKDGegfggnURMCvqxgBcdLPuTrGD
 nOWd1aF9NxkMta5OoNad6A9vxTr1EJ1HxTvwWGO/ePmEBUclgeEYZO4BYRCnIQ0pZgSR
 itZwNZTFxZhrMuEYLJVT1LtDCFNw5qfLj6ET6UuqXwNTxDt+1h4rRCqr6i4xIUo9N3Bj
 5RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UkhUWSEpBOxaKVYckqggA+lLHZxUS/KpnMFT6sdHjJM=;
 b=Wn2i/UDI25pkhanGVqts85sc1py2xvYMyqB/JMjZb6YVWxHio8HKmQcpXcSNBxTC1Z
 ZA4FNa1Y5Bq3Uw+xjvPgVvHwWr/CJLVemVz5qn0JkBx5sW5EFf/G8P7uoCifDXXnMhQM
 xmUMQpAGltOzXxvVr4SugdzYW9DGgXZaRss0Wa7hXKsTEMbN/Ig32+10n8lvPnML0cZH
 FOFQts6rgs+kl9G7XHS6NdaN9Mujz6r0LXolrrNWmKiAXXw+ANcUVXBYmwGe/0fZSV6k
 qEbwFCfVYaA8G/zS1F264h+Sz237V/hfJFWIyH49eZZBN5ySK3YeYANbhZomtbruBWDX
 aiEQ==
X-Gm-Message-State: AOAM532fiyyz884FuS7wSm23MU0AzToNkXkgkYyBAheN6vnbnd6drohK
 YgS+nZgsOBZi+73kVTjdt487/G4VWB8=
X-Google-Smtp-Source: ABdhPJwwr1ADq9JiNuIbwJlLv31JlmKqdEXzfIg0HYRsXSEsCbMiyyoJCGkvx8HjDlYl8TMlhM3V4Q==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr3162809wrj.287.1601969402295; 
 Tue, 06 Oct 2020 00:30:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/37] accel/tcg: use current_machine as it is always set for
 softmmu
Date: Tue,  6 Oct 2020 09:29:28 +0200
Message-Id: <20201006072947.487729-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

current_machine is always set before accelerators are initialized,
so use that instead of MACHINE(qdev_get_machine()).

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-cpus.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
index cedd1e6c4f..da1c63d8f6 100644
--- a/accel/tcg/tcg-cpus.c
+++ b/accel/tcg/tcg-cpus.c
@@ -479,16 +479,7 @@ static void tcg_start_vcpu_thread(CPUState *cpu)
     if (!tcg_region_inited) {
         tcg_region_inited = 1;
         tcg_region_init();
-        /*
-         * If MTTCG, and we will create multiple cpus,
-         * then we will have cpus running in parallel.
-         */
-        if (qemu_tcg_mttcg_enabled()) {
-            MachineState *ms = MACHINE(qdev_get_machine());
-            if (ms->smp.max_cpus > 1) {
-                parallel_cpus = true;
-            }
-        }
+        parallel_cpus = qemu_tcg_mttcg_enabled() && current_machine->smp.max_cpus > 1;
     }
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
-- 
2.26.2



