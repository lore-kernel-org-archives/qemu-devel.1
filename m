Received: from eggs.gnu.org ([2001:4830:134:3::10]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1T8-0007iD-GG
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1T7-0006up-Le
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:56 +0200
Message-Id: <20170622124204.19407-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 23/31] ppc: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 target/ppc/mem_helper.c | 2 +-
 target/ppc/translate.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index e6383c6bfa..a34e604db3 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -111,7 +111,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr,=
 uint32_t reg,
                  uint32_t ra, uint32_t rb)
 {
     if (likely(xer_bc !=3D 0)) {
-        int num_used_regs =3D (xer_bc + 3) / 4;
+        int num_used_regs =3D DIV_ROUND_UP(xer_bc, 4);
         if (unlikely((ra !=3D 0 && lsw_reg_in_range(reg, num_used_regs, =
ra)) ||
                      lsw_reg_in_range(reg, num_used_regs, rb))) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d927..76f9ccde25 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2882,7 +2882,7 @@ static void gen_lswi(DisasContext *ctx)
     }
     if (nb =3D=3D 0)
         nb =3D 32;
-    nr =3D (nb + 3) / 4;
+    nr =3D DIV_ROUND_UP(nb, 4);
     if (unlikely(lsw_reg_in_range(start, nr, ra))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
         return;
--=20
2.13.1.395.gf7b71de06
