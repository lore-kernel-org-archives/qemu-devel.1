Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99874C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643EE2339F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Sm60RcjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643EE2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LEi-0004j1-9r
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0p-0005BZ-8m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0o-0008Rx-78
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:31 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0m-00086q-VY; Wed, 21 Aug 2019 03:26:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjD0r0wz9sR0; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372352;
 bh=z0xLOJT+W0eOPaWM+bo1X3aSAUKo9hpukkRVyqWQD+Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sm60RcjAEGETDAjtFDRGsRk/m4wVjcFsfZxKeQxpLs8rl91afDDiI6MIS7jtsHROj
 aNhbi9xj8hPvE0o1vLIzGNQ0Rrh6V2bIsmGWafAH7YfBRHR8Tn5+Ql/V0p8f5WQjvY
 y8aAuMp4Ed6ufDIv6QJkMTdkOt6+lBYpKJ8fOvac=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:37 +1000
Message-Id: <20190821072542.23090-38-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 37/42] spapr/xive: Mask the EAS when allocating
 an IRQ
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
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

If an IRQ is allocated and not configured, such as a MSI requested by
a PCI driver, it can be saved in its default state and possibly later
on restored using the same state. If not initially MASKED, KVM will
try to find a matching priority/target tuple for the interrupt and
fail to restore the VM because 0/0 is not a valid target.

When allocating a IRQ number, the EAS should be set to a sane default :
VALID and MASKED.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190813164420.9829-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a29b48edf7..c1c97192a7 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -536,7 +536,10 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t =
lisn, bool lsi)
         return false;
     }
=20
-    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID);
+    /*
+     * Set default values when allocating an IRQ number
+     */
+    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
     if (lsi) {
         xive_source_irq_set_lsi(xsrc, lisn);
     }
--=20
2.21.0


