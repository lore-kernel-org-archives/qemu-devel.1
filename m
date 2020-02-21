Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DEDC11D27
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88475208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dv7wkvEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88475208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4z94-0003t2-N9
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7l-0001sT-1F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7j-0007vL-Th
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:08 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41281 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7j-0007aV-Gd; Thu, 20 Feb 2020 22:37:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwB2f3jz9sSH; Fri, 21 Feb 2020 14:36:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256218;
 bh=d7Oo57xSePtAPZw1vQ7lnHZ7unAZbPpu/m8dqU1L7nw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dv7wkvEmGHVXsHYtvYksRg+uDgfll02Cu61CeFeowuWQsnIrzkWtNajHaCwqDPaKh
 lfLXR3Dv6r2H66TvJS8VB2Q8aq3LpPI9d75LDhfVN/TgvLxe620dy6Wfwi3AgXNRGG
 yiLaB61kV8PPqd8EYxX3pmNC7duubP4P7lX8hKgs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/20] spapr/rtas: Print message from "ibm,os-term"
Date: Fri, 21 Feb 2020 14:36:31 +1100
Message-Id: <20200221033650.444386-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The "ibm,os-term" RTAS call has a single parameter which is a pointer to
a message from the guest kernel about the termination cause; this prints
it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20200203032044.118585-1-aik@ozlabs.ru>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 883fe28465..656fdd2216 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -345,6 +345,13 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
 {
+    target_ulong msgaddr =3D rtas_ld(args, 0);
+    char msg[512];
+
+    cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
+    msg[sizeof(msg) - 1] =3D 0;
+
+    error_report("OS terminated: %s", msg);
     qemu_system_guest_panicked(NULL);
=20
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
--=20
2.24.1


