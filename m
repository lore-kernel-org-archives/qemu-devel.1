Received: from eggs.gnu.org ([2001:4830:134:3::10]:56964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gTyh6-0002jr-Mn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 19:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gTyh3-0005q8-Gh
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 19:36:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42544
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gTyh3-0005pE-9a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 19:36:05 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB40YWl9022120
	for <qemu-devel@nongnu.org>; Mon, 3 Dec 2018 19:36:04 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5dcubk4h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 19:36:04 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 4 Dec 2018 00:36:03 -0000
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon,  3 Dec 2018 19:35:57 -0500
In-Reply-To: <cover.1543883650.git.alifm@linux.ibm.com>
References: <cover.1543883650.git.alifm@linux.ibm.com>
Message-Id: <390c0b08c7beb83da3a8ef5b880db223a096d525.1543883650.git.alifm@linux.ibm.com>
Subject: [Qemu-devel] [PATCH for 3.1? or 4 v4 1/1] qemu-iotests: Don't run
 the test when user is root
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
