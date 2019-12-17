Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B7C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B6E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JvPGq8Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B6E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih57r-0002er-IL
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jO-0001hk-NY
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jN-000761-B3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:10 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43285 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jN-0006bE-04; Mon, 16 Dec 2019 23:45:09 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWb56VTz9sTP; Tue, 17 Dec 2019 15:43:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557819;
 bh=HsIVagByvmKam4iCJYnc9UEUs0SR2UwTtQMiFTEdpi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JvPGq8Sfdb0PERR+ZThx+8lrmfyDNtCGS7IFEahq8hdomoOIKXKgsGgjz7BlYDydp
 U/IM3Nvwf3eXV9THYTRw4vtNyr4uI2YuB6d1OWp0XWTwJ2PgbBtKQ5S8AT+tcUTM2K
 4XPN9FWwU4hCuNd/7oe1sw9e842IwTas/5YMK5HU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 51/88] ppc: well form kvmppc_hint_smt_possible error hint helper
Date: Tue, 17 Dec 2019 15:42:45 +1100
Message-Id: <20191217044322.351838-52-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Make kvmppc_hint_smt_possible hint append helper well formed:
rename errp to errp_in, as it is IN-parameter here (which is unusual
for errp), rename function to be kvmppc_error_append_*_hint.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191127191434.20945-1-vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 2 +-
 target/ppc/kvm.c     | 6 +++---
 target/ppc/kvm_ppc.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d9c9a2bcee..e3c7d487b8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2564,7 +2564,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
                                       " requires the use of VSMT mode %d=
.\n",
                                       smp_threads, kvm_smt, spapr->vsmt)=
;
                 }
-                kvmppc_hint_smt_possible(&local_err);
+                kvmppc_error_append_smt_possible_hint(&local_err);
                 goto out;
             }
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c77f9848ec..7406d18945 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
     return ret;
 }
=20
-void kvmppc_hint_smt_possible(Error **errp)
+void kvmppc_error_append_smt_possible_hint(Error **errp_in)
 {
     int i;
     GString *g;
@@ -2091,10 +2091,10 @@ void kvmppc_hint_smt_possible(Error **errp)
             }
         }
         s =3D g_string_free(g, false);
-        error_append_hint(errp, "%s.\n", s);
+        error_append_hint(errp_in, "%s.\n", s);
         g_free(s);
     } else {
-        error_append_hint(errp,
+        error_append_hint(errp_in,
                           "This KVM seems to be too old to support VSMT.=
\n");
     }
 }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 98bd7d5da6..47b08a4030 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
 int kvmppc_smt_threads(void);
-void kvmppc_hint_smt_possible(Error **errp);
+void kvmppc_error_append_smt_possible_hint(Error **errp_in);
 int kvmppc_set_smt_threads(int smt);
 int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
@@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
     return 1;
 }
=20
-static inline void kvmppc_hint_smt_possible(Error **errp)
+static inline void kvmppc_error_append_smt_possible_hint(Error **errp_in=
)
 {
     return;
 }
--=20
2.23.0


