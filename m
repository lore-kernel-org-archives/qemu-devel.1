Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC9C5ACC4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9365921D56
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OTr3aJxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9365921D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4cTk-0001bj-P2
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 22:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR4-0004ah-1C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR2-0008Hu-Jo
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:33 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56693 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4cR1-0008Dk-Lq; Wed, 19 Feb 2020 22:23:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NKg00350z9sRt; Thu, 20 Feb 2020 14:23:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582169004;
 bh=FFr8QTXtG4J8rnGCRYb/tmkP97s+UaHKY8wEmJk8kxU=;
 h=From:To:Cc:Subject:Date:From;
 b=OTr3aJxZIvgj77qXrLJDPJ6mLqAu//khGSpUKXhi69Nb06G87fPYttERFZM0DDTI/
 2uX1yKX/LVIgRINXo2cYk9m3WPD4g9bzofChwSgQnrtDedX8fUPKd4EZg4hrizZIc4
 9IraXRm1nwpuKZuvdvFxizvV2cZZZQB0NBmJJ5gk=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	groug@kaod.org,
	clg@kaod.org
Subject: [PATCH v5 00/18] target/ppc: Correct some errors with real mode
 handling
Date: Thu, 20 Feb 2020 14:22:58 +1100
Message-Id: <20200220032317.96884-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

POWER "book S" (server class) cpus have a concept of "real mode" where
MMU translation is disabled... sort of.  In fact this can mean a bunch
of slightly different things when hypervisor mode and other
considerations are present.

We had some errors in edge cases here, so clean some things up and
correct them.

Some of those limitations caused problems with calculating the size of
the Real Mode Area of pseries guests, so continue on to clean up and
correct those calculations as well.

Changes since v4:
 * Some tiny cosmetic fixes to the original patches
 * Added a bunch of extra patches correcting RMA calculation
Changes since v3:
 * Fix style errors reported by checkpatch
Changes since v2:
 * Removed 32-bit hypervisor stubs more completely
 * Minor polish based on review comments
Changes since RFCv1:
 * Add a number of extra patches taking advantage of the initial
   cleanups

David Gibson (18):
  ppc: Remove stub support for 32-bit hypervisor mode
  ppc: Remove stub of PPC970 HID4 implementation
  target/ppc: Correct handling of real mode accesses with vhyp on hash
    MMU
  target/ppc: Introduce ppc_hash64_use_vrma() helper
  spapr, ppc: Remove VPM0/RMLS hacks for POWER9
  target/ppc: Remove RMOR register from POWER9 & POWER10
  target/ppc: Use class fields to simplify LPCR masking
  target/ppc: Streamline calculation of RMA limit from LPCR[RMLS]
  target/ppc: Correct RMLS table
  target/ppc: Only calculate RMLS derived RMA limit on demand
  target/ppc: Streamline construction of VRMA SLB entry
  target/ppc: Don't store VRMA SLBE persistently
  spapr: Don't use weird units for MIN_RMA_SLOF
  spapr,ppc: Simplify signature of kvmppc_rma_size()
  spapr: Don't attempt to clamp RMA to VRMA constraint
  spapr: Don't clamp RMA to 16GiB on new machine types
  spapr: Clean up RMA size calculation
  spapr: Fold spapr_node0_size() into its only caller

 hw/ppc/spapr.c                  | 124 ++++++------
 hw/ppc/spapr_cpu_core.c         |   6 +-
 hw/ppc/spapr_hcall.c            |   4 +-
 include/hw/ppc/spapr.h          |   4 +-
 target/ppc/cpu-qom.h            |   1 +
 target/ppc/cpu.h                |  25 +--
 target/ppc/kvm.c                |   5 +-
 target/ppc/kvm_ppc.h            |   7 +-
 target/ppc/mmu-hash64.c         | 327 ++++++++++++--------------------
 target/ppc/translate_init.inc.c |  63 ++++--
 10 files changed, 252 insertions(+), 314 deletions(-)

--=20
2.24.1


