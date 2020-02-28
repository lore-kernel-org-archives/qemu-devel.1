Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71792C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA652469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEgOuzT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA652469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hjV-0005Zh-Ax
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgq-0000Yk-CA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgp-0004mg-84
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:36 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:32905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hgp-0004mP-29
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id x7so3474574wrr.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AtHbaaNp/yXKEKBhkcpvkZbIAOX8syg21QrKqfVwqLY=;
 b=zEgOuzT2jA9Cb7U0BFlCnzYlKD4P+GCGVW4AtDPvLke6bTJDHoFP0lflXNxg2NXy+q
 pci0jEkJPPq0e0a+zDwYiWOmI6EICwVt+qwdjU9Bh6GJyAP8TGnFmyRX6SrpqduZZWzo
 VY9EMNr/lR+oaQZ/xNn3vpu4nJARoQHwo4NDW5YcjCoiJSEAmoSowDLP84g9JXi4M3ok
 YJaZdJYHyVnPPuXsSMX6uvHZGciIMjM9vWnj6oSaMKicrlXbj3uMVBFbkUc/DkZlGmNc
 lyeuJ08hWcc7oCprAVr/CNJK1pH6iagdKk45nuJDJoOga24TgM9w0GOfY+H10f8posOd
 EpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AtHbaaNp/yXKEKBhkcpvkZbIAOX8syg21QrKqfVwqLY=;
 b=aozAySLCPiv8OMSeOSeXlI77B5YEn4X1kIQvJa5YTTWcCbKzikmN4X+L20lz1EzSFF
 TglqtGruJIG/sN/VIneh9y4rjiT21bpIE3TC1iz01xkyKb1G0K6BIHgpqddeOazXoSSc
 SWMj6d0pHF3E8JW10Qz4Awef918vCilfQdbzNgABctX0HlHIL+lNnFRuHevcWkVXgGE5
 wKykYxNjsMQMjG0/DE/wzclwVvX5lmvWnIHZF0Q3A0B97Vov1I41l9RIgbrfBEAisMm/
 gcw0EaHmJxakLkZJFXApq+1khsZ3A6oibQwFzlJmoJILVqNK8qjbVLIlXsOxObb/5ViC
 20pw==
X-Gm-Message-State: APjAAAUoNTAIGzZSuWXsxM5zKhEG9u6Utl2CzNocZG8QCEC1OgeRLXRt
 qr5YSt6XOw8/7fiPbgGsQlvSD7dUoLYXIg==
X-Google-Smtp-Source: APXvYqxUnId1yl4rgHeOcmVZc5xCu7+WMw3BgrG95FhNxKHpi5PSeYQBgPAPuL5yQxzbr7b5yasoUQ==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr5111945wrv.94.1582904193902;
 Fri, 28 Feb 2020 07:36:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/33] qemu-doc: move system requirements chapter inside PC
 section
Date: Fri, 28 Feb 2020 15:35:53 +0000
Message-Id: <20200228153619.9906-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

The system requirements documented in this chapter are limited to x86 KVM targets.
Clean them up and move them to the target section.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200226113034.6741-8-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-doc.texi | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 88e84300e91..40fab523f35 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -38,7 +38,6 @@
 * Introduction::
 * QEMU System emulator::
 * QEMU System emulator targets::
-* System requirements::
 * Security::
 * Implementation notes::
 * Deprecated features::
@@ -190,6 +189,7 @@ various targets are mentioned in the following sections.
 @menu
 * pcsys_devices::      Peripherals
 * cpu_models_x86::     Supported CPU model configurations on x86 hosts
+* pcsys_req::          OS requirements
 @end menu
 
 @node pcsys_devices
@@ -267,6 +267,13 @@ CS4231A is the chip used in Windows Sound System and GUSMAX products
 @include docs/system/cpu-models-x86.texi
 @raisesections
 
+@node pcsys_req
+@subsection OS requirements
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
+require the host to be running Linux v4.5 or newer.  Red Hat Enterprise Linux
+7 is also supported, since the required functionality was backported.
+
 @node PowerPC System emulator
 @section PowerPC System emulator
 @cindex system emulation (PowerPC)
@@ -1038,19 +1045,6 @@ so should only be used with trusted guest OS.
 
 @c man end
 
-@node System requirements
-@chapter System requirements
-
-@section KVM kernel module
-
-On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
-require the host to be running Linux v4.5 or newer.
-
-The OpteronG[345] CPU models require KVM support for RDTSCP, which was
-added with Linux 4.5 which is supported by the major distros. And even
-if RHEL7 has kernel 3.10, KVM there has the required functionality there
-to make it close to a 4.5 or newer kernel.
-
 @include docs/security.texi
 
 @include qemu-tech.texi
-- 
2.20.1


