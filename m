Received: from eggs.gnu.org ([2001:4830:134:3::10]:55324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUSm8-0007Fx-5I
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUSm4-00013Y-8a
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:43:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42098
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUSm4-00011u-2y
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:43:16 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB58cUNE196584
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 03:43:15 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p69uxmhqs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 03:43:15 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Dec 2018 08:43:13 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  5 Dec 2018 09:43:08 +0100
MIME-Version: 1.0
Message-Id: <20181205084308.201356-1-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] iotests: make 235 work on s390 (and others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

"-machine pc" will not work all architectures. Lets fall back to the
default machine by not specifying it.

In addition we also need to specify -no-shutdown on s390 as qemu will
exit otherwise.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tests/qemu-iotests/235 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index da044ed34e..d6edd97ab4 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,9 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
                 str(size))
 
 vm = QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'pc,accel=kvm')
+vm.add_args('-machine', 'accel=kvm')
+if iotests.qemu_default_machine == 's390-ccw-virtio':
+        vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=src,file=' + disk)
 vm.launch()
 
-- 
2.19.1
