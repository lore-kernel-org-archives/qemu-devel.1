Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E27C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32C7214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmaHht/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32C7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0562-0004iS-U7
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iK-0001WC-4o
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iJ-0003bM-2f
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:36 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iI-0003YZ-Rz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id w15so2965758wru.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FY19DEE+QJS7b4V+GSCB1o9qTQC3ZKnckCvlTkoC0Q4=;
 b=qmaHht/X+mF3e9YGU+6QpGfIRrzqLPvM/WsOgN86v3dsF1B0IXzf7a315ME17osgh/
 kSrP0y4s/9nBINZjrGCR6lT7dpcOMsSxMqsMidQmJTyG6dAVNHf2sT6/RVpeH2J1Lsiw
 27R0bGE5Sv6eo+CObzbFpy78J4W5tRbsz1HGq6de04QM6b9P3aMU6yiFw+Fa7trE4gxI
 aYiC73jjbL3aJXDcpsCWK2QJvQiE3004V3hl8PKOt0J4YaaG6vC6m39iyDoyJJuNf+CL
 9VKvVtt8FVfSux7NUovppcXVL8dW6zvYjqMYlElzA4IKOtBonJlLgbftB3GsukqP9pE6
 +xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FY19DEE+QJS7b4V+GSCB1o9qTQC3ZKnckCvlTkoC0Q4=;
 b=larQQXK/DlJR0iMB9h4NasV5MNJ3BMnYKoOYTw98NR7qUGbcoZIIhWFbFO1+VMrYkw
 AgQjZdSWNBuO3Yw53Nf+zE4CsVoX22kfvLgLcNzRYWKxA6/L0jJoLLm50gNGHWj9xpb6
 s0l0WXviV25fiLMHHgsWIxLfuvPaKc4F1a+bKKu3NIRty0yTqgzMAja2CGNwKR71yOxI
 nEGOoMpNZLEmH8lDVLql57nlEh5hqI8H68Ykyg24RNwzGpeNzQGQLcKv9sGbMXp/ntIs
 gxXmGvm2ZcRxire0gIvYzeNNEZQjYaQms1cGLjK14TZd5m5FN3X+y4VNxPGD1majBtTM
 yByA==
X-Gm-Message-State: APjAAAUURI5gF3fTpNxI/kcM4C2Z2AzRwNedvp1fR5IZsEov1MEu0fK7
 bEKSNdkP4+HA5zi0GRp3fJvTsW62SSM=
X-Google-Smtp-Source: APXvYqxgSRwjeRkSIruvNZlbBKeMLDDWIFH9XIJMErQZFyRWaX2K4XJkgM9hy+RW+zDOG9BHQdZpfw==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr4854832wrq.93.1581086073667; 
 Fri, 07 Feb 2020 06:34:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/48] docs/arm-cpu-features: Make kvm-no-adjvtime comment
 clearer
Date: Fri,  7 Feb 2020 14:33:40 +0000
Message-Id: <20200207143343.30322-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The bold text sounds like 'knock knock'. Only bolding the
second 'not' makes it easier to read.

Fixes: dea101a1ae
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200206225148.23923-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/arm-cpu-features.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index dbf3b7cf42c..fc1623aeca5 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -185,7 +185,7 @@ the list of KVM VCPU features and their descriptions.
 
   kvm-no-adjvtime          By default kvm-no-adjvtime is disabled.  This
                            means that by default the virtual time
-                           adjustment is enabled (vtime is *not not*
+                           adjustment is enabled (vtime is not *not*
                            adjusted).
 
                            When virtual time adjustment is enabled each
-- 
2.20.1


