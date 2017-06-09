Received: from eggs.gnu.org ([2001:4830:134:3::10]:49150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCaq-0004Zl-0T
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCam-0001O3-TH
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:36:20 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJCam-0001Nv-Nr
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:36:16 -0400
Received: by mail-qt0-x241.google.com with SMTP id w1so12989106qtg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 22:36:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  8 Jun 2017 22:36:01 -0700
Message-Id: <20170609053611.26032-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 0/7] tcg: allocate TB structs preceding
 translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

This is a follow-up to Emilio's patch set.

My primary changes to Emilio's patches are to the first patch, in
merging the existing implementations from tcg/ppc/tcg-target.inc.c
into util/cacheinfo.c.

Then I've a few follow-up patches to take advantage of the new TB
placement for arm platforms.  I've had a look at the asm output for
ppc64 and s390x, and don't see anything obvious that can be improved.

Changes since v4:
  * The first patch reorganized a bit for aarch64 and ppc64.
    Re-tested on win32, for which there was a Werror.
    Incorporated feedback from Emilio re MacOS.
  * Fixed the short description for the tcg/arm patches.


r~


Emilio G. Cota (2):
  util: add cacheinfo
  tcg: allocate TB structs before the corresponding translated code

Richard Henderson (5):
  tcg/aarch64: Use ADR in tcg_out_movi
  tcg/arm: Use indirect branch for goto_tb
  tcg/arm: Remove limit on code buffer size
  tcg/arm: Try pc-relative addresses for movi
  tcg/arm: Use ldr (literal) for goto_tb

 include/exec/exec-all.h      |   5 +-
 include/exec/tb-context.h    |   3 +-
 include/qemu/osdep.h         |   3 +
 tcg/aarch64/tcg-target.inc.c |   7 +-
 tcg/arm/tcg-target.inc.c     |  82 +++++++++++--------
 tcg/ppc/tcg-target.inc.c     |  71 +----------------
 tcg/tcg.c                    |  20 +++++
 tcg/tcg.h                    |   2 +-
 translate-all.c              |  41 ++++++----
 util/Makefile.objs           |   1 +
 util/cacheinfo.c             | 185 +++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 293 insertions(+), 127 deletions(-)
 create mode 100644 util/cacheinfo.c

-- 
2.9.4
