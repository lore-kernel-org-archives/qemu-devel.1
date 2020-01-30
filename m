Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BDC33CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 01:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C36206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 01:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f/QrLsvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C36206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwybx-0003GN-12
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 20:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iwybL-0002l1-Qo
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 20:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iwybK-0002Hu-BC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 20:26:35 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:49905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iwybJ-00027K-Is; Wed, 29 Jan 2020 20:26:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 487N3l3n1sz9sPJ; Thu, 30 Jan 2020 12:26:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580347587;
 bh=D1ZHqnZx6ANpXdyIlh22ap4pXL4wkhwKxKN2Dpgovb8=;
 h=From:To:Cc:Subject:Date:From;
 b=f/QrLsvVP6hGCLgFyHl2uK/fZ5hE3BC5OW5NAO+Or/kpBqyJ47+LAh9Qi1oinCaBk
 EL+zFpoQrN36L1qwNiI+lOw+e/VzH0sY4lQpGvAkwKmpckUVjNf9c52x0+0Ap/wqHP
 Y5VPVMYfre3nIIAtfrMacUc9x7SSxd/FztqY3BT4=
From: David Gibson <david@gibson.dropbear.id.au>
To: mpe@ellerman.id.au,
	groug@kaod.org,
	clg@kaod.org
Subject: [PATCH] spapr: Enable DD2.3 accelerated count cache flush in
 pseries-5.0 machine
Date: Thu, 30 Jan 2020 12:26:22 +1100
Message-Id: <20200130012622.8564-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For POWER9 DD2.2 cpus, the best current Spectre v2 indirect branch
mitigation is "count cache disabled", which is configured with:
    -machine cap-ibs=3Dfixed-ccd
However, this option isn't available on DD2.3 CPUs with KVM, because they
don't have the count cache disabled.

For POWER9 DD2.3 cpus, it is "count cache flush with assist", configured
with:
    -machine cap-ibs=3Dworkaround,cap-ccf-assist=3Don
However this option isn't available on DD2.2 CPUs with KVM, because they
don't have the special CCF assist instruction this relies on.

On current machine types, we default to "count cache flush w/o assist",
that is:
    -machine cap-ibs=3Dworkaround,cap-ccf-assist=3Doff
This runs, with mitigation on both DD2.2 and DD2.3 host cpus, but has a
fairly significant performance impact.

It turns out we can do better.  The special instruction that CCF assist
uses to trigger a count cache flush is a no-op on earlier CPUs, rather th=
an
trapping or causing other badness.  It doesn't, of itself, implement the
mitigation, but *if* we have count-cache-disabled, then the count cache
flush is unnecessary, and so using the count cache flush mitigation is
harmless.

Therefore for the new pseries-5.0 machine type, enable cap-ccf-assist by
default.  Along with that, suppress throwing an error if cap-ccf-assist
is selected but KVM doesn't support it, as long as KVM *is* giving us
count-cache-disabled.  To allow TCG to work out of the box, even though i=
t
doesn't implement the ccf flush assist, downgrade the error in that case =
to
a warning.  This matches several Spectre mitigations where we allow TCG
to operate for debugging, since we don't really make guarantees about TCG
security properties anyway.

While we're there, make the TCG warning for this case match that for othe=
r
mitigations.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c      |  5 ++++-
 hw/ppc/spapr_caps.c | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

I have put this into my ppc-for-5.0 tree already, and hope to send a
pull request tomorrow (Jan 31).

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 02cf53fc5b..deaa44f1ab 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4397,7 +4397,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
-    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_dual;
     smc->dr_phb_enabled =3D true;
@@ -4465,8 +4465,11 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
  */
 static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
+    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
 }
=20
 DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 481dfd2a27..d0d4b32a40 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -482,18 +482,36 @@ static void cap_large_decr_cpu_apply(SpaprMachineSt=
ate *spapr,
 static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
+    Error *local_err =3D NULL;
     uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
=20
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested count cache flush assist capability level not supported by tc=
g,"
-                   " try appending -machine cap-ccf-assist=3Doff");
+        /* TCG doesn't implement anything here, but allow with a warning=
 */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-ccf-assis=
t=3Don");
     } else if (kvm_enabled() && (val > kvm_val)) {
+        uint8_t kvm_ibs =3D kvmppc_get_cap_safe_indirect_branch();
+
+        if (kvm_ibs =3D=3D SPAPR_CAP_FIXED_CCD) {
+            /*
+             * If we don't have CCF assist on the host, the assist
+             * instruction is a harmless no-op.  It won't correctly
+             * implement the cache count flush *but* if we have
+             * count-cache-disabled in the host, that flush is
+             * unnnecessary.  So, specifically allow this case.  This
+             * allows us to have better performance on POWER9 DD2.3,
+             * while still working on POWER9 DD2.2 and POWER8 host
+             * cpus.
+             */
+            return;
+        }
         error_setg(errp,
 "Requested count cache flush assist capability level not supported by kv=
m,"
                    " try appending -machine cap-ccf-assist=3Doff");
     }
+
+    if (local_err !=3D NULL)
+        warn_report_err(local_err);
 }
=20
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
--=20
2.24.1


