Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785EC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB53420866
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kdu52bwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB53420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8yb3-0003e7-4n
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 22:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j8yTX-0004j2-3p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j8yTV-0002Gy-Bg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:44:07 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54305 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j8yTU-0002DZ-VB; Mon, 02 Mar 2020 22:44:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48WjY63nwYz9sSx; Tue,  3 Mar 2020 14:43:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583207034;
 bh=y6ErqbT5fsGuHeotXcrkwcOLx68MPUWxYgqXIr7yKT0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kdu52bwjN3ISFL7VGFEfUlihQLw2YGRkcvndP1En+aZ1TmH+rm44l3p84swD7/MIm
 5NLcDohgKgp9erniJapiD1xNz3LisTThV8ypS0wInDNXPyFmA3tb6rHZ37tm1hD8Em
 rRn9fz74dbqyTu1eCJsn+/heHIsg3V/aWhuEumv0=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
Subject: [PATCH v7 15/17] spapr: Don't clamp RMA to 16GiB on new machine types
Date: Tue,  3 Mar 2020 14:43:49 +1100
Message-Id: <20200303034351.333043-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303034351.333043-1-david@gibson.dropbear.id.au>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, paulus@samba.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In spapr_machine_init() we clamp the size of the RMA to 16GiB and the
comment saying why doesn't make a whole lot of sense.  In fact, this was
done because the real mode handling code elsewhere limited the RMA in TCG
mode to the maximum value configurable in LPCR[RMLS], 16GiB.

But,
 * Actually LPCR[RMLS] has been able to encode a 256GiB size for a very
   long time, we just didn't implement it properly in the softmmu
 * LPCR[RMLS] shouldn't really be relevant anyway, it only was because we
   used to abuse the RMOR based translation mode in order to handle the
   fact that we're not modelling the hypervisor parts of the cpu

We've now removed those limitations in the modelling so the 16GiB clamp n=
o
longer serves a function.  However, we can't just remove the limit
universally: that would break migration to earlier qemu versions, where
the 16GiB RMLS limit still applies, no matter how bad the reasons for it
are.

So, we replace the 16GiB clamp, with a clamp to a limit defined in the
machine type class.  We set it to 16 GiB for machine types 4.2 and earlie=
r,
but set it to 0 meaning unlimited for the new 5.0 machine type.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 13 ++++++++-----
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ef7667455c..95bda4a615 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2701,12 +2701,14 @@ static void spapr_machine_init(MachineState *mach=
ine)
=20
     spapr->rma_size =3D node0_size;
=20
-    /* Actually we don't support unbounded RMA anymore since we added
-     * proper emulation of HV mode. The max we can get is 16G which
-     * also happens to be what we configure for PAPR mode so make sure
-     * we don't do anything bigger than that
+    /*
+     * Clamp the RMA size based on machine type.  This is for
+     * migration compatibility with older qemu versions, which limited
+     * the RMA size for complicated and mostly bad reasons.
      */
-    spapr->rma_size =3D MIN(spapr->rma_size, 0x400000000ull);
+    if (smc->rma_limit) {
+        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
+    }
=20
     if (spapr->rma_size > node0_size) {
         error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx"=
)",
@@ -4598,6 +4600,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
+    smc->rma_limit =3D 16 * GiB;
     mc->nvdimm_supported =3D false;
 }
=20
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 90dbc55931..2015e37ac5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -126,6 +126,7 @@ struct SpaprMachineClass {
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
+    hwaddr rma_limit;          /* clamp the RMA to this size */
=20
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio,=20
--=20
2.24.1


