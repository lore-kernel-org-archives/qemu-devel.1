Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77253C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9F72332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BytxYckJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9F72332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0L2C-0006cc-Bu
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0G-0004On-Cx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0E-0007st-Vv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:25:56 -0400
Received: from ozlabs.org ([203.11.71.1]:53337)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0E-0007qS-1s; Wed, 21 Aug 2019 03:25:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj85MMyz9sNC; Wed, 21 Aug 2019 17:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372348;
 bh=QhtAqHLfc/dTm4MprysS84S8YY7xN8GFeazUYfR9k1A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BytxYckJ2qZNoTCJ/0Tg1ClPF/iTYs3O/AdMVWlEnOKObXtpo5GiHFLS+9O9Ho5QV
 pJKfYsLHRr44aTPRNh2CglvFMjb6M+zmXd8YyufpfHjLqsWufRmSv6AgLbRFmNbhge
 5rryHkI+Xqwxfd1bZDbLx5V8jDHDd4V7yQ56d6Jo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:01 +1000
Message-Id: <20190821072542.23090-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 01/42] spapr: quantify error messages regarding
 capability settings
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Daniel Black <daniel@linux.ibm.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Black <daniel@linux.ibm.com>

Its not immediately obvious how cap-X=3DY setting need to be applied
to the command line so, for spapr capability error messages, this
has been clarified to:

 appending -machine cap-X=3DY

The wrong value messages have been left as is, as the user has found
the right location.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Black <daniel@linux.ibm.com>
Message-Id: <20190812071044.30806-1-daniel@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7830d66d77..a61bf329bf 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -195,10 +195,12 @@ static void cap_htm_apply(SpaprMachineState *spapr,=
 uint8_t val, Error **errp)
     }
     if (tcg_enabled()) {
         error_setg(errp,
-                   "No Transactional Memory support in TCG, try cap-htm=3D=
off");
+                   "No Transactional Memory support in TCG,"
+                   " try appending -machine cap-htm=3Doff");
     } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
         error_setg(errp,
-"KVM implementation does not support Transactional Memory, try cap-htm=3D=
off"
+"KVM implementation does not support Transactional Memory,"
+                   " try appending -machine cap-htm=3Doff"
             );
     }
 }
@@ -216,7 +218,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
      * rid of anything that doesn't do VMX */
     g_assert(env->insns_flags & PPC_ALTIVEC);
     if (!(env->insns_flags2 & PPC2_VSX)) {
-        error_setg(errp, "VSX support not available, try cap-vsx=3Doff")=
;
+        error_setg(errp, "VSX support not available,"
+                   " try appending -machine cap-vsx=3Doff");
     }
 }
=20
@@ -230,7 +233,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
         return;
     }
     if (!(env->insns_flags2 & PPC2_DFP)) {
-        error_setg(errp, "DFP support not available, try cap-dfp=3Doff")=
;
+        error_setg(errp, "DFP support not available,"
+                   " try appending -machine cap-dfp=3Doff");
     }
 }
=20
@@ -254,7 +258,8 @@ static void cap_safe_cache_apply(SpaprMachineState *s=
papr, uint8_t val,
                    cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe cache capability level not supported by kvm, try cap-cfp=
c=3D%s",
+                   "Requested safe cache capability level not supported =
by kvm,"
+                   " try appending -machine cap-cfpc=3D%s",
                    cap_cfpc_possible.vals[kvm_val]);
     }
=20
@@ -282,7 +287,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineS=
tate *spapr, uint8_t val,
                    cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe bounds check capability level not supported by kvm, try =
cap-sbbc=3D%s",
+"Requested safe bounds check capability level not supported by kvm,"
+                   " try appending -machine cap-sbbc=3D%s",
                    cap_sbbc_possible.vals[kvm_val]);
     }
=20
@@ -313,7 +319,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachi=
neState *spapr,
                    cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe indirect branch capability level not supported by kvm, t=
ry cap-ibs=3D%s",
+"Requested safe indirect branch capability level not supported by kvm,"
+                   " try appending -machine cap-ibs=3D%s",
                    cap_ibs_possible.vals[kvm_val]);
     }
=20
@@ -402,11 +409,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
=20
     if (tcg_enabled()) {
         error_setg(errp,
-                   "No Nested KVM-HV support in tcg, try cap-nested-hv=3D=
off");
+                   "No Nested KVM-HV support in tcg,"
+                   " try appending -machine cap-nested-hv=3Doff");
     } else if (kvm_enabled()) {
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
-"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=3D=
off");
+"KVM implementation does not support Nested KVM-HV,"
+                       " try appending -machine cap-nested-hv=3Doff");
         } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
                 error_setg(errp,
 "Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
@@ -436,10 +445,12 @@ static void cap_large_decr_apply(SpaprMachineState =
*spapr,
=20
         if (!kvm_nr_bits) {
             error_setg(errp,
-                       "No large decrementer support, try cap-large-decr=
=3Doff");
+                       "No large decrementer support,"
+                        " try appending -machine cap-large-decr=3Doff");
         } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
             error_setg(errp,
-"KVM large decrementer size (%d) differs to model (%d), try -cap-large-d=
ecr=3Doff",
+"KVM large decrementer size (%d) differs to model (%d),"
+                " try appending -machine cap-large-decr=3Doff",
                 kvm_nr_bits, pcc->lrg_decr_bits);
         }
     }
@@ -455,7 +466,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineStat=
e *spapr,
     if (kvm_enabled()) {
         if (kvmppc_enable_cap_large_decr(cpu, val)) {
             error_setg(errp,
-                       "No large decrementer support, try cap-large-decr=
=3Doff");
+                       "No large decrementer support,"
+                       " try appending -machine cap-large-decr=3Doff");
         }
     }
=20
@@ -475,10 +487,12 @@ static void cap_ccf_assist_apply(SpaprMachineState =
*spapr, uint8_t val,
     if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by tc=
g, try cap-ccf-assist=3Doff");
+"Requested count cache flush assist capability level not supported by tc=
g,"
+                   " try appending -machine cap-ccf-assist=3Doff");
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by kv=
m, try cap-ccf-assist=3Doff");
+"Requested count cache flush assist capability level not supported by kv=
m,"
+                   " try appending -machine cap-ccf-assist=3Doff");
     }
 }
=20
--=20
2.21.0


