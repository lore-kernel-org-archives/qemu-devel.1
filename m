Received: from eggs.gnu.org ([2001:4830:134:3::10]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJlvf-000425-QC
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJlva-0006gF-6y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:56:56 -0500
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Date: Mon,  5 Nov 2018 20:56:40 +0000
Message-Id: <20181105205641.17862-1-v.mayatskih@gmail.com>
Subject: [Qemu-devel] [PATCH 0/1 V2] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org, Vitaly Mayatskikh <v.mayatskih@gmail.com>

V2 changes:
- checkpatch style fixes
- correct size detection of disk image placed on a file system

This driver moves virtio-blk host-side processing to kernel (via new
vhost_blk kernel driver). It accelerates virtual disk performance
close to the bare metal levels, especially for parellel loads.

For example, fio numjobs=16 gets 101k randread IOPS using virtio-blk
and 1202k IOPS using vhost-blk, close to 1480k of raw disk performance.

See the IOPS numbers below.

The kernel part if you want to try:
- vhost_blk: https://lkml.org/lkml/2018/11/2/648
- vhost num-queues scalability fix: https://lkml.org/lkml/2018/11/2/550

# fio num-jobs
# A: bare metal over block
# B: bare metal over file
# C: virtio-blk over block
# D: virtio-blk over file
# E: vhost-blk over block
# F: vhost-blk over file
#
#  A     B     C    D    E     F

1  171k  151k  148k 151k 187k  175k
2  328k  302k  249k 241k 334k  296k
3  479k  437k  179k 174k 464k  404k
4  622k  568k  143k 183k 580k  492k
5  755k  697k  136k 128k 693k  579k
6  887k  808k  131k 120k 782k  640k
7  1004k 926k  126k 131k 863k  693k
8  1099k 1015k 117k 115k 931k  712k
9  1194k 1119k 115k 111k 991k  711k
10 1278k 1207k 109k 114k 1046k 695k
11 1345k 1280k 110k 108k 1091k 663k
12 1411k 1356k 104k 106k 1142k 629k
13 1466k 1423k 106k 106k 1170k 607k
14 1517k 1486k 103k 106k 1179k 589k
15 1552k 1543k 102k 102k 1191k 571k
16 1480k 1506k 101k 102k 1202k 566k

Vitaly Mayatskikh (1):
  Add vhost-pci-blk driver

 configure                     |  10 +
 default-configs/virtio.mak    |   1 +
 hw/block/Makefile.objs        |   1 +
 hw/block/vhost-blk.c          | 429 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c        |  60 +++++
 hw/virtio/virtio-pci.h        |  19 ++
 include/hw/virtio/vhost-blk.h |  43 ++++
 7 files changed, 563 insertions(+)
 create mode 100644 hw/block/vhost-blk.c
 create mode 100644 include/hw/virtio/vhost-blk.h

-- 
2.17.1
