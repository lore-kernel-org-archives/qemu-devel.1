Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2BBC2D0E1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950EB207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950EB207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnj7-0008MA-NG
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhZ-0006Se-OT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhW-0000bU-UB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-nypAO2_oMr-RwPU7Hf4Kww-1; Mon, 14 Sep 2020 08:35:15 -0400
X-MC-Unique: nypAO2_oMr-RwPU7Hf4Kww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C5C64083;
 Mon, 14 Sep 2020 12:35:14 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD2BA1002D41;
 Mon, 14 Sep 2020 12:35:11 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/15] ppc: Add a return value to ppc_set_compat() and
 ppc_set_compat_all()
Date: Mon, 14 Sep 2020 14:34:52 +0200
Message-Id: <20200914123505.612812-3-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recommended in "qapi/error.h", indicate success / failure with a
return value. Since ppc_set_compat() is called from a VMState handler,
let's make it an int so that it propagates any negative errno returned
by kvmppc_set_compat(). Do the same for ppc_set_compat_all() for
consistency, even if it isn't called in a context where a negative errno
is required on failure.

This will allow to simplify error handling in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu.h    |  4 ++--
 target/ppc/compat.c | 26 +++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 766e9c5c26fa..e8aa185d4ff8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1352,10 +1352,10 @@ bool ppc_check_compat(PowerPCCPU *cpu, uint32_t com=
pat_pvr,
 bool ppc_type_check_compat(const char *cputype, uint32_t compat_pvr,
                            uint32_t min_compat_pvr, uint32_t max_compat_pv=
r);
=20
-void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
+int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
=20
 #if !defined(CONFIG_USER_ONLY)
-void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
+int ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
 void ppc_compat_add_property(Object *obj, const char *name,
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 08aede88dc1d..e9bec5ffedbf 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -158,7 +158,7 @@ bool ppc_type_check_compat(const char *cputype, uint32_=
t compat_pvr,
     return pcc_compat(pcc, compat_pvr, min_compat_pvr, max_compat_pvr);
 }
=20
-void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
+int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
 {
     const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
     CPUPPCState *env =3D &cpu->env;
@@ -169,11 +169,11 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_=
pvr, Error **errp)
         pcr =3D 0;
     } else if (!compat) {
         error_setg(errp, "Unknown compatibility PVR 0x%08"PRIx32, compat_p=
vr);
-        return;
+        return -EINVAL;
     } else if (!ppc_check_compat(cpu, compat_pvr, 0, 0)) {
         error_setg(errp, "Compatibility PVR 0x%08"PRIx32" not valid for CP=
U",
                    compat_pvr);
-        return;
+        return -EINVAL;
     } else {
         pcr =3D compat->pcr;
     }
@@ -185,17 +185,19 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_=
pvr, Error **errp)
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Unable to set CPU compatibility mode in KVM"=
);
-            return;
+            return ret;
         }
     }
=20
     cpu->compat_pvr =3D compat_pvr;
     env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
+    return 0;
 }
=20
 typedef struct {
     uint32_t compat_pvr;
-    Error *err;
+    Error **errp;
+    int ret;
 } SetCompatState;
=20
 static void do_set_compat(CPUState *cs, run_on_cpu_data arg)
@@ -203,26 +205,28 @@ static void do_set_compat(CPUState *cs, run_on_cpu_da=
ta arg)
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     SetCompatState *s =3D arg.host_ptr;
=20
-    ppc_set_compat(cpu, s->compat_pvr, &s->err);
+    s->ret =3D ppc_set_compat(cpu, s->compat_pvr, s->errp);
 }
=20
-void ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
+int ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
 {
     CPUState *cs;
=20
     CPU_FOREACH(cs) {
         SetCompatState s =3D {
             .compat_pvr =3D compat_pvr,
-            .err =3D NULL,
+            .errp =3D errp,
+            .ret =3D 0,
         };
=20
         run_on_cpu(cs, do_set_compat, RUN_ON_CPU_HOST_PTR(&s));
=20
-        if (s.err) {
-            error_propagate(errp, s.err);
-            return;
+        if (s.ret < 0) {
+            return s.ret;
         }
     }
+
+    return 0;
 }
=20
 int ppc_compat_max_vthreads(PowerPCCPU *cpu)
--=20
2.26.2


