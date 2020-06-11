Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EFC207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuE+WBuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EFC207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU8A-0003Ig-CO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAE-0001XD-1H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAC-0001NM-4D
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNt5J3B5SyxBKUNcwB+7h6Tk/wi7DwPIja8T9RRLV2s=;
 b=IuE+WBuSNoXOGDqIgTBfG2DQqT/lhjhbxbHjTj7gIvP1AXz6/0C9FJeGlV9tzujfS7gw0k
 BtdbwnfJ0IG74ndGpLxpkBWa+OxpfsrE8Gw3HkiHhgmAeUWKLUPltoWCli2xXvASLDir7q
 qCxuIlZPOsEq5T9XZxeyyGMeTE90ufQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-fPdDTtdYMoS-3w7ak-akuQ-1; Thu, 11 Jun 2020 15:46:57 -0400
X-MC-Unique: fPdDTtdYMoS-3w7ak-akuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C9918B8C61;
 Thu, 11 Jun 2020 19:46:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89F8060CC0;
 Thu, 11 Jun 2020 19:46:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 085/115] sysemu/hvf: Only declare hvf_allowed when HVF is
 available
Date: Thu, 11 Jun 2020 15:44:19 -0400
Message-Id: <20200611194449.31468-86-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

When HVF is not available, the hvf_allowed variable does not exist.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200526172427.17460-4-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d211e808e9..fe95743124 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -18,7 +18,6 @@
 #include "exec/memory.h"
 #include "sysemu/accel.h"
 
-extern bool hvf_allowed;
 #ifdef CONFIG_HVF
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
@@ -26,11 +25,12 @@ extern bool hvf_allowed;
 #include "target/i386/cpu.h"
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg);
+extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else
+#else /* !CONFIG_HVF */
 #define hvf_enabled() 0
 #define hvf_get_supported_cpuid(func, idx, reg) 0
-#endif
+#endif /* !CONFIG_HVF */
 
 /* hvf_slot flags */
 #define HVF_SLOT_LOG (1 << 0)
-- 
2.26.2



