Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B0C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B144D20874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LP8aVkvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B144D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawIR-0006Da-8r
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 01:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8p-0004a1-4S
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8n-000758-Fh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:46 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46167 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haw8m-00073Q-WF; Wed, 12 Jun 2019 01:49:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NwtR60Tqz9sPH; Wed, 12 Jun 2019 15:49:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560318575;
 bh=tyUDdI4e4bCE/oy8otsoOZLgCZX2M2lVZQFcb3wbaG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LP8aVkvAJvLUWrSFlNtQ6ksimJNKkRnHwnOBTYOUSh3HpxkKXO2KHxnYgYgRYXalY
 vehJGdI60JE8d6Q8PHz0Et6ZZWKMYugZatlMi0JyiIbDnVJxH1J63VWcTbivwvU0nz
 5NZ+1hOvViOc45KyAzbxR0bLzS4bIUgjtjtfROVk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 15:49:29 +1000
Message-Id: <20190612054929.21136-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612054929.21136-1-david@gibson.dropbear.id.au>
References: <20190612054929.21136-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 13/13] ppc/xive: Make XIVE generate the proper
 interrupt types
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It should be generic Hypervisor Virtualization interrupts for HV
directed rings and traditional External Interrupts for the OS directed
ring.

Don't generate anything for the user ring as it isn't actually
supported.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190606174409.12502-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 22 +++++++++++++++++++---
 include/hw/ppc/xive.h |  3 ++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0c74e47aa4..b2b92a92c8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -61,13 +61,28 @@ static uint8_t exception_mask(uint8_t ring)
     }
 }
=20
+static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
+{
+        switch (ring) {
+        case TM_QW0_USER:
+                return 0; /* Not supported */
+        case TM_QW1_OS:
+                return tctx->os_output;
+        case TM_QW2_HV_POOL:
+        case TM_QW3_HV_PHYS:
+                return tctx->hv_output;
+        default:
+                return 0;
+        }
+}
+
 static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs =3D &tctx->regs[ring];
     uint8_t nsr =3D regs[TM_NSR];
     uint8_t mask =3D exception_mask(ring);
=20
-    qemu_irq_lower(tctx->output);
+    qemu_irq_lower(xive_tctx_output(tctx, ring));
=20
     if (regs[TM_NSR] & mask) {
         uint8_t cppr =3D regs[TM_PIPR];
@@ -100,7 +115,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t =
ring)
         default:
             g_assert_not_reached();
         }
-        qemu_irq_raise(tctx->output);
+        qemu_irq_raise(xive_tctx_output(tctx, ring));
     }
 }
=20
@@ -556,7 +571,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER9:
-        tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
+        tctx->hv_output =3D env->irq_inputs[POWER9_INPUT_HINT];
+        tctx->os_output =3D env->irq_inputs[POWER9_INPUT_INT];
         break;
=20
     default:
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index d872f96d1a..a6ee7e831d 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -317,7 +317,8 @@ typedef struct XiveTCTX {
     DeviceState parent_obj;
=20
     CPUState    *cs;
-    qemu_irq    output;
+    qemu_irq    hv_output;
+    qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
 } XiveTCTX;
--=20
2.21.0


