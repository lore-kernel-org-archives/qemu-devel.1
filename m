Received: from eggs.gnu.org ([2001:4830:134:3::10]:42453)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPphQ-00057V-9k
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPphN-0005GJ-6L
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:32 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:50550 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPphM-0005F6-TT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:29 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 27 Jun 2017 14:34:06 +0200
Message-Id: <1498566850-7934-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 0/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>

this adds a create option for QCOW2 images to specify the compression algorithm
for compressed clusters. The series adds 3 algorithms to choose from:
zlib (default), zlib-fast and lzo. zlib-fast optimizes the zlib parameters
without the need for an additional compression library. lzo is choosen
as we already link against it and its widely available. Further
libraries like zstd are in preparation.

Compression time vs. size of an uncompressed Debian 9 QCOW2 image (size 1148MB):

zlib         35.7s     339MB
zlib-fast    12.8s     348MB
lzo          4.2s      429MB

Peter Lieven (4):
  block/qcow2: add compression_algorithm create option
  block/qcow2: optimize qcow2_co_pwritev_compressed
  block/qcow2: add lzo compression algorithm
  block/qcow2: add zlib-fast compression algorithm

 block/qcow2-cluster.c     |  66 ++++++++++------
 block/qcow2.c             | 186 +++++++++++++++++++++++++++++++++++++---------
 block/qcow2.h             |  22 ++++--
 configure                 |   2 +-
 docs/interop/qcow2.txt    |   8 +-
 include/block/block_int.h |  35 ++++-----
 qemu-img.texi             |  12 +++
 7 files changed, 251 insertions(+), 80 deletions(-)

-- 
1.9.1
