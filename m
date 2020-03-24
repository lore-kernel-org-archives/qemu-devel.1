Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E665C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2930020714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jHmTxP5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2930020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbvJ-0006ES-AL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu8-0004bB-RN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu7-0001ew-L5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu7-0001bf-AH; Tue, 24 Mar 2020 01:15:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW65T8z9sSN; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=Xc+3RKabXHno7VL+AST1GTZnAiqqXI+OYqmv72T8XXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jHmTxP5C42dI8ZUfqy0+b2sXaQP7NAORnL4ORJj3ShGeocPlCOfhFB97hWqh+BW45
 W7MIG+f0SF3yy5bDq/x7QNU7+QWzlie6wFs5A0aApPjo09GjlaVjpK3iQHUwZhkEWp
 KXVpOhJ6+c5dDvC0emb+zjrjS+TX19JiWRmEAFVc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 6/7] hw/ppc: Take QEMU lock when calling ppc_dcr_read/write()
Date: Tue, 24 Mar 2020 16:14:55 +1100
Message-Id: <20200324051456.256116-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324051456.256116-1-david@gibson.dropbear.id.au>
References: <20200324051456.256116-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, Amit Lazar <abasarlaz@hotmail.com>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The ppc_dcr_read() and ppc_dcr_write() functions call into callbacks
in device code, so we need to hold the QEMU iothread lock while
calling them.  This is the case already for the callsites in
kvmppc_handle_dcr_read/write(), but we must also take the lock when
calling the helpers from TCG.

This fixes a bug where attempting to initialise the PPC405EP
SDRAM will cause an assertion when sdram_map_bcr() attempts
to remap memory regions.

Reported-by: Amit Lazar <abasarlaz@hotmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200322192258.14039-1-peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/timebase_helper.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 703bd9ed18..d16360ab66 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -21,6 +21,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
=20
 /***********************************************************************=
******/
 /* SPR accesses */
@@ -167,13 +168,19 @@ target_ulong helper_load_dcr(CPUPPCState *env, targ=
et_ulong dcrn)
         raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                POWERPC_EXCP_INVAL |
                                POWERPC_EXCP_INVAL_INVAL, GETPC());
-    } else if (unlikely(ppc_dcr_read(env->dcr_env,
-                                     (uint32_t)dcrn, &val) !=3D 0)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "DCR read error %d %03x\n",
-                      (uint32_t)dcrn, (uint32_t)dcrn);
-        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                               POWERPC_EXCP_INVAL |
-                               POWERPC_EXCP_PRIV_REG, GETPC());
+    } else {
+        int ret;
+
+        qemu_mutex_lock_iothread();
+        ret =3D ppc_dcr_read(env->dcr_env, (uint32_t)dcrn, &val);
+        qemu_mutex_unlock_iothread();
+        if (unlikely(ret !=3D 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "DCR read error %d %03x\n",
+                          (uint32_t)dcrn, (uint32_t)dcrn);
+            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                                   POWERPC_EXCP_INVAL |
+                                   POWERPC_EXCP_PRIV_REG, GETPC());
+        }
     }
     return val;
 }
@@ -185,12 +192,17 @@ void helper_store_dcr(CPUPPCState *env, target_ulon=
g dcrn, target_ulong val)
         raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                POWERPC_EXCP_INVAL |
                                POWERPC_EXCP_INVAL_INVAL, GETPC());
-    } else if (unlikely(ppc_dcr_write(env->dcr_env, (uint32_t)dcrn,
-                                      (uint32_t)val) !=3D 0)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "DCR write error %d %03x\n",
-                      (uint32_t)dcrn, (uint32_t)dcrn);
-        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                               POWERPC_EXCP_INVAL |
-                               POWERPC_EXCP_PRIV_REG, GETPC());
+    } else {
+        int ret;
+        qemu_mutex_lock_iothread();
+        ret =3D ppc_dcr_write(env->dcr_env, (uint32_t)dcrn, (uint32_t)va=
l);
+        qemu_mutex_unlock_iothread();
+        if (unlikely(ret !=3D 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "DCR write error %d %03x\n",
+                          (uint32_t)dcrn, (uint32_t)dcrn);
+            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                                   POWERPC_EXCP_INVAL |
+                                   POWERPC_EXCP_PRIV_REG, GETPC());
+        }
     }
 }
--=20
2.25.1


