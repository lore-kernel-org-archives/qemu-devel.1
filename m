Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476DDC742AB
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB13208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R3FTx/Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB13208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46879 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlp0G-0006Pp-1j
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48714)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlozu-0005Md-TM
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlozt-000423-Ih
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:25:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48881 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlozr-0003v1-7U; Fri, 12 Jul 2019 02:25:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lNFn5QRBz9sDB; Fri, 12 Jul 2019 16:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562912717;
 bh=S1HPw4/KuMYi7qH1HpKbINRPa9UXu8ZoGC7mBL9ouyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R3FTx/OrbukL5tl0WD/EDpxGnNVkQ7lsxpxxWMx4jGE9bfeoXMWV81oR9a46a4cN+
 fuKuvgr6d8iLEo4Xv4wkgngv7DiO5rSAkbJro6lo3vn5VqmkcDGBU7WxB6VsUOzGUP
 qDPcgHW2Ft/ZL7bP4GyctWJDvnGhvCgtM6LdwJ4Y=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 12 Jul 2019 16:25:09 +1000
Message-Id: <20190712062509.31370-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712062509.31370-1-david@gibson.dropbear.id.au>
References: <20190712062509.31370-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 2/2] xics/kvm: Always set the MASKED bit if
 interrupt is masked
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
Cc: gkurz@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The ics_set_kvm_state_one() function is called either to restore the
state of an interrupt source during migration or to set the interrupt
source to a default state during reset.

Since always, ie. 2013, the code only sets the MASKED bit if the 'current
priority' and the 'saved priority' are different. This is likely true
when restoring an interrupt that had been previously masked with the
ibm,int-off RTAS call. However this is always false in the case of
reset since both 'current priority' and 'saved priority' are equal to
0xff, and the MASKED bit is never set.

The legacy KVM XICS device gets away with that because it ends updating
its internal structure the same way, whether the MASKED bit is set or
the priority is 0xff.

The XICS-on-XIVE device for POWER9 is different. It sticks to the KVM
documentation [1] and _really_ relies on the MASKED bit to correctly
set. If not, it will configure the interrupt source in the XIVE HW, even
though the guest hasn't configured the interrupt yet. This disturbs the
complex logic implemented in XICS-on-XIVE and may result in the loss of
subsequent queued events.

Always set the MASKED bit if interrupt is masked as expected by the KVM
XICS-on-XIVE device. This has no impact on the legacy KVM XICS.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/virtual/kvm/devices/xics.txt

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 51433b19b0..2df1f3e92c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -257,6 +257,9 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno, E=
rror **errp)
         << KVM_XICS_PRIORITY_SHIFT;
     if (irq->priority !=3D irq->saved_priority) {
         assert(irq->priority =3D=3D 0xff);
+    }
+
+    if (irq->priority =3D=3D 0xff) {
         state |=3D KVM_XICS_MASKED;
     }
=20
--=20
2.21.0


