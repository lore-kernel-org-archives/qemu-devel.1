Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7EDC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6244021548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYNfFSan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6244021548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHipe-00018D-CW
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikY-0008MU-6Z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikV-00025N-FK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwRsiAgwiuMJ8M0GDg76a+2Chg0wg2H4wvRAU+ZIZ68=;
 b=eYNfFSanknKMDOb8qzRIAeYk9F8XbOeH5wF9NNR0CutStyk5iwpWukR26OeOe+s5xQGV/w
 uXrgHM4sBceMy57joS1oq2+MSofykJ8gUN/kJjGOd/eF164slzeWO2Wjr2QuZrU/k+D9DR
 QaA20ggDNfuAqHgiXLFND3hdUNHcy24=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-adSDTHIbMCagWmdJPzaE1Q-1; Mon, 14 Sep 2020 03:17:58 -0400
X-MC-Unique: adSDTHIbMCagWmdJPzaE1Q-1
Received: by mail-wm1-f70.google.com with SMTP id x81so2132558wmg.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kwRsiAgwiuMJ8M0GDg76a+2Chg0wg2H4wvRAU+ZIZ68=;
 b=tC/jeBRcGdwxrFwgk4f4jcNzC+oMctnT48VR0aOWfD2eVMmjBQ+KODbn0CVRa0qW/s
 wxigbRzdnepEaC2QCVjC7GZhcZafws0wx/05K2FU42W/AhliETYUVHxcwmkaLva1H9Rk
 leLn2ChSgwIMLOBqsfvRMtu63hUcUVkRxfnES9zNpfv2O5Nc8af1w1SeCxIrznO+TIZU
 NGJVuXx11CN+uAYuA+nhe47BtekgcMbh0ZeyhxAc3fNvK5HA9a7MKlfGjRb7BF0iYSQd
 DZV1maDh/bQP0vR0pxtoIfNKg5UrvzNZ2jHsWhtwocFjAX6lf1w27Ynykq5bI6dFx3gF
 DMsw==
X-Gm-Message-State: AOAM531l/ZGKD1RmBrIMY8A9b0fID79zHOzcBeiqNR9JJKqGmXzxVaE8
 tVJ+bliOA7hrQnr2nE5hKPeBKuXqy9vynbcpZfiS4Cg/a7Lty/O0n/7O11ganC4AQcwYg/W8rIT
 Prf7KPMwk8XAWd+g=
X-Received: by 2002:adf:f382:: with SMTP id m2mr13652723wro.327.1600067876931; 
 Mon, 14 Sep 2020 00:17:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhTMFfzClwTwYTcPjK/+GTMHaihx/N+J3Nqwsc8vdNxgcVz3EIllZpLuQrWA31ADoUv/x9Iw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr13652716wro.327.1600067876787; 
 Mon, 14 Sep 2020 00:17:56 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l10sm18142419wru.59.2020.09.14.00.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] roms/Makefile.edk2: enable new ARM/AARCH64 flags up to
 edk2-stable202008
Date: Mon, 14 Sep 2020 09:17:17 +0200
Message-Id: <20200914071720.1099898-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laszlo Ersek <lersek@redhat.com>

Edk2 commit ffe048a0807b ("ArmVirtPkg: handle NETWORK_TLS_ENABLE in
ArmVirtQemu*", 2019-06-28), part of edk2-stable201908, allows us to
include the UEFI HTTPS Boot feature in the ArmVirtQemu fw platform (ARM
and AARCH64).

Edk2 commit range 4c0f6e349d32..0980779a9ddc, part of edk2-stable202005,
added TPM2 support to ArmVirtQemu; enable it as well. (Unlike with OVMF
IA32 and X64, TPM-1.2 support is not included, hence the TPM2-specific
flag names.)

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908072939.30178-8-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 roms/Makefile.edk2 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 8cdf337fc1e..a8ed3255757 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -64,7 +64,10 @@ submodules:
 		--arch=AARCH64 \
 		--platform=ArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
-		-D NETWORK_HTTP_BOOT_ENABLE
+		-D NETWORK_HTTP_BOOT_ENABLE \
+		-D NETWORK_TLS_ENABLE \
+		-D TPM2_ENABLE \
+		-D TPM2_CONFIG_ENABLE
 	cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_$(call toolchain,aarch64)/FV/QEMU_EFI.fd \
 		$@
 	truncate --size=64M $@
@@ -75,7 +78,10 @@ submodules:
 		--arch=ARM \
 		--platform=ArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
-		-D NETWORK_HTTP_BOOT_ENABLE
+		-D NETWORK_HTTP_BOOT_ENABLE \
+		-D NETWORK_TLS_ENABLE \
+		-D TPM2_ENABLE \
+		-D TPM2_CONFIG_ENABLE
 	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_EFI.fd \
 		$@
 	truncate --size=64M $@
-- 
2.26.2


