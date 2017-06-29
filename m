Received: from eggs.gnu.org ([2001:4830:134:3::10]:51638)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8d-00071k-Ki
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8V-0007up-Sw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:28 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:40724 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8V-0007qd-Jw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:23 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:03 +0200
Message-Id: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 0/8] add Qcow2 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

this adds a create option for Qcow2 images to specify the compression format
and level for compressed clusters. The series adds 2 algorithms to choose from:
zlib and lzo. zlib is the current default, but with unoptimal settings.
If no compress.format option is specified the old zlib with the old parameters
is used and the created images are backwards compatible with older QEMU version.
As soon as a compression format is specified a new compress format header extension
is written and the Qcow2 images are incompatible with older QEMU versions.

Some numbers for an uncompressed Debian 9 QCOW2 image (size 1148MB):

compress.format     compress time    compressed size   decompress time
none                35.7s            339MB             3.4s
zlib (default)      30.5s            320MB             3.2s
zlib (level 1)      12.8s            348MB             3.2s
lzo                  4.2s            429MB             1.6s

Changes V1->V2:
  - split the series into more patches
  - added an qapi scheme for the compression settings
  - renamed compression_algorithm to compress.format and added compress.level+
  - updated the header extension to carry a variable extra payload and compress
    level.
  - removed extra reservations for header extensions
  - added missing lzo_init and fixed compress overhead for lzo

Peter Lieven (8):
  docs: add compress format extension to qcow2 spec
  qapi: add compress parameters to Qcow2 Blockdev options
  block/qcow2: parse compress create options
  qemu-img: add documentation for compress settings
  block/qcow2: read and write the compress format extension
  block/qcow2: optimize qcow2_co_pwritev_compressed
  block/qcow2: start using the compress format extension
  block/qcow2: add lzo compress format

 block/qcow2-cluster.c     |  73 +++++++++++-----
 block/qcow2.c             | 219 +++++++++++++++++++++++++++++++++++++++-------
 block/qcow2.h             |  33 +++++--
 configure                 |   2 +-
 docs/interop/qcow2.txt    |  43 ++++++++-
 include/block/block_int.h |   2 +
 qapi/block-core.json      |  54 +++++++++++-
 qemu-img.texi             |  22 +++++
 8 files changed, 384 insertions(+), 64 deletions(-)

-- 
1.9.1
