Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A02D208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0RIkySV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A02D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxFy-0007m1-UB
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCo-0005W1-OJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCn-00004y-1N
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602506732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afTxi5eJGUK9TCxtbNIddaNUCDX7pFC3c3DvHTcAqpY=;
 b=a0RIkySVoEBjFZcRPSurxBtRLGgyWPW2IOg2lN7wUDv4q+M9gxQp6t1ArhbZLmBt9ZWl6G
 ygNcBHrUSNkQ8SG9OoDObl2lOkkvRBwQK0mG+JMDlY1xTcz6V6MfOJp3q2glREqmInfilQ
 +Pp0/W5HQBsDtmXiwUPGYX6Bzp+NMPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-i2NSvxGNNo2nNrkNKnI9rw-1; Mon, 12 Oct 2020 08:45:27 -0400
X-MC-Unique: i2NSvxGNNo2nNrkNKnI9rw-1
Received: by mail-wr1-f71.google.com with SMTP id i1so1175190wrb.18
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=afTxi5eJGUK9TCxtbNIddaNUCDX7pFC3c3DvHTcAqpY=;
 b=VR9Tb6qE9tCpZmbk7OJlob5c+UHVQ6NnvENcGULhZFT3pe5ctNCLTliSb1eAnxhrd2
 qIJnZV7Q2Hi8vJ3JGnby9cepuL5muleOB2BjRVxH+8PTXkJf3CTuUXRWpK8D2Gth4YN6
 bhqa2anp84uJpkiAmI1gIu5VCfvhbJFOgBUlKB6TKuH48/VUCbawF33mWggMkcw2P+2+
 AtQq4ZN7HipKuHwAYE4puTGEUnmjD2SaOw9UgxrpT3SNzBOf9ht+ec4Ry510dgb/rJV6
 P5ZpmHYooZJTRgataEuN8sljc0ll3PCJqyowuBGPt1lHaN+qfbRgcF/4hS3TI07IJQsz
 7wYQ==
X-Gm-Message-State: AOAM531LP7kVK5UX5XmJonAh+JbJE7G2ZjvrjSaQJYea97Ls/8SotJcv
 EDc5fUfIWrI6KOpqQpRR0AiikjEdmkuiSY3nYNVGmxFMGuJZh+FatWRNhfzmv5Kh0qsELJbH01w
 uRtNnC1MJ4IM6tDs=
X-Received: by 2002:adf:df03:: with SMTP id y3mr10299492wrl.70.1602506726316; 
 Mon, 12 Oct 2020 05:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpp+5kB0ZYqB04uT+WIG2a4k9Wmj2oRtvHubS3HvdSiiZu7CRJnV3hLF0c9e7ixdPrjPJpoQ==
X-Received: by 2002:adf:df03:: with SMTP id y3mr10299453wrl.70.1602506726102; 
 Mon, 12 Oct 2020 05:45:26 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d2sm14916896wrq.34.2020.10.12.05.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:45:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/pci-host/uninorth: Use the PCI_FUNC() macro from
 'hw/pci/pci.h'
Date: Mon, 12 Oct 2020 14:45:04 +0200
Message-Id: <20201012124506.3406909-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012124506.3406909-1-philmd@redhat.com>
References: <20201012124506.3406909-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We already have a generic PCI_FUNC() macro in "hw/pci/pci.h" to
extract the PCI function identifier, use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/uninorth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 1ed1072eeb5..c21de0ab805 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -65,7 +65,7 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint32_t addr)
         if (slot == 32) {
             slot = -1; /* XXX: should this be 0? */
         }
-        func = (reg >> 8) & 7;
+        func = PCI_FUNC(reg >> 8);
 
         /* ... and then convert them to x86 format */
         /* config pointer */
-- 
2.26.2


