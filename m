Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDBFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 04:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BA120726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 04:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M3c5eViJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BA120726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izvKr-0001TG-RJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 23:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izvIN-00076a-Rf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 23:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izvIM-00072t-Hb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 23:31:11 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59409 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1izvIL-0005ad-7y; Thu, 06 Feb 2020 23:31:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48DMmy2zj5z9sSD; Fri,  7 Feb 2020 15:30:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581049858;
 bh=P785p36H7X0KObisezvwaG4CrKJjnf9NT1kKSv7E3K0=;
 h=From:To:Cc:Subject:Date:From;
 b=M3c5eViJEDEN1jHXt+txZ9oQV1kxl5+Pu4H64OMBt4YP7+iJBllsGWw139Xuab3OO
 O6tavxKz7cPSpiddLj30MEnwOWQ9Mz1+pc//a0EhAfJ4jy9jG0OjO5N36OGI+fWEvR
 mnFHaCAVor9UQQdF3EmX2Kxrv4A0n6E70+pdjuNk=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	pair@us.ibm.com
Subject: [PATCH 0/2] spapr: Use vIOMMU translation for virtio by default
Date: Fri,  7 Feb 2020 15:30:53 +1100
Message-Id: <20200207043055.218856-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
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
Cc: mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@samba.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Upcoming Secure VM support for pSeries machines introduces some
complications for virtio, since the transfer buffers need to be
explicitly shared so that the hypervisor can access them.

While it's not strictly speaking dependent on it, the fact that virtio
devices bypass normal platform IOMMU translation complicates the issue
on the guest side.  Since there are some significan downsides to
bypassing the vIOMMU anyway, let's just disable that.

There's already a flag to do this in virtio, just turn it on by
default for forthcoming pseries machine types.

The implementation does this with a compat_props_add() from the latest
machine type.  This breaks the previous convention that the setup for
the latest machine type didn't do anything, instead just taking all
the defaults from the abstract base class.  However,
compat_props_add() can't be used from the base class, because
mc->compat_props is explicitly uninitialized for abstract classes.  If
anyone knows a better way to handle this, let me know.

David Gibson (2):
  spapr: Disable legacy virtio devices for pseries-5.0 and later
  spapr: Enable virtio iommu_platform=3Don by default

 hw/ppc/spapr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--=20
2.24.1


