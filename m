Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32661C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DEC208A7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzjhOI9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DEC208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWhj-0004qu-9k
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWgv-0004Qa-P1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:34:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWgt-0003je-AD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594301658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pDsqSQQ8gP0qR3ZQLjnVIJ/ymoSLCPmhFPtjAoidZQ8=;
 b=NzjhOI9kUigxCVzcH7DHFu+ATfk4OBWWvGr69c4h/46qYjLUIKa0yhBp7FeLXsfj6FGxLp
 b2JBxDwZsvBST7Uot+ve2pXWDL0GQ1nMN4we8b/bXN1/XpdnuosF1VEGGZwI9jYV8D1mtj
 fjPmuF61Rkaqvj91AoLDKeAdWD9Zhkg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-SdXlpLbLMkG3i0ZMkB_sFw-1; Thu, 09 Jul 2020 09:34:16 -0400
X-MC-Unique: SdXlpLbLMkG3i0ZMkB_sFw-1
Received: by mail-wm1-f70.google.com with SMTP id q20so2181695wme.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pDsqSQQ8gP0qR3ZQLjnVIJ/ymoSLCPmhFPtjAoidZQ8=;
 b=QVBi3E8cKZkCIWOtF47FT5C6wnU9qbIq9NFrDhKPuUke2bRhHVHKMYdlA2+6/W8xzW
 0Cr4o1aNM/wmqCNi/FAxNUgfs+eQ2ryLItjGfB9y3Xtru+jgEFTaG3TSkX9RTcNtNpz4
 rLHKpTavgdRT7LKLY0uF8dJl//96gxsFuPv6o+5mnVitf2LV620sG/ts2gN9E5iC2/l8
 HStgi4yUUL6/WzbnRX51R5UR0musXran4/SzsgipuvhGH+x/BEorKZcFKgPbFVZr0RvJ
 0je4q/L5bRl37tiQ4kWAeh43Z+hs2+3eIhQYRgIj0sVBFNF90hcGC01LdRGCmkio5Rnq
 C1TA==
X-Gm-Message-State: AOAM530P5A7+lzkFhoybF35CaX7NTRGdmOADU4geh1mpIXF/y/73MOYU
 hY2vvheU3GtGTFTueZ0mDxzSWGVMYZ9qAyla1HvJtHJoZjMRvOIo0+Ayqe8RGb0mYsfBEtkTCjQ
 eg7cQ3Ze7h7uusHs=
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr41127wml.92.1594301654881;
 Thu, 09 Jul 2020 06:34:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRjD47pMoPv0Pykkc+NwbLHI+zwl5flW3MmhaXslaZfGB8TM4R0VeYQvZVs/EBeKHXQ8TkOg==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr41031wml.92.1594301653713;
 Thu, 09 Jul 2020 06:34:13 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm6350358wre.6.2020.07.09.06.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 06:34:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] softmmu/vl: Include "qemu/rcu.h" for rcu_disable_atfork()
Date: Thu,  9 Jul 2020 15:34:11 +0200
Message-Id: <20200709133411.23929-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 73c6e4013b we let vl.c use rcu_disable_atfork()
which is declared in "qemu/rcu.h", but forgot to include
this header. Fortunately has never been a problem since
vl.c includes "exec/memory.h" which includes "qemu/rcu.h".

Include the missing header now in case we split vl.c later.

Fixes: 73c6e4013b ("rcu: disable pthread_atfork callbacks ASAP")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 softmmu/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index ecbc18ba75..f243745c51 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -83,6 +83,7 @@
 #include "qemu/config-file.h"
 #include "qemu-options.h"
 #include "qemu/main-loop.h"
+#include "qemu/rcu.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
-- 
2.21.3


