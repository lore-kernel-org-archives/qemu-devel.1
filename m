Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5730BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DF320878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DF320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzf3-0006KV-51
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kRzcZ-0003aX-Cm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:20:21 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:39315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kRzcX-0005S1-QC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:20:19 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-joa5kJdZOUOvq-lKaQhXpg-1; Mon, 12 Oct 2020 11:20:10 -0400
X-MC-Unique: joa5kJdZOUOvq-lKaQhXpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2752D1921FA0;
 Mon, 12 Oct 2020 15:20:09 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E76573661;
 Mon, 12 Oct 2020 15:20:08 +0000 (UTC)
Subject: [PATCH 4/4] spapr: Make spapr_cpu_core_unrealize() idempotent
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Oct 2020 17:20:07 +0200
Message-ID: <160251600753.796881.11787439223917154767.stgit@bahia.lan>
In-Reply-To: <160251562222.796881.8197386060416409319.stgit@bahia.lan>
References: <160251562222.796881.8197386060416409319.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 11:19:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_cpu_core_realize() has an err_unrealize label which partially
duplicates the code of spapr_cpu_core_realize().

Let's make spapr_cpu_core_unrealize() idempotent and call it instead.
The registration and unregistration of the reset handler are moved
around to simplify the code even more.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index cffd74f542ba..e3fd81eb9741 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -227,11 +227,13 @@ static void spapr_cpu_core_unrealize(DeviceState *dev=
)
     CPUCore *cc =3D CPU_CORE(dev);
     int i;
=20
-    qemu_unregister_reset(spapr_cpu_core_reset_handler, sc);
-
     for (i =3D 0; i < cc->nr_threads; i++) {
-        spapr_unrealize_vcpu(sc->threads[i], sc);
+        if (sc->threads[i]) {
+            spapr_unrealize_vcpu(sc->threads[i], sc);
+        }
     }
+
+    qemu_unregister_reset(spapr_cpu_core_reset_handler, sc);
 }
=20
 static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -326,19 +328,14 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
         }
     }
=20
+    qemu_register_reset(spapr_cpu_core_reset_handler, sc);
+
     for (j =3D 0; j < cc->nr_threads; j++) {
         if (!spapr_realize_vcpu(sc->threads[j], spapr, sc, errp)) {
-            goto err_unrealize;
+            spapr_cpu_core_unrealize(dev);
+            return;
         }
     }
-
-    qemu_register_reset(spapr_cpu_core_reset_handler, sc);
-    return;
-
-err_unrealize:
-    while (--j >=3D 0) {
-        spapr_unrealize_vcpu(sc->threads[j], sc);
-    }
 }
=20
 static Property spapr_cpu_core_properties[] =3D {



