Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19554C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D947420714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nS+LLB7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D947420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9DI-0007Sl-VS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95m-00019R-QV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95j-0002xF-2H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60955 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95h-0001v9-Hx; Tue, 17 Mar 2020 06:04:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKw5hLBz9sT2; Tue, 17 Mar 2020 21:04:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439476;
 bh=a78LN1DHf/xUKLvhVIm9tRfpO0P/QhRCfN+jcV/NO9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nS+LLB7/iPHDKwPIsKxM5TanK4pX9DjeRoB9V7Ele/zfUj86+XY1m3srt/LtEUi2B
 SpyfKWDDvrlzAPgPWxJI1Y2JgEWzrHk6nxm7A/BsVLfawirnUOrrE1gEOh3Pwue57x
 Htco8lXXZaT4F/V4febCFkLgmXjMGGt9WkyfHEdY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/45] spapr,ppc: Simplify signature of kvmppc_rma_size()
Date: Tue, 17 Mar 2020 21:03:56 +1100
Message-Id: <20200317100423.622643-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, Cedric Le Goater <clg@fr.ibm.com>,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function calculates the maximum size of the RMA as implied by the
host's page size of structure of the VRMA (there are a number of other
constraints on the RMA size which will supersede this one in many
circumstances).

The current interface takes the current RMA size estimate, and clamps it
to the VRMA derived size.  The only current caller passes in an arguably
wrong value (it will match the current RMA estimate in some but not all
cases).

We want to fix that, but for now just keep concerns separated by having t=
he
KVM helper function just return the VRMA derived limit, and let the calle=
r
combine it with other constraints.  We call the new function
kvmppc_vrma_limit() to more clearly indicate its limited responsibility.

The helper should only ever be called in the KVM enabled case, so replace
its !CONFIG_KVM stub with an assert() rather than a dummy value.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cedric Le Goater <clg@fr.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr.c       | 5 +++--
 target/ppc/kvm.c     | 5 ++---
 target/ppc/kvm_ppc.h | 7 +++----
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 510494ad87..18bf4bc3de 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1586,8 +1586,9 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *sp=
apr)
     spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
=20
     if (spapr->vrma_adjust) {
-        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(MACHINE(spa=
pr)),
-                                          spapr->htab_shift);
+        hwaddr vrma_limit =3D kvmppc_vrma_limit(spapr->htab_shift);
+
+        spapr->rma_size =3D MIN(spapr_node0_size(MACHINE(spapr)), vrma_l=
imit);
     }
 }
=20
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7f44b1aa1a..597f72be1b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2113,7 +2113,7 @@ void kvmppc_error_append_smt_possible_hint(Error *c=
onst *errp)
=20
=20
 #ifdef TARGET_PPC64
-uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
+uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
 {
     struct kvm_ppc_smmu_info info;
     long rampagesize, best_page_shift;
@@ -2140,8 +2140,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
         }
     }
=20
-    return MIN(current_size,
-               1ULL << (best_page_shift + hash_shift - 7));
+    return 1ULL << (best_page_shift + hash_shift - 7);
 }
 #endif
=20
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 9e4f2357cc..332fa0aa1c 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -47,7 +47,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t =
page_shift,
                               int *pfd, bool need_vfio);
 int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
-uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)=
;
+uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
 bool kvmppc_has_cap_spapr_vfio(void);
 #endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
@@ -255,10 +255,9 @@ static inline int kvmppc_reset_htab(int shift_hint)
     return 0;
 }
=20
-static inline uint64_t kvmppc_rma_size(uint64_t current_size,
-                                       unsigned int hash_shift)
+static inline uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
 {
-    return ram_size;
+    g_assert_not_reached();
 }
=20
 static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
--=20
2.24.1


