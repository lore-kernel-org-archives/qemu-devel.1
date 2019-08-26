Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0392C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 09:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC8B20578
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 09:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC8B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Azl-0008Vq-Mf
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 05:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1i2Az6-0007xF-Fb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 05:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1i2Az4-0006aC-56
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 05:08:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>)
 id 1i2Az3-0006Zm-WC; Mon, 26 Aug 2019 05:08:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CEF43082199;
 Mon, 26 Aug 2019 09:08:15 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-182.ams2.redhat.com
 [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6BE45D9C3;
 Mon, 26 Aug 2019 09:08:13 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 11:08:12 +0200
Message-Id: <20190826090812.19080-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 26 Aug 2019 09:08:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] pseries: Fix compat_pvr on reset
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/ppc/spapr.c          | 8 +++++++-
 hw/ppc/spapr_cpu_core.c | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index baedadf20b8c..d063312a3b2a 100644
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
index bf47fbdf6f7f..45e2f2747ffc 100644
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


