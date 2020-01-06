Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416A6C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C08207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C08207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUJE-0008I2-N4
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioTpG-0001BN-TI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioTpF-0001Dd-PD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:50 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:46115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioTpF-0001Cp-JB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:49 -0500
Received: from player731.ha.ovh.net (unknown [10.108.57.141])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id EFBA511D0EA
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:57:47 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id EEC18DB3A82C;
 Mon,  6 Jan 2020 14:57:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 09/12] spapr/xive: Deduce the SpaprXive pointer from
 XiveTCTX::xptr
Date: Mon,  6 Jan 2020 15:56:42 +0100
Message-Id: <20200106145645.4539-10-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106145645.4539-1-clg@kaod.org>
References: <20200106145645.4539-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5398408578433190886
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeeh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.51.249
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

And use it instead of reaching out to the machine. This allows to get rid
of a call to qdev_get_machine() and to reduce the scope of another one so
that it is only used within the argument list of error_append_hint(). Thi=
s
is an acceptable tradeoff compared to all it would require to know about
the maximum number of CPUs here without calling qdev_get_machine().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 32b2809210a0..edb7ee0e74f1 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -75,7 +75,7 @@ static void kvm_cpu_disable_all(void)
=20
 void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
 {
-    SpaprXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
+    SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
     uint64_t state[2];
     int ret;
=20
@@ -97,7 +97,7 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **=
errp)
=20
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
-    SpaprXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
+    SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
     uint64_t state[2] =3D { 0 };
     int ret;
=20
@@ -152,8 +152,7 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx=
, Error **errp)
=20
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-    SpaprXive *xive =3D SPAPR_MACHINE(ms)->xive;
+    SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
     unsigned long vcpu_id;
     int ret;
=20
@@ -179,7 +178,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **=
errp)
                    vcpu_id, strerror(errno));
         if (errno =3D=3D ENOSPC) {
             error_append_hint(&local_err, "Try -smp maxcpus=3DN with N <=
 %u\n",
-                              ms->smp.max_cpus);
+                              MACHINE(qdev_get_machine())->smp.max_cpus)=
;
         }
         error_propagate(errp, local_err);
         return;
--=20
2.21.1


