Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6226C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F88206C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alp95rrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F88206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIMy5-00062O-F7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 22:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kIMwG-0004Ei-BA
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 22:12:52 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kIMwE-0003eP-SG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 22:12:52 -0400
Received: by mail-pf1-x444.google.com with SMTP id d6so3041945pfn.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UZo00x5e0PgCE56Mxc+bsaLI7WCxdZMfP8+4vb35TnY=;
 b=Alp95rrdqAVJEIc5zWAXfeUhhW/9ma9I13QRsh72lpVIPBe+tB9H9E0BcSs/Np5qi9
 TkR9+808QsluR3H7jw69eCSr26DTPNowrm8pKUir5c+YXUigGFZBa5PJ6CndjkVPNyip
 2ba6ovMLBkcCDx/4vXWlcxfDgWJEmqYOBka0SWCD5t0THhePhex1zp/5oAAvVPwEOGKG
 dy9c6gSC6+Ny8SPd+LXRt1XRk+D1rh3AkEPVOBROyMJx2s2jQHXsC9S67HTkMlVlcwOi
 Bxh4wqepBHFU/Qe6Xvy7Fu9FPKG3/eZvEJXs8uee9Bqe8Ai/BSZrrhn7gXsK2RamaaOE
 VdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UZo00x5e0PgCE56Mxc+bsaLI7WCxdZMfP8+4vb35TnY=;
 b=SFCKiTgzkbrLOIdwD9HC2PvtEAusayqkyKvjt4odYJVmXK3w9OcAoFqjEoz1xrJvC+
 S2cr0GsmJur5tPrIUUjzFcsDxWPsrC6/qSYXagjSKv51etDKT+YJ0khaims8HwyssXmG
 GKAJzVG7YCYfG0XB/vm5InaG2g4gT1ERmMFZ9Q416IWsI93LYwSV8YRj9ZZXgpfShyqO
 58XFeesRAuzWTVkS/KWFbjSRmU/yfZsNMAEZM19nzpgNW2VKsqTvaOCrnW7PohTSw2/9
 2dMS1FM4f+0jrZmIUzRmcMT3HypKYv96v98PxpJV2+SOTp/+LcNP2+RQRdjRg8NdAB52
 bTIw==
X-Gm-Message-State: AOAM533XmtMUsaFJaKGRDPFZHTMVyL/l5mIvPHfx+npNh2TNSnaCK03N
 S51EAc0EgWqB6NqoW14Ut7I=
X-Google-Smtp-Source: ABdhPJx8UpuH7zd9QSc1U/aT202HcO4nuY5YVhJEmXPv0wuXlt1u4+gZ5ptvBu/kVy0gLxbOVSBb9A==
X-Received: by 2002:a63:4923:: with SMTP id w35mr16286724pga.368.1600222369700; 
 Tue, 15 Sep 2020 19:12:49 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id y29sm16149486pfq.207.2020.09.15.19.12.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Sep 2020 19:12:49 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V9 1/6] linux-headers: Update MIPS KVM type defintition
Date: Wed, 16 Sep 2020 10:12:19 +0800
Message-Id: <1600222344-16808-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update MIPS KVM type defintition from Linux 5.9-rc6.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 linux-headers/linux/kvm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a28c366..36a480f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -789,9 +789,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
-/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
-#define KVM_VM_MIPS_TE		0
+/* on MIPS, 0 indicates auto, 1 forces VZ ASE, 2 forces trap & emulate */
+#define KVM_VM_MIPS_AUTO	0
 #define KVM_VM_MIPS_VZ		1
+#define KVM_VM_MIPS_TE		2
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
-- 
2.7.0


