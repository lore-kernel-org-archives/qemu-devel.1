Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBB8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4172F22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtcl+Le6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4172F22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifT8J-00022u-Vq
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ifSLS-0002LH-8T
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ifSLO-0002wH-Se
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ifSLO-0002rv-Ly
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576172020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r69RStoSm0rMO8wwtIxPtrqT52+0T861lC3busDYwak=;
 b=Wtcl+Le6v0hhSRxyATrCtT8df+xLyJB0vS+Bnkx+nkxUKxSLjofZbTKR86yl3VMEX9Avb7
 A0/7IYgTVr+aBNESmy6y0qk7vWmC2hUixEpbkuQ09TRocAPgBsB7qf3/ZBwwknaGR4Z2uH
 f7RtG+4MMslpRUfRi/O89xEw+nPnp/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-ByIa6DMzPIaUClIcA_SxXw-1; Thu, 12 Dec 2019 12:33:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954F218543A1;
 Thu, 12 Dec 2019 17:33:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6A2419C4F;
 Thu, 12 Dec 2019 17:33:33 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v2 2/5] target/arm/kvm64: kvm64 cpus have timer registers
Date: Thu, 12 Dec 2019 18:33:17 +0100
Message-Id: <20191212173320.11610-3-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-1-drjones@redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ByIa6DMzPIaUClIcA_SxXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the missing GENERIC_TIMER feature to kvm64 cpus.

We don't currently use these registers when KVM is enabled, but it's
probably best we add the feature flag for consistency and potential
future use. There's also precedent, as we add the PMU feature flag to
KVM enabled guests, even though we don't use those registers either.

This change was originally posted as a hunk of a different, never
merged patch from Bijan Mottahedeh.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b8fe4d..5cafcb7d36dd 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -605,6 +605,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *=
ahcf)
     set_feature(&features, ARM_FEATURE_NEON);
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
+    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
=20
     ahcf->features =3D features;
=20
--=20
2.21.0


