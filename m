Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C093C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3E32072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CmaxjR9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3E32072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5UO-0003Gb-K2
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jL-0001cf-BG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jK-00071l-9O
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:07 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57659 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jJ-0006Vo-VK; Mon, 16 Dec 2019 23:45:06 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWb3HC8z9sTJ; Tue, 17 Dec 2019 15:43:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557819;
 bh=gKTXY6PIFlGqQkjlQe3AzKVDyV+OH7Fw3zyDvKgJzpc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CmaxjR9z/I8fsymqZJUtk2RrfDSOX/x063IEx0/+7Ta5uozXmvsOp5CxQfiyZx9lw
 6ksP4jWO12wctUXaJbmQMGP5Ys9n0bSOzMzLMewLdcW33cH6IpgJokvl5UH5Q0VLrO
 XgfXO3folmt49nVH53F8gpOJ5R1q1SKRPTXzGR7s=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 57/88] xics: Don't deassert outputs
Date: Tue, 17 Dec 2019 15:42:51 +1100
Message-Id: <20191217044322.351838-58-david@gibson.dropbear.id.au>
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

The correct way to do this is to deassert the input pins on the CPU side.
This is the case since a previous change.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157548862298.3650476.1228720391270249433.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 0b259a09c5..1952009e6d 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -289,9 +289,6 @@ void icp_reset(ICPState *icp)
     icp->pending_priority =3D 0xff;
     icp->mfrr =3D 0xff;
=20
-    /* Make all outputs are deasserted */
-    qemu_set_irq(icp->output, 0);
-
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
=20
--=20
2.23.0


