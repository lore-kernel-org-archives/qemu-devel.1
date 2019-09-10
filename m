Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF662067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOgF04CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF662067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cy0-0003yb-Vi
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct2-0008PX-Kl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct1-0002ZE-Ja
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i7ct1-0002Yr-EW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so17835486wrw.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=H/RngVVAFC6u7kHobivBuj3t/ObQ9MDzihOX8Ue72qY=;
 b=sOgF04CL48muksHqhI07dFayZIhWRLSf/gA5sLdj76AxYXFgCzJYG5ATkmGXGL/AVk
 o2vSMPVxh/xYza11TbARaBim353aGDR1eXDWrUZri2cBSEYjpaXYwPTQwNWRBqr8qS4n
 5ruJjwYa+YBQ4CgX6mUqNgPYwfs065pf50IHBQr17V6WvJQIe9WgoW6LIey9y/Xc7FW5
 kpKFTvJSoJy+Na2037p6Wd0jMhWwRg9CVtH27nuidwcYr8Uj8cMZanF6rlYXCDYL3hJ9
 v2cOBro0+ND8ih3Yc7b3Ch1+jJfZzfNOVjzTDb0aCjdsKsn9WGfsShn6L4XegJWImRVm
 zHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=H/RngVVAFC6u7kHobivBuj3t/ObQ9MDzihOX8Ue72qY=;
 b=rU9ZkDid0f8KMMotYIf4xxJA3TMftnO/l+Yn6BKAngjFoVQXb+yjoO7i6vpYU7qyeI
 /m6NuI35zMA+jZ09qQZ491zhNd7xf3ii75pnWbun8O/g1qv7PVwc1vcsfsWkp8DVO0/k
 CkWEbtcKj6Yr7V5vYBmWpgLPpS8DiA2nkRIWdTRt4p4XAfwPBUmPWokylNJLskNbgOtQ
 HveZqfrELtT5f1FMwqrZM+bhoKH1dQSzeLp6zypD5nQgmMqoZd4fw95O8MdLDWsHOUFn
 Ck9L2dSO3CxoODohz8edHBzDqbpbGWGOa4N1se6lEKi9ateJ1DgacFb0CRVjEfLXO+mV
 3liw==
X-Gm-Message-State: APjAAAXh8gv3oOOiI/wngCGvfHilKLVLHAiHWtbRf9zmhQsc7popLlE8
 1fC5CRC0g5QjvmYxSURT2b5A5yoXg+Y=
X-Google-Smtp-Source: APXvYqynw70k2L8t8RmowQsUvN0lBgXakfaLuEGPmfoG2F/QkQFiC2CaQbvl9xzj5KI2IW0HFQ+2Bw==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr26631987wrl.81.1568109394391; 
 Tue, 10 Sep 2019 02:56:34 -0700 (PDT)
Received: from moi-XPS-13-9350.arm.com
 (host86-144-13-57.range86-144.btcentralplus.com. [86.144.13.57])
 by smtp.gmail.com with ESMTPSA id e30sm32403540wra.48.2019.09.10.02.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:56:34 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 11:56:09 +0200
Message-Id: <20190910095610.4546-4-beata.michalska@linaro.org>
In-Reply-To: <20190910095610.4546-1-beata.michalska@linaro.org>
References: <20190910095610.4546-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 3/4] migration: ram: Switch to ram block
 writeback
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to ram block writeback for pmem migration.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 migration/ram.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b01a37e7ca..8ea0bd63fc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,7 +33,6 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "qemu/main-loop.h"
-#include "qemu/pmem.h"
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
@@ -4064,9 +4063,7 @@ static int ram_load_cleanup(void *opaque)
     RAMBlock *rb;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        if (ramblock_is_pmem(rb)) {
-            pmem_persist(rb->host, rb->used_length);
-        }
+        qemu_ram_block_writeback(rb);
     }
 
     xbzrle_load_cleanup();
-- 
2.17.1


