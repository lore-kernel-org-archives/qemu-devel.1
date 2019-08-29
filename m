Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8AC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3785C233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YCL479+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3785C233A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3DoD-00076z-4Z
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dc0-0004Cl-DL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbx-0003fY-U9
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:48 -0400
Received: from ozlabs.org ([203.11.71.1]:38183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dbw-0003bC-S5; Thu, 29 Aug 2019 02:08:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscN28QJz9sNy; Thu, 29 Aug 2019 16:08:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058916;
 bh=qZJM/LEr77cOigBpqblqk77y8s9FtXzFqxNRRjTVASQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YCL479+HDUzgHLk09MYiJCJC2l+ExxyAhXVJTCvQWb9y6H45lc9Npyl2sstrx2Cid
 lFh2pETSMIG+Vvuol13PxI/1Tlf/u6tHOxzN8MhK5SR5bO/kT2ywsg+7GxeORmXBuM
 zr5bAkUmOju9tdOAM2pQgKPAdxQR8hE/k0ziI3pc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:18 +1000
Message-Id: <20190829060827.25731-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 10/19] pseries: Fix compat_pvr on reset
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

If we a migrate P8 machine to a P9 machine, the migration fails on
destination with:

  error while loading state for instance 0x1 of device 'cpu'
  load of migration failed: Operation not permitted

This is caused because the compat_pvr field is only present for the first
CPU.
Originally, spapr_machine_reset() calls ppc_set_compat() to set the value
max_compat_pvr for the first cpu and this was propagated to all CPUs by
spapr_cpu_reset().  Now, as spapr_cpu_reset() is called before that, the
value is not propagated to all CPUs and the migration fails.

To fix that, propagate the new value to all CPUs in spapr_machine_reset()=
.

Fixes: 25c9780d38d4 ("spapr: Reset CAS & IRQ subsystem after devices")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190826090812.19080-1-lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 8 +++++++-
 hw/ppc/spapr_cpu_core.c | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index baedadf20b..d063312a3b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1752,7 +1752,13 @@ static void spapr_machine_reset(MachineState *mach=
ine)
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas =3D spapr_ovec_new();
=20
-        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
+        /*
+         * reset compat_pvr for all CPUs
+         * as qemu_devices_reset() is called before this,
+         * it can't be propagated by spapr_cpu_reset()
+         * from the first CPU to all the others
+         */
+        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
     }
=20
     /*
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index bf47fbdf6f..45e2f2747f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -43,6 +43,8 @@ static void spapr_cpu_reset(void *opaque)
=20
     /* Set compatibility mode to match the boot CPU, which was either se=
t
      * by the machine reset code or by CAS. This should never fail.
+     * At startup the value is already set for all the CPUs
+     * but we need this when we hotplug a new CPU
      */
     ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort=
);
=20
--=20
2.21.0


