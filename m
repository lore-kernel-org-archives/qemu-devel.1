Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4255C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E962068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWpxsKJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E962068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7dL-0004bC-9R
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bc-0002qQ-F2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7ba-00059t-Mi
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTBnywXLaOQMIyRP1BOGtBwgA4JsTbKiYnIyA3r8z1g=;
 b=TWpxsKJw76lHVZC+jKHlNM86/1DWR6IJgEpWbTk6+f7YsFWWuA1gsYw9JWk/6u83PWI0qG
 xZ2D9MXRukJ1DE0V4CJzeK3jNFFHYX3QN4J4yI5pUSe1MVoV+OjpuSM1ewJgFmvymdM0My
 rOt52vcvJtPI4B9TrjVZpwp2PL7XYuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-3xATsw58MS6htv7VgtN3VQ-1; Mon, 09 Nov 2020 08:53:08 -0500
X-MC-Unique: 3xATsw58MS6htv7VgtN3VQ-1
Received: by mail-wm1-f70.google.com with SMTP id t201so2001937wmt.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bTBnywXLaOQMIyRP1BOGtBwgA4JsTbKiYnIyA3r8z1g=;
 b=V7yWC30WPhztc0H5olqbXUrQQALg8YAmn6X9gP9iQpr/KyfollIhN3E+41bgCt6bZl
 nZG5ABIT5C3zC9rF2qkrxAj2KIJk/HGKhPjCAzSoLvgmsMmslMz7mGqc6Fyv6LnWxY68
 kEa5REQOa1YKdG62jHKnI3Vm0h4o2jtyWGgLXkB4cqVgPbIg5k97ij3eay1aA6fnUP4p
 O0E4S7/AAk6+Y42kPO7PCVuzf+vdawAeuRwAbCvGD02nW2TU4U+/T+jWdC1u1ncYwLLZ
 QEmet1X0VcMdh0Z+ZzZCSf6pCFvfnb6ZVPcknCt2QKeaTLijqFtMwkcYn0NBcbKV3ikO
 lg0g==
X-Gm-Message-State: AOAM530Z+dliPLFAahfn3zt4hIzZVrA4lh7ca9WOdyjcTDcKcUDnc/d2
 hkoq+rtaoNIxhf98rSxPXdEfi2FrB128DR4IbZD8f3dTbXB5eEtOy5Kc/+p2Q3+XBcX/SICHzjN
 Ae04hUKeW1U3uLV4=
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr18009974wrj.11.1604929986981; 
 Mon, 09 Nov 2020 05:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1+hmulN5kQ0yjlLUIkXwQDlswViMOf3q0y15jRtb0PISBQWHAykNGp30Q1rBDv/c1UvgN9A==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr18009961wrj.11.1604929986863; 
 Mon, 09 Nov 2020 05:53:06 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id i33sm13707609wri.79.2020.11.09.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:53:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 1/4] hw/usb/Kconfig: Fix USB_XHCI_NEC (depends on
 USB_XHCI_PCI)
Date: Mon,  9 Nov 2020 14:52:57 +0100
Message-Id: <20201109135300.2592982-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109135300.2592982-1-philmd@redhat.com>
References: <20201109135300.2592982-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 755fba11fbc and 8ddab8dd3d8 we can not build
USB_XHCI_NEC without USB_XHCI_PCI. Correct the Kconfig
dependency.

Fixes: 755fba11fbc ("usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c")
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index a674ce4c542..6a213b04758 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -42,9 +42,7 @@ config USB_XHCI_PCI
 
 config USB_XHCI_NEC
     bool
-    default y if PCI_DEVICES
-    depends on PCI
-    select USB_XHCI
+    select USB_XHCI_PCI
 
 config USB_XHCI_SYSBUS
     bool
-- 
2.26.2


