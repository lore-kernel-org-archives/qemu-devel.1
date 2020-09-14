Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146B8207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146B8207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnjG-0000HT-44
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnho-0006Yg-GL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhk-0000ik-6g
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-fbfapbYuNvq8zGJWV7KgPQ-1; Mon, 14 Sep 2020 08:35:25 -0400
X-MC-Unique: fbfapbYuNvq8zGJWV7KgPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD3D80F058;
 Mon, 14 Sep 2020 12:35:23 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C93821002393;
 Mon, 14 Sep 2020 12:35:20 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/15] spapr: Get rid of cas_check_pvr() error reporting
Date: Mon, 14 Sep 2020 14:34:55 +0200
Message-Id: <20200914123505.612812-6-groug@kaod.org>
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
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
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

The cas_check_pvr() function has two purposes:
- finding the "best" logical PVR, ie. the most recent one supported by
  the guest for this CPU type
- checking if the guest supports the real PVR of this CPU type, which
  is just an optional extra information to workaround the lack of
  support for "compat" mode in PR KVM

This logic doesn't need error reporting, really. If we don't find a
suitable logical PVR, we return the special value 0 which is definitely
not a valid PVR. Let the caller decide on whether it should error out
or not.

This doesn't change the behavior.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c2776b6a7de2..885ea60778ba 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1590,12 +1590,11 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *=
cpu,
     }
 }
=20
-static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
-                              target_ulong *addr, bool *raw_mode_supported=
,
-                              Error **errp)
+/* Returns either a logical PVR or zero if none was found */
+static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
+                              target_ulong *addr, bool *raw_mode_supported=
)
 {
     bool explicit_match =3D false; /* Matched the CPU's real PVR */
-    uint32_t max_compat =3D spapr->max_compat_pvr;
     uint32_t best_compat =3D 0;
     int i;
=20
@@ -1624,14 +1623,6 @@ static uint32_t cas_check_pvr(SpaprMachineState *spa=
pr, PowerPCCPU *cpu,
         }
     }
=20
-    if ((best_compat =3D=3D 0) && (!explicit_match || max_compat)) {
-        /* We couldn't find a suitable compatibility mode, and either
-         * the guest doesn't support "raw" mode for this CPU, or raw
-         * mode is disabled because a maximum compat mode is set */
-        error_setg(errp, "Couldn't negotiate a suitable PVR during CAS");
-        return 0;
-    }
-
     *raw_mode_supported =3D explicit_match;
=20
     /* Parsing finished */
@@ -1680,6 +1671,7 @@ target_ulong do_client_architecture_support(PowerPCCP=
U *cpu,
     bool guest_xive;
     CPUState *cs;
     void *fdt;
+    uint32_t max_compat =3D spapr->max_compat_pvr;
=20
     /* CAS is supposed to be called early when only the boot vCPU is activ=
e. */
     CPU_FOREACH(cs) {
@@ -1692,9 +1684,14 @@ target_ulong do_client_architecture_support(PowerPCC=
PU *cpu,
         }
     }
=20
-    cas_pvr =3D cas_check_pvr(spapr, cpu, &vec, &raw_mode_supported, &loca=
l_err);
-    if (local_err) {
-        error_report_err(local_err);
+    cas_pvr =3D cas_check_pvr(cpu, max_compat, &vec, &raw_mode_supported);
+    if (!cas_pvr && (!raw_mode_supported || max_compat)) {
+        /*
+         * We couldn't find a suitable compatibility mode, and either
+         * the guest doesn't support "raw" mode for this CPU, or "raw"
+         * mode is disabled because a maximum compat mode is set.
+         */
+        error_report("Couldn't negotiate a suitable PVR during CAS");
         return H_HARDWARE;
     }
=20
--=20
2.26.2


