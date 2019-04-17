Received: from eggs.gnu.org ([209.51.188.92]:51334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGdBT-0007vs-Oq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGdBR-0002fI-V8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:35 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGdBQ-0002cq-3o
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:33 -0400
Received: by mail-pg1-x541.google.com with SMTP id q1so11432420pgv.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 22:32:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Apr 2019 19:32:24 -1000
Message-Id: <20190417053225.27505-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/1] util/path: Do not cache all filenames at
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, evgreen@chromium.org, peter.maydell@linaro.org

This is a third variant attempting to fix the problem of
the -L interp_prefix handling not coping well pointing to
a full chroot.

Previous versions include:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06592.html
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07304.html

Both of the other versions keep an open file descriptor to
the directory that is interp_prefix.  While this seems to be
efficient, they also leak a file descriptor into the guest.
This has follow-on effects on the emulation, causing failures
e.g. within the LTP testsuite.

This version uses only string manipulation and access(2).

A plausible criticism of this is the mutex and the cache.
Are they really needed?  I have no idea.  I can imagine
removing that is actually more efficient, not needing a
lock around a shared data structure.

Comments?


r~


Richard Henderson (1):
  util/path: Do not cache all filenames at startup

 util/path.c | 211 ++++++++++++++--------------------------------------
 1 file changed, 57 insertions(+), 154 deletions(-)

-- 
2.17.1
