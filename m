Received: from eggs.gnu.org ([2001:4830:134:3::10]:45687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvW-0003vM-Js
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-00070f-Kl
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:46 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:51890)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-0006yc-Es
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:42 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:17 +0000
Message-ID: <1490014826-4472-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 01/10] target-mips: fix compiler
 warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

static code analyzer complain:

target/mips/helper.c:453:5: warning: Function call argument is an uniniti=
alized value
    qemu_log_mask(CPU_LOG_MMU,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~

'physical' and 'prot' are uninitialized if 'ret' is not TLBRET_MATCH.

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index d2e7795..e359ca3 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -450,10 +450,18 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr a=
ddress, int rw,
     access_type =3D ACCESS_INT;
     ret =3D get_physical_address(env, &physical, &prot,
                                address, rw, access_type);
-    qemu_log_mask(CPU_LOG_MMU,
-             "%s address=3D%" VADDR_PRIx " ret %d physical " TARGET_FMT_=
plx
-             " prot %d\n",
-             __func__, address, ret, physical, prot);
+    switch (ret) {
+    case TLBRET_MATCH:
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=3D%" VADDR_PRIx " physical " TARGET_FM=
T_plx
+                      " prot %d\n", __func__, address, physical, prot);
+        break;
+    default:
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=3D%" VADDR_PRIx " ret %d\n", __func__,=
 address,
+                      ret);
+        break;
+    }
     if (ret =3D=3D TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
--=20
2.7.4
