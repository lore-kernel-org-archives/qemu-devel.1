Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DE3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3FF2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNYPsGwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3FF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8UW-0002or-AI
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TS-00019X-Tk
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TQ-0004ma-MT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594923551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gz67eWvULgd0XWJXCmx2u72FxEioeNRL6S8wxfz1tu8=;
 b=DNYPsGwT1vJEfgQgrzLAwnRTBzgY7x32ilIFj6hfUmlP2UaBe7OZco6Bo1u5pXHc+bGK2U
 VX3RwYQYA5X8sVu5jPfPN3b8mfKomGnSaPHhOlfdCEKGmK/MzsLEvkc8SwP+wdPiM1ds0U
 QlZ4npoupx0uNV2puyKCZ4o1qeAaklc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-uGj__g66NfeMkQ40WSeMiQ-1; Thu, 16 Jul 2020 14:19:08 -0400
X-MC-Unique: uGj__g66NfeMkQ40WSeMiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7D51B18BCC;
 Thu, 16 Jul 2020 18:19:07 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A29272AC8;
 Thu, 16 Jul 2020 18:19:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 2/6] i386/cpu: Don't add unavailable_features to
 env->user_features
Date: Thu, 16 Jul 2020 14:18:59 -0400
Message-Id: <20200716181903.1895314-3-ehabkost@redhat.com>
In-Reply-To: <20200716181903.1895314-1-ehabkost@redhat.com>
References: <20200716181903.1895314-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

Features unavailable due to absent of their dependent features should
not be added to env->user_features. env->user_features only contains the
feature explicity specified with -feature/+feature by user.

Fixes: 99e24dbdaa68 ("target/i386: introduce generic feature dependency mechanism")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20200713174436.41070-3-xiaoyao.li@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index caf0334f3a..93b62b2eca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6371,7 +6371,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
                                       unavailable_features & env->user_features[d->to.index],
                                       "This feature depends on other features that were not requested");
 
-            env->user_features[d->to.index] |= unavailable_features;
             env->features[d->to.index] &= ~unavailable_features;
         }
     }
-- 
2.26.2


