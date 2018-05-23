Received: from eggs.gnu.org ([2001:4830:134:3::10]:32829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSOb-0002bd-1p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSOW-0007y4-77
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:57:33 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSOW-0007y0-2V
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:57:28 -0400
Received: by mail-qt0-x242.google.com with SMTP id m9-v6so27631015qtb.5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:57:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 23 May 2018 08:57:19 -0300
Message-Id: <20180523115719.26679-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests: Allow GTESTER_OPTIONS variable
 expansion from command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>

The gtester utility offers the "-p=TESTPATH" option to
"only run test cases matching TESTPATH".  We already use
a $GTESTER_OPTIONS variable.
Use make variable expansion to allow qtest path matching
from command line:

  $ time make check-qtest-arm GTESTER_OPTIONS="-p /arm/boot-serial"
    GTESTER check-qtest-arm

  user 0m1.548s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I am more interested in the "-s" option (exclude pattern) but
can't have it working :(

i.e. "run all but qom/hmp":
make check-qtest-arm GTESTER_OPTIONS="-s /arm/qom -s /arm/hmp"

 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2..b0ff3d988c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -870,7 +870,7 @@ tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
 
 SPEED = quick
-GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
+GTESTER_OPTIONS += -k $(if $(V),--verbose,-q)
 GCOV_OPTIONS = -n $(if $(V),-f,)
 
 # gtester tests, possibly with verbose output
-- 
2.17.0
