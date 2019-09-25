Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE7C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE08D217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DtfvuHW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE08D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1Bs-0005tu-Su
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13g-0008H2-Po
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13f-0003SB-M1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:52 -0400
Received: from ozlabs.org ([203.11.71.1]:36117)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13e-0003Oj-HN; Wed, 25 Sep 2019 02:45:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8m2Hv6z9sPL; Wed, 25 Sep 2019 16:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393944;
 bh=CypVHYHnjB6CExsc3EkZt1KsaIgGQjWWt6h0wm6GrOA=;
 h=From:To:Cc:Subject:Date:From;
 b=DtfvuHW5xprbu9kaFoW3gXkVh004TzYVXzxTPI7owDRWXeKyp+Zjo2tCKxMYuk2k/
 vKNE2zz6TTirV4h0ACtilbLwSwp8CACBKgQDXcd2IphyA0jxKWZUU8BsKid3Cf7Xw8
 EdRANCXdn/Xa+NEKA/dUtTb/oHvKpmAyr7XyU/Hs=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/20] spapr: IRQ subsystem cleanups
Date: Wed, 25 Sep 2019 16:45:14 +1000
Message-Id: <20190925064534.19155-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a first batch of a number of cleanups to the handling of IRQs
in spapr.  It includes some cleanups to both the XICS and XIVE
interrupt controller backends, as well as more to the common spapr irq
handling infrastructure.

These are first steps towards even more cleanups that should make the
"dual" irq model less confusing.

David Gibson (20):
  xics: Use incomplete type for XICSFabric
  xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
  xics: Rename misleading ics_simple_*() functions
  xics: Eliminate reset hook
  xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
  xics: Create sPAPR specific ICS subtype
  spapr: Fold spapr_phb_lsi_qirq() into its single caller
  spapr: Replace spapr_vio_qirq() helper with spapr_vio_irq_pulse()
    helper
  spapr: Clarify and fix handling of nr_irqs
  spapr: Eliminate nr_irqs parameter to SpaprIrq::init
  spapr: Fix indexing of XICS irqs
  spapr: Simplify spapr_qirq() handling
  spapr: Eliminate SpaprIrq:get_nodename method
  spapr: Remove unhelpful tracepoints from spapr_irq_free_xics()
  spapr: Handle freeing of multiple irqs in frontend only
  spapr, xics, xive: Better use of assert()s on irq claim/free paths
  spapr: Remove unused return value in claim path
  xive: Improve irq claim/free path
  spapr: Use less cryptic representation of which irq backends are
    supported
  spapr: Eliminate SpaprIrq::init hook

 hw/char/spapr_vty.c         |   3 +-
 hw/intc/spapr_xive.c        |  23 ++-
 hw/intc/trace-events        |  10 +-
 hw/intc/xics.c              | 210 ++++++++--------------
 hw/intc/xics_spapr.c        |  46 ++++-
 hw/net/spapr_llan.c         |   3 +-
 hw/ppc/pnv_psi.c            |   6 +-
 hw/ppc/spapr.c              |  15 +-
 hw/ppc/spapr_hcall.c        |   6 +-
 hw/ppc/spapr_irq.c          | 342 ++++++++++++++----------------------
 hw/ppc/spapr_pci.c          |   3 +-
 hw/ppc/spapr_vio.c          |   3 +-
 hw/ppc/trace-events         |   4 -
 include/hw/pci-host/spapr.h |   7 -
 include/hw/ppc/spapr_irq.h  |  31 ++--
 include/hw/ppc/spapr_vio.h  |   5 +-
 include/hw/ppc/spapr_xive.h |   5 +-
 include/hw/ppc/xics.h       |  31 ++--
 include/hw/ppc/xics_spapr.h |   5 +-
 19 files changed, 320 insertions(+), 438 deletions(-)

--=20
2.21.0


