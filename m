Received: from eggs.gnu.org ([2001:4830:134:3::10]:43171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1ehcdZ-0004Xo-3B
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1ehcdX-0005Pt-WD
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:48:21 -0500
Date: Fri, 2 Feb 2018 11:02:25 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Message-ID: <671eaa99f4e0bf3a58f76f9151f7cfa24662227f.1517565566.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180124101358.GA5028@bogon.m.sigxcpu.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] linux-user: Fix register used for 6th and
 7th syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This unbreaks the testcase from

    http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

Thanks to Laurent Vivier for spotting the 7th one.

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
Suggested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3 collects *-by: replies. Anything else I can do to get this applied?

 linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/host=
/aarch64/safe-syscall.inc.S
index 58a2329b37..bc1f5a9792 100644
--- a/linux-user/host/aarch64/safe-syscall.inc.S
+++ b/linux-user/host/aarch64/safe-syscall.inc.S
@@ -36,7 +36,7 @@ safe_syscall_base:
 	 *               and return the result in x0
 	 * and the syscall instruction needs
 	 *               x8 =3D=3D syscall number
-	 *               x0 ... x7 =3D=3D syscall arguments
+	 *               x0 ... x6 =3D=3D syscall arguments
 	 *               and returns the result in x0
 	 * Shuffle everything around appropriately.
 	 */
@@ -47,8 +47,8 @@ safe_syscall_base:
 	mov	x2, x4
 	mov	x3, x5
 	mov	x4, x6
-	mov	x6, x7
-	ldr	x7, [sp]
+	mov	x5, x7
+	ldr	x6, [sp]
=20
 	/* This next sequence of code works in conjunction with the
 	 * rewind_if_safe_syscall_function(). If a signal is taken
--=20
2.15.1
