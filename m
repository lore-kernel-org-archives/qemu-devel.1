Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A5FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0611C20656
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEmk9xP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0611C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6TG-0002ad-Vd
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iT6NT-0005HV-Rd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iT6NS-0008Ob-Oz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:40:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iT6NS-0008OI-Le
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573227646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q9MqMidwocG5LVaShmKq/hsFgYzFcJ9+Fw5EvQqr+60=;
 b=bEmk9xP17kgiK0bMqPaDq52AJ7bFX864FX40Otj/MpIkIh4XnWooZFUk7QeTSb5bjctjWa
 7sbnGGuREUjWXTd3dDgKkxYIJYO8+22vW3Y9kTOw6mmGZV0zufR5fMW4CCnFaZWRrJ1jXW
 orHCUuL9qyNHrGiGh1RCHAL8OJPXSJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-hN3oEJEQOoOv7w6KXFZf0Q-1; Fri, 08 Nov 2019 10:40:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95E25107ACC4;
 Fri,  8 Nov 2019 15:40:41 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.36.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D49FC5DA81;
 Fri,  8 Nov 2019 15:40:36 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] spapr: Fix VSMT mode when it is not supported by the kernel
Date: Fri,  8 Nov 2019 16:40:35 +0100
Message-Id: <20191108154035.12913-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: hN3oEJEQOoOv7w6KXFZf0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 29cb4187497d sets by default the VSMT to smp_threads,
but older kernels (< 4.13) don't support that.

We can reasonably restore previous behavior with this kernel
to allow to run QEMU as before.

If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
as it is done for previous machine types (< pseries-4.2)

Fixes: 29cb4187497d ("spapr: Set VSMT to smp_threads by default")
Cc: groug@kaod.org
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c       | 2 +-
 target/ppc/kvm.c     | 5 +++++
 target/ppc/kvm_ppc.h | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 94f9d27096af..f6c8ad1eda32 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2522,7 +2522,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *sp=
apr, Error **errp)
             goto out;
         }
         /* In this case, spapr->vsmt has been set by the command line */
-    } else if (!smc->smp_threads_vsmt) {
+    } else if (!smc->smp_threads_vsmt || !kvmppc_check_smt_possible()) {
         /*
          * Default VSMT value is tricky, because we need it to be as
          * consistent as possible (for migration), but this requires
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7d2e8969ac5f..40ed59881167 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2060,6 +2060,11 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic=
_proxy)
     }
 }
=20
+bool kvmppc_check_smt_possible(void)
+{
+    return kvm_enabled() && cap_ppc_smt_possible;
+}
+
 int kvmppc_smt_threads(void)
 {
     return cap_ppc_smt ? cap_ppc_smt : 1;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 98bd7d5da6d6..c9629a416b0b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
+bool kvmppc_check_smt_possible(void);
 int kvmppc_smt_threads(void);
 void kvmppc_hint_smt_possible(Error **errp);
 int kvmppc_set_smt_threads(int smt);
@@ -159,6 +160,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *c=
pu, int mpic_proxy)
 {
 }
=20
+static inline bool kvmppc_check_smt_possible(void)
+{
+    return false;
+}
+
 static inline int kvmppc_smt_threads(void)
 {
     return 1;
--=20
2.21.0


