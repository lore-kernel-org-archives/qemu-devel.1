Received: from eggs.gnu.org ([2001:4830:134:3::10]:59562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDYbN-0001Og-Rj
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDYbM-0005s9-SI
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:58:05 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue,  1 May 2018 18:57:48 +0200
Message-Id: <20180501165750.19242-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-img: Special post-backing convert
 handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is the issue:

$ qemu-img create -f qcow2 base.qcow2 512M
Formatting 'base.qcow2', fmt=qcow2 size=536870912 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-img create -f qcow2 -b base.qcow2 source.qcow2 1G
Formatting 'source.qcow2', fmt=qcow2 size=1073741824 backing_file=base.qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-img convert -O qcow2 -B base.qcow2 -o compat=0.10 \
    source.qcow2 target.qcow2
$ qemu-img info target.qcow2
image: target.qcow2
file format: qcow2
virtual size: 1.0G (1073741824 bytes)
disk size: 512M    <-------------------- this here
cluster_size: 65536
backing file: base.qcow2
Format specific information:
    compat: 0.10
    refcount bits: 16
$ qemu-img map target.qcow2
Offset          Length          Mapped to       File
0x20000000      0x20000000      0x50000         target.qcow2

So qemu-img convert sees that source.qcow2 contains only zeroes past the
end of base.qcow2 -- but that is not the backing file, so it will
explicitly write zeroes to target.qcow2.  But that file is compat=0.10,
so it does not support efficient zero writes and will actually fill that
area with real zeroes.  Hence the mapping, hence the disk size.

However, we don't need to write zeroes to an image when it is
initialized to zeroes -- which the current qemu-img code says doesn't
happen for target images with backing files.  But it does happen when
the target backing file is shorter than the target image, then the area
past the end of the backing file may indeed read as zeroes and we don't
need to write anything there.

So the first patch in this series makes qemu-img convert detect that
case and handle zeroes past the end of the backing file as "fall back to
the backing file" (because that means zeroes, at least if unallocated
areas read as zeroes (which I presume they have to for formats
supporting backing files, but better be safe than sorry)), and the
second adds an iotest.


Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1527898


Max Reitz (2):
  qemu-img: Special post-backing convert handling
  iotests: Test post-backing convert target behavior

 qemu-img.c                 | 26 +++++++++++++++++++++++++-
 tests/qemu-iotests/122     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 18 ++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

-- 
2.14.3
