Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267A5C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA22F2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oR8N34j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA22F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYg1-0002ad-OW
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeP-000110-Ki
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeN-0005UE-NG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:04 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeN-0005MB-Bc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id q10so7534673wrm.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AeKWqQhPlzaWtXuwJ6mJcGzp66I0kbIvzpPBZPsWdUA=;
 b=oR8N34j842rt7k326qfgLtXb5GUAAgq6fMOj77oq/i9VYaO988l1ePPXx6f2WKEz48
 LZT4uZOGzE2HIVmVPaANbXLHMS0NootkolD63qdDFTHooNlxHSbwg+xnDw2DczhnTw11
 +zhSAqXzZ3jOsE/liQYdwpd3ZNTecLRBmKe827bF8gkL3l7YcrmavHk2BCXm22MEGYQG
 aZXQHDH+38gJxJDKEy48R+EPY222NUlsnC4uoCWUIgJbt5pP08AUIFu0fYxuH70sSeHU
 eXnlOKac1GYcALUia/Qi6UKw/vwqhrq3DOEdFoih9VY+z0ZxNBdS/hEWSDnh7Mevggzq
 BaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AeKWqQhPlzaWtXuwJ6mJcGzp66I0kbIvzpPBZPsWdUA=;
 b=saCom8+9npCYnZKAQV7Xxc0hlWxn6biCqHDb66JXVbdBOyuadAgeczw248cH3Ribmp
 nEd1WOcxDrRXdT3MhrzUqLZWeJ7oYNbWWumw67+Oc35M0zXdV36A+No5wlGq7y+5BYz6
 FVoi9JJYwojr1GaZmuRJCDTwcCL56+VJEsWIcSDPW1HOHzUyKbBXv0Ah0GPprRt0cvfM
 +XEu9KxKEuyJxKs/IXC1M/25Xi+g1rMP2kTtg3Cqi2wSqp7MknMwOek8dXd72jpmQdBy
 cxUKOTvQptwgoWwd72iLDucBy2sGhwVbVNZ75555zI7wGt2tNHY119wYji2GKtSS1ooW
 G/3g==
X-Gm-Message-State: APjAAAX1jyr8fv2Z7PJjBTIll103GaUf8GEiMaJXw3EaXpCyWa+Xch2g
 H64c3CAu9YQ33FA7VBpual18bQ==
X-Google-Smtp-Source: APXvYqyoxVwYmBCSZFrxvDYU2KhKmeANua4dMO+T/UGB6ErKNHWp0Y381Kv5gzN89GN8WE8wFjihTg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr10892246wrn.245.1578579541667; 
 Thu, 09 Jan 2020 06:19:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g2sm8139970wrw.76.2020.01.09.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:18:59 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E1F21FF8C;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 01/14] hw/i386/x86-iommu: Add missing stubs
Date: Thu,  9 Jan 2020 14:18:45 +0000
Message-Id: <20200109141858.14376-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit 6c730e4af9 we introduced a stub to build the MicroVM
machine without Intel IOMMU. This stub is incomplete for the
other PC machines. Add the missing stubs.

Fixes: 6c730e4af9
Reported-by: Travis-CI
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191220154225.25879-1-philmd@redhat.com>

diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
index 03576cdccb4..c5ba077f9d1 100644
--- a/hw/i386/x86-iommu-stub.c
+++ b/hw/i386/x86-iommu-stub.c
@@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+bool x86_iommu_ir_supported(X86IOMMUState *s)
+{
+    return false;
+}
+
+IommuType x86_iommu_get_type(void)
+{
+    abort();
+}
-- 
2.20.1


