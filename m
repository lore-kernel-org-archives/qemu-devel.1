Received: from eggs.gnu.org ([2001:4830:134:3::10]:59114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSjsL-000572-9e
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSjsH-0003AM-ES
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dSjsH-0003A4-5C
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:57:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  5 Jul 2017 13:57:29 +0100
Message-Id: <20170705125738.8777-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v9 0/9] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v9:
 * Fix swapped fmt <-> output_fmt parameters in documentation [Max]
 * Clarify that backing file clusters also available in the new image
   file *may* be ommitted from the calculation [Max]

v8:
 * Check 2P file size in qemu-iotests 178 [Berto]
 * Use QCOW_MAX_L1_SIZE to check maximum virtual disk size [Berto]

v7:
 * Check max file size with 7 exabytes [Berto]
 * Really use UINT64_MAX everywhere instead of ~0ULL [Berto]

v6:
 * Change bdrv_measure() return type to BlockMeasureInfo * [Eric]
 * Clarify that holes in sparse POSIX files are still counted [Eric]

v5:
 * Use UINT64_MAX instead of ~0ULL [Berto]
 * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
   [Berto]

v4:
 * Make qcow2 refcount calculation conservative [Maor]
 * Include actual qemu-img convert image size in test cases

v3:
 * Drop RFC, this is ready to go for QEMU 2.10
 * Use "required size" instead of "required bytes" in qemu-img output for
   consistency [Nir]
 * Clarify BlockMeasureInfo semantics [Max]
 * Clarify bdrv_measure() opts argument and error handling [Nir]
 * Handle -o backing_file= for qcow2 [Max]
 * Handle snapshot options in qemu-img measure
 * Probe input image for allocated data clusters for qcow2.  Didn't centralize
   this because there are format-specific aspects such as the cluster_size.  It
   may make sense to centralize it later (with a bit more complexity) if
   support is added to more formats.
 * Add qemu-img(1) man page section for 'measure' sub-command [Max]
 * Extend test case to cover additional scenarios [Nir]

RFCv2:
 * Publishing RFC again to discuss the new user-visible interfaces.  Code has
   changed quite a bit, I have not kept any Reviewed-by tags.
 * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
 * Report both "required bytes" and "fully allocated bytes" to handle the empty
   image file and prealloc use cases [Nir and Dan]
 * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
 * Rename "err" label "out" in qemu-img-cmds.c [Nir]
 * Add basic qcow2 support, doesn't support qemu-img convert from existing files yet

RFCv1:
 * Publishing patch series with just raw support, no qcow2 yet.  Please review
   the command-line interface and let me know if you are happy with this
   approach.

Users and management tools sometimes need to know the size required for a new
disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of time.
Image formats like qcow2 have non-trivial metadata that makes it hard to
estimate the exact size without knowledge of file format internals.

This patch series introduces a new qemu-img sub-command that calculates the
required size for both image creation and conversion scenarios.

The conversion scenario is:

  $ qemu-img measure -f raw -O qcow2 input.img
  required size: 1327680
  fully allocated size: 1074069504

Here an existing image file is taken and the output includes the space required
for data from the input image file.

The creation scenario is:

  $ qemu-img measure -O qcow2 --size 5G
  required size: 327680
  fully allocated size: 1074069504

Stefan Hajnoczi (9):
  block: add bdrv_measure() API
  raw-format: add bdrv_measure() support
  qcow2: extract preallocation calculation function
  qcow2: make refcount size calculation conservative
  qcow2: extract image creation option parsing
  qcow2: add bdrv_measure() support
  qemu-img: add measure subcommand
  qemu-iotests: support per-format golden output files
  iotests: add test 178 for qemu-img measure

 qapi/block-core.json             |  25 +++
 include/block/block.h            |   2 +
 include/block/block_int.h        |   2 +
 block.c                          |  35 ++++
 block/qcow2.c                    | 383 +++++++++++++++++++++++++++++----------
 block/raw-format.c               |  26 +++
 qemu-img.c                       | 234 ++++++++++++++++++++++++
 qemu-img-cmds.hx                 |   6 +
 qemu-img.texi                    |  30 +++
 tests/qemu-iotests/178           | 170 +++++++++++++++++
 tests/qemu-iotests/178.out.qcow2 | 286 +++++++++++++++++++++++++++++
 tests/qemu-iotests/178.out.raw   | 158 ++++++++++++++++
 tests/qemu-iotests/check         |   5 +
 tests/qemu-iotests/group         |   1 +
 14 files changed, 1268 insertions(+), 95 deletions(-)
 create mode 100755 tests/qemu-iotests/178
 create mode 100644 tests/qemu-iotests/178.out.qcow2
 create mode 100644 tests/qemu-iotests/178.out.raw

-- 
2.9.4
