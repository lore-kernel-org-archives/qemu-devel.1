Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915BC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BA32068D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHJSIus2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BA32068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMD5-0008Pt-FP
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9u-0004Ck-69
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9r-0002mN-Kg
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604747603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEc+RfmAYP+OhFOJ5aN77pHj0CJAU6+TLoy2UhjPLRw=;
 b=cHJSIus25DGhsljLCAhLESJVpwU2hqwh5EcBgiWx8XKueQKr/y9pyO5fFCrUD1elMQ9hDa
 OUPwL9b5YCoNUrPsmAs3jLYwMX1NC4RbgmTzVXq8wcI4nbNqs7yghSN11ZIyNOHb4oIXRN
 Uky1Q6dgcTxLzxuciHXjZb2VawYGKLk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-1whLzy5NO02YNNMotoHoiw-1; Sat, 07 Nov 2020 06:13:21 -0500
X-MC-Unique: 1whLzy5NO02YNNMotoHoiw-1
Received: by mail-wr1-f69.google.com with SMTP id p12so1609363wrx.3
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uEc+RfmAYP+OhFOJ5aN77pHj0CJAU6+TLoy2UhjPLRw=;
 b=PSWqf1UI2uETqGSRuMCgEjJ4LPs/elj9eAgnNzqXmgs8qxfVyeIDEHdyXAFxi4mx0F
 b7FsLaL9Qm7CeDKek+Kk/U7oJp1Msla6NPLVZj3k3kySyX5w4Qrp6MEKHkoq7shRjwO7
 2iQoXd5GlDw3oTO1qMLtXq6uH+Qsm03q6GKiB1Dz2RZO48VcwsfmDQmMgmrAJcYBjzxG
 fbnSUR07vxWTMSXt9Zij0Cv3du6pai82gkWb5oByHaYAsgle/BpQGkvsBpzDHYvMzAGD
 a8hgi9ulaiTBWWbJJAK5idmKUvhXIBvF/lHkPJkP3xo2bljaahiXTA8CZPy1cZV49fYJ
 5giA==
X-Gm-Message-State: AOAM5317GCfOHmFVmbRFYk/IuRVhyJQu/TFkR8kc2weqgm8CvcY4wFa7
 mwjoR9tKYk/FZKvVIcmZxjj2NF8Uqq1XjtQzpN7nnhVGjCiVCEsTC3uXvl+NOK8ldfA2snD7Fyl
 mWYDSzLJ/zt7K6ew=
X-Received: by 2002:adf:9407:: with SMTP id 7mr7867166wrq.182.1604747599815;
 Sat, 07 Nov 2020 03:13:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVpeC6Xv6gCRGdypwoYxSe7zVaQAbjeHiaM49K2Z6APXIuHn4Aq+FO7cIQpsENG2FeH5nm5g==
X-Received: by 2002:adf:9407:: with SMTP id 7mr7867149wrq.182.1604747599649;
 Sat, 07 Nov 2020 03:13:19 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y2sm6096468wrh.0.2020.11.07.03.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:13:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/5] hw/usb/Kconfig: Fix USB_XHCI_NEC (depends on
 USB_XHCI_PCI)
Date: Sat,  7 Nov 2020 12:13:04 +0100
Message-Id: <20201107111307.262263-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107111307.262263-1-philmd@redhat.com>
References: <20201107111307.262263-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
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


