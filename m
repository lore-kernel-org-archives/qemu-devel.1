Received: from eggs.gnu.org ([2001:4830:134:3::10]:50347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctXh6-0000XJ-BW
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctXh5-00069l-Dc
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:52:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ctXh5-00062x-87
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:52:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 11:52:29 +0100
Message-Id: <1490871151-29029-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.9 0/2] tcg/sparc: zero extend ld/st
 helper args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

These patches fix problems with the SPARC TCG backend code
which calls the load and store helpers. Where the argument
being passed to the helper is narrower than the size of the
native register, the SPARC calling convention requires that
we extend it to the register size, but we weren't doing that.
This meant we passed the host code registers which might have
garbage in the high parts, and if the host code was built
with optimization this resulted in wrong behaviour.

Changes v1->v2:
 * fix argument order to emit_extend() in 32-bit host case
 * switch on (op & MO_SIZE) rather than just op

thanks
-- PMM

Peter Maydell (2):
  tcg/sparc: Zero extend data argument to store helpers
  tcg/sparc: Zero extend address argument to ld/st helpers

 tcg/sparc/tcg-target.inc.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

-- 
2.7.4
