Received: from eggs.gnu.org ([209.51.188.92]:50683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafZ-0004Ke-Mg
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafY-0003v7-PO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:57161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hHafY-0003ul-Gl
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:36 -0400
From: Nick Hudson <nick.hudson@gmx.co.uk>
Message-ID: <eb28f1c2-9556-f3c2-ac2b-0f69db474ff6@gmx.co.uk>
Date: Fri, 19 Apr 2019 22:03:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 2/2] Always return EXCP_DMAR for protection
 id trap as, EXCP_DMP is considered legacy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>

Always return EXCP_DMAR for protection id trap as EXCP_DMP is considered l=
egacy.

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must
use traps 26, 27,and 28 which provide equivalent functionality"

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/mem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..77fb544838 100644
=2D-- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -154,8 +154,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr=
 addr, int mmu_idx,
      if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.=
  */
-        ret =3D (type & PAGE_EXEC ? EXCP_IMP :
-               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
+        ret =3D (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }
 -- 2.17.1
