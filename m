Received: from eggs.gnu.org ([2001:4830:134:3::10]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fitWH-0007ME-81
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 23:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fitWG-0003IR-Cw
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 23:34:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 27 Jul 2018 11:33:59 +0800
Message-Id: <20180727033402.13513-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC for-3.0-rc3 0/3] qemu-img: Disable copy
 offloading by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Kevin pointed out that both glibc and kernel provides a slow fallback of
copy_file_range which hurts thin provisioning. This is particularly true for
thin LVs, because host_device driver cannot get allocation info from the
volume, and copy_file_range is called on every sectors, making the dst fully
allocated.

NFS mount points also doesn't support SEEK_DATA well, so the allocation
information is unknown to QEMU.

That leaves only iscsi:// which seems to do what we want so far, but it is a
smaller use case.

Add an option to qemu-img convert, "-C", to enable (attempting) copy offloading
explicitly. And mark it incompatible with "-S" and "-c".

Fam Zheng (3):
  Revert "qemu-img: Document copy offloading implications with -S and
    -c"
  qemu-img: Add -C option for convert with copy offloading
  iotests: Add test for 'qemu-img convert -C' compatibility

 qemu-img-cmds.hx           |  2 +-
 qemu-img.c                 | 21 +++++++++++++++++----
 qemu-img.texi              | 14 +++++++++-----
 tests/qemu-iotests/082     |  8 ++++++++
 tests/qemu-iotests/082.out | 11 +++++++++++
 5 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.17.1
