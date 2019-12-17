Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAB2C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852B520733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X/TXAZPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852B520733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4yu-00066H-Aa
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4i2-0008CH-G7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4i1-0005SR-7V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:46 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51863 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4i0-0005Ko-T4; Mon, 16 Dec 2019 23:43:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWR547Yz9sSX; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557811;
 bh=z9QUoRpZ10vAUbFSnp5wy0y9JozdiioGdb647sP2Mqw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X/TXAZPik/kVDT/nyVLQgoYMExWlJ0CAAah+Yy667Bfd+p3H8OJMlXXQEgsctdsrA
 fhcxSvac5hQt3HYBdZgTLL4I6NI2xSyekxlYWy07GygdS6KmYCBYF00djaUKvokIFE
 aes7SdjxqYiL6PyGxEYOOuqKSuTru6Pht0n0d1Dc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/88] ppc/xive: Record the IPB in the associated NVT
Date: Tue, 17 Dec 2019 15:42:11 +1100
Message-Id: <20191217044322.351838-18-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When an interrupt can not be presented to a vCPU, because it is not
running on any of the HW treads, the XIVE presenter updates the
Interrupt Pending Buffer register of the associated XIVE NVT
structure. This is only done if backlog is activated in the END but
this is generally the case.

The current code assumes that the fields of the NVT structure is
architected with the same layout of the thread interrupt context
registers. Fix this assumption and define an offset for the IPB
register backup value in the NVT.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191115162436.30548-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c             | 11 +++++++++--
 include/hw/ppc/xive_regs.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3d472e29c8..177663d2b4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1607,14 +1607,21 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
      * - logical server : forward request to IVPE (not supported)
      */
     if (xive_end_is_backlog(&end)) {
+        uint8_t ipb;
+
         if (format =3D=3D 1) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "XIVE: END %x/%x invalid config: F1 & backlog\=
n",
                           end_blk, end_idx);
             return;
         }
-        /* Record the IPB in the associated NVT structure */
-        ipb_update((uint8_t *) &nvt.w4, priority);
+        /*
+         * Record the IPB in the associated NVT structure for later
+         * use. The presenter will resend the interrupt when the vCPU
+         * is dispatched again on a HW thread.
+         */
+        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ipb(p=
riority);
+        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
         xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
=20
         /*
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 55307cd153..530f232b04 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -255,6 +255,7 @@ typedef struct XiveNVT {
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
+#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
         uint32_t        w5;
         uint32_t        w6;
         uint32_t        w7;
--=20
2.23.0


