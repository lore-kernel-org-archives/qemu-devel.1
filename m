Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8DBC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB93207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNCXV00C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB93207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8W0-00061L-3v
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TV-0001E2-Vh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49152
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TU-0004nw-9W
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594923555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1YYfA/S6edNf0X620yHafKKhENPsI6sBNbeWo6Tc9Q=;
 b=bNCXV00CJetxAmUGnxzlKvEB3Le6ZTx7yCG59m+pliZdd985pDWqC6cndng2QQ6PY3u9KC
 /J8YW/sjgtYoO2OHzcaRJ1miul2HvxJ601TGnwttZplVXBOYIJPbugm3Vo3LseChZTWwPP
 PwmD2/Ft4L20//qsNAaMtRhAxL8a0xA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-x_RddnLPPzi52Oun-s97gg-1; Thu, 16 Jul 2020 14:19:13 -0400
X-MC-Unique: x_RddnLPPzi52Oun-s97gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9BC81009445;
 Thu, 16 Jul 2020 18:19:11 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8433310013D7;
 Thu, 16 Jul 2020 18:19:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 6/6] i386: hvf: Explicitly set CR4 guest/host mask
Date: Thu, 16 Jul 2020 14:19:03 -0400
Message-Id: <20200716181903.1895314-7-ehabkost@redhat.com>
In-Reply-To: <20200716181903.1895314-1-ehabkost@redhat.com>
References: <20200716181903.1895314-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 13:59:43
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
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

Removal of register reset omitted initialization of CR4 guest/host mask.
x86_64 guests aren't booting without it.

Fixes: 5009ef22c6bb2 ("i386: hvf: Don't duplicate register reset")
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200714090726.41082-1-r.bolshakov@yadro.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/hvf/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 75ba1e2a5f..587b1b8375 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -166,6 +166,7 @@ static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
 
     wvmcs(vcpu, VMCS_GUEST_CR4, guest_cr4);
     wvmcs(vcpu, VMCS_CR4_SHADOW, cr4);
+    wvmcs(vcpu, VMCS_CR4_MASK, CR4_VMXE);
 
     hv_vcpu_invalidate_tlb(vcpu);
     hv_vcpu_flush(vcpu);
-- 
2.26.2


