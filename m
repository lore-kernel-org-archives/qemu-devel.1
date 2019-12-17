Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C10C2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5722067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af6NHcB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5722067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6f2-0003kR-5O
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6K1-0000nZ-26
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jy-0001FH-N6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jy-0001BZ-Ha
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sycYzc90UKlJPyK8203d36UCiFa0IWSVytZB9r+GpRs=;
 b=af6NHcB/CrpK+WzJtXzhLALQWCYr3h+isLUW1gjHuqXXC5eX74Bxhztv06oQcVAT6fVlJF
 SETh2UlcuTsjmNlxRixPK8nxzBa1V8pS/h5Y3B5gFUqyPLgtx3A+PY9cA9g6H/8nhsFFpy
 rNChdsSk+0RgbHiOvhr9u+hQqRhLr84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-88xGZMMNNyaKnEvny_Apkg-1; Tue, 17 Dec 2019 01:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 885E5800D41;
 Tue, 17 Dec 2019 06:26:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56BA31001281;
 Tue, 17 Dec 2019 06:26:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 861F51136424; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/34] ppc: make Error **errp const where it is appropriate
Date: Tue, 17 Dec 2019 07:26:37 +0100
Message-Id: <20191217062651.9687-21-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 88xGZMMNNyaKnEvny_Apkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Mostly, Error ** is for returning error from the function, so the
callee sets it. However kvmppc_hint_smt_possible gets already filled
errp parameter. It doesn't change the pointer itself, only change the
internal state of referenced Error object. So we can make it Error
*const * errp, to stress the behavior. It will also help coccinelle
script (in future) to distinguish such cases from common errp usage.

While there, rename the function to
kvmppc_error_append_smt_possible_hint().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20191205174635.18758-8-vsementsov@virtuozzo.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message replaced]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/ppc/kvm_ppc.h | 4 ++--
 hw/ppc/spapr.c       | 2 +-
 target/ppc/kvm.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 98bd7d5da6..f22daabf51 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
 int kvmppc_smt_threads(void);
-void kvmppc_hint_smt_possible(Error **errp);
+void kvmppc_error_append_smt_possible_hint(Error *const *errp);
 int kvmppc_set_smt_threads(int smt);
 int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
@@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
     return 1;
 }
=20
-static inline void kvmppc_hint_smt_possible(Error **errp)
+static inline void kvmppc_error_append_smt_possible_hint(Error *const *err=
p)
 {
     return;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3ae7db1563..c5d8f0afb6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2564,7 +2564,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *sp=
apr, Error **errp)
                                       " requires the use of VSMT mode %d.\=
n",
                                       smp_threads, kvm_smt, spapr->vsmt);
                 }
-                kvmppc_hint_smt_possible(&local_err);
+                kvmppc_error_append_smt_possible_hint(&local_err);
                 goto out;
             }
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c77f9848ec..27ea3ce535 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
     return ret;
 }
=20
-void kvmppc_hint_smt_possible(Error **errp)
+void kvmppc_error_append_smt_possible_hint(Error *const *errp)
 {
     int i;
     GString *g;
--=20
2.21.0


