Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD1FC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1A321548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYwezX1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1A321548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHimi-0004Cy-0A
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikQ-00082W-2Z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikO-00024o-86
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEJ/RxZYJkU25hNvp9iS/FgHWdPQEQCLZNo0Yd5S9ZE=;
 b=IYwezX1vzfI4OJ2J1jwJwl7q5BArL3/Hot3uVahTK98/sMqz9XciOJQdRtaO+tGKys3NtQ
 7nwKji7YRKThpiiGoMLXi1+163eRU/cs2lhfx00yhp9a3xTs4yPUvtlQpVlRovL0dA8ToC
 79AmLHTasGX9kQsdixJh6+5xqCnjXMQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-rwE26L0NOD-CgDVoZ2AXaw-1; Mon, 14 Sep 2020 03:17:53 -0400
X-MC-Unique: rwE26L0NOD-CgDVoZ2AXaw-1
Received: by mail-wr1-f72.google.com with SMTP id a10so6460087wrw.22
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uEJ/RxZYJkU25hNvp9iS/FgHWdPQEQCLZNo0Yd5S9ZE=;
 b=sTz6/pX7chONIbl3kR7gvFLTRgH77i4Fd0aFJY6CeoG4oHosXuFyGWlAXBiuEPSXUN
 x0l1zDqUqaK3RT3IbEEn5hQJWvgDARY9RcHJ/17odfv2Ah4aabXlc9avIcg9UZ3wE8ho
 Ribp7BGm8MI8efD+PDai41tUqqhGfXa4Os5IzQHfywUgXx9Lau+nXfsPs3hheIIXMdB7
 MQ98eFbLkd1C9lOYHXA/+wQzGaqbGgYO6eBbtXkCCmUboBIsi/TA34+ZoTLwxZL9fHV7
 Ae/AhbUDcsZj+1bEKURvEar+eeF3OUWL9bL82hk4rjvG0cZ33UMD8z0SaZXZLBJ5Fpuw
 9s0w==
X-Gm-Message-State: AOAM5324N2C28rRxApUXdSwhtNR4PRzVwxZv4CcrNpR+R08uhSHJOqc3
 l0mNlHO+KZJTHbf/uTTzf0YfPYw0aCLnAIxfaf5NGh9RoOYeK14dPAEQnp43wcxkzlQv7eKOQWX
 rQ0y1fwfSWE2iel4=
X-Received: by 2002:adf:f101:: with SMTP id r1mr14235558wro.314.1600067872160; 
 Mon, 14 Sep 2020 00:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb9a/c7xaQIIDntiYb1q9mnTPlEaqQF1l63GFtTkvvNa8OreWhUXd2o4wk5zsKZebDxSdYBQ==
X-Received: by 2002:adf:f101:: with SMTP id r1mr14235544wro.314.1600067872012; 
 Mon, 14 Sep 2020 00:17:52 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m1sm17854077wmc.28.2020.09.14.00.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] roms/Makefile.edk2: complete replacing TPM2*_ENABLE
 macros
Date: Mon, 14 Sep 2020 09:17:16 +0200
Message-Id: <20200914071720.1099898-7-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At tag "edk2-stable202008", the TPM2_ENABLE and TPM2_CONFIG_ENABLE macros
are useless (for IA32 and X64). Their roles have been absorbed by
TPM_ENABLE and TPM_CONFIG_ENABLE, respectively. Remove the old build
flags.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908072939.30178-7-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 roms/Makefile.edk2 | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 7c06645c95c..8cdf337fc1e 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -89,9 +89,7 @@ submodules:
 		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
 		-D TPM_ENABLE \
-		-D TPM_CONFIG_ENABLE \
-		-D TPM2_ENABLE \
-		-D TPM2_CONFIG_ENABLE
+		-D TPM_CONFIG_ENABLE
 	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
 
 ../pc-bios/edk2-i386-secure-code.fd: submodules
@@ -104,8 +102,6 @@ submodules:
 		-D NETWORK_TLS_ENABLE \
 		-D TPM_ENABLE \
 		-D TPM_CONFIG_ENABLE \
-		-D TPM2_ENABLE \
-		-D TPM2_CONFIG_ENABLE \
 		-D SECURE_BOOT_ENABLE \
 		-D SMM_REQUIRE
 	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
@@ -119,9 +115,7 @@ submodules:
 		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
 		-D TPM_ENABLE \
-		-D TPM_CONFIG_ENABLE \
-		-D TPM2_ENABLE \
-		-D TPM2_CONFIG_ENABLE
+		-D TPM_CONFIG_ENABLE
 	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
 
 ../pc-bios/edk2-x86_64-secure-code.fd: submodules
@@ -135,8 +129,6 @@ submodules:
 		-D NETWORK_TLS_ENABLE \
 		-D TPM_ENABLE \
 		-D TPM_CONFIG_ENABLE \
-		-D TPM2_ENABLE \
-		-D TPM2_CONFIG_ENABLE \
 		-D SECURE_BOOT_ENABLE \
 		-D SMM_REQUIRE
 	cp edk2/Build/Ovmf3264/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
-- 
2.26.2


