Received: from eggs.gnu.org ([2001:4830:134:3::10]:53486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxU-0002Zk-A3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-000140-7i
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxR-00011r-3O
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:42 -0400
Message-Id: <1504729728-23279-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

Related threads:
  [PATCH 00/13] instrument: Add basic event instrumentation
  Date: Mon, 24 Jul 2017 20:02:24 +0300
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
and
  [PATCH v4 00/20] instrument: Add basic event instrumentation
  Date:	Wed, 6 Sep 2017 20:22:41 +0300
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html

This set does something similar to the instrumentation patches by Lluis,
but with a different implementation (and for now less events).

My focus has been on working on the skeleton of a (pseudo) stable API,
as Stefan requested. Of course more events would have to be added, but
before spending more time on this I'd like to get some feedback on the
core of the design. Patch 2 has all the details.

Note: yes, patch 1 is not used in the series, but this is an RFC. It's there
because it will be needed to get the tb->plugin_mask when deciding whether
to generate a mem_cb helper when generating loads/stores from TCG.

This set applies on top of:
  https://github.com/cota/qemu/tree/tcg-generic-15%2Bmulti-tcg-v4-parallel

The tree can be fetched from:
  https://github.com/cota/qemu/tree/plugins

Thanks,

		Emilio
---
 Makefile                  |   7 +-
 Makefile.objs             |   1 +
 accel/tcg/cpu-exec.c      |   6 +-
 accel/tcg/translate-all.c |   9 +-
 configure                 |  52 ++++
 include/exec/exec-all.h   |   2 +
 include/exec/tb-hash-xx.h |  26 +-
 include/exec/tb-hash.h    |   6 +-
 include/exec/tb-lookup.h  |   1 +
 include/qemu/plugin-api.h | 105 +++++++
 include/qemu/plugin.h     |  74 +++++
 include/qom/cpu.h         |   4 +
 linux-user/main.c         |  18 ++
 plugin.c                  | 519 ++++++++++++++++++++++++++++++++
 qemu-options.hx           |  17 ++
 qemu-plugins.symbols      |   6 +
 qom/cpu.c                 |   3 +
 tcg/tcg-op.c              |  10 +-
 tcg/tcg.h                 |   2 +-
 tests/qht-bench.c         |   2 +-
 vl.c                      |  10 +
 21 files changed, 857 insertions(+), 23 deletions(-)
