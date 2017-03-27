Received: from eggs.gnu.org ([2001:4830:134:3::10]:57368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csX8M-0001PK-CP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csX8L-0003jA-IP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1csX8L-0003YE-Bd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 17:04:28 +0100
Message-Id: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] tcg/sparc: zero extend ld/st
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
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

These patches fix problems with the SPARC TCG backend code
which calls the load and store helpers. Where the argument
being passed to the helper is narrower than the size of the
native register, the SPARC calling convention requires that
we extend it to the register size, but we weren't doing that.
This meant we passed the host code registers which might have
garbage in the high parts, and if the host code was built
with optimization this resulted in wrong behaviour.

I still see problems trying to run the bits of 'make check'
that run guest code, but at least with these patches we can
run the i386 bios code enough to try to do PXE boot and not
find a server.


Peter Maydell (2):
  tcg/sparc: Zero extend data argument to store helpers
  tcg/sparc: Zero extend address argument to ld/st helpers

 tcg/sparc/tcg-target.inc.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.7.4
