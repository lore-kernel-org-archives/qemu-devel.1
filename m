Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A2FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808C021835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hy+f+QRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808C021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyki-0000N3-11
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybC-0004zC-6t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybB-00073j-8s
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:18 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybB-00072y-3j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:17 -0500
Received: by mail-pl1-x643.google.com with SMTP id c23so5121991plz.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ze57z0hQRkPeItK9rFzUaBjTkCWGyBz1l0/XVJKtpEA=;
 b=Hy+f+QRgGSc2OUx7cJ6809mCoVGKpGvLx6LOSbFFqqacS7CfrjZF4V9wKnEGvfTLnb
 UlLN7WGxUjjVeQzSYSRkxNm4jR2MSWH4RxbfdscbK/M3A16PR5SvitUHEpFZmZTDjJpC
 8X8zwzTr8FwlCRlCRrmEZoEoVnC1Ik1YdxISCPnQHUWxOUf5idBqzYxIviCtpaQ9cO+I
 IiKWMg6IV8G4gK+pF8t+azPNnrh/n8Ef6JmaE8nzPM6xtHrL+IKHHb0fvb178ItVtBz7
 tTrY3OfLcswHI0EqhXbBBYRZqXh2+Q09GFURnfoiF12leFG/K3DiQnA8hnm3gr4mk8A8
 50rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ze57z0hQRkPeItK9rFzUaBjTkCWGyBz1l0/XVJKtpEA=;
 b=FQrY6aEbEKghQMyOD3cRWZQKMtaSbRXO7EnoA1cKcLh/KD3H96Lwxo+28+j8RZ4/yi
 bjgjoEECrhvFqiQLGKICgvdw16YTdVPhraCyZHQIL0jp4Bk4p1qpMZfAs2mv2O/jsGb6
 4eca2HCcmBU4h3U6YrOy+mqyd7o8sghPwQTwS7V4opcT9sa6ZujORFR8zoqrCQIbKHqU
 zWtFukgyWiL++WCuz0SMYYvRuHKgaTA72nrVNkJUMy7oZFFGIj2Mr+GDQY8dy1AbN7kw
 qHTvlrwjUwT+cI44W98NsWYmY4PuCrCjxAO9Bfot22Cz4LtPTUjoYA+REA4GplmLZnpk
 ZhHw==
X-Gm-Message-State: APjAAAWmJgL+9zg2mgxW3DuzXHhrqq/W9JBkGaqtmJ39Z37JZzwSnDYc
 lg+4uXu8qI9ZtE1yTlLe8kA/T7YhcG0=
X-Google-Smtp-Source: APXvYqxaB3zRyL2yelTNFkq9GX5mgKihtEPsFpfCXXnhcB5PpbX0QLlLX+cmN+iMfUxkBFpW4bEjWw==
X-Received: by 2002:a17:90b:85:: with SMTP id bb5mr1938113pjb.22.1576534335917; 
 Mon, 16 Dec 2019 14:12:15 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/28] target/s390x: Include tcg.h in mem_helper.c
Date: Mon, 16 Dec 2019 12:11:39 -1000
Message-Id: <20191216221158.29572-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2325767f17..57ce17c252 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -27,6 +27,7 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
+#include "tcg.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/storage-keys.h"
-- 
2.20.1


