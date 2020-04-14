Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44BC2BBC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA4F2076D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/lkR0fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA4F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKOW-0007Xd-7P
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOKNo-00070T-Oq
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOKNn-0004o6-Gu
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:09:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOKNn-0004nb-AU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:09:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id h26so2626410wrb.7
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v6Zv+pX1jlJqPpGlzzS0UHccRy5au45iW1uB7VR0uRk=;
 b=A/lkR0fi6W7ZdKckfOiXkVnUHfqVDwqevglnG0zorUNwGX+Y981e96h8lc1NRmxIYm
 SzD+udUTZvDoOnyQAlKYwHN41FVFeSR90RpiMEF6I081FclcBbXRxwGw/dK2qirPFHFT
 wbzyDkZJJ1WfuQyGYvkfMcK15/GPvoISje721IzdlqPfYpBd6OXoXeST+fpa/Izl+isn
 7/IOHQpAgX2YT5g1rQ1oP0CXP/E2DLeOch/0+hUJlAKgvJjNIbGeHcx0WczkNb8L4Wvm
 dQ3D8gUgQte5bAGat9QhvTf5zV7LqvOLrBsRhz3GqyVWSrFDP5yEJAiDlIpMQfhUnENO
 JqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v6Zv+pX1jlJqPpGlzzS0UHccRy5au45iW1uB7VR0uRk=;
 b=qDz8m+XqUGWaor4gKBhV8EHK1xUpAIZOLh/UJRB3EmHUJ4Du3QrgSniTZm6YRrQYQN
 WoSIaG+B1iA70CSlcWWO3R+tCb2DaUjZ55a/G5mOBjgX+/jvq9ZSMO+M1/tvjFU2KtT4
 i/6dfqDhpH/lnyLPZwByqZUf948/Y8rXeSrtsi3Gb+qx9G6aBlEpxWek/B01OrD+cv95
 Ke5TFbSQC2SG2QwLu4kHFE8d1nUlAYks+fblst095UPY4pW+sLfu99W8TbBqWvB3vElj
 1Aeaojl1fIW8CYZO3sF7rmDRmkpXptEBzx4QArdoO8cwqSp5RY219I1MiDXGywa+1wfY
 BpdA==
X-Gm-Message-State: AGi0PuYEpne/XDYUTj2TzQsL6IME12fMhDouzytVDBmSh6cfwUodDPyI
 3/HESnQrxaY9ZhZG9Z5aLRvGhw==
X-Google-Smtp-Source: APiQypL4AVPq2x8qZxjW2MdmhGEHILQ3YVtv65jSuwNcDFiqttmXHcw2DSMCq9WZwOgYbQ/zTcVgzQ==
X-Received: by 2002:a5d:6645:: with SMTP id f5mr24741897wrw.280.1586866177813; 
 Tue, 14 Apr 2020 05:09:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i25sm18391406wml.43.2020.04.14.05.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 05:09:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [for-5.0] Deprecate KVM support for AArch32
Date: Tue, 14 Apr 2020 13:09:35 +0100
Message-Id: <20200414120935.12719-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel has dropped support for allowing 32-bit Arm systems
to host KVM guests (kernel commit 541ad0150ca4aa663a2, which just
landed upstream in the 5.7 merge window).  Mark QEMU's support for
this configuration as deprecated, so that we can delete that support
code in 5.2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I was reading the 5.7 merge window writeup on LWN this weekend
and saw that the dropping of 32-bit support had gone in; just
enough time to squeeze our deprecation warning into 5.0 so we
can drop the code in 5.2 rather than 6.0...

 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index c633fe2beff..3142fac3865 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -336,6 +336,14 @@ The ``compat`` property used to set backwards compatibility modes for
 the processor has been deprecated. The ``max-cpu-compat`` property of
 the ``pseries`` machine type should be used instead.
 
+KVM guest support on 32-bit Arm hosts (since 5.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Linux kernel has dropped support for allowing 32-bit Arm systems
+to host KVM guests as of the 5.7 kernel. Accordingly, QEMU is deprecating
+its support for this configuration and will remove it in a future version.
+Running 32-bit guests on a 64-bit Arm host remains supported.
+
 System emulator devices
 -----------------------
 
-- 
2.20.1


