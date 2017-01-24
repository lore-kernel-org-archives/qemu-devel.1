Received: from eggs.gnu.org ([2001:4830:134:3::10]:36842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cVxLS-0001sl-Kz
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cVxLP-000541-FG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:24:54 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1cVxLP-00053f-8p
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:24:51 -0500
Received: by mail-wm0-x241.google.com with SMTP id d140so33298715wmd.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 01:24:49 -0800 (PST)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Tue, 24 Jan 2017 04:24:06 -0500
Message-Id: <1485249848-13854-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH 0/2 v14] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This patch set adds the IO throttling functionality to fsdev/9p devices.
So far cgroups were used for throttling IO opertions on the fsdev/9p devices.
It is difficult to use cgroups for throttling because we have to set up 
cgroups externally before we start the qemu process.
Qemu provides the throttling apis for implementing the throttling. 
Block devices already make use of these APIs for throtting the IO operations.
So, we use the same APIs to enable the throttling functionality for
fsdevices.As of now the feature is enabled only on 9p-local driver.

This feature can be used as shown in the below example:

-fsdev local,id=sdb1,path=PATH_TO_DEVICE,security_model=none,writeout=immediate,
 throttling.bps-read=4194304,throttling.bps-write=4194304  -device
 virtio-9p-pci,fsdev=sdb1,mount_tag=sdb1

The main advantages are:
 
- Easy to use because the throttling options are part of qemu cli options
- Provides a uniform way of using throttling options across block and
    fsdev/9p devices
- No need to setup cgroup to provide throttling functionality for the fsdev
  devices.
- Removes the redundant throttling code that was present in block and fsdev
  files

Missing features:

-QMP support
-Throttling support for other fsdev/9p drivers.

Thanks,
Pradeep

Pradeep Jagadeesh (2):
  fsdev: add IO throttle support to fsdev devices
  throttle: removed duplicate throtlle code from block and fsdev files

 blockdev.c                      |  81 ++-------------------------
 fsdev/Makefile.objs             |   2 +-
 fsdev/file-op-9p.h              |   3 +
 fsdev/qemu-fsdev-opts.c         |   3 +
 fsdev/qemu-fsdev-throttle.c     | 118 ++++++++++++++++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h     |  39 +++++++++++++
 hw/9pfs/9p-local.c              |   8 +++
 hw/9pfs/9p.c                    |   5 ++
 hw/9pfs/cofile.c                |   2 +
 include/qemu/throttle-options.h |  92 +++++++++++++++++++++++++++++++
 10 files changed, 275 insertions(+), 78 deletions(-)
 create mode 100644 fsdev/qemu-fsdev-throttle.c
 create mode 100644 fsdev/qemu-fsdev-throttle.h
 create mode 100644 include/qemu/throttle-options.h

-- 
1.8.3.1
