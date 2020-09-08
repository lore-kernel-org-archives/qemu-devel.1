Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22072C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD790221EC
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUO+7oiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD790221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcre-0002XY-V7
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFcpf-0007Pt-CO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFcpc-0008NP-FW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599568479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H8Bt+SoGCwHI5v8vuo9aRmtnYuy2KkNT4W5PKJJ+pEo=;
 b=cUO+7oiwFG12NB9pkFrMxnq1JXWxb+xgP3VvFMbYRaFuB8uh7fjtjM4/WP3be3HVdEqybX
 oiaEQSYGI2XvgQCzEuvF0p8dCWEk9Gt07J4lC31R9FAJzqa+5nb5yWnuVCi02q/5ARvqrl
 YnHGTY/lcvOtqiuGClBCVmAB28pxYG0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-SAptONMiO7-QZtoc2Zrpew-1; Tue, 08 Sep 2020 08:34:38 -0400
X-MC-Unique: SAptONMiO7-QZtoc2Zrpew-1
Received: by mail-wm1-f72.google.com with SMTP id c72so3424056wme.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H8Bt+SoGCwHI5v8vuo9aRmtnYuy2KkNT4W5PKJJ+pEo=;
 b=XjfYv+87vXd30J7mz49vy9P1fcV2/i8R/ooDqAA7oBSLXIyP2/huc7pZkJyBolusR7
 bWRKPTiIrv3q8sD3ciUlk3sxuqruTxcpkfRCXfLXpCIT/rD/vE0xYg/X6ZmKxF74ZrSo
 vUXelt/AnITMhqomuHy2ZN5/5mDizv18sX7cnvnpnrfXJ9x3exPguw4CunnJwkpGx2Qw
 oQI1GeC0z941ef0gNsZELj/Mvcj4j8mrslhILgpKXos1o1DzIYsWsLjjfwLkCNQhvmpx
 dkOWRQj+k6mSygv8mtFszKCS3sFkSPPyOGj0E8s9bmARRXG8AVGVqhxwg6M9YtvImhaQ
 PjGA==
X-Gm-Message-State: AOAM531Lwdb2sLD2u1pVb756PhskiWgTx8LX4g+kKNdNPQqrJD38nKzD
 NvpRH6Jd0a50vdnaiXX37KgFKZ4SrzLNUCLZNjS0uJyVvPrfNup66oS47hDMyi/8Ua1pJEKToAX
 zVnIZo5+o4TmMF+w=
X-Received: by 2002:adf:a48d:: with SMTP id g13mr26245410wrb.212.1599568477004; 
 Tue, 08 Sep 2020 05:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHVDS7APNGfQg6onMvH5pOdGKb31yvi/vagMB+owAQf86vw4YlC+7eWYF0aReRutuR2PMNqA==
X-Received: by 2002:adf:a48d:: with SMTP id g13mr26245379wrb.212.1599568476678; 
 Tue, 08 Sep 2020 05:34:36 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b11sm33839733wrt.38.2020.09.08.05.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:34:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/core/cpu: Add missing 'exec/cpu-common.h' include
Date: Tue,  8 Sep 2020 14:34:33 +0200
Message-Id: <20200908123433.105706-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_common_reset() uses tcg_flush_softmmu_tlb() which is
declared in "exec/cpu-common.h". Add the missing header
to avoid when refactoring other headers:

  hw/core/cpu.c: In function ‘cpu_common_reset’:
  hw/core/cpu.c:273:9: error: implicit declaration of function ‘tcg_flush_softmmu_tlb’ [-Werror=implicit-function-declaration]
    273 |         tcg_flush_softmmu_tlb(cpu);
        |         ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 22bc3f974a2..63ece3662d6 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "exec/log.h"
+#include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
-- 
2.26.2


