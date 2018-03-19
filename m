Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ext5F-0000GE-R2
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ext5C-0000vY-5X
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:36:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ext5B-0000v2-RU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:36:06 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 19 Mar 2018 12:35:42 +0100
Message-Id: <20180319113544.704-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/2] target/m68k: add a mechanism to
 automatically free TCGv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

    SRC_EA() and gen_extend() can return either a temporary
    TCGv or a memory allocated one. Mark them when they are
    allocated, and free them automatically at end of the
    instruction translation.

    We want to free locally allocated TCGv to avoid
    overflow in sequence like:

      0xc00ae406:  movel %fp@(-132),%fp@(-268)
      0xc00ae40c:  movel %fp@(-128),%fp@(-264)
      0xc00ae412:  movel %fp@(-20),%fp@(-212)
      0xc00ae418:  movel %fp@(-16),%fp@(-208)
      0xc00ae41e:  movel %fp@(-60),%fp@(-220)
      0xc00ae424:  movel %fp@(-56),%fp@(-216)
      0xc00ae42a:  movel %fp@(-124),%fp@(-252)
      0xc00ae430:  movel %fp@(-120),%fp@(-248)
      0xc00ae436:  movel %fp@(-12),%fp@(-260)
      0xc00ae43c:  movel %fp@(-8),%fp@(-256)
      0xc00ae442:  movel %fp@(-52),%fp@(-276)
      0xc00ae448:  movel %fp@(-48),%fp@(-272)
      ...

    That can fill a lot of TCGv entries in a sequence,
    especially since 15fa08f845 ("tcg: Dynamically allocate TCGOps")
    we have no limit to fill the TCGOps cache and we can fill
    the entire TCG variables array and overflow it.

v2: split patch in two (separate the patch to add
    parameter to gen_exten())
    mark to release missed gen_load() in gen_lea_indexed()

Laurent Vivier (2):
  target/m68k: add DisasContext parameter to gen_extend()
  target/m68k: add a mechanism to automatically free TCGv

 target/m68k/translate.c | 102 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 36 deletions(-)

-- 
2.14.3
