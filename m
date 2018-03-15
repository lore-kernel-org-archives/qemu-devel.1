Received: from eggs.gnu.org ([2001:4830:134:3::10]:54471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQH-0000Tg-Uj
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQD-0005rO-UP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:21 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewYQD-0005qa-Ga
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:17 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 15 Mar 2018 20:19:55 +0100
Message-Id: <20180315191958.28937-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 0/3] target/m68k: fix TCGv array overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Since commit 15fa08f845 ("tcg: Dynamically allocate TCGOps")
we have no limit to fill the TCGOps cache and we can fill
the entire TCG variables array and overflow it.

It seems to happen only with m68k, because m68k translator
doesn't free some TCGv at end of instruction translation
because the variable can be either temporary one or an
allocated one,

I try to fix this by introducing a new TCG function
to try to free a TCGv if it is a temporary one and
do nothing otherwise (patches 1 and 2)

The last patch is here to avoid the error and
stop the translation before the buffer overflows
(but I guess we should not need this with correctly
written translation functions...)

Laurent Vivier (3):
  tcg: introduce tcg_temp_try_free()
  target/m68k: use tcg_temp_try_free()
  m68k: Test if we overflow the temp variable array

 target/m68k/translate.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++-
 tcg/tcg-op.h            |  2 ++
 tcg/tcg.c               | 28 +++++++++++++++------
 tcg/tcg.h               |  9 +++++++
 4 files changed, 98 insertions(+), 8 deletions(-)

-- 
2.14.3
