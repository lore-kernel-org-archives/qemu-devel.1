Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F71C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09962176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNNTJ6K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09962176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUak-0003FX-GY
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWR-0005wc-FR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWP-0002RE-Mw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWP-0002PX-GT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCkgMdCs9M+FW3SBiXFe1dVrNAoaL+kwT+9vvcyqXwM=;
 b=RNNTJ6K/8YgwclRnU2CM9ZnEANVDuhiH8g3sZVYHvmKu+mhDZJzkSMjPCx5xFoKjR7xWcX
 7Nd3+Mt3QYFNU0/aYLGXcu4sNjxXTvScENefPaaRcsri/yK3I5rztkbIwSU08Q7qTZS7uK
 B5XTEEOwKLdSXGx/Ym1NiV9NqQzv/4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-o8fbVnnZPTiBE0uS2M4A7w-1; Wed, 18 Dec 2019 03:17:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3145D801E6C
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 029666888A
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:17:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1BEA1136424; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/35] Revert "ppc: well form kvmppc_hint_smt_possible error
 hint helper"
Date: Wed, 18 Dec 2019 09:17:06 +0100
Message-Id: <20191218081721.23520-21-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: o8fbVnnZPTiBE0uS2M4A7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit cdcca22aabafc0496894ce05c80097684832c7d9.

Commit cdcca22aaba is a superseded version of the next commit that
crept in by accident.  Revert it, so the final version applies.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/ppc/kvm_ppc.h | 4 ++--
 hw/ppc/spapr.c       | 2 +-
 target/ppc/kvm.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 47b08a4030..98bd7d5da6 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
 int kvmppc_smt_threads(void);
-void kvmppc_error_append_smt_possible_hint(Error **errp_in);
+void kvmppc_hint_smt_possible(Error **errp);
 int kvmppc_set_smt_threads(int smt);
 int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
@@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
     return 1;
 }
=20
-static inline void kvmppc_error_append_smt_possible_hint(Error **errp_in)
+static inline void kvmppc_hint_smt_possible(Error **errp)
 {
     return;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f11422fc41..32e1cc1d3f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2486,7 +2486,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *sp=
apr, Error **errp)
                                       " requires the use of VSMT mode %d.\=
n",
                                       smp_threads, kvm_smt, spapr->vsmt);
                 }
-                kvmppc_error_append_smt_possible_hint(&local_err);
+                kvmppc_hint_smt_possible(&local_err);
                 goto out;
             }
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7406d18945..c77f9848ec 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
     return ret;
 }
=20
-void kvmppc_error_append_smt_possible_hint(Error **errp_in)
+void kvmppc_hint_smt_possible(Error **errp)
 {
     int i;
     GString *g;
@@ -2091,10 +2091,10 @@ void kvmppc_error_append_smt_possible_hint(Error **=
errp_in)
             }
         }
         s =3D g_string_free(g, false);
-        error_append_hint(errp_in, "%s.\n", s);
+        error_append_hint(errp, "%s.\n", s);
         g_free(s);
     } else {
-        error_append_hint(errp_in,
+        error_append_hint(errp,
                           "This KVM seems to be too old to support VSMT.\n=
");
     }
 }
--=20
2.21.0


