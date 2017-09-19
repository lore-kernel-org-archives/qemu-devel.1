Received: from eggs.gnu.org ([2001:4830:134:3::10]:53553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJVO-0006kB-IT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJVK-0005GH-OJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:28:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJVK-0005Fk-Ho
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:28:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A151A7C82F
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:28:01 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-61.ams2.redhat.com
	[10.36.117.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13CDA5C541
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:28:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 16:27:57 +0200
Message-Id: <20170919142758.13577-2-pbonzini@redhat.com>
In-Reply-To: <20170919142758.13577-1-pbonzini@redhat.com>
References: <20170919142758.13577-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/51] ptimer-test: do not link to
 libqemustub.a/libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This test provides its own mocks, so do not use the "standard"
stubs in libqemustub.a or the event loop implementation in
libqemuutil.a.

This is required on OS X, which otherwise brings in qemu-timer.o,
async.o and main-loop.o from libqemuutil.a.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    | 2 +-
 tests/ptimer-test-stubs.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59e027f6ea..194315475b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -618,7 +618,7 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o \
 	libqemuutil.a libqemustub.a
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o libqemustub.a
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
 
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index 8a1b0a336c..ca5cc3b13b 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -30,6 +30,10 @@ QEMUTimerListGroup main_loop_tlg;
 
 int64_t ptimer_test_time_ns;
 
+/* Do not artificially limit period - see hw/core/ptimer.c.  */
+int use_icount = 1;
+bool qtest_allowed;
+
 void timer_init_tl(QEMUTimer *ts,
                    QEMUTimerList *timer_list, int scale,
                    QEMUTimerCB *cb, void *opaque)
-- 
2.13.5
