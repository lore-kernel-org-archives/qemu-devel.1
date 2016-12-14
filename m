Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHEyZ-0002jb-Qm
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHEyW-0002Q5-Mt
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:12:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHEyW-0002Pp-CW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:12:24 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEJAuwF001092
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 14:12:23 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b90amqkj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 14:12:22 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:12:20 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 20:12:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
Subject: [Qemu-devel] commit virtio: recalculate vq->inuse after migration
 might cause last_avail_idx vs. used_idx failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

We have a migration problem, which is in my opinion caused by a
deficiency in how vq->inuse is calculated after the migration (commit
bccdef6b  "virtio: recalculate vq->inuse after migration" to
blame).


We got a bugreport with this log for a live migration target. 

2016-12-13T18:59:03.647309Z qemu-system-s390x: VQ 1 size 0x100 < last_avail_idx 0x2f76 - used_idx 0x762f
2016-12-13T18:59:03.647385Z qemu-system-s390x: error while loading state for instance 0x0 of device '/fe.0.0001/virtio-net'
2016-12-13T18:59:03.647540Z qemu-system-s390x: load of migration failed: Operation not permitted
2016-12-13 18:59:03.796+0000: shutting down, reason=failed

They use QEMU version 2.7 but looking at the current git master
I think this did not get fixed in the meanwhile.

So here goes the argument. The recalculation is done like this:

+            vdev->vq[i].inuse = vdev->vq[i].last_avail_idx -
+                                vdev->vq[i].used_idx;

This does not seem correct when last_avail_idx has already
wrapped around but used_idx not yet. We see from the log that
last_avail_idx  (0x2f76) less that used_idx (0x762f) thus
inuse (of type int) ends up being negative.

+            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {

Because vdev->vq[i].vring.num is unsigned int ala usual arithmetic
conversions ("Otherwise, if the operand that has unsigned integer type
has rank greater or equal to the rank of the type of the other operand,
then the operand with signed integer type is converted to the type of
the operand with unsigned integer type." C99) inuse gets converted to
unsigned int.

Thus the check fails and produces the log cited above.

+                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
+                             "used_idx 0x%x",
+                             i, vdev->vq[i].vring.num,
+                             vdev->vq[i].last_avail_idx,
+                             vdev->vq[i].used_idx);
+                return -1;
+            }

Do we want to try to fix this for 2.8? I already have a small patch prepared.

Regards,
Halil
