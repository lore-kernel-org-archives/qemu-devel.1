Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70657C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC4F2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V32yNIzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC4F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7dk-0005e3-P1
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bm-0003Et-Dv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bk-0005Ea-I9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=medLDSYusB8YjCm6gdZ83ILtuaQLgway4LfVPfNsVbk=;
 b=V32yNIziaXUL+hqVnelotKIRgrAC0GfX/VArm9ou8+KLRgzuJpCeWZq0WdiYqw3bCWlKPI
 cu+Y1g7O4RNRWyGcM1eQd4E7MG33JdFxXW2Cx1aezMliHP+2lRVrsarzOicV8Besn0Pcmi
 2E1KUQfcxuZ6FCrfqMwlGwQqfL3o+QY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-CksNRRwCP5GHJB2M8RYxBw-1; Mon, 09 Nov 2020 08:53:18 -0500
X-MC-Unique: CksNRRwCP5GHJB2M8RYxBw-1
Received: by mail-wm1-f70.google.com with SMTP id 3so1995329wms.9
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=medLDSYusB8YjCm6gdZ83ILtuaQLgway4LfVPfNsVbk=;
 b=flJ4SLVsnhGN/aMTiBXrNOpbPz5fvp5rf9SuWoPdLSSmG3vr5vBq55ZeUagxLCSRdG
 Gx1suJC1sh8zQ/P7xKEX/uXgqL/pCuRRgsV+m4sgRj6O/R2kUgPjpGOctQFxzN2jKsoM
 ByPgila+5YOTugACsQLwiMDr8npx/A8iRckxu/X7JW1a6FzMoDTvZ8+0RS1m59hwbPWM
 LCJj+WLuWgw57YDKAnb9t2sTS+9sxzgUbfGUTNOKo9Blfl5Oc3fVObggRqa3ubcv3c2P
 f3T2Cbba9cQ3uSnj1VkZYU8g904DzZdRc/TUks9fMMwXPl1zhyW/Ht2L2qR3oTNNxncH
 8rsw==
X-Gm-Message-State: AOAM530tgDNXZLizoeD/R3EUWVSbEFT0oqRRlFKL83ozKveIoWf5Kleu
 nagOZAaCub0xdESJR3hGGnHk0UHYmht5XRr6Xp+9VyJd0I3lSbuZmIHthVVed4z2oGAVtAw1Mrr
 FVTl6vJafuTmTeAY=
X-Received: by 2002:a1c:a185:: with SMTP id k127mr11595274wme.23.1604929996505; 
 Mon, 09 Nov 2020 05:53:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwZRPeg9uhlkjNJxEkEkU67k7KaxGBk8Tcn3XXTmhuV1WZZSRBFxC7lRp34edvMwYipRdrBg==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr11595254wme.23.1604929996287; 
 Mon, 09 Nov 2020 05:53:16 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o7sm14093693wrp.23.2020.11.09.05.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:53:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v2 3/4] hw/usb/hcd-xhci-pci: Use
 OBJECT_DECLARE_SIMPLE_TYPE() macro
Date: Mon,  9 Nov 2020 14:52:59 +0100
Message-Id: <20201109135300.2592982-4-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-xhci-pci.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index aa2e890627c..cf9a180caa4 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -28,9 +28,7 @@
 #include "hcd-xhci.h"
 
 #define TYPE_XHCI_PCI "pci-xhci"
-#define XHCI_PCI(obj) \
-    OBJECT_CHECK(XHCIPciState, (obj), TYPE_XHCI_PCI)
-
+OBJECT_DECLARE_SIMPLE_TYPE(XHCIPciState, XHCI_PCI)
 
 typedef struct XHCIPciState {
     /*< private >*/
-- 
2.26.2


