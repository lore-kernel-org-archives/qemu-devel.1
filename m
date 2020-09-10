Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D933C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926B220708
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfvytXJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926B220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGjN-0008Hm-Ny
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGb0-0005cg-9T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGay-0001nL-Mi
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGs5ABKm8y9Jc/D3T2fzKVj+EYzhUQk9uXM+DI2xiY8=;
 b=UfvytXJwaUshkoAXm5DqDY0WlAxkGs6JLz7inrVLQFBMqOghHj0HUW1dg2laFH8ZOp5UjC
 GT5LO2jfKjB2A/3+2ZzhLXYTdo8PlRb7lGhCrOlRBOMTvCt+VsHyu6QbD+Cuchj+Akdtbf
 3HVZbM8KX8yDEbf0bpbbxH/RXPhh+Zk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-jMlzLLndMmOstmn3ryW6Xg-1; Thu, 10 Sep 2020 03:02:09 -0400
X-MC-Unique: jMlzLLndMmOstmn3ryW6Xg-1
Received: by mail-wm1-f70.google.com with SMTP id s19so1042791wme.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lGs5ABKm8y9Jc/D3T2fzKVj+EYzhUQk9uXM+DI2xiY8=;
 b=DTVHUHG014dyP7x17s8IZPSbjd9xU79vS75vs4YPmU4fgAs0U652dZM2eBfKkZ4zUo
 K8Q0Q70FpQmMW8CyicYzSSTB+CU/8R7yIDVK1Hb7eHvta/ytR14kFSdL3aq25B/dUN3h
 LVvtXoDwHaKkJTpqUpo2qtX9zHF1u4+JGnohVRhV85uvxqXXKh8iutkTHwfwES7vaiSZ
 BzUcW4BDzINs5ZvxaFhXrrPj5MEAXzSpHVEToL3ZRh8c8ea4zvXdlVJDxtZ9paFRgoSC
 ckxvAh85eUCslEFowky1blstqQR25Wdl8JLuU7e89m+Uj5aseCldZbuvJR/uSeufzu0n
 n84w==
X-Gm-Message-State: AOAM531T6Hl9cZ1VPlZh/PtlBEzxeRHhG+1f5aokTaf0aGg7FVjxH0Fj
 S5UZvYXS8WyeD03vvULcu2qEy7MwxhRlVlGJUjOMj8rgwA7Sczcf8hXXi53IZqaYED1SSR8/F7Z
 PUt66REzCC30oFoc=
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr6890997wma.111.1599721328157; 
 Thu, 10 Sep 2020 00:02:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE0Z695VXU3e9M0JVMx/m5jixlhhfySuGaTkiZxpc9kM9WGt9z1mdGK0NlEetghntMunzOLg==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr6890972wma.111.1599721327946; 
 Thu, 10 Sep 2020 00:02:07 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m185sm2221410wmf.5.2020.09.10.00.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:02:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/i386/kvm: Rename host_tsx_blacklisted() as
 host_tsx_broken()
Date: Thu, 10 Sep 2020 09:01:31 +0200
Message-Id: <20200910070131.435543-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910070131.435543-1-philmd@redhat.com>
References: <20200910070131.435543-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to use inclusive terminology, rename host_tsx_blacklisted()
as host_tsx_broken().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 205b68bc0ce..3d640a8decf 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -302,7 +302,7 @@ static int get_para_features(KVMState *s)
     return features;
 }
 
-static bool host_tsx_blacklisted(void)
+static bool host_tsx_broken(void)
 {
     int family, model, stepping;\
     char vendor[CPUID_VENDOR_SZ + 1];
@@ -408,7 +408,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
     } else if (function == 7 && index == 0 && reg == R_EBX) {
-        if (host_tsx_blacklisted()) {
+        if (host_tsx_broken()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
     } else if (function == 7 && index == 0 && reg == R_EDX) {
-- 
2.26.2


