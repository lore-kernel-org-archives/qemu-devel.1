Received: from eggs.gnu.org ([2001:4830:134:3::10]:35689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crP8D-0003o6-41
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crP88-0003t8-1k
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:19:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1crP87-0003su-OJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:19:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2ODJZuu116193
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 09:19:45 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29cxewrdhp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 09:19:41 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Mar 2017 13:19:35 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Mar 2017 14:19:30 +0100
Message-Id: <1490361570-288658-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] boot-serial-test: use -no-shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>

a qemu with an empty s390 guest will exit very quickly. This races
against the testsuite reading from the console pipe leading to
intermittent test suite failures. Using -no-shutdown will keep
the guest running.

Fixes: 864111f422ba (vl: exit qemu on guest panic if -no-shutdown is not set)
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tests/boot-serial-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 57edf6a..11f48b0 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -79,8 +79,8 @@ static void test_machine(const void *data)
     g_assert(fd != -1);
 
     args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
-                           " -serial chardev:serial0 %s", test->machine,
-                           tmpname, test->extra);
+                           " -no-shutdown -serial chardev:serial0 %s",
+                           test->machine, tmpname, test->extra);
 
     qtest_start(args);
     unlink(tmpname);
-- 
2.7.4
