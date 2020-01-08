Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA8C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772022067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEWvuMWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772022067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAlm-0000WM-QL
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWR-0003qg-4h
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWQ-0004M3-1p
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:15 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWP-0004Lb-Ry
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:14 -0500
Received: by mail-wr1-x430.google.com with SMTP id c9so3167376wrw.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G/wfhSCVdFYk0kyTP7PLIWQJ6W1w4exviX2br2pbzUs=;
 b=GEWvuMWMm0FIm13/D5imLf9jpwauudV0rGFLtWbzi/S4qLCjqKsfmZgeKaeEkWLFec
 /J1e2flm0k1kJGMfUxJjsCc5tmZZnQKghumyLyEpMSw1sMpMDX7GSvLkOXq3r/7dqCgs
 uMddYVZrY9WX4cdQsUp9TLjYFQ68mU8Q5lPSXeWAb0AwBsaoAY2rEPw4b4XgNuKO+xJ6
 /leADosfxomPK37njXS5JZiJg7drLG8M4lqifqAmeLmLT7Jjp0xtma/fkfd1DMGR7tjJ
 ORAtssJWHrOoxtC3+CaxMykaR17hmRH8i7D0q3Hg/YDY1n1KTZXlBkhlzYyNNFxjHctv
 DdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G/wfhSCVdFYk0kyTP7PLIWQJ6W1w4exviX2br2pbzUs=;
 b=j9batjcdpNIADDnBmBlYOyzHVRaev3oNfZ8SelU+3rKtbMDhTTdGyHM2sHb6Smu+TM
 R3IWL1XkKIMKesaGiaDfUhTUGJaAOQpP0npTF6Mk/GG/juQ8hkrZgOw43Gt2ey21pK0A
 roLss7IWo1KoYFghjsiQKsWaidaJ4Sjy7Fy2Q5C1XSfA1OdT5F6Jh9ImDeEFUsXVxByn
 49G3YXFs9QLPnA6s5R6CnvBz0l/7Qm164sI4LQMSnCsQGs/Qf8a3t+jLTQ9aGHlXhYFl
 6cBSLtV4SVk6MdkVkWt40uB6oOSIZyS7j32NEEvMJsu4CTP/h/YZJm7eBQi9RxV8naEQ
 zfyg==
X-Gm-Message-State: APjAAAXEbUnpgtkFvh0QDfh7TTbXJhwHbRzKrewDhjWP6EHcIo1qFSMx
 dmm7SNW4W5Tm35iJhuuvpxdpYMKe
X-Google-Smtp-Source: APXvYqxBLa9pMJtIac9q/Yyv/LI2wnh+TsNEOw5u7O+EArXvQGkkGNU9aSXzLrSkMh8oR83BzrZ98A==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr4406509wrp.378.1578486791670; 
 Wed, 08 Jan 2020 04:33:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] hw/ppc/Makefile: Simplify the sPAPR PCI objects rule
Date: Wed,  8 Jan 2020 13:32:32 +0100
Message-Id: <1578486775-52247-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The CONFIG_PSERIES already selects CONFIG_PCI.
Simplify the Makefile rules.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-10-philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/Makefile.objs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 101e9fc..79adf06 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -7,14 +7,11 @@ obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
 obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
+obj-$(call land,$(CONFIG_PSERIES),$(CONFIG_LINUX)) += spapr_pci_vfio.o spapr_pci_nvlink2.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
 obj-$(CONFIG_POWERNV) += pnv_homer.o pnv_pnor.o
 
-
-ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
-obj-y += spapr_pci_vfio.o spapr_pci_nvlink2.o
-endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-$(CONFIG_PPC405) += ppc405_boards.o ppc405_uc.o
-- 
1.8.3.1



