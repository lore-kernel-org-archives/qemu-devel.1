Received: from eggs.gnu.org ([208.118.235.92]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0w-0005Sd-PY
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0v-0003oD-3a
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:58 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60596 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz0u-0003mV-Q1
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:01 +0100
Message-Id: <1546268200-26966-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/44] atomics: Set ATOMIC_REG_SIZE=8 for
 MIPS n32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Paul Burton <pburton@wavecomp.com>

ATOMIC_REG_SIZE is currently defined as the default sizeof(void *) for
all MIPS host builds, including those using the n32 ABI. n32 is the
MIPS64 ILP32 ABI and as such tcg/mips/tcg-target.h defines
TCG_TARGET_REG_BITS as 64 for n32 builds. If we attempt to build QEMU
for an n32 host with support for a 64b target architecture then
TCG_OVERSIZED_GUEST is 0 and accel/tcg/cputlb.c attempts to use
atomic_* functions. This fails because ATOMIC_REG_SIZE is 4, causing
the calls to QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE) in the
various atomic_* functions to generate errors.

Fix this by defining ATOMIC_REG_SIZE as 8 for all MIPS64 builds, which
will cover both n32 (ILP32) & n64 (LP64) ABIs in much the same was as
we already do for x86_64/x32.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Paul Burton <pburton@wavecomp.com>
---
 include/qemu/atomic.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f6993a8..a6ac188 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -99,9 +99,10 @@
  * those few cases by hand.
  *
  * Note that x32 is fully detected with __x86_64__ + _ILP32, and that fo=
r
- * Sparc we always force the use of sparcv9 in configure.
+ * Sparc we always force the use of sparcv9 in configure. MIPS n32 (ILP3=
2) &
+ * n64 (LP64) ABIs are both detected using __mips64.
  */
-#if defined(__x86_64__) || defined(__sparc__)
+#if defined(__x86_64__) || defined(__sparc__) || defined(__mips64)
 # define ATOMIC_REG_SIZE  8
 #else
 # define ATOMIC_REG_SIZE  sizeof(void *)
--=20
2.7.4
