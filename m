Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOToo-0003rX-PP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOTon-00012a-DJ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:28:18 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  3 Jan 2017 18:27:46 +0000
Message-Id: <20170103182801.9638-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 00/15] Convert QCow[2] to QCryptoBlock & add
 LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This series is a continuation of previous work to support LUKS in
QEMU. The existing merged code supports LUKS as a standalone
driver which can be layered over/under any other QEMU block device
driver. This works well when using LUKS over protocol drivers (file,
rbd, iscsi, etc, etc), but has some downsides when combined with
format drivers like qcow2.

If you layer LUKS under qcow2 (eg qcow2 -> luks -> file) then you
cannot get any information about the qcow2 file without first
decrypting it, as both the header and payload are encrypted.

If you layer LUKS over qcow2 (eg luks -> qcow2 -> file) then you
cannot distinguish between a qcow2 file where the guest has done
LUKS encryption from a qcow2 file which qemu has done encryption.
More seriously, when encrypting sectors the guest virtual sector
is used as the input for deriving the initialization vectors.
When internal snapshots are used, this means that multiple sectors
in the qcow2 file may be encrypted with the same initialization
vector. This is a security weakness when combined with certain
cryptographic modes.

Integrating LUKS natively into qcow2 allows us to combine the
best aspects of both layering strategies above. In particular
the header remains unecrypted, but initialization vectors are
generated using physical sector numbers preserving security
when snapshots are used. This is a change from previous postings
of this work, where the IVs were (incorrectly) generated based
on the virtual disk sector.

In a previous posting of this work, Fam had suggested that we
do integration by layering luks over qcow2, but having QEMU
block layer automatically create the luks driver above qcow2
based on the qcow2 header crypt_method field. This is not
possible though, because such a scheme would suffer from the
problem of IVs being generated from the virtual disk sector
instead of physical disk sector. So having LUKS specific
code in the qcow2 block driver is unavoidable. In comparison
to the previous posting though, the amount of code in qcow2.c
has been reduced by allowing re-use of code from block/crypto.c
for handling QemuOpts -> QAPI conversion. So extra lines of
code in qcow2 to support LUKS is < 200.

I have also split the changes to qcow2 up into 2 patches. The
first patch simply introduces use of the QCryptoBlock framework
to qcow2 for the existing (deprecated) AES-CBC encryption method.
The second patch wires up the LUKS support for qcow2. This makes
it clearer which parts of the changes are related to plain code
refactoring, vs enabling the new features. Specifically we can
now see that the LUKS enablement in qcow2 has this footprint:

  block/qcow2-cluster.c  |   4 +-
  block/qcow2-refcount.c |  10 +++++
  block/qcow2.c          | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
  block/qcow2.h          |   9 ++++
  4 files changed, 224 insertions(+), 35 deletions(-)

Main changes since previous posting

 - Make sure iotests work for qcow v1
 - Fix bugs in qcow v1 conversion to QCryptoBlock which
   caused segv with legacy AES encryption
 - Split qcow2 conversion into two parts, one converting
   to QCryptoBlock just for legacy AES, one adding LUKS
   support
 - Enable more iotests for qcow to exercise legacy AES
   code path
 - Refactor generic LUKS block driver to allow code
   sharing with the qcow2 LUKS integration
 - Switch to use physical sector when generating
   initialization vectors for LUKS with qcow2 to
   avoid security weakness with snapshots.

Daniel P. Berrange (15):
  block: expose crypto option names / defs to other drivers
  block: add ability to set a prefix for opt names
  qcow: document another weakness of qcow AES encryption
  qcow: require image size to be > 1 for new images
  iotests: skip 042 with qcow which dosn't support zero sized images
  iotests: skip 048 with qcow which doesn't support resize
  iotests: fix 097 when run with qcow
  qcow: make encrypt_sectors encrypt in place
  qcow: convert QCow to use QCryptoBlock for encryption
  qcow2: make qcow2_encrypt_sectors encrypt in place
  qcow2: convert QCow2 to use QCryptoBlock for encryption
  qcow2: add support for LUKS encryption format
  iotests: enable tests 134 and 158 to work with qcow (v1)
  block: rip out all traces of password prompting
  block: remove all encryption handling APIs

 block.c                    |  77 +--------
 block/crypto.c             | 166 ++++++++++++-------
 block/crypto.h             | 102 ++++++++++++
 block/qapi.c               |   2 +-
 block/qcow.c               | 207 +++++++++++-------------
 block/qcow2-cluster.c      |  56 +------
 block/qcow2-refcount.c     |  10 ++
 block/qcow2.c              | 385 +++++++++++++++++++++++++++++++++++----------
 block/qcow2.h              |  17 +-
 blockdev.c                 |  37 +----
 docs/specs/qcow2.txt       |  99 ++++++++++++
 hmp.c                      |  31 ----
 include/block/block.h      |   3 -
 include/block/block_int.h  |   1 -
 include/monitor/monitor.h  |   7 -
 include/qapi/error.h       |   1 -
 include/qemu/osdep.h       |   2 -
 monitor.c                  |  68 --------
 qapi-schema.json           |  10 +-
 qapi/block-core.json       |  28 +++-
 qapi/common.json           |   5 +-
 qemu-img.c                 |  31 ----
 qemu-img.texi              |   9 ++
 qemu-io.c                  |  20 ---
 qmp.c                      |  12 +-
 tests/qemu-iotests/042     |   2 +-
 tests/qemu-iotests/048     |   2 +-
 tests/qemu-iotests/049     |   2 +-
 tests/qemu-iotests/049.out |   4 +-
 tests/qemu-iotests/082.out | 243 ++++++++++++++++++++++++++++
 tests/qemu-iotests/087     |  83 +++++++++-
 tests/qemu-iotests/087.out |  28 +++-
 tests/qemu-iotests/097     |  10 +-
 tests/qemu-iotests/097.out | 125 +--------------
 tests/qemu-iotests/134     |  20 ++-
 tests/qemu-iotests/134.out |  10 +-
 tests/qemu-iotests/158     |  21 ++-
 tests/qemu-iotests/158.out |  14 +-
 tests/qemu-iotests/173     | 126 +++++++++++++++
 tests/qemu-iotests/173.out | 119 ++++++++++++++
 tests/qemu-iotests/174     |  76 +++++++++
 tests/qemu-iotests/174.out |  19 +++
 tests/qemu-iotests/175     |  85 ++++++++++
 tests/qemu-iotests/175.out |  26 +++
 tests/qemu-iotests/group   |   3 +
 util/oslib-posix.c         |  66 --------
 util/oslib-win32.c         |  24 ---
 47 files changed, 1613 insertions(+), 881 deletions(-)
 create mode 100644 block/crypto.h
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out
 create mode 100755 tests/qemu-iotests/174
 create mode 100644 tests/qemu-iotests/174.out
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

-- 
2.9.3
