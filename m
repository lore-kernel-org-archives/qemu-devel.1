Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A93C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05ECB21548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNa5oLzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05ECB21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHima-0003ud-Sc
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikB-0007gh-7R
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHik9-00022c-CT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P3Lz7UjzzU/d1z060aEklKNAaDMzZucdwToE6SczDk=;
 b=ZNa5oLzB4GXhwWWzdL/hgtUmRpS0eE52MM1RgfdtEG0XKMDxoYHn4muSTzMvjyvuT8/k2t
 jrERKARXhc5gaLXGigs6/b3CAKeo4OG7ifLaez9QpXd+S7KjSjAiqnWv5H5dBtG5aLgPEy
 lD0iCNTmnEnFDOyWTI4vgaqMptciOpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-dfIQCZy-N5CaWwmC0CO6Bw-1; Mon, 14 Sep 2020 03:17:38 -0400
X-MC-Unique: dfIQCZy-N5CaWwmC0CO6Bw-1
Received: by mail-wr1-f69.google.com with SMTP id s8so6499573wrb.15
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7P3Lz7UjzzU/d1z060aEklKNAaDMzZucdwToE6SczDk=;
 b=F/K2RLx/yGt3CNQa8jOcppYOvj7VnYyyS64hDgeUHKqufvWEeRJLXnyrELz/Oss9ww
 81Xxx6Y+fIMgi2gBjlGnOczHDI4842ruzsiNf7vc/A5svQkQHelYx3THIPv1GUEtfT3M
 cHRXyvu1quiYPKTEKfRcSYFnYgKHKMhWd7qvsNk9DQOpSSgxcbKcAhtioGTCSmTLZwsI
 30qOPnTZcP0X1pK2BcSZ2ZIqF2Ibm8i8jbsyuSY98QbHdA34q37PjpgnsvbxP54fm/9f
 CkQnZWXbjr7Ot+Dpd9dsn57AMbhtjyYqiYTgFgTZsKnnkkscfyA3OYKSQ5IMkL9dzBez
 ZafA==
X-Gm-Message-State: AOAM532gmP5uyJUR7ReC+iVlkvV0MkR7E06xw5CchrkGZ1Our5KtYuU6
 +aN1hILzPRvkFrrr1UgW8KPPpyTAKdWa98aUXVfrLNV0Hvlb/qyHVpHYEXv3NV1OAuKYAsYsmzP
 CadudPZfG+RZxfUI=
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr5739649wma.43.1600067857175;
 Mon, 14 Sep 2020 00:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8TfoRSBNHgrZAgYcyvJr/XR2NQjB3VO2cbmqUst9Mp5YZNv1MxWvtmUa04S6dPfuo923rfg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr5739640wma.43.1600067857022;
 Mon, 14 Sep 2020 00:17:37 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q4sm20794750wru.65.2020.09.14.00.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] roms/Makefile.edk2: prepare for replacing TPM2*_ENABLE
 macros
Date: Mon, 14 Sep 2020 09:17:13 +0200
Message-Id: <20200914071720.1099898-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
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

Ekd2 commit 07952a962a40 ("OvmfPkg: rename TPM2 config prefix to TPM",
2020-03-04), part of edk2-stable202005, renamed OVMF's TPM2*_ENABLE build
flags to TPM*_ENABLE. Going forward, the TPM*_ENABLE flags would activate
both TPM1.2 and TPM2.0 support.

In order to build OVMF at edk2-stable202008 without losing currently
enabled functionality, insert the new flags as no-ops now. We'll remove
the old flags after advancing with the edk2 submodule.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908072939.30178-4-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 roms/Makefile.edk2 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 33a074d3a4c..7c06645c95c 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -88,6 +88,8 @@ submodules:
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
+		-D TPM_ENABLE \
+		-D TPM_CONFIG_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE
 	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
@@ -100,6 +102,8 @@ submodules:
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
+		-D TPM_ENABLE \
+		-D TPM_CONFIG_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE \
 		-D SECURE_BOOT_ENABLE \
@@ -114,6 +118,8 @@ submodules:
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
+		-D TPM_ENABLE \
+		-D TPM_CONFIG_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE
 	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
@@ -127,6 +133,8 @@ submodules:
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
+		-D TPM_ENABLE \
+		-D TPM_CONFIG_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE \
 		-D SECURE_BOOT_ENABLE \
-- 
2.26.2


