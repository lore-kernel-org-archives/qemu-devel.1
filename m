Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F42C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191882084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM/0PUwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191882084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNpd-0007Xs-6D
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNoc-0005XV-6v
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNoa-0001ix-Gw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkSNcsho6DvA/UdVRqB8QxEaCIKTx2/65WBDZF1cLy4=;
 b=SM/0PUwLFrrc6Xpzr+h6d6+hARpHEuYdp6+CUqhOLWvWEws5Wl6hCUKkgzrKg+hpWdWYAH
 IZDED/iMzK5/eUWWmm+h8P/hhFQa7ljF/z24T8ZW+EiaiESbPfXBwImwdl7aw975WY9x/k
 bVp0/8yuW/M7Q0OtjXz3WbYrs7wFTxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-_FknG71kOmS8uwVFusLCjA-1; Wed, 02 Sep 2020 04:08:15 -0400
X-MC-Unique: _FknG71kOmS8uwVFusLCjA-1
Received: by mail-wm1-f69.google.com with SMTP id a5so1300402wmj.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MkSNcsho6DvA/UdVRqB8QxEaCIKTx2/65WBDZF1cLy4=;
 b=DmRL7hmykXNnD2PHWrK6ySoz8FR5G3SbBLwZv43JpqiM7i7MtHWE4ng0YQKCxhtxKi
 sK6A4Q2iujZAEseyLfab7x6tG8Rbqks/Gr4KSh2UmgP5Lb7ODiZ+lof+EDM+FEyjqHe+
 l++T4Y/bW20m7Uz4KUBDE2BH37F0gnLv5fnyztQwOJ3hLphd31GvfwA15x2DS0ZDBbLH
 tssk1BrTnZLvgw4ic0Goejpmv1GWScZ7Te6a6GMdistRDTsRqUuwZsBM6v2CJP+d1FXQ
 XDgVrYKasK1+bG8O3ysLBK4Ilmr+ajjrInTjCmSmSPUOEuhSe3c5qON2K9aF6j23Qvrc
 gTRg==
X-Gm-Message-State: AOAM531MG3D7D53By7T/8QMnTHtwg/6RjA2kXGv+Vhp7x6rOwMVI//HU
 xELx49M+keV42qSExw4gYPfIFlaX05Dxf266fwSRUzo2dLr3UFtldr0iFvBNCmCErShFSFqIt23
 rxsLzsclJY3RtqOk=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr6180031wrn.357.1599034094565; 
 Wed, 02 Sep 2020 01:08:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpW0HtuwgcfIsS0tmj4gTF5kz37mBKmxNbyWVAJiejxYlEqVGG4KgJToxdFjgwM6KLilLpuQ==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr6180002wrn.357.1599034094363; 
 Wed, 02 Sep 2020 01:08:14 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q12sm5217629wrp.17.2020.09.02.01.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:08:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/pci-bridge: Do not declare local variable only used
 for assertion
Date: Wed,  2 Sep 2020 10:07:58 +0200
Message-Id: <20200902080801.160652-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902080801.160652-1-philmd@redhat.com>
References: <20200902080801.160652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This variable is used once in an assertion. Remove single
declaration and access directly in the assert().

See in "qemu/osdep.h":

 *                                  [...] disable assertion is not
 * supported upstream so the risk is all yours.  Meanwhile, please
 * submit patches to remove any side-effects inside an assertion, or
 * fixing error handling that should use Error instead of assert.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/pci-bridge/pci_bridge_dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 4a080b7c7bf..10c521085d7 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -224,9 +224,7 @@ void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
-    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
-
-    g_assert(shpc_present(pci_hotplug_dev));
+    g_assert(shpc_present(PCI_DEVICE(hotplug_dev)));
     shpc_device_unplug_cb(hotplug_dev, dev, errp);
 }
 
-- 
2.26.2


