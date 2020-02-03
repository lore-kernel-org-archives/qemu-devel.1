Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3AC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144562080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oAVN71BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144562080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV2q-0003py-5G
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxT-0002ex-Ly
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxR-0002iM-V6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33403 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxR-0002d0-Hz; Mon, 03 Feb 2020 01:11:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBr1fSYz9sSn; Mon,  3 Feb 2020 17:11:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710292;
 bh=VZiQwU8h2glXrV7i9ASdaVhFIQnGSa15tDuQJObRS1I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oAVN71BHwbHyf3gkV2f3q3/k2jj+cScbU66zIZG0QTXq+92E+hQzDINEOrvBK5G6y
 ES4VW59p5dFR7foaw3onkCqXynhKPbMqC6/kBHskBSrxsnJPPFTCd0ocH71ycAr4JY
 PbsYrQVAeCZwz05nmjZTJpN2RLwp5m2hU+/ibpN8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 22/35] spapr: Enable DD2.3 accelerated count cache flush in
 pseries-5.0 machine
Date: Mon,  3 Feb 2020 17:11:10 +1100
Message-Id: <20200203061123.59150-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
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
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
---
 hw/ppc/spapr.c      |  5 ++++-
 hw/ppc/spapr_caps.c | 21 +++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a0076e5fbd..fe8266a1d1 100644
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
index 481dfd2a27..7f933a98ed 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -485,11 +485,24 @@ static void cap_ccf_assist_apply(SpaprMachineState =
*spapr, uint8_t val,
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
+        warn_report("TCG doesn't support requested feature, cap-ccf-assi=
st=3Don");
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
--=20
2.24.1


