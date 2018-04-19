Received: from eggs.gnu.org ([2001:4830:134:3::10]:58588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xe-0001jq-0C
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xa-0001OG-3y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:50 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:60328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xZ-0001MY-TK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:46 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.17])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6DDFB12E39F
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:44 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:27 +0200
Message-Id: <20180419124331.3915-32-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 31/35] spapr/xive: raise migration priority
 of the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE MMIO regions should be set on the destination before the XIVE
sources are restored. This is currently handled at the machine level
because it depends on the KVM initialization to be done before
anything else.

But it has ugly consequences on MMU, which seems broken after migration :

  Oops: Exception in kernel mode, sig: 4 [#1]
  LE SMP NR_CPUS=3D2048 NUMA pSeries
  Modules linked in: ipmi_devintf ipmi_msghandler vmx_crypto crct10dif_vp=
msum ...
  CPU: 3 PID: 1 Comm: systemd Not tainted 4.16.0+ #2
  NIP:  c000000000079810 LR: c00000000033f720 CTR: 0000000000000000
  REGS: c00000007a803880 TRAP: 0700   Not tainted  (4.16.0+)
  MSR:  8000000002049033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24048884  XER: 2=
0040000
  CFAR: c000000000079ae4 SOFTE: 0
  GPR00: c00000000033f720 c00000007a803b00 c0000000015f8a00 c00000007bb1d=
800
  GPR04: 00000000000000a0 c0000000017a2598 c00000007a803ba0 0000000000000=
002
  GPR08: 8403bb74000000c0 0000000000000004 00000000000000c0 0000000000000=
060
  GPR12: 0000000044048888 c000000007d80f00 00000594336eeaa0 0000000000000=
003
  GPR16: 00007ffff732c410 00007ffff732c420 00000594336ec090 fffffffffffff=
ffd
  GPR20: 0000000000000000 c00000007bb1d800 0000059444690000 0000059444680=
000
  GPR24: 0000059444680000 8603146e00000080 c00000007bb1d800 0000000000000=
001
  GPR28: c0000000017a24e8 0000059444680000 0000000200000000 0000059444680=
0a0
  NIP [c000000000079810] radix__flush_tlb_page_psize+0x60/0x300
  LR [c00000000033f720] ptep_clear_flush+0xe0/0x1e0
  Call Trace:
  [c00000007a803b00] [c00000007a803b80] 0xc00000007a803b80 (unreliable)
  [c00000007a803b40] [c00000007a803b80] 0xc00000007a803b80
  [c00000007a803b80] [c000000000325cc4] wp_page_copy+0x314/0x9a0
  [c00000007a803c10] [c0000000003298b4] do_wp_page+0x1e4/0x860
  [c00000007a803c60] [c00000000032f58c] __handle_mm_fault+0x10fc/0x1b10
  [c00000007a803d40] [c0000000003300d8] handle_mm_fault+0x138/0x250
  [c00000007a803d80] [c000000000069a24] __do_page_fault+0x224/0xa50
  [c00000007a803e30] [c00000000000a534] handle_page_fault+0x18/0x38

Work in progress.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dea636f9befe..24b3ee2fe13d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1916,6 +1916,7 @@ static const VMStateDescription vmstate_spapr =3D {
     .pre_load =3D spapr_pre_load,
     .post_load =3D spapr_post_load,
     .pre_save =3D spapr_pre_save,
+    .priority =3D MIG_PRI_MAX,
     .fields =3D (VMStateField[]) {
         /* used to be @next_irq */
         VMSTATE_UNUSED_BUFFER(version_before_3, 0, 4),
--=20
2.13.6
