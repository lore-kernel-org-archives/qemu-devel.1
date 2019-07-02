Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C4C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2533D20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nHVmeTsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2533D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCOB-0002HG-EN
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzK-0005Ng-FI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzI-0003GD-JH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:58 -0400
Received: from ozlabs.org ([203.11.71.1]:53127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzH-0002wG-Cc; Tue, 02 Jul 2019 02:09:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMk4QNRz9sQx; Tue,  2 Jul 2019 16:09:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047746;
 bh=aYdVUD9TY91wmtYbmrNUJyyN1R8X32PzBPjRraQ5umg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nHVmeTsykqw+0dp5LcMmWra0pHOk3thuAv0vCnLt5xzBEKp3HiFEcSYSh0g6fCKu9
 i7FyUWGb5QFm+/sZ/x0Z3fJNgU6eCsHM+4etTLP93uTpQoRGizJCHPSdd4Osf/sRb2
 P3WciNswYQmaSu/XH+y4dGRUiuaeb1h6sK90gI5U=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:31 +1000
Message-Id: <20190702060857.3926-24-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 23/49] xics/kvm: Skip rollback when KVM XICS is
 absent
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

There is no need to rollback anything at this point, so just return an
error.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156077920657.433243.13541093940589972734.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 534515143e..377ff88701 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -348,7 +348,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
         error_setg(errp,
                    "KVM and IRQ_XICS capability must be present for in-k=
ernel XICS");
-        goto fail;
+        return -1;
     }
=20
     rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-x=
ive");
--=20
2.21.0


