Received: from eggs.gnu.org ([2001:4830:134:3::10]:41448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntI-0003sN-6m
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntE-00034R-6q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:04 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:48817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntE-00033d-0W
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:00 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id E38F9FCD77
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:58 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:23 +0200
Message-Id: <1499274819-15607-11-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 10/26] ppc/xive: record interrupt source
 MMIO address for hcalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The address of the MMIO page through which the Event State Buffer is
controlled is returned to the guest by the H_INT_GET_SOURCE_INFO hcall.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 3 +++
 include/hw/ppc/xive.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a1cb87a07b76..0db97fd33981 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -344,6 +344,9 @@ static void xive_ics_realize(ICSState *ics, Error **e=
rrp)
                                 ICS_BASE(xs)->offset * (1 << xs->esb_shi=
ft),
                                 &xs->esb_iomem);
=20
+    /* Record base address which is needed by the hcalls */
+    xs->esb_base =3D x->vc_base + ICS_BASE(xs)->offset * (1 << xs->esb_s=
hift);
+
     qemu_register_reset(xive_ics_reset, xs);
 }
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 1178300c9df3..b06bc861b845 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -43,6 +43,7 @@ struct XiveICSState {
=20
     uint64_t     flags;
     uint32_t     esb_shift;
+    hwaddr       esb_base;
     MemoryRegion esb_iomem;
=20
     XIVE         *xive;
--=20
2.7.5
