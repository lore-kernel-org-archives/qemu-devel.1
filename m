Received: from eggs.gnu.org ([209.51.188.92]:52578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gn9M8-0001Sj-Kp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gn9M7-00035o-Ai
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:49:44 -0500
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Date: Fri, 25 Jan 2019 23:49:25 +0200
Message-Id: <20190125214926.3204-2-remi@remlab.net>
In-Reply-To: <1648289.tQCHxfjYn9@basile.remlab.net>
References: <1648289.tQCHxfjYn9@basile.remlab.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] target/arm: actually enable PAuth in user
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

This always enables IA, IB, DA and DB keys in user mode on the maximum
CPU, in a manner that is consistent with the other CPUs. That is to say
redefining the reset value of SCTLR_ELx registers.

Without this patch, the PAC* and AUT* instructions have no effects
(except PACGA of course).

Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e9bc461c36..148c103ca4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -413,8 +413,8 @@ static void aarch64_max_initfn(Object *obj)
                                 (void *)&apdb_bit, &error_fatal);
=20
             /* Enable all PAC keys by default.  */
-            cpu->env.cp15.sctlr_el[1] |=3D SCTLR_EnIA | SCTLR_EnIB;
-            cpu->env.cp15.sctlr_el[1] |=3D SCTLR_EnDA | SCTLR_EnDB;
+            cpu->reset_sctlr |=3D SCTLR_EnIA | SCTLR_EnIB;
+            cpu->reset_sctlr |=3D SCTLR_EnDA | SCTLR_EnDB;
         }
 #endif
=20
--=20
2.20.1
