Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBC4C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEAF2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA1A05Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEAF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1Z6-0006oo-8W
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO1LX-00088w-SJ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO1LU-0002LA-Fj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601569334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ILVY5aeJqy2jKuyV4vgyIfzjSo6AsLHrLCtthdQdX2U=;
 b=YA1A05QlHHj8PDBaZEeNclE5Qausc67qCgrTEAwzB6/7mJI+mLoc4lqFztfNAvbnwfNJ7C
 PAoMt4d7XVBK+8uluAFQHi0Xo6DHvRWE3u2L0oUI00REvtfYpBfbdT4e2HXge7a0WgqILR
 ohdaD5BKZg1bcIoBUUjfpDgUpvJpGvU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-zNqA_OCXPzSNcvfiMYp9Aw-1; Thu, 01 Oct 2020 12:22:11 -0400
X-MC-Unique: zNqA_OCXPzSNcvfiMYp9Aw-1
Received: by mail-wm1-f69.google.com with SMTP id a7so1369124wmc.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ILVY5aeJqy2jKuyV4vgyIfzjSo6AsLHrLCtthdQdX2U=;
 b=i9BhgW4jqthvowka/gh3KYzY5Hwb52vWbuYl+CWMrQmhn6fHe260lojgLrRTGNrsXG
 dev06NCl9fI2XHdVpWv3MX/0CbWPFbg6q0D5xXD+Q+aTJPPCDOLrLIX3gTqUH0qbZqEZ
 ZJDd6HzD+xmLpvYhKWL3lAH5B3uVB8Mn58eUcJFLg6Um4vkp027I+7vfxLf9mAxL63bf
 9dKn7rYI9pjO5B1+b7BYcERgn1FxPLa9a7wCNMl/HVpzsIybPDrY55yw+0trRa95MOIG
 d8dF3M0Bmchp6dGxfAgoqiQOXkbRYKZcBZhyCG1Eq9ezoyJojHKHMsN6AKANTvxk53ff
 iAqw==
X-Gm-Message-State: AOAM5307pp+knP+2MQS14V4JXVxwIPHVVmrEzmY2o5h2w2z8Io9HIkmI
 MCjc6O0S30xq9WZl6plIXLJmh77hDxR4ONz7UiPFDR/wxBSjbspPyQD+N1w0hAoJ27nolNqwjbB
 QddGkGOk1f4tBSio=
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr861081wmb.32.1601569330307; 
 Thu, 01 Oct 2020 09:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFf+s9RlRrvChBS5D4yNrEsCEQpsSEQmQXCB8opbptFHAq11ZSYTGGTW4JFFsYRGnyhkN2cA==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr861057wmb.32.1601569330047; 
 Thu, 01 Oct 2020 09:22:10 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i14sm10626735wro.96.2020.10.01.09.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:22:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
Date: Thu,  1 Oct 2020 18:22:07 +0200
Message-Id: <20201001162207.1566127-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While APEI is a generic ACPI feature (usable by X86 and ARM64), only
the 'virt' machine uses it, by enabling the RAS Virtualization. See
commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").

Restrict the APEI tables generation code to the single user: the virt
machine. If another machine wants to use it, it simply has to 'select
ACPI_APEI' in its Kconfig.

Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Reworded

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 hw/arm/Kconfig                  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 9a94ebd0be..08a32123b4 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
-CONFIG_ACPI_APEI=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f303c6bead..7d040827af 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -26,6 +26,7 @@ config ARM_VIRT
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HW_REDUCED
     select ACPI_NVDIMM
+    select ACPI_APEI
 
 config CHEETAH
     bool
-- 
2.26.2


