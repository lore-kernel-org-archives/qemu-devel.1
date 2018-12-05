Received: from eggs.gnu.org ([2001:4830:134:3::10]:35778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pburton@wavecomp.com>) id 1gUfOp-0000Mc-1G
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pburton@wavecomp.com>) id 1gUfOl-0002ia-57
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:12:07 -0500
Received: from mail-eopbgr820115.outbound.protection.outlook.com
	([40.107.82.115]:36150
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pburton@wavecomp.com>)
	id 1gUfOi-0002Ux-BU
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:12:01 -0500
From: Paul Burton <paul.burton@mips.com>
Date: Wed, 5 Dec 2018 22:11:43 +0000
Message-ID: <20181205221126.16220-1-paul.burton@mips.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] atomic.h: Set ATOMIC_REG_SIZE=8 for MIPS n32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Paul Burton <pburton@wavecomp.com>

ATOMIC_REG_SIZE is currently defined as the default sizeof(void *) for
all MIPS host builds, including those using the n32 ABI. n32 is the
MIPS64 ILP32 ABI and as such tcg/mips/tcg-target.h defines
TCG_TARGET_REG_BITS as 64 for n32 builds. If we attempt to build QEMU
for an n32 host with support for a 64b target architecture then
TCG_OVERSIZED_GUEST is 0 and accel/tcg/cputlb.c attempts to use atomic_*
functions. This fails because ATOMIC_REG_SIZE is 4, causing the calls to
QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE) in the various
atomic_* functions to generate errors.

Fix this by defining ATOMIC_REG_SIZE as 8 for all MIPS64 builds, which
will cover both n32 (ILP32) & n64 (LP64) ABIs in much the same was as we
already do for x86_64/x32.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---
 include/qemu/atomic.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f6993a8fb1..a6ac188188 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -99,9 +99,10 @@
  * those few cases by hand.
  *
  * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
- * Sparc we always force the use of sparcv9 in configure.
+ * Sparc we always force the use of sparcv9 in configure. MIPS n32 (ILP32)=
 &
+ * n64 (LP64) ABIs are both detected using __mips64.
  */
-#if defined(__x86_64__) || defined(__sparc__)
+#if defined(__x86_64__) || defined(__sparc__) || defined(__mips64)
 # define ATOMIC_REG_SIZE  8
 #else
 # define ATOMIC_REG_SIZE  sizeof(void *)
--=20
2.19.1
