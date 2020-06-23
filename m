Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B828C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C7920738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6cIv/00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C7920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngan-0006Lb-7f
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWd-0006GB-KE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWa-0007br-SH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592909492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZQ1iXj/Bq+YaBfUtLyYjvldkQlNyk/VkfsOF9orImA=;
 b=C6cIv/00Au+ZCW3qI45aM3wn2F74bjDuOdE5i9qeU9qJa7nI7kKXUbhOWUl1aJjfte7YdI
 UnmjhNl8xkI8c1dSzgiWP9DwQVK70sPu/+xuO+eLhg+HmWXEsSsWOK651MKDcd7MxoDC1Q
 EnU6ZkrIgjukfth3ruZtv1npakf4c64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Tuaaaku3POW1ghMqPMXcUQ-1; Tue, 23 Jun 2020 06:51:30 -0400
X-MC-Unique: Tuaaaku3POW1ghMqPMXcUQ-1
Received: by mail-wm1-f70.google.com with SMTP id 23so3595283wmi.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oZQ1iXj/Bq+YaBfUtLyYjvldkQlNyk/VkfsOF9orImA=;
 b=EVkkqjLRd9o8d6LE7RLcl0e0Y+lCNGoa3SWB8wyGBtH77T+S4owa946N5LHKMiUJWF
 IMBV8qEtmUnlHv4OhWoEyoU+pXBx016pOfTISJQhTW9f+Wm+sLygHFV0x/ttNMrEXDKn
 dTLZsvgOBBbGN2IsuSwtR0Cfq5Y3QMfzG0n7x0eiI/zPnBc6w+ZIsTGNSsVHG7dJjop7
 RpmthCHfb78AgVjaxB3qUb8s9gNQCoUmYXwe1ORsGw4u4kRdnoI5JRMu/L3t+HOP/LV2
 t9AFy9t98xZCcMY28qnd1hrVbUyXk0Tkb/Zp6e6S3ib4FqCW0NEfGkW31eOb4FbK5yN6
 qI/g==
X-Gm-Message-State: AOAM5318SHD2fd+zOTKtdTOcpm38dwKIQ1Uw9JGDHmNsWnyhb1zvr3GP
 MpTRKg9kBVHahFcLkS0q0J5KuapCtgfbZ4Dx8D6G3QGR/4SeRcmbBF6cKcPeswt+kECvbt6f51r
 qPE7h08LYrQxYvz4=
X-Received: by 2002:adf:e50a:: with SMTP id j10mr26012279wrm.71.1592909489441; 
 Tue, 23 Jun 2020 03:51:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyuS/JbnpSn9OgQJWh9mW9to5y+6XJc1jU0fAPSPVWArLyfs8W2ovPuZhWk97kfUtl8tfn0Q==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr26012236wrm.71.1592909489238; 
 Tue, 23 Jun 2020 03:51:29 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v4sm6965597wro.26.2020.06.23.03.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:51:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/7] target/i386/kvm: Simplify kvm_get_mce_cap_supported()
Date: Tue, 23 Jun 2020 12:50:51 +0200
Message-Id: <20200623105052.1700-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the MCE supported capabilities should be the same for
all VMs, it is safe to directly use the global kvm_state.
Remove the unnecessary KVMState* argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/i386/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 19d3db657a..626cb04d88 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -536,7 +536,7 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     }
 }
 
-static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
+static int kvm_get_mce_cap_supported(uint64_t *mce_cap,
                                      int *max_banks)
 {
     int r;
@@ -544,7 +544,7 @@ static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
     r = kvm_check_extension(KVM_CAP_MCE);
     if (r > 0) {
         *max_banks = r;
-        return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
+        return kvm_ioctl(kvm_state, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
     }
     return -ENOSYS;
 }
@@ -1707,7 +1707,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         int banks;
         int ret;
 
-        ret = kvm_get_mce_cap_supported(cs->kvm_state, &mcg_cap, &banks);
+        ret = kvm_get_mce_cap_supported(&mcg_cap, &banks);
         if (ret < 0) {
             fprintf(stderr, "kvm_get_mce_cap_supported: %s", strerror(-ret));
             return ret;
-- 
2.21.3


