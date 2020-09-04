Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE4C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC422073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOp6R/ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC422073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDB9-0006eP-HG
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8c-0001dh-2g
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8a-0007G9-CN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599231382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQCpSNO7veoJhtMx8Ih+Np7ociwkxkz+29u6+xfj2qo=;
 b=iOp6R/uepCeH3CuD8Gu1Eb0FZGMK0dHE0ZNXKh9YnIj9/ihTw3SwFJUt7g9ZA1HHl6gFX8
 G7bRConmSGS+rPJu8D6D8zaHUs0r+v19D/xSF5wJS2GwhfuP0SCoflu32VdyreS0uAg+1i
 vAUZxLpCxmouwOR+Y4evVimaR5oOs+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-e1eVaAbeP_KCXn6BQYr99g-1; Fri, 04 Sep 2020 10:55:15 -0400
X-MC-Unique: e1eVaAbeP_KCXn6BQYr99g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 401C518BA284
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:55:14 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5B547A1F4;
 Fri,  4 Sep 2020 14:55:12 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 21/22] i386: record if Hyper-V features were already
 expanded
Date: Fri,  4 Sep 2020 16:54:30 +0200
Message-Id: <20200904145431.196885-22-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a per cpu hyperv_features_expaned flag indicating that Hyper-V
related CPUIDs were already acquired from KVM. We are going to start
doing the expansion prior to creating KVM vCPU but in case KVM doesn't
support sustem wide KVM_GET_SUPPORTED_HV_CPUID ioctl this can't happen.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/kvm.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0aad60e0c707..c72755139047 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1669,6 +1669,7 @@ struct X86CPU {
     uint32_t hyperv_interface_id[4];
     uint32_t hyperv_version_id[4];
     uint32_t hyperv_limits[3];
+    bool hyperv_features_expaned;
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0945983498b2..961241528a5c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1225,6 +1225,10 @@ static void hyperv_expand_features(CPUState *cs, Error **errp)
     if (!hyperv_enabled(cpu))
         return;
 
+    if (cpu->hyperv_features_expaned) {
+        return;
+    }
+
     if (kvm_check_extension(kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
         cpuid = get_supported_hv_cpuid(cs);
     } else {
@@ -1361,6 +1365,8 @@ static void hyperv_expand_features(CPUState *cs, Error **errp)
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
+    cpu->hyperv_features_expaned = true;
+
 out:
 
     g_free(cpuid);
-- 
2.25.4


