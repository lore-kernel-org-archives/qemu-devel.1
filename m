Received: from eggs.gnu.org ([2001:4830:134:3::10]:46898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTotF-0003RO-LW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTorh-0002bF-AI
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:08:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTorh-0001g6-2j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:25 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  3 Dec 2018 15:05:30 +0100
Message-Id: <1543845937-300-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 0/7] Assume GCC v4.8 and Clang v3.4 as
 minimum compiler versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

It's unlikely that any of the developers still uses an older version
than GCC 4.8 or Clang 3.4, since all supported distributions have at
least these versions nowadays, so let's add a proper sanity check for
these versions and get rid of code that is only there for older versions.

Note: I did not remove all "#if QEMU_GNUC_PREREQ(4, <8)" checks yet
since some of them still apply to Clang, which reports itself as
GCC 4.2. We should replace those checks with proper checks for the
Clang version instead, in case newer versions of Clang support the
corresponding feature - but that needs some time-consuming research
first which I'll only start if this patch series gets accepted first.

Thomas Huth (7):
  configure: Add a test for the minimum compiler version
  Remove support for compilers that can not do 128-bit arithmetics
  configure: Remove old -fno-gcse workaround for GCC 4.6.x and 4.7.[012]
  Remove QEMU_ARTIFICIAL macro
  tcg/tcg.h: Remove GCC check for tcg_debug_assert() macro
  audio/alsaaudio: Remove compiler check around pragma
  includes: Replace QEMU_GNUC_PREREQ with "__has_builtin ||
    !defined(__clang__)"

 Makefile.target            |   3 -
 audio/alsaaudio.c          |   2 -
 configure                  |  83 +++++++----------------
 include/qemu/compiler.h    |   8 +--
 include/qemu/host-utils.h  |  34 +---------
 include/qemu/int128.h      | 160 ---------------------------------------------
 scripts/checkpatch.pl      |   1 -
 scripts/cocci-macro-file.h |   1 -
 target/ppc/cpu.h           |   2 -
 target/ppc/int_helper.c    | 159 --------------------------------------------
 target/s390x/int_helper.c  |   7 --
 tcg/tcg.h                  |   4 +-
 util/host-utils.c          | 135 --------------------------------------
 13 files changed, 27 insertions(+), 572 deletions(-)

-- 
1.8.3.1
