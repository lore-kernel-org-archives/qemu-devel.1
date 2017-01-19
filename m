Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUJgP-0004WV-DZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUJgL-000830-Hw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:51:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34303
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cUJgL-00082j-CQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:51:41 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0JKhlqw055864
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 15:51:39 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283255xfb6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 15:51:39 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Thu, 19 Jan 2017 20:51:38 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Thu, 19 Jan 2017 21:51:31 +0100
Message-Id: <20170119205134.50112-1-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Farman <farman@linux.vnet.ibm.com>

In the Linux kernel, I see two (three) places where the BLKSECTGET ioctl is
handled:

(1) block/(compat_)ioctl.c -- (compat_)blkdev_ioctl
(2) drivers/scsi/sg.c -- sg_ioctl

The former has been around forever[1], and returns a short value measured in
sectors.  A sector is generally assumed to be 512 bytes.

The latter has been around for slightly less than forever[2], and returns an
int that measures the value in bytes.  A change to return the block count
was brought up a few years ago[3] and nacked.

As a convenient example, if I use the blockdev tool to drive the ioctl to a
SCSI disk and its scsi-generic equivalent, I get different results:

  # lsscsi -g
  [0:0:8:1077166114]disk    IBM      2107900          .217  /dev/sda /dev/sg0
  # blockdev --getmaxsect /dev/sda
  2560
  # blockdev --getmaxsect /dev/sg0
  20

Now, the value for /dev/sda looks "correct" to me.

  # cd /sys/devices/css0/0.0.0125/0.0.1f69/host0/rport-0\:0-8/
  # cd target0\:0\:8/0\:0\:8\:1077166114/
  # cat block/sda/queue/max_sectors_kb
  1280
  # cat block/sda/queue/hw_sector_size
  512

And the math checks out:

  max_sectors_kb * 1024 / hw_sector_size == getmaxsect
  -OR-
  1280 * 1024 / 512 = 2560

For /dev/sg0, it appears the answer is coming from the sg_ioctl result
which is already multiplied by the block size, and then looking at only the
upper half (short) of the returned big-endian fullword:

  (1280 * 1024 / 512) * 512 = 1310720 = x00140000 => x0014 = 20

The reason for all this?  Well, QEMU recently added a BLKSECTGET ioctl
call[4] which we see during guest boot.  This code presumes the value is in
blocks/sectors, and converts it to bytes[5].  Not that this matters, because
the short/int discrepancy gives us "zero" on s390x.

Also, that code doesn't execute for scsi-generic devices, so the conversion
to bytes is correct, but I'd like to extend this code to interrogate
scsi-generic devices as well.  This is important because libvirt converts
a specified virtio-scsi device to its /dev/sgX address for the QEMU
commandline.

So, do I have to code around the different field sizes (int vs short) as
well as scaling (bytes vs blocks)?  Obviously doable, but looking at the
resulting commits, I find myself feeling a little ill.

Changes:
 v1->v2:
  - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]

[1] The initial kernel git commit
[2] kernel commit 44ec95425c1d9dce6e4638c29e4362cfb44814e7
[3] https://lkml.org/lkml/2012/6/27/78
[4] qemu commit 6f6071745bd0366221f5a0160ed7d18d0e38b9f7
[5] qemu commit 5def6b80e1eca696c1fc6099e7f4d36729686402 

Eric Farman (3):
  hw/scsi: Fix debug message of cdb structure in scsi-generic
  block: Fix target variable of BLKSECTGET ioctl
  block: get max_transfer limit for char (scsi-generic) devices

 block/file-posix.c     | 17 +++++++++++------
 hw/scsi/scsi-generic.c |  5 +++--
 include/block/block.h  |  1 +
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.8.4
