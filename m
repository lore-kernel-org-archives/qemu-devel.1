Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E7020760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E7020760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJFN-0002Sa-CS
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjJE0-0000jm-8M
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:10:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjJDz-0008Ux-K2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:10:15 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-DfY-fTscMxWmNw7l3TAY_w-1; Thu, 11 Jun 2020 05:10:11 -0400
X-MC-Unique: DfY-fTscMxWmNw7l3TAY_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04A86873092;
 Thu, 11 Jun 2020 09:10:10 +0000 (UTC)
Received: from bahia.lan (ovpn-114-202.ams2.redhat.com [10.36.114.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD08E60BF4;
 Thu, 11 Jun 2020 09:10:08 +0000 (UTC)
Subject: [PATCH v2 3/3] spapr: Forbid nested KVM-HV in pre-power9 compat mode
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Jun 2020 11:10:08 +0200
Message-ID: <159186660803.48605.11792415961949917926.stgit@bahia.lan>
In-Reply-To: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nested KVM-HV only works on POWER9.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_caps.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 2cb7ba8f005a..e86a7c350444 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -409,6 +409,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *=
spapr,
                                     uint8_t val, Error **errp)
 {
     ERRP_AUTO_PROPAGATE();
+    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
+
     if (!val) {
         /* capability disabled by default */
         return;
@@ -418,6 +420,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState =
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



