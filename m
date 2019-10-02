Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A0ECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227AA2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iro0UzWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227AA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUno-0004ED-Ro
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkg-0001Zv-IW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkf-0002lt-5Q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:30 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46621 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFUkb-0002by-NC; Tue, 01 Oct 2019 22:52:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jgf62Wd0z9sPh; Wed,  2 Oct 2019 12:52:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569984734;
 bh=LDtL5N4JOK/xgl80NjUxnH8/3lQYWSI4nLNfApMKNKg=;
 h=From:To:Cc:Subject:Date:From;
 b=iro0UzWgtfWxRih2rBW2e6RiWwVf8quxM4qDP/Dd+GPI3PgPthntIvXZ4nUWJ1nsH
 huBZZ8TPlcwhKoDSschBsPlEWxxM2G/D+UJazdVy4CzHgHFg5OsdyWVV52eAmojKu1
 WUhTVNqvd+Z5Qjx6ZVYkAIPqtdIDZ8SODKpozBXU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/34] spapr: IRQ subsystem cleanup
Date: Wed,  2 Oct 2019 12:51:34 +1000
Message-Id: <20191002025208.3487-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a substantial rework to clean up the handling of IRQs in
spapr.  It includes some cleanups to both the XICS and XIVE interrupt
controller backends, as well as more to the common spapr irq handling
infrastructure.

Changes since v2:
 * Fixed a bug where the "move handling multiple irq frees" to
   frontend patch was actually freeing one irq over and over, rather
   than freeing multiple irqs
 * Fixed some places I missed still using only-Error * style, and flow
   on adjustments
 * New idiom to iterate across all constructed backends for the things
   that need that (cpu_intc_create, claim & freem), rather than
   open-coding a call on the xics, then xive versions.

Changes since v1:
 * Lots of extra patches
 * Many minor adjustments based on feedback
 * Moved towards return value + Error * style, instead of just Error *
   style

David Gibson (34):
  xics: Minor fixes for XICSFabric interface
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
  xive: Improve irq claim/free path
  spapr: Use less cryptic representation of which irq backends are
    supported
  spapr: Add return value to spapr_irq_check()
  spapr: Eliminate SpaprIrq::init hook
  spapr, xics, xive: Introduce SpaprInterruptController QOM interface
  spapr, xics, xive: Move cpu_intc_create from SpaprIrq to
    SpaprInterruptController
  spapr, xics, xive: Move irq claim and free from SpaprIrq to
    SpaprInterruptController
  spapr: Formalize notion of active interrupt controller
  spapr, xics, xive: Move set_irq from SpaprIrq to
    SpaprInterruptController
  spapr, xics, xive: Move print_info from SpaprIrq to
    SpaprInterruptController
  spapr, xics, xive: Move dt_populate from SpaprIrq to
    SpaprInterruptController
  spapr, xics, xive: Match signatures for XICS and XIVE KVM connect
    routines
  spapr: Remove SpaprIrq::init_kvm hook
  spapr, xics, xive: Move SpaprIrq::reset hook logic into
    activate/deactivate
  spapr, xics, xive: Move SpaprIrq::post_load hook to backends
  spapr: Remove SpaprIrq::nr_msis
  spapr: Move SpaprIrq::nr_xirqs to SpaprMachineClass
  spapr: Remove last pieces of SpaprIrq

 hw/char/spapr_vty.c         |   3 +-
 hw/intc/spapr_xive.c        | 298 ++++++++-----
 hw/intc/spapr_xive_kvm.c    |  30 +-
 hw/intc/trace-events        |  10 +-
 hw/intc/xics.c              | 210 +++------
 hw/intc/xics_kvm.c          |   9 +-
 hw/intc/xics_spapr.c        | 157 ++++++-
 hw/net/spapr_llan.c         |   3 +-
 hw/ppc/pnv_psi.c            |   6 +-
 hw/ppc/spapr.c              |  57 ++-
 hw/ppc/spapr_caps.c         |  64 +++
 hw/ppc/spapr_cpu_core.c     |   3 +-
 hw/ppc/spapr_hcall.c        |   7 +-
 hw/ppc/spapr_irq.c          | 847 +++++++++++-------------------------
 hw/ppc/spapr_pci.c          |  10 +-
 hw/ppc/spapr_vio.c          |   3 +-
 hw/ppc/trace-events         |   4 -
 include/hw/pci-host/spapr.h |  11 +-
 include/hw/ppc/spapr.h      |  14 +-
 include/hw/ppc/spapr_irq.h  |  89 ++--
 include/hw/ppc/spapr_vio.h  |   5 +-
 include/hw/ppc/spapr_xive.h |   9 +-
 include/hw/ppc/xics.h       |  33 +-
 include/hw/ppc/xics_spapr.h |  10 +-
 include/hw/ppc/xive.h       |   2 +-
 25 files changed, 897 insertions(+), 997 deletions(-)

--=20
2.21.0


