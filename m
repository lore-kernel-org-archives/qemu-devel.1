Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D8C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121D921741
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoZqtaFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121D921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxIR-0003CS-3t
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCb-0004yN-MS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCZ-0008TL-92
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602506718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwG8iSHLZW0tTYCnl2ic6/t6qmfYl8jGlMpgEnOotCs=;
 b=LoZqtaFZ14PMiVG5YwWZDLriI0xjyU7gGSiWQDnxzOKLHb3cwadDmXh61qzcP0A40ySUE2
 MdBHKQ2YyjyqH2/HvUpEO+g/Lj8MJVewGgFov7OAbbgBhTP9E7hVojhpHOr9/MiNsDaQfr
 5mQmXpW3qfQOevb7Xa+m/mWEKiM/jJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-hoFV5ny6N6WiNJXhxgNeWQ-1; Mon, 12 Oct 2020 08:45:16 -0400
X-MC-Unique: hoFV5ny6N6WiNJXhxgNeWQ-1
Received: by mail-wm1-f71.google.com with SMTP id c204so5732218wmd.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bwG8iSHLZW0tTYCnl2ic6/t6qmfYl8jGlMpgEnOotCs=;
 b=bjYMktBwwQbsEEJhy2/x5u2H7L/kIt8z/hyR6cYl8CzNPzjXS+s8oz3S7mjlUYAyJI
 IL38Vfq9Sj3D9EhJxPDCQtz/jeEx92FQ7s59Ezov3eT4fTufJdPO/TF/r08Mng6kJQR2
 tSwJhZ1lA0vz31JJ4ISw7wwP2GANeBIHVYJdDUufTRJ8jYpc8Fs4mT37FcsImzDt3ZPf
 77x8vzCVqVh2PHGkhPTf56hSLraf6cZSHG7TRXadYJXlIEOb/CnJX8Sm5baJNWVc4mud
 yzKCAZ2SatBR61IRfZOnc4LZQj0JmCAzwFulh7Jhl0i3aXeRVnIhNbSkviwzZ4vMKfVz
 ycSQ==
X-Gm-Message-State: AOAM5300lW5ywZKB6nB8IeStYgpMqbcg5NQJhT11N0XSrGkB6VFjGcmq
 TgSKtxE2iM6gOp1kDIu9gHyH4Wr2X6uc4bJDGF9/o5E/g87j9hQSBvOcezjGBOiEYWMNyBXfG3B
 BfDp0jMfAxqUhqAE=
X-Received: by 2002:adf:dd46:: with SMTP id u6mr29753231wrm.295.1602506715237; 
 Mon, 12 Oct 2020 05:45:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyueR4JjpNH2sLzfTjSqD0R65Ts5ka4vohHBW3dn4ShgyH1BUlk0MTIhNUHnqavD80ySjglhw==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr29753217wrm.295.1602506715091; 
 Mon, 12 Oct 2020 05:45:15 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f6sm11016383wru.50.2020.10.12.05.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:45:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/pci-host/bonito: Make PCI_ADDR() macro more readable
Date: Mon, 12 Oct 2020 14:45:02 +0200
Message-Id: <20201012124506.3406909-2-philmd@redhat.com>
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

The PCI_ADDR() macro use generic PCI fields shifted by 8-bit.
Rewrite it extracting the shift operation one layer.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index a99eced0657..abb3ee86769 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -196,8 +196,8 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
 #define PCI_IDSEL_VIA686B          (1 << PCI_IDSEL_VIA686B_BIT)
 
 #define PCI_ADDR(busno , devno , funno , regno)  \
-    ((((busno) << 16) & 0xff0000) + (((devno) << 11) & 0xf800) + \
-    (((funno) << 8) & 0x700) + (regno))
+    ((((busno) << 8) & 0xff00) + (((devno) << 3) & 0xf8) + \
+    (((funno) & 0x7) << 8) + (regno))
 
 typedef struct BonitoState BonitoState;
 
-- 
2.26.2


