Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2F3C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020E420748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UKlNeUrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020E420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLg1z-00064Q-7F
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyM-0007yQ-Fd
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyL-0004Cn-9F
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40711 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyK-0004Al-UH; Tue, 07 Apr 2020 00:36:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K4Hptz9sSk; Tue,  7 Apr 2020 14:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=EYxcaKAJK6jtK2yRfiXyVNG0eInMoSPB/jy3Zpie/2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UKlNeUrSEksUbGIyc8O6geQ/NhgpCdKvaAsM3Ar5+gjtxzq6LIdMPqAr5yiZ/tf9z
 jxB7zxacvQUGeF27BTJB5qwEkS5JsssIt4E6GMVrv7YmCrPYTThtz2GFT7Dx5v/PIY
 EKsJcpZEMkxC8fAX/gt7Z7dpSg1ep+/KBKLgIDq4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 08/10] hw/ppc/ppc440_uc.c: Remove incorrect iothread locking
 from dcr_write_pcie()
Date: Tue,  7 Apr 2020 14:36:04 +1000
Message-Id: <20200407043606.291546-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In dcr_write_pcie() we take the iothread lock around a call to
pcie_host_mmcfg_udpate().  This is an incorrect attempt to deal with
the bug fixed in commit 235352ee6e73d7716, where we were not taking
the iothread lock before calling device dcr read/write functions.
(It's not sufficient locking, because although the other cases in the
switch statement won't assert, there is no locking which prevents
multiple guest CPUs from trying to access the PPC460EXPCIEState
struct at the same time and corrupting data.)

Unfortunately with commit 235352ee6e73d7716 we are now trying
to recursively take the iothread lock, which will assert:

  $ qemu-system-ppc -M sam460ex --display none
  **
  ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1830:qemu_mute=
x_lock_iothread_impl: assertion failed: (!qemu_mutex_iothread_locked())
  Aborted (core dumped)

Remove the locking within dcr_write_pcie().

Fixes: 235352ee6e73d7716
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200330125228.24994-1-peter.maydell@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index d5ea962249..b30e093cbb 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -13,7 +13,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/irq.h"
@@ -1183,9 +1182,7 @@ static void dcr_write_pcie(void *opaque, int dcrn, =
uint32_t val)
     case PEGPL_CFGMSK:
         s->cfg_mask =3D val;
         size =3D ~(val & 0xfffffffe) + 1;
-        qemu_mutex_lock_iothread();
         pcie_host_mmcfg_update(PCIE_HOST_BRIDGE(s), val & 1, s->cfg_base=
, size);
-        qemu_mutex_unlock_iothread();
         break;
     case PEGPL_MSGBAH:
         s->msg_base =3D ((uint64_t)val << 32) | (s->msg_base & 0xfffffff=
f);
--=20
2.25.2


