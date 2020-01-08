Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A588AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB7D2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3VREGMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB7D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Oi-0004VN-Uv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IH-0003gK-JQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IG-0002wQ-KO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:05 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:39950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2IF-0002vF-SY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:04 -0500
Received: by mail-pf1-x42f.google.com with SMTP id q8so901359pfh.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hhHB6i0A+5MwcgIQSr5VNpYjYgYnhF/9Apso16V9eJA=;
 b=E3VREGMivbEy57IJX9Zc8ejNz2y28vCTzimJUMmUrGnPUnLU5/VPN63fYibCRapD0O
 hXW7mzHTT+mxqctZ/d06lzstGaD06yOmkeWPbY4yoWF6FnGbb7eownvtSm1jMZpWL8Dz
 3F4TEr4R2ZmjxWJ/Q219Eoprs1TiQwvCOkSpAso94t41/s5Rxyd/QsRy4O6BbkaXtJQe
 IQvR8Ef3I2eeMAmL0cuNVDdc6CB8MP5VZXW0yvAaT1cNwXb41qF9VEdNj4A3vhhzG7Om
 8gJOfm0H2jS1fESDyzJyi/wtofP5njbra4I0d+JBo5bk/ZdeaMsBhOUpbOHp4ZIo2Tpr
 Be7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hhHB6i0A+5MwcgIQSr5VNpYjYgYnhF/9Apso16V9eJA=;
 b=jsS+QfUHzua1vLCjfD5W/T6AYoi7BPQ5PnqyMv0Ja3GAtfOxZaWe/Zz/I3eoY4OlR1
 C7mrFEWmK8LFsEmLuyA9feJEgzJP4q3wiuOtmSejkA4R+0gUDuNAhHKZNSgnpimxd/ly
 uGZYeXp09BfY7Ee/O9S92T2H+AuJPchDVPpEP179y+0Ywr74clcIm4HeZoecumI4AJuI
 jT50cAmgGaeprwWJj9eHI5D0S3lPKkyHt0EwP2Wzf3gZDDnJu9ez+7ARU+wlBzeveaD/
 MduimhsSfjqW4hmqE8DPyIrq0Y66F6V43q5T03nQyTHY0hHQhxJNvqd28phrB0UvslLC
 GVrg==
X-Gm-Message-State: APjAAAUU4girJljl0a1ol0HvMbQkgJsaRkcHz3A/RdxSKoXzEqhdOMQX
 4EtQtapjpcaCZqzcyu9qBw2utdM0ddqiPA==
X-Google-Smtp-Source: APXvYqzrA2LFd1IQkFR2iTlkC2ijNKxGHeMHTolbD3apf6JrlFJbIMnQamklAJvPb41JR5C4MNaNGw==
X-Received: by 2002:a63:181:: with SMTP id 123mr3079272pgb.36.1578455162199;
 Tue, 07 Jan 2020 19:46:02 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] target/s390x: Include tcg.h in mem_helper.c
Date: Wed,  8 Jan 2020 14:44:53 +1100
Message-Id: <20200108034523.17349-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2921419c27..20a84b3912 100644
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


