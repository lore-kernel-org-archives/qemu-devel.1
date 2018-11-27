Received: from eggs.gnu.org ([2001:4830:134:3::10]:59286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd35-0002Ti-HD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd32-0005KN-Cb
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:07 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:38414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd32-0005JY-31
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:04 -0500
Received: from player758.ha.ovh.net (unknown [10.109.159.152])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id BF662D4F8B
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:05:01 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:04:53 +0100
Message-ID: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 0/9] ppc: get rid of g_malloc(sizeof(T)
 * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

As explained in HACKING, the g_malloc(sizeof(T) * n) construct is unsafe
because it can't detect multiplication overflowing size_t and doesn't
allow type checking.

It appears to be used in a bunch of places though:

$ git grep -E 'malloc.*sizeof' | grep ' \* '  | wc -l
101

This series fixes the ppc target and ppc machine code. The changes are
mostly trivial. Only the mac99 and e500 machines required some more work
that should be reviewed carefully, as it was only compile-tested.

--
Greg

---

Greg Kurz (9):
      target/ppc: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      spapr: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      ppc405_boards: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      ppc405_uc: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      ppc440_bamboo: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      sam460ex: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      virtex_ml507: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      mac_newworld: simplify IRQ wiring
      e500: simplify IRQ wiring


 hw/ppc/e500.c                   |   18 ++++++++----------
 hw/ppc/mac_newworld.c           |   30 +++++++++++++-----------------
 hw/ppc/ppc405_boards.c          |    4 ++--
 hw/ppc/ppc405_uc.c              |    4 ++--
 hw/ppc/ppc440_bamboo.c          |    5 ++---
 hw/ppc/sam460ex.c               |    2 +-
 hw/ppc/spapr_iommu.c            |    2 +-
 hw/ppc/spapr_vio.c              |    2 +-
 hw/ppc/virtex_ml507.c           |    2 +-
 include/hw/ppc/openpic.h        |    2 ++
 target/ppc/translate_init.inc.c |    6 +++---
 11 files changed, 36 insertions(+), 41 deletions(-)
