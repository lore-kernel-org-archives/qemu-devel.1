Received: from eggs.gnu.org ([2001:4830:134:3::10]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Jb-6q
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007HK-EB
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-00074j-35
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:48 -0500
Received: by mail-wr1-x434.google.com with SMTP id z13-v6so7399511wrs.3
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:11 +0100
Message-Id: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 00/11] decodetree: Add tokens to ease
 checking ISA flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi Richard,

I have been wondering how we can simplify when dealing with multiple ISAs.
I used the MIPS arch because it aims to be simple, but handling the multiple
ISAs/ASEs as once is a mess, with the particular case of the MIPS32R6.

First I wanted to split the translate.c in various ISA/ASE-related files,
but this there are too many inlined func involved, I found it handy to use
the ?cond token, so we can link all translate functions without worrying
about #ifdef'ry.
The translating functions are now smaller/easier to read.

Then I wanted to add stricter ISA check, to not deal with multiple
specifications included more than once, and ease overlapping patterns.

I'm not super happy with this series (in particular the token added
are MIPS oriented, you can not use spaces in the condition), but I'm
interested by what you think :)

Rebasing decodetree specs is painful, so better figure what's the best
now before continuing.

At some point I'd like to get to the one ISA/ASE per file, so we can share
compilation units between targets (via $common-obj) and also be able to
disable completely some ISAs, for whatever reason (downstream/obsolete/...).

Regards,

Phil.

Philippe Mathieu-Daudé (11):
  MAINTAINERS: Add scripts/decodetree.py to the TCG section
  decodetree: Add multiple include guard
  target/mips: Move the !ISA_MIPS32R6 check out of
    decode_opc_special2_legacy
  target/mips: Avoid access to CPUMIPSState from decode* functions
  decodetree: Force Python to print unsigned values
  scripts/decodetree: Allow empty specifications
  scripts/decodetree: Add add_func_check()
  target/mips: Add a decodetree stub
  target/mips: Port SYNCI to decodetree
  scripts/decodetree: Add add_cond_check()
  target/mips: Port MIPS64 DCL[Z/O] to decodetree

 MAINTAINERS                 |  1 +
 scripts/decodetree.py       | 62 ++++++++++++++++++++++++++++++-------
 target/mips/Makefile.objs   |  8 +++++
 target/mips/insns.decode    | 22 +++++++++++++
 target/mips/translate.c     | 20 ++++++------
 target/mips/translate.inc.c | 32 +++++++++++++++++++
 6 files changed, 123 insertions(+), 22 deletions(-)
 create mode 100644 target/mips/insns.decode
 create mode 100644 target/mips/translate.inc.c

-- 
2.17.2
