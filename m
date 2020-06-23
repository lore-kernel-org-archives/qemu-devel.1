Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB19C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9897620738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj8O7cUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9897620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngay-0006eV-Q4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWX-000613-QI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWV-0007ZX-Rt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592909487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmjIgwRF8m2X82NXC/aF4wUlj0t/xV0oEGPCL2nLyv8=;
 b=hj8O7cUwD7lC3ZsoIB0UQzR/kyDkEysT2AJX18Y78ooHbD6sycLW+Csqk97xKVSn2xUQuO
 KfLtccpNWekxk/Gpuku2m1nKz+HEo3ZEUKxQbUM7rk8egy9DCxRu0tiqtteqCKGFRMQvcI
 gt0Vd4ik+0IrUPdzFoAaGrs/rHHgKFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-wLsuMfbuPjeyRFOKpsQEgw-1; Tue, 23 Jun 2020 06:51:25 -0400
X-MC-Unique: wLsuMfbuPjeyRFOKpsQEgw-1
Received: by mail-wr1-f72.google.com with SMTP id l3so5617210wrw.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qmjIgwRF8m2X82NXC/aF4wUlj0t/xV0oEGPCL2nLyv8=;
 b=V3+YKrI7w7KMbXYal0pomOOSDtENCJl54zz44tWk78iSGSKQi75CvHl5jnbNFftaH2
 sGnqwyntnP5+QD7IT2L8R5C3Ww/Z6XH57NQ9xnB8KkPTHcUEY5m4oC90MIK3r4rJi1hP
 /Bx+YIyd4j5EVUfrCvZeuyN2W+eur8VIm1p5J1QMzcDD2BsL+plwV9e2rYVJy99YQ7xp
 ECFPN3InjjwMghMQy9Z3bVA786c+P0Ji0pTJ5vYhRmf4PsaP38QODD+LY0/bxgUv27N8
 sr1H84jOCFl8VsWXz5t0+tz2HKuwnTcdSgNZAtfpZh4/fwlHqP1yQfqwWt/i9SVgMzMh
 +PcA==
X-Gm-Message-State: AOAM5313XYdLz0zlhdwGjB3Uop9JbMQhpxC6+4EYlV5/YdB812Is11rD
 1krbB7cxPk0MDZdWaVIQVWC9+nZX+AwzbB9h1nyUyEpdA4d/cgPAawdRfoXtBo+0oxLic0xPLDQ
 Vf9H03qd8/YNyJnE=
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr7100476wrr.176.1592909484049; 
 Tue, 23 Jun 2020 03:51:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlpmoxTmn90g70HUfnMorwjhE16MuS3RvWoGCm7N031I11kiIVc6XhUo8zzfA2/fxL4+l7Mg==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr7100432wrr.176.1592909483842; 
 Tue, 23 Jun 2020 03:51:23 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a16sm21190508wrx.8.2020.06.23.03.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/i386/kvm: Simplify get_para_features()
Date: Tue, 23 Jun 2020 12:50:50 +0200
Message-Id: <20200623105052.1700-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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

The KVMState* argument is now unused, drop it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 03df6ac3b4..19d3db657a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -289,7 +289,7 @@ static const struct kvm_para_features {
     { KVM_CAP_ASYNC_PF, KVM_FEATURE_ASYNC_PF },
 };
 
-static int get_para_features(KVMState *s)
+static int get_para_features(void)
 {
     int i, features = 0;
 
@@ -452,7 +452,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
 
     /* fallback for older kernels */
     if ((function == KVM_CPUID_FEATURES) && !found) {
-        ret = get_para_features(s);
+        ret = get_para_features();
     }
 
     return ret;
-- 
2.21.3


