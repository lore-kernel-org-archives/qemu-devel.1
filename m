Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C2C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568DC20737
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0TuT0aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568DC20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOSU-0005mH-Aa
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOR-0005M4-Nd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOM-0007ER-50
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOL-0007Dp-U9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id b11so3682561wrs.6
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=on6om2BuBSGRUVifgjuA6roTR5aDCOVAu/rIcJHMwjY=;
 b=X0TuT0aQyZUWlhshx4MZ4QyeKNdTTjoXjWjQ7/dbGceLuYeL9CstQI2U/LoC9sKbSh
 Xkb6pDIEWJzYRdE2SWPEqu8IE7xyUi8liBWsMa2HbFCV0JLMP9mlFb/7gxPJCmJeJgtU
 kKD2IjGyTyBNdcafCoY/gK4NQQelbsxBl35BXrmQ+YOD7pbJpl3VOJEzUA9iIfquKFGH
 pQJFv8dfMhJX20Q7kAmVbYSw0hbWfZK1NfoNLQIdFT4SfH54T1XTjfAy6fJJCieS31nj
 7nhG4MovcE4fgIJ1OW/Wle27eUr5ro+u4X04c4vnCnP+O9Carzn6C+PRu9BCwMWaagx9
 UqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=on6om2BuBSGRUVifgjuA6roTR5aDCOVAu/rIcJHMwjY=;
 b=BdmmilxJigM3tvBjzTKXduYzGcjvje7C7WTkjhN/ILJvifgiuYvNHviiQXgJB0JdWi
 CtsHDDJYFZD7nBcGO0bZjTuhWf5/+6So7JxRcop38cd9bYLtaid3XWoYveMsnN3TsdGl
 SYS5DEj3DA9q5X1MTaPxeuLCDVhBMQW4E5RjOW2jSCwmfXf48No6Xwh2WGPFNt/OTre+
 2nYMhtCi+vWUIvjsT7ABCwoo+HUoKCvZ6F62PHZxxLmHEBfiJBFy2qSqouyeXDndfF/P
 mq8PgfSouASDYLjU3AGGxm5FuiPZH1cAE+5J/Fvl5VBPF6RrWZ09+zbAjoPaW552ZIab
 EBCQ==
X-Gm-Message-State: AGi0PuYC8jNef4gLXwqn2nZWNxV9IPDWqNQEcmYmBaForYWp7PH6ePgH
 MzanI1kviOP3eJ02U+b2GaoIxmSMeJj04g==
X-Google-Smtp-Source: APiQypK8BWnC7SPHiI8Lbxda8XZnZ31FwqTuODzOzHJ8+uWdyC5pzB8YQkZJ8fA2tp8Ng0/rp+38ig==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr15019449wrp.294.1586881588674; 
 Tue, 14 Apr 2020 09:26:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] Deprecate KVM support for AArch32
Date: Tue, 14 Apr 2020 17:26:13 +0100
Message-Id: <20200414162613.4479-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
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


