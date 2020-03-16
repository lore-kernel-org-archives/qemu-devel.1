Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C824C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E502051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufezYnnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E502051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsaz-0000gZ-Av
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqhp-0007PI-5n
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqho-0000bP-3M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:01 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqhl-0008Qg-Cq; Mon, 16 Mar 2020 10:26:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id b72so10017218pfb.11;
 Mon, 16 Mar 2020 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l70jAvVnYp9V72sa7a7DmNyd3hGe9AZcFFHBU2hoH0Q=;
 b=ufezYnnXNznbPxxeTZVCbSni/7kFFYJED4iNadNItvQSoVu9EEfMw6C2fbrFkMIt55
 Mjw0i/M8JdQpa5EGF/nGOMN8jBWJhXwJRF0BA+icpZRSMhaPul8m/wZz76fyTHY0Bswm
 n5PIAs4FP5AirFLKfFjsaeb305ZKuDhEqZVY+wbiOd3bSm2MEg0npz1GX/tuVTaCsT5I
 EAvi+ttQacE4sdjSQUV0kymtJNYos/3Xg/0j8HhBoHFrYICRzsHQ2ZnXvjd3HQ0jzM8s
 JVKiH1OKlEMtVA+kmh59N7/cvjpa+pfCQ6CksZ64wDMaBMojdCvp4yFWQevLpOkcIKaM
 DR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l70jAvVnYp9V72sa7a7DmNyd3hGe9AZcFFHBU2hoH0Q=;
 b=JGjm9GM1Y/+4D5r0yHoaJE5bl03EBwlOu7PnqaUgjOoecBFovFlZ8dhE/ABEsTnnJr
 IGx9VqNsFyrFtSxofFhjG9uM8wdtV3EI1BD9I/dSJk/uU9V+gRSge8rhrBB5iwRFdvnX
 peGflE+wIZRwDH8J+SveFK+TvS7xXTINhpUCSGu7HTluU1jHFT26zILPYQEpqkUOJOIB
 ZqO8uHON253/0mNJa5LwOWdXdxuCJN14DQxI6ItbO0WId1CCVrFPTa7+p+edGORLNgqw
 jZB+8zQ5f5Flvyq3epYFbshnZ3mH97PLbg4NfiMv/8KiQKVD8GeAtXD3qpoBcaRirIkn
 IT+A==
X-Gm-Message-State: ANhLgQ2iFpN55HeX+DMh1GBdiglv57svhSVyZjZdadXRs+3Sa/71TN/I
 Hfa/dCsz3KmGF4F1/kIRd5gQ/Rjl2JY=
X-Google-Smtp-Source: ADFU+vu4F1j7MgA4Rl/2uRuJnOUIJvLmlt9K9G7SImGXJHslr4pbu0VQqMT2Vu7Q9aUqbcqhu4+6+Q==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr122859pgi.33.1584368816180;
 Mon, 16 Mar 2020 07:26:56 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:26:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 1/8] ppc/spapr: Fix FWNMI machine check failure handling
Date: Tue, 17 Mar 2020 00:26:06 +1000
Message-Id: <20200316142613.121089-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ppc_cpu_do_system_reset delivers a system rreset interrupt to the guest,
which is certainly not what is intended here. Panic the guest like other
failure cases here do.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_events.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 2afd1844e4..11303258d4 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -785,7 +785,6 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
 static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    CPUState *cs = CPU(cpu);
     uint64_t rtas_addr;
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
@@ -823,8 +822,7 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
     /* get rtas addr from fdt */
     rtas_addr = spapr_get_rtas_addr();
     if (!rtas_addr) {
-        /* Unable to fetch rtas_addr. Hence reset the guest */
-        ppc_cpu_do_system_reset(cs);
+        qemu_system_guest_panicked(NULL);
         g_free(ext_elog);
         return;
     }
-- 
2.23.0


