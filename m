Received: from eggs.gnu.org ([2001:4830:134:3::10]:45814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChB-0005ba-9w
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUCh6-0000IK-8Q
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUCh6-0000Hr-2x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  4 Dec 2018 16:32:50 +0100
Message-Id: <1543937577-28256-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 v2 0/7] Assume GCC v4.8 and Clang v3.4
 as minimum compiler
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

v2:
 - Don't remove CONFIG_INT128 sections, they are still required for
   32-bit hosts
 - Check for Apple's Xcode version of Clang

Thomas Huth (7):
  configure: Add a test for the minimum compiler version
  configure: Remove obsolete check for Clang < 3.2
  configure: Remove old -fno-gcse workaround for GCC 4.6.x and 4.7.[012]
  tcg/tcg.h: Remove GCC check for tcg_debug_assert() macro
  audio/alsaaudio: Remove compiler check around pragma
  includes: Replace QEMU_GNUC_PREREQ with "__has_builtin ||
    !defined(__clang__)"
  Remove QEMU_ARTIFICIAL macro

 Makefile.target            |  3 ---
 audio/alsaaudio.c          |  2 --
 configure                  | 57 ++++++++++++++++++++--------------------------
 include/qemu/compiler.h    |  8 +------
 include/qemu/host-utils.h  |  4 ++--
 scripts/checkpatch.pl      |  1 -
 scripts/cocci-macro-file.h |  1 -
 tcg/tcg.h                  |  4 +---
 8 files changed, 29 insertions(+), 51 deletions(-)

-- 
1.8.3.1
