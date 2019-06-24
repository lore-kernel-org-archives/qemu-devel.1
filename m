Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E37C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4740220663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfUop-0005aA-Fi
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 15:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfUoA-000591-Hz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfUo9-0005JT-BI
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hfUo9-0005Ij-69
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:39:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 838F0308FBAF;
 Mon, 24 Jun 2019 19:39:15 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EC3A5C232;
 Mon, 24 Jun 2019 19:39:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 21:39:13 +0200
Message-Id: <20190624193913.28343-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 24 Jun 2019 19:39:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] i386/kvm: Fix build with -m32
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

find_next_bit() takes a pointer of type "const unsigned long *", but the
first argument passed here is a "uint64_t *".  These types are
incompatible when compiling qemu with -m32.

Just use ctz64() instead.

Fixes: c686193072a47032d83cb4e131dc49ae30f9e5d
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 target/i386/kvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e4b4f5756a..31490bf8b5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1043,14 +1043,15 @@ static int hv_cpuid_check_and_set(CPUState *cs, s=
truct kvm_cpuid2 *cpuid,
     CPUX86State *env =3D &cpu->env;
     uint32_t r, fw, bits;
     uint64_t deps;
-    int i, dep_feat =3D 0;
+    int i, dep_feat;
=20
     if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) =
{
         return 0;
     }
=20
     deps =3D kvm_hyperv_properties[feature].dependencies;
-    while ((dep_feat =3D find_next_bit(&deps, 64, dep_feat)) < 64) {
+    while (deps) {
+        dep_feat =3D ctz64(deps);
         if (!(hyperv_feat_enabled(cpu, dep_feat))) {
                 fprintf(stderr,
                         "Hyper-V %s requires Hyper-V %s\n",
@@ -1058,7 +1059,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, str=
uct kvm_cpuid2 *cpuid,
                         kvm_hyperv_properties[dep_feat].desc);
                 return 1;
         }
-        dep_feat++;
+        deps &=3D ~(1ull << dep_feat);
     }
=20
     for (i =3D 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); =
i++) {
--=20
2.21.0


