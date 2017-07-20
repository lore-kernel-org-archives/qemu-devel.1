Received: from eggs.gnu.org ([2001:4830:134:3::10]:41061)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYCK0-0008Bg-M0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYCJv-0007sk-M1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:56 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34579 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYCJv-0007rr-Bu
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:51 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 20 Jul 2017 16:20:31 +0200
Message-Id: <1500560441-5670-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V4 00/10] add Qcow2 compress format extension
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

Changes V3->V4:
  - reduce the compress format name to 15 bytes [Eric]
  - explain the default compression level for zlib [Eric]
  - explain the difference between zlib with default compression
    and the old default [Eric]
  - added Patch 10

Changes V2->V3:
  - rebase to current master (qcow2 crypto extension)
  - patch 1: explicitly list valid format names, list valid compression levels,
             remove extra_data and extra_data_size for now [Kevin]
  - patch 2: don't hook the compression options in the blockdev-add options [Kevin, Daniel]
  - patch 3: parse compress settings from the qapi struct [Daniel]
  - patch 4: mention valid values for zlib, mention incompatiblity for QEMU < 2.10 [Kevin]
  - patch 5: use qapi to parse the compress format from header [Daniel]
  - added patch 6

Changes V1->V2:
  - split the series into more patches
  - added an qapi scheme for the compression settings
  - renamed compression_algorithm to compress.format and added compress.level+
  - updated the header extension to carry a variable extra payload and compress
    level.
  - removed extra reservations for header extensions
  - added missing lzo_init and fixed compress overhead for lzo

Peter Lieven (10):
  specs/qcow2: add compress format extension
  qapi/block-core: add Qcow2Compress parameters
  block/qcow2: parse compress create options
  qemu-img: add documentation for compress settings
  block/qcow2: read and write the compress format extension
  block/qcow2: simplify ret usage in qcow2_create
  block/qcow2: optimize qcow2_co_pwritev_compressed
  block/qcow2: start using the compress format extension
  block/qcow2: add lzo compress format
  block/qcow2: add compress info to image specific info

 block/qcow2-cluster.c     |  73 +++++++++-----
 block/qcow2.c             | 248 ++++++++++++++++++++++++++++++++++++++--------
 block/qcow2.h             |  21 +++-
 configure                 |   2 +-
 docs/interop/qcow2.txt    |  43 +++++++-
 include/block/block_int.h |   2 +
 qapi/block-core.json      |  54 +++++++++-
 qemu-img.texi             |  21 ++++
 8 files changed, 392 insertions(+), 72 deletions(-)

-- 
1.9.1
