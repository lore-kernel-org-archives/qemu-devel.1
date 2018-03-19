Received: from eggs.gnu.org ([2001:4830:134:3::10]:60383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1exrCO-000234-VJ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1exrCM-0001aa-AV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:35:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1exrCM-0001ZI-4k
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:35:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2J9R3F0116726
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 05:35:19 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gt91gur3p-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 05:35:19 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 19 Mar 2018 09:35:17 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon, 19 Mar 2018 10:35:09 +0100
In-Reply-To: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
References: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20180319093509.50881-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_shutdown()".
It's because of the newly introduced function vm_shutdown calls bdrv_drain_all,
which is called later by bdrv_close_all. bdrv_drain_all resumes the jobs
that doubles the speed and offset is doubled.
Some jobs' status are changed as well.

Thus, let's not call bdrv_drain_all in vm_shutdown.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
---
 cpus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 2e6701795b..ae2962508c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1006,8 +1006,9 @@ static int do_vm_stop(RunState state, bool send_stop)
             qapi_event_send_stop(&error_abort);
         }
     }
-
-    bdrv_drain_all();
+    if (send_stop) {
+        bdrv_drain_all();
+    }
     replay_disable_events();
     ret = bdrv_flush_all();
 
-- 
2.13.5
