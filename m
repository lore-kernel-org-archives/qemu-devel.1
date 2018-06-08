Received: from eggs.gnu.org ([2001:4830:134:3::10]:38142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDzD-0004kz-8m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDzA-0004YT-KV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:47:11 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:45386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRDzA-0004Xr-Cq
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:47:08 -0400
Received: from player168.ha.ovh.net (unknown [10.109.108.82])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7D78D1B9A9B
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 11:47:06 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Jun 2018 11:46:55 +0200
Message-ID: <152845121577.13960.4480474870896921301.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4] target/ppc: Allow PIR read in privileged
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, leandro.lupori@gmail.com

From: luporl <leandro.lupori@gmail.com>

According to PowerISA, the PIR register should be readable in privileged
mode also, not only in hypervisor privileged mode.

PowerISA 3.0 - 4.3.3 Processor Identification Register

"Read access to the PIR is privileged; write access is not provided."

Figure 18 in section 4.4.4 explicitly confirms that mfspr PIR is privileged
and doesn't require hypervisor state.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes in v2:
- added my Signed-off-by, maintainers CC and Jose's Reviewed-by tags

Changes in v3:
- added subsystem name, version tag and summary of changes
- added the section of PowerISA that describes PIR access privileges

Changes in v4 (Greg):
- rebased against ppc-for-3.0 (ie, file is now target/ppc/translate_init.inc.c)
- added some more context from PowerISA
---
 target/ppc/translate_init.inc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 1a89017ddea8..bb9296f5a3da 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -7819,7 +7819,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
     /* Processor identification */
     spr_register_hv(env, SPR_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
     spr_register_hv(env, SPR_HID0, "HID0",
