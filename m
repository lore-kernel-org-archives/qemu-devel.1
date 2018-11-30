Received: from eggs.gnu.org ([2001:4830:134:3::10]:33617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSpXN-0007Rq-Iz
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSpXK-0001IN-9W
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:37:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37264
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gSpXJ-0001El-Vu
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:37:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAUKZE66139296
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 15:37:16 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p39js6xaa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 15:37:16 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 30 Nov 2018 20:37:15 -0000
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 30 Nov 2018 15:37:09 -0500
In-Reply-To: <cover.1543610035.git.alifm@linux.ibm.com>
References: <cover.1543610035.git.alifm@linux.ibm.com>
Message-Id: <3130ecca88d5f7d97860c05cf1346164938cb15d.1543610035.git.alifm@linux.ibm.com>
Subject: [Qemu-devel] [RFC for 3.1? or 4 v3 1/1] qemu-iotests: Don't run the
 test when user is root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, kwolf@redhat.com, eblake@redhat.com, alifm@linux.ibm.com

Test 232 creates image files with read-only permission and
expects an error message when trying to access the image
files with read-only and auto-read-only turned off.

Don't run as root user, since root can open files with read/write
access for read-only files.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 tests/qemu-iotests/232 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 0708b8b..1d34242 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -92,6 +92,11 @@ echo
 
 chmod a-w $TEST_IMG
 
+if [ -w $TEST_IMG ]
+then
+    _notrun "Cannot run this test as root user"
+fi
+
 run_qemu_info_block -drive driver=file,file="$TEST_IMG",if=none,read-only=on,auto-read-only=off
 run_qemu_info_block -drive driver=file,file="$TEST_IMG",if=none,read-only=on,auto-read-only=on
 run_qemu_info_block -drive driver=file,file="$TEST_IMG",if=none,read-only=on
-- 
2.7.4
