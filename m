Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D1C204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D1C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7Qu-00059W-2L
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw7Q4-0004Dk-CX
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:11:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41206
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw7Q1-0007Kp-QS
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:11:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-KOiE28a6OEGzVQBlUtN5sQ-1; Thu, 16 Jul 2020 13:11:30 -0400
X-MC-Unique: KOiE28a6OEGzVQBlUtN5sQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60BF1803A1C;
 Thu, 16 Jul 2020 17:11:23 +0000 (UTC)
Received: from bahia.lan (ovpn-113-187.ams2.redhat.com [10.36.113.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B6B07B5E1;
 Thu, 16 Jul 2020 17:11:22 +0000 (UTC)
Subject: [PATCH v4 for-5.2 2/2] spapr: Forbid nested KVM-HV in pre-power9
 compat mode
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 16 Jul 2020 19:11:21 +0200
Message-ID: <159491948127.188975.9621435875869177751.stgit@bahia.lan>
In-Reply-To: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
References: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=unavailable autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nested KVM HV only works if the kernel is using the radix MMU mode, ie.
the CPU is POWER9 and it is not running in some pre-power9 compat mode.
Otherwise, the KVM HV module fails to load in the guest with -ENODEV.
It might be painful for a user to discover this late that nested cannot
work with their setup. Erroring out at machine init instead seems to be
the best we can do.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr_caps.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 275f5bd0342c..10a80a8159f4 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -382,6 +382,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *=
spapr,
                                     uint8_t val, Error **errp)
 {
     ERRP_GUARD();
+    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
+
     if (!val) {
         /* capability disabled by default */
         return;
@@ -391,6 +393,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState =
*spapr,
         error_setg(errp, "No Nested KVM-HV support in TCG");
         error_append_hint(errp, "Try appending -machine cap-nested-hv=3Dof=
f\n");
     } else if (kvm_enabled()) {
+        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                              spapr->max_compat_pvr)) {
+            error_setg(errp, "Nested KVM-HV only supported on POWER9");
+            error_append_hint(errp,
+                              "Try appending -machine max-cpu-compat=3Dpow=
er9\n");
+            return;
+        }
+
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
                        "KVM implementation does not support Nested KVM-HV"=
);



