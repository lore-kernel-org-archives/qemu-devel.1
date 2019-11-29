Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B70C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D04F207FA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mif7cP/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D04F207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZ0J-0005HP-9I
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 00:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaYuy-0002h1-CH
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaYuu-0002uz-Sk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:34:11 -0500
Received: from ozlabs.org ([203.11.71.1]:47053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaYuu-0002Mn-GQ; Fri, 29 Nov 2019 00:34:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PNV00zrLz9sR8; Fri, 29 Nov 2019 16:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575005640;
 bh=eSymelUFtceSa3fIrS+iMSr+NirExn0qwY6U9PuT39U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mif7cP/8eQ0/WPbEJIW4malfvYPzeMSlReIlzlrMvzpuV5y4Bs6CUGXckGJAHt3sc
 T4+ePium7VXm5es1txjsWH8fed3Xf/ldWU1dkkR4OiigSAxFEwKENHMo2D3vr0HnuW
 q2HVdmP2CyFL3igPSDm6MjlT2jsVBlCKSRXWjymg=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org
Subject: [for-5.0 4/4] spapr: Simplify ovec diff
Date: Fri, 29 Nov 2019 16:33:56 +1100
Message-Id: <20191129053356.232413-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191129053356.232413-1-david@gibson.dropbear.id.au>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_ovec_diff(ov, old, new) has somewhat complex semantics.  ov is set
to those bits which are in new but not old, and it returns as a boolean
whether or not there are any bits in old but not new.

It turns out that both callers only care about the second, not the first.
This is basically equivalent to a bitmap subset operation, which is easie=
r
to understand and implement.  So replace spapr_ovec_diff() with
spapr_ovec_subset().

Cc: Mike Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 14 +++-----------
 hw/ppc/spapr_hcall.c        |  8 ++------
 hw/ppc/spapr_ovec.c         | 30 ++++++++++--------------------
 include/hw/ppc/spapr_ovec.h |  4 +---
 4 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5187f5b0a5..32e1cc1d3f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1840,8 +1840,6 @@ static bool spapr_ov5_cas_needed(void *opaque)
 {
     SpaprMachineState *spapr =3D opaque;
     SpaprOptionVector *ov5_mask =3D spapr_ovec_new();
-    SpaprOptionVector *ov5_legacy =3D spapr_ovec_new();
-    SpaprOptionVector *ov5_removed =3D spapr_ovec_new();
     bool cas_needed;
=20
     /* Prior to the introduction of SpaprOptionVector, we had two option
@@ -1873,17 +1871,11 @@ static bool spapr_ov5_cas_needed(void *opaque)
     spapr_ovec_set(ov5_mask, OV5_DRCONF_MEMORY);
     spapr_ovec_set(ov5_mask, OV5_DRMEM_V2);
=20
-    /* spapr_ovec_diff returns true if bits were removed. we avoid using
-     * the mask itself since in the future it's possible "legacy" bits m=
ay be
-     * removed via machine options, which could generate a false positiv=
e
-     * that breaks migration.
-     */
-    spapr_ovec_intersect(ov5_legacy, spapr->ov5, ov5_mask);
-    cas_needed =3D spapr_ovec_diff(ov5_removed, spapr->ov5, ov5_legacy);
+    /* We need extra information if we have any bits outside the mask
+     * defined above */
+    cas_needed =3D !spapr_ovec_subset(spapr->ov5, ov5_mask);
=20
     spapr_ovec_cleanup(ov5_mask);
-    spapr_ovec_cleanup(ov5_legacy);
-    spapr_ovec_cleanup(ov5_removed);
=20
     return cas_needed;
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0f19be794c..f1799b1b70 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1671,7 +1671,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     target_ulong fdt_bufsize =3D args[2];
     target_ulong ov_table;
     uint32_t cas_pvr;
-    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates=
;
+    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
     bool guest_radix;
     Error *local_err =3D NULL;
     bool raw_mode_supported =3D false;
@@ -1770,9 +1770,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     /* capabilities that have been added since CAS-generated guest reset=
.
      * if capabilities have since been removed, generate another reset
      */
-    ov5_updates =3D spapr_ovec_new();
-    spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
-                                        ov5_cas_old, spapr->ov5_cas);
+    spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas=
);
     spapr_ovec_cleanup(ov5_cas_old);
     /* Now that processing is finished, set the radix/hash bit for the
      * guest if it requested a valid mode; otherwise terminate the boot.=
 */
@@ -1849,8 +1847,6 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
         spapr->fdt_blob =3D fdt;
     }
=20
-    spapr_ovec_cleanup(ov5_updates);
-
     if (spapr->cas_reboot) {
         qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
     }
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 811fadf143..0ff6d1aeae 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -76,31 +76,21 @@ void spapr_ovec_intersect(SpaprOptionVector *ov,
     bitmap_and(ov->bitmap, ov1->bitmap, ov2->bitmap, OV_MAXBITS);
 }
=20
-/* returns true if options bits were removed, false otherwise */
-bool spapr_ovec_diff(SpaprOptionVector *ov,
-                     SpaprOptionVector *ov_old,
-                     SpaprOptionVector *ov_new)
+/* returns true if ov1 has a subset of bits in ov2 */
+bool spapr_ovec_subset(SpaprOptionVector *ov1, SpaprOptionVector *ov2)
 {
-    unsigned long *change_mask =3D bitmap_new(OV_MAXBITS);
-    unsigned long *removed_bits =3D bitmap_new(OV_MAXBITS);
-    bool bits_were_removed =3D false;
+    unsigned long *tmp =3D bitmap_new(OV_MAXBITS);
+    bool result;
=20
-    g_assert(ov);
-    g_assert(ov_old);
-    g_assert(ov_new);
-
-    bitmap_xor(change_mask, ov_old->bitmap, ov_new->bitmap, OV_MAXBITS);
-    bitmap_and(ov->bitmap, ov_new->bitmap, change_mask, OV_MAXBITS);
-    bitmap_and(removed_bits, ov_old->bitmap, change_mask, OV_MAXBITS);
+    g_assert(ov1);
+    g_assert(ov2);
=20
-    if (!bitmap_empty(removed_bits, OV_MAXBITS)) {
-        bits_were_removed =3D true;
-    }
+    bitmap_andnot(tmp, ov1->bitmap, ov2->bitmap, OV_MAXBITS);
+    result =3D bitmap_empty(tmp, OV_MAXBITS);
=20
-    g_free(change_mask);
-    g_free(removed_bits);
+    g_free(tmp);
=20
-    return bits_were_removed;
+    return result;
 }
=20
 void spapr_ovec_cleanup(SpaprOptionVector *ov)
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 7891e9caac..2bed517a2b 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -66,9 +66,7 @@ SpaprOptionVector *spapr_ovec_clone(SpaprOptionVector *=
ov_orig);
 void spapr_ovec_intersect(SpaprOptionVector *ov,
                           SpaprOptionVector *ov1,
                           SpaprOptionVector *ov2);
-bool spapr_ovec_diff(SpaprOptionVector *ov,
-                     SpaprOptionVector *ov_old,
-                     SpaprOptionVector *ov_new);
+bool spapr_ovec_subset(SpaprOptionVector *ov1, SpaprOptionVector *ov2);
 void spapr_ovec_cleanup(SpaprOptionVector *ov);
 void spapr_ovec_set(SpaprOptionVector *ov, long bitnr);
 void spapr_ovec_clear(SpaprOptionVector *ov, long bitnr);
--=20
2.23.0


