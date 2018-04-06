Received: from eggs.gnu.org ([2001:4830:134:3::10]:58419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsL-0002GF-7X
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsH-0003Sm-To
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4GsH-0003Rc-Mr
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  5 Apr 2018 22:12:51 -0400
Message-Id: <1522980788-1252-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/17] tcg: tb_lock_removal redux v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

v1: http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06499.html

Changes since v1:

- Add R-b's

- Rebase onto master

- qht_lookup_custom: move @func to be the last argument, which
  simplifies the new qht_lookup function. (I've kept R-b's tags
  here because this is a very simple change.)

- qht_insert: add an **existing argument and keep the bool return value,
  as suggested by Alex.

- Fix indentation of TB_FOR_EACH_TAGGED macro

- Add page_locked assertions, as suggested by Alex.

- Expand comment in tb_link_page and in docs/mttcg about parallel
  code insertion.

- Fix stale comment about tb_lock next to CF_INVALID

- Fix stale comment in cpu_restore_state, as suggested by Alex.

There is only one checkpatch error for the entire series -- it is
a false positive.

You can fetch the tree from:
  https://github.com/cota/qemu/tree/tb-lock-removal-redux-v2

Thanks,

		Emilio
---
 accel/tcg/cpu-exec.c            |   96 ++-
 accel/tcg/cputlb.c              |    8 -
 accel/tcg/translate-all.c       | 1053 ++++++++++++++++++++++----------
 accel/tcg/translate-all.h       |    6 +-
 docs/devel/multi-thread-tcg.txt |   24 +-
 exec.c                          |   25 +-
 include/exec/cpu-common.h       |    2 +-
 include/exec/exec-all.h         |   51 +-
 include/exec/memory-internal.h  |    6 +-
 include/exec/tb-context.h       |    4 -
 include/qemu/qht.h              |   32 +-
 linux-user/main.c               |    3 -
 tcg/tcg.c                       |  205 +++++++
 tcg/tcg.h                       |   13 +-
 tests/qht-bench.c               |   18 +-
 tests/test-qht.c                |   23 +-
 util/qht.c                      |   41 +-
 17 files changed, 1133 insertions(+), 477 deletions(-)
