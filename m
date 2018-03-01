Received: from eggs.gnu.org ([2001:4830:134:3::10]:33085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erX5Q-0000JA-Fr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erX5M-0004nO-En
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  1 Mar 2018 17:53:44 -0500
Message-Id: <1519944838-12430-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCHv1 00/14] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>

[ What is this all about? See this message:
  http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04785.html ]

Merged the separate patchsets I sent in the last couple of weeks into
one set. This will be easier to merge since it will avoid potential
merge conflicts due to adding max_insns to dc->base.

Changes since sending the separate series for sh4/sparc/mips/s390x/openrisc:
- Rebased on top of master (669743979)
- Added R-b's
- sh4: no changes since v3
- mips: no changes (no reviews yet!)
- sparc:
  + Use base.singlestep_enabled and singlestep like in other targets,
    e.g. Alpha.
  + Remove the unnecessary
     (dc.pc - pc_start) < (TARGET_PAGE_SIZE - 32))
    check.
- s390x:
  + Remove dc->pc, use pc_next instead as David suggested.
  + Use dc for DisasContext instead of s.
  + Compute next_page in translate_insn instead of keeping it in dc.
  + Looked into dropping dc->do_debug, but don't see an easy way to do so.
- openrisc:
  + Consistently use DISAS_NORETURN after generating an
    exception; fixed the two call sites that Richard pointed out,
    plus a couple of others that weren't visible in the previous patch.
  + Remove the dc->next_page_start field; instead, set the max_insn
    bound in translate_insn.

You can fetch this series from:
  https://github.com/cota/qemu/tree/trloop-conv-v1

Diffstat below.

Thanks,

		Emilio

 accel/tcg/translator.c      |   21 +-
 include/exec/translator.h   |    8 +-
 target/alpha/translate.c    |    6 +-
 target/arm/translate-a64.c  |    8 +-
 target/arm/translate.c      |    9 +-
 target/hppa/translate.c     |    7 +-
 target/i386/translate.c     |    5 +-
 target/mips/translate.c     |  623 +++++------
 target/openrisc/translate.c |  226 ++--
 target/ppc/translate.c      |    5 +-
 target/s390x/translate.c    | 1527 +++++++++++++--------------
 target/sh4/translate.c      |  171 +--
 target/sparc/translate.c    |  207 ++--
 13 files changed, 1401 insertions(+), 1422 deletions(-)
