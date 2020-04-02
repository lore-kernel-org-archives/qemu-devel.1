Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A18C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFC2206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkQ7E8iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFC2206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8Gm-0000H6-IE
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jK8DW-0002LI-5e
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jK8DV-0007cc-1d
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49454
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jK8DU-0007c9-UG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ3U51HON3TXLJT8Q2aD4tlT/7B2ruyUCI5f++GmHKA=;
 b=LkQ7E8iEuRD5izGncSYwANeNeT75kk3jsbJ+zxdeBi5M+18pwJIfKfoTSC3fUKIgh45ZMN
 m0If0ckc1t8kRq94iykqPc1UgkgIce76Bo8sBQPWact/WbsUKlIttZAmJmhh7mc5/5P6/K
 Hkn8fSF7W2k9RNR77LEs50m3ftzzu0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-qK1Dk4QSM8KQHtm1aAO3iA-1; Thu, 02 Apr 2020 18:21:38 -0400
X-MC-Unique: qK1Dk4QSM8KQHtm1aAO3iA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6589C18A6EC0;
 Thu,  2 Apr 2020 22:21:37 +0000 (UTC)
Received: from localhost (ovpn-116-71.gru2.redhat.com [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D5489F0A;
 Thu,  2 Apr 2020 22:21:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 8/9] target/i386: set the CPUID level to 0x14 on old
 machine-type
Date: Thu,  2 Apr 2020 19:20:50 -0300
Message-Id: <20200402222051.523093-9-ehabkost@redhat.com>
In-Reply-To: <20200402222051.523093-1-ehabkost@redhat.com>
References: <20200402222051.523093-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Luwei Kang <luwei.kang@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luwei Kang <luwei.kang@intel.com>

The CPUID level need to be set to 0x14 manually on old
machine-type if Intel PT is enabled in guest. E.g. the
CPUID[0].EAX(level)=3D7 and CPUID[7].EBX[25](intel-pt)=3D1 when the
Qemu with "-machine pc-i440fx-3.1 -cpu qemu64,+intel-pt" parameter.

Some Intel PT capabilities are exposed by leaf 0x14 and the
missing capabilities will cause some MSRs access failed.
This patch add a warning message to inform the user to extend
the CPUID level.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Message-Id: <1584031686-16444-1-git-send-email-luwei.kang@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6ad24774c5..f3b25c7301 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6356,9 +6356,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, Err=
or **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
=20
         /* Intel Processor Trace requires CPUID[0x14] */
-        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
-             kvm_enabled() && cpu->intel_pt_auto_level) {
-            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
+            if (cpu->intel_pt_auto_level) {
+                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14)=
;
+            } else if (cpu->env.cpuid_min_level < 0x14) {
+                mark_unavailable_features(cpu, FEAT_7_0_EBX,
+                    CPUID_7_0_EBX_INTEL_PT,
+                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu .=
..,+intel-pt,level=3D0x14\"");
+            }
         }
=20
         /* CPU topology with multi-dies support requires CPUID[0x1F] */
--=20
2.24.1


