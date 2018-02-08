Received: from eggs.gnu.org ([2001:4830:134:3::10]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTz-0002S7-78
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTw-0006sT-6j
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:39 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:43310 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1ejqTv-0006r4-WC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:36 -0500
From: <antonios.motakis@huawei.com>
Date: Thu, 8 Feb 2018 19:00:15 +0100
Message-ID: <20180208180019.13683-1-antonios.motakis@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] QID path collision fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, groug@kaod.org
Cc: veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com, Antonios Motakis <antonios.motakis@huawei.com>

From: Antonios Motakis <antonios.motakis@huawei.com>

This is an implementation that ensures that a unique 64bit QID path
is generated per file.

Since if a file is unique on the host is determined by both inode
and device id, which are 64 and 32 bits respectively, the proper
long term fix will be an extension in the 9p protocol allowing for
a bigger QID path field. The fix presented here is a 'fallback'
solution, within the current limitations of 9p.

The first patch is a preparatory change.

The main feature of the second patch is that now stat_to_qid can
fail. We ensure always the same device is being accessed for each
file we advertise, to avoid collisions and leave the interesting
parts for the next patches.

The third patch implements a hash map that maps the first 16 bits of
inode and device id to a 16 bit prefix for the QID path. The last
48 bits are set equal to the last 48 inode bits. This should cover
most users, and should keep the hash table used for the mapping
very small for 99% of use cases.

The fourth patch implements a full mapping, as suggested by Emilio
G. Cota, that kicks in if the prefix map method fails. This can
happen for example if the host OS does not allocate inodes in a
predictable way. In that case, the implementation will allow to
keep track of up to 2**48 QID paths.

Antonios Motakis (4):
  9pfs: V9fsQID: set type of version and path to unsigned
  9pfs: check for file device to avoid QID path collisions
  9pfs: stat_to_qid: use device as input to qid.path
  9pfs: stat_to_qid: implement slow path

 fsdev/9p-marshal.h |   4 +-
 hw/9pfs/9p.c       | 201 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h       |  21 ++++++
 3 files changed, 205 insertions(+), 21 deletions(-)

-- 
1.8.3.1
