Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B184FC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0582072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WWiMzqOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0582072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5PD-0004FM-Hl
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k9-0002MG-G7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k6-00082W-1J
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:55 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54171 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4k2-0007WF-CT; Mon, 16 Dec 2019 23:45:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWg4R8zz9sTc; Tue, 17 Dec 2019 15:43:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557823;
 bh=xZ5+eSjBmXhW8eTHhL7F8PZe9+G9Eaqb505vaM9HCi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WWiMzqOymUtFm/gwdDyWiuiujLcU/HJtZ46pLUYkgb9IpTyfh1Kh6n5U8plNHdA0p
 3rX+p6IhW0xSyCmu2/vLPXjwOCr2VWWkPXh9lrupk1ysjLGOjLNoTqO8dQ/zhnoJ4N
 RWLTwKqAlRkwrHV1UYBaFiJmMTSlhFum7AXS3W4E=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 59/88] ppc: Ignore the CPU_INTERRUPT_EXITTB interrupt with KVM
Date: Tue, 17 Dec 2019 15:42:53 +1100
Message-Id: <20191217044322.351838-60-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

This only makes sense with an emulated CPU. Don't set the bit in
CPUState::interrupt_request when using KVM to avoid confusions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157548863423.3650476.16424649423510075159.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 85dfe7687f..d78c2af63e 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -22,6 +22,7 @@
=20
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
+#include "sysemu/kvm.h"
=20
 /* Swap temporary saved registers with GPRs */
 static inline void hreg_swap_gpr_tgpr(CPUPPCState *env)
@@ -102,6 +103,10 @@ static inline void hreg_compute_hflags(CPUPPCState *=
env)
=20
 static inline void cpu_interrupt_exittb(CPUState *cs)
 {
+    if (!kvm_enabled()) {
+        return;
+    }
+
     if (!qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
--=20
2.23.0


