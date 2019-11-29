Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E268C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 01:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1906421775
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 01:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RNUdH0ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1906421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaVJk-0005TL-8J
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 20:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVC1-0002fc-QC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVBn-0003NU-2J
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:35:30 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaVBj-0002tK-Ea; Thu, 28 Nov 2019 20:35:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PHBM5Nn7z9sPv; Fri, 29 Nov 2019 12:35:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574991307;
 bh=4jXHJwcJ835Ed2wfJaN9ot4xP/54/M1z4ELPqzcSWY0=;
 h=From:To:Cc:Subject:Date:From;
 b=RNUdH0ERMa/dYo2fgyYBGkM++ZK3Nc/AJOhGrJXOSF9HCdZbaY+b2EpjBW0Wspysm
 6+w1TopWvMJCSYA8e/tM3oA7/dMscjYXmhZwqkQRLh37ZtbB01tbeDTAIMdPRWDSLN
 DxYm+PsOwLBD8GYQuPjm2mETR0/ZdtJ+iW+UkkSw=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org
Subject: [for-5.0 0/4] Fixes for RMA size calculation
Date: Fri, 29 Nov 2019 12:35:00 +1100
Message-Id: <20191129013504.145455-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
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
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PAPR guests have a certain "Real Mode Area" - a subsection of memory
which can be accessed when in guest real mode (that is, with the MMU
"off" from the guest point of view).  This is advertised to the guest
in the device tree.

We want to make the RMA as large as we can, to allow for flexibility
in loading boot images, which need to fit within it.  But, there's a
somewhat complex set of constraints on the size.  At the moment, we
don't always get those correct.  This has caused crashes in some
cases, although for now those are worked around inside the guest
kernel.

These patches clarify and correct the logic here.  They will break
some cases using a host kernel with 4kiB pagesize (which doesn't
include any mainstream distro kernel nowadays).  Since that case is
very rare, and there do exist a number of workarounds for it, I think
that's worth it for the simplified logic and more consistent
behaviour.

David Gibson (4):
  spapr,ppc: Simplify signature of kvmppc_rma_size()
  spapr: Don't attempt to clamp RMA to VRMA constraint
  spapr: Clean up RMA size calculation
  spapr: Correct clamping of RMA to Node 0 size

 hw/ppc/spapr.c         | 110 ++++++++++++++++++++---------------------
 hw/ppc/spapr_hcall.c   |   4 +-
 include/hw/ppc/spapr.h |   3 +-
 target/ppc/kvm.c       |   5 +-
 target/ppc/kvm_ppc.h   |   7 ++-
 5 files changed, 63 insertions(+), 66 deletions(-)

--=20
2.23.0


