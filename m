Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4AFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72420206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELuPXcs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72420206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNjz-0007XT-Cp
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTd-0000mM-H1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTa-00061c-8E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNPluIGqzQFzA2wtuOabw//XnigjK8NroKcshcX3968=;
 b=ELuPXcs4c7hj4eQQgd6IMHt16DsUSd8LOyfgYw0DbMFHGaZN883jvjNj5bhOhHMHV9kaSN
 WjqQofXCPpU/daY8sq8vHs+DjvLFvtmd86nXkpL7K6aDw+72EkODnFndmkeYwmqZL965it
 YXBEvsZrveEvk0UIA+2JRaIO0N0h1eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-4BMeOV7JPk6aF2eN_iSE-w-1; Thu, 24 Sep 2020 05:23:39 -0400
X-MC-Unique: 4BMeOV7JPk6aF2eN_iSE-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC24104D3E5;
 Thu, 24 Sep 2020 09:23:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A98DC73662;
 Thu, 24 Sep 2020 09:23:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/92] i386/cpu: Clear FEAT_XSAVE_COMP_{LO,
 HI} when XSAVE is not available
Date: Thu, 24 Sep 2020 05:22:10 -0400
Message-Id: <20200924092314.1722645-29-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

Per Intel SDM vol 1, 13.2, if CPUID.1:ECX.XSAVE[bit 26] is 0, the
processor provides no further enumeration through CPUID function 0DH.
QEMU does not do this for "-cpu host,-xsave".

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20200716082019.215316-2-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 23e9a17a04..7eb708bedb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6268,6 +6268,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     uint64_t mask;
 
     if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
+        env->features[FEAT_XSAVE_COMP_LO] = 0;
+        env->features[FEAT_XSAVE_COMP_HI] = 0;
         return;
     }
 
-- 
2.26.2



