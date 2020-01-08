Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6455C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07522070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NkB/nFId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07522070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3vc-0005RN-D4
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oa-0003rE-FR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oY-0002hE-Th
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:36599 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oY-0002dY-HO; Wed, 08 Jan 2020 00:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMB3pqrz9sSS; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460998;
 bh=5xKJEBqM26YAjxkdN6Iin53kkuGV/UKASaxALQ4irx8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NkB/nFIdWFEkB5TIGmyJiE8qqdcvHsechDINtbn5WINsuTjdlaQF//ICsQZR8pQml
 E3sSZcbyl3k1GOcZmf6QwUskAuiHPAZqp25dj2hw5TjDD6A0uTDB4QOdvkB7LEv/kv
 PzB3D0FHo/h8LBjoGXDXIJyvHzSL47lHOzQ6z2nI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 08/26] ppc/spapr: Don't call KVM_SVM_OFF ioctl on TCG
Date: Wed,  8 Jan 2020 16:22:54 +1100
Message-Id: <20200108052312.238710-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharata B Rao <bharata@linux.ibm.com>

Invoking KVM_SVM_OFF ioctl for TCG guests will lead to a QEMU crash.
Fix this by ensuring that we don't call KVM_SVM_OFF ioctl on TCG.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: 4930c1966249 ("ppc/spapr: Support reboot of secure pseries guest")
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
Message-Id: <20200102054155.13175-1-bharata@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 45a26c0fc6..b5799e62b4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2902,9 +2902,12 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int=
64_t tb_offset)
 void kvmppc_svm_off(Error **errp)
 {
     int rc;
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
=20
-    rc =3D kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    rc =3D kvm_vm_ioctl(KVM_STATE(current_machine->accelerator), KVM_PPC=
_SVM_OFF);
     if (rc && rc !=3D -ENOTTY) {
         error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
     }
--=20
2.24.1


