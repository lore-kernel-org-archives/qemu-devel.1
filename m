Received: from eggs.gnu.org ([2001:4830:134:3::10]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eKrJc-0000eK-Im
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eKrJY-00043Z-KP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:49:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1eKrJY-00041q-B4
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:49:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1FF4Qa074095
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 10:15:49 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek9jc81u1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 10:15:49 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 15:15:43 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri,  1 Dec 2017 16:15:37 +0100
Message-Id: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for 2.11 0/1] Fix guest boot with vhost-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>, Felipe Franciosi <felipe@nutanix.com>, qemu-devel@nongnu.org, Eric Farman <farman@linux.vnet.ibm.com>

(Apologies for not noticing this earlier in the development cycle;
I have been on leave and am just getting back.)

A colleague of mine noticed an inability to start a guest with the
2.11 RC's, when a vhost-scsi device is defined in the guest.  The
symptoms on s390 are an exception loop in the guest, which is ugly:

[    1.006087] Kernel stack overflow.
[    1.006145] CPU: 1 PID: 114 Comm: systemd-udevd Not tainted 4.4.0-83-generic #106-Ubuntu
[    1.006237] task: 000000000165d7c0 ti: 0000000001474000 task.ti: 0000000001474000
[    1.006331] Krnl PSW : 0704d00180000000 00000000001f8bd0 (search_module_extables+0x68/0xc0)
[    1.006453]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 EA:3
Krnl GPRS: a42be0ffd90b3c69 0000000000000000 0000000000bd8ce0 0000000000000000
[    1.006627]            00000000001f8bd0 00000000001f0ff8 0000000000000000 0000000000000000
[    1.006693]            0704d00180000000 00000000001f8bd0 00000000000000e0 fffffffffffffff8
[    1.006786]            00000000001f8bd0 00000000007d8b38 00000000014740a8 0000000001474078
[    1.006886] Krnl Code: 00000000001f8bbe: c020004f0091        larl    %r2,bd8ce0
           00000000001f8bc4: ecb1fff800d9       aghik   %r11,%r1,-8
          #00000000001f8bca: ec1200268064       cgrj    %r1,%r2,8,1f8c16
          >00000000001f8bd0: d503d000b000       clc     0(4,%r13),0(%r11)
           00000000001f8bd6: a784fff1           brc     8,1f8bb8
           00000000001f8bda: e330b1740012       lt      %r3,372(%r11)
           00000000001f8be0: a784ffec           brc     8,1f8bb8
           00000000001f8be4: ec331dbc0355       risbg   %r3,%r3,29,188,3
[    1.007385] Call Trace:
[    1.007416] ([<00000000014740c8>] 0x14740c8)
[    1.007477]  [<000000000012205c>] do_no_context+0x34/0xf8
[    1.007528]  [<00000000007c2328>] pgm_check_handler+0x15c/0x1a4
[    1.007590]  [<00000000001f8bd0>] search_module_extables+0x68/0xc0
[    1.007661] ([<0000000001474270>] 0x1474270)
[    1.007725]  [<000000000012205c>] do_no_context+0x34/0xf8
[    1.007789]  [<00000000007c2328>] pgm_check_handler+0x15c/0x1a4
[    1.007865]  [<00000000001f8bd0>] search_module_extables+0x68/0xc0
[    1.007929] ([<0000000001474418>] 0x1474418)
...repeating...

Since this worked perfectly fine with 2.10, I was able to bisect the
problem to commit 5c0919d02066 ("virtio-scsi: Add virtqueue_size parameter
allowing virtqueue size to be set.").  When I attempted to revert this
commit from 2.11-rc3, I get a build error because commit 920036106044
("vhost-user-scsi: add missing virtqueue_size param") makes no sense.

This made the problem rather straightforward, because the change that
was put in for vhost-user-scsi needed to also be added for vhost-scsi.

I haven't looked at the vhost-user-scsi stuff to know how it works and/or
whether we could combine matters into VhostSCSICommon (or whatever).  If
there were more time before 2.11 I would, but thought this would be a
better solution in the short term.

Eric Farman (1):
  vhost-scsi: add missing virtqueue_size parameter

 hw/scsi/vhost-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.13.5
