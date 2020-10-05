Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B734C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C069920774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvcSP+yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C069920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSAh-0006jZ-Pn
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS70-0002TK-7n
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6y-0002BX-Jf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601910551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf8rK9xDa9svdb2z1vEaRvDMGoSCuMueC7BL1Ki37S8=;
 b=YvcSP+yM0+JIQeSSwdk0PSILmVELlUTpLwuMOiutzGluR9IqXCd1Iiid7koVX3iBJbg5jl
 ejeg306aArVrW+9TEq8fQWxYSzFoKLR9T18wZpBtOu1gnQLijISWyFevxUOdsjLWKiPhxF
 SLqzJM4oXuxWjn90BLeOpwobZzEmD/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-5M2C1SSUNEeC-MSYxztzRw-1; Mon, 05 Oct 2020 11:09:10 -0400
X-MC-Unique: 5M2C1SSUNEeC-MSYxztzRw-1
Received: by mail-wr1-f70.google.com with SMTP id f11so1932101wro.15
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uf8rK9xDa9svdb2z1vEaRvDMGoSCuMueC7BL1Ki37S8=;
 b=KaSguvczbQmY5/0kN3WctxL7Q3GO+P7SeLX12TnFDkq8kVEJ2lmX18XPUQgNS0NBPL
 trzx+F7LrSTvlahIq2DcsjTuaulDsYY7AhZXELYCmL+HdlJ14eyJJYA8k9P0GBoYPNCQ
 pZbgcAmUjN9cmpPIbhqD0qDJxBIA3+oL5m3MDIL1ZY7NNrhWkemJHWHKC5H+RFbcxzJG
 yMusl9FgJAZLdvt8eNeut0E36QlUWJY+ynLYpof0pHNDn17rKW6aYj+qodHFj2gG7ShD
 JhTwDx/OxX+xWIChh+2xQ95uHf3ZjlTeEVblmCSYriQBqgp5C0kr5LfMBp1BCeErqMlk
 KxUA==
X-Gm-Message-State: AOAM533sDbF3LLdgaV3iBp7xrria5TspZM1z3ud0zdndsNqocN/m5ipf
 rcFfOqDLjyg2Nu+Sak798CBzODU6ScdMUiOQnw+sXIrKPe7Yb/AurUE3W5/cltsU92zsRh9rbFc
 R94i3gOoq6P5ZYP0=
X-Received: by 2002:adf:f747:: with SMTP id z7mr4557059wrp.168.1601910547926; 
 Mon, 05 Oct 2020 08:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrHlXqcN7hi+PBf3pxvfT3E+nWElduDq15r8VzmSX3MaPPNVh4PUCZjX94hCT8/YMIXed88w==
X-Received: by 2002:adf:f747:: with SMTP id z7mr4557024wrp.168.1601910547733; 
 Mon, 05 Oct 2020 08:09:07 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k190sm11342wme.33.2020.10.05.08.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:09:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] hw/rx/Kconfig: Let gdbsim machine select FDT
Date: Mon,  5 Oct 2020 17:08:45 +0200
Message-Id: <20201005150845.2124381-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005150845.2124381-1-philmd@redhat.com>
References: <20201005150845.2124381-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'gdbsim' machine uses QEMU FDT API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/rx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index 2b297c5a6a..d1b1645ea5 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -8,3 +8,4 @@ config RX62N_MCU
 config RX_GDBSIM
     bool
     select RX62N_MCU
+    select FDT
-- 
2.26.2


