Received: from eggs.gnu.org ([2001:4830:134:3::10]:37201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cjncv-0008VU-3G
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cjncr-0005nf-7C
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cjncr-0005nG-0w
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  3 Mar 2017 21:51:46 +0800
Message-Id: <20170303135150.12145-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

RFCv1:
 * Publishing patch series with just raw support, no qcow2 yet.  Please review
   the command-line interface and let me know if you are happy with this
   approach.

Users and management tools sometimes need to know the size required for a new
disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of time.
Image formats like qcow2 have non-trivial metadata that makes it hard to
estimate the exact size without knowledge of file format internals.

This patch series introduces a new qemu-img subcommand that calculates the
required size for both image creation and conversion scenarios.

The conversion scenario is:

  $ qemu-img max-size -f raw -O qcow2 input.img
  107374184448

Here an existing image file is taken and the output includes the space required
for data from the input image file.

The creation scenario is:

  $ qemu-img max-size -O qcow2 --size 5G
  196688

Stefan Hajnoczi (4):
  block: add bdrv_max_size() API
  raw-format: add bdrv_max_size() support
  qemu-img: add max-size subcommand
  iotests: add test 178 for qemu-img max-size

 include/block/block.h      |   2 +
 include/block/block_int.h  |   2 +
 block.c                    |  37 +++++++++
 block/raw-format.c         |  16 ++++
 qemu-img.c                 | 196 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx           |   6 ++
 tests/qemu-iotests/178     |  75 +++++++++++++++++
 tests/qemu-iotests/178.out |  25 ++++++
 tests/qemu-iotests/group   |   1 +
 9 files changed, 360 insertions(+)
 create mode 100755 tests/qemu-iotests/178
 create mode 100644 tests/qemu-iotests/178.out

-- 
2.9.3
