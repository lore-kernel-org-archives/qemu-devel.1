Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2ECC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D740820727
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPFKI3we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D740820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVqc-0000LI-Rc
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVfg-0002Hj-6Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVfd-0003TR-5s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604069183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e0jB6jiJn8QGLsdv/mqDddEswZ7xIZ5m5iNf0wcCKNM=;
 b=GPFKI3web6D1g1SA6MFe/EK04hDwVzP69IEU/04DPId3S/Ea+SEtmWxXxdgKdK4rlUaAii
 W0R0gjOHA90/a956wA6XG/W18MDsIEwNwUS3iUj+mNGph5BNA3gz1l4HRPkPE+6TyZlq2P
 sJ1ienBpaT/myUOYZmNnsPVbVYtl0C8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-eWQs1EtbPjaTgRkqNzYDxg-1; Fri, 30 Oct 2020 10:46:21 -0400
X-MC-Unique: eWQs1EtbPjaTgRkqNzYDxg-1
Received: by mail-wm1-f72.google.com with SMTP id e15so704473wme.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e0jB6jiJn8QGLsdv/mqDddEswZ7xIZ5m5iNf0wcCKNM=;
 b=EMT9tKq9zmYmphHHUW8Ent5oDiupWkKg8xvGIgcm+ZvcDwzE/0Lr9aTEs/FbyFyYtW
 KEFMrDVna+8Jp8UexXz66rqEjFBg6ZxX/0YHv0Z1aHB5Oh8KTuPJIbvQ8kxxRYiQyF3o
 +p54IL9uBrcMoSVua5J1CQ0gdZAcvD43/xzizn5YcMrk9/YNM/1ZQl3kMfsqAZnYQxa8
 VQ7z6Iy0XOEVUqMNnrorq9kPTOPkWwHa/eOvv5ikePQqhDHEryKL8vO6xOUBm+7G6Snw
 MhdMbBj7VbxByAu7ncWmJm8cw+VYG54feqJUJSPL0EUt+DY3T2tzRxK2++g/gLSSCk+9
 grfg==
X-Gm-Message-State: AOAM5332+rmKF47ahVBCmTpnoKYsG4Kou2Dz2+ja8oV/VAQGv9xtnrc0
 x1HG/uqHFnH3hRo0ELlAtbhjBzmcbO2iwlKvV2l4ODcShni7myegUuiBigpLH8JvGUo3264e/ZL
 lu4wSH3fjWOS1uNQ=
X-Received: by 2002:a1c:4944:: with SMTP id w65mr3015455wma.50.1604069179854; 
 Fri, 30 Oct 2020 07:46:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUr6X7yNMxn8YF2IWie8ctUePIVGCuADg/qj5Kk4caGoNBusFpOh+kjRcV2BqJYWpVuKtBzg==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr3015429wma.50.1604069179625; 
 Fri, 30 Oct 2020 07:46:19 -0700 (PDT)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y20sm1132435wma.15.2020.10.30.07.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/arm/smmuv3: Fix potential integer overflow (CID
 1432363)
Date: Fri, 30 Oct 2020 15:46:17 +0100
Message-Id: <20201030144617.1535064-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the BIT_ULL() macro to ensure we use 64-bit arithmetic.
This fixes the following Coverity issue (OVERFLOW_BEFORE_WIDEN):

  CID 1432363 (#1 of 1): Unintentional integer overflow:

  overflow_before_widen:
    Potentially overflowing expression 1 << scale with type int
    (32 bits, signed) is evaluated using 32-bit arithmetic, and
    then used in a context that expects an expression of type
    hwaddr (64 bits, unsigned).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/smmuv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2017ba7a5a7..22607c37841 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -864,7 +865,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
         scale = CMD_SCALE(cmd);
         num = CMD_NUM(cmd);
         ttl = CMD_TTL(cmd);
-        num_pages = (num + 1) * (1 << (scale));
+        num_pages = (num + 1) * BIT_ULL(scale);
     }
 
     if (type == SMMU_CMD_TLBI_NH_VA) {
-- 
2.26.2


