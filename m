Received: from eggs.gnu.org ([2001:4830:134:3::10]:37136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0003PH-GX
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmL-0000Na-Il
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmL-0000Mi-9z
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:17 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:45:55 +0200
Message-Id: <1503564371-26090-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/16] qapi: Rework mapping of enum value to
 string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

The purpose of this work is to make holes in QAPI enumerations
possible.

Why holes?  Because we want to be able to suppress enumeration
constants with #if.  Holes could be avoided, e.g. by letting the
compiler assign the values.  Falls apart when the conditions are
target-specific, because then target-specific code would get different
values.

Why are holes a problem?  The tables mapping enumeration constants to
strings use a NULL sentinel.

This is PATCH 06-13 of "[PATCH v2 00/54] qapi: add #if pre-processor
conditions to generated code" reworked for reviewability.  Took a bit
of time, but it was probably less work and certainly more fun than
reviewing the old PATCH 06 and 12 (almost 300 hunks!) in sufficient
depth would have been.

* PATCH 01: New, included only so I can update qapi-code-gen.txt
  sanely in PATCH 12
* PATCH 02: New, factored out of old PATCH 12 (sort of)
* PATCH 03: Old PATCH 07 rebased, superfluous initializer dropped,
  commit message rewritten
* PATCH 04: New, to finish PATCH 03's cleanup job
* PATCH 05: Old PATCH 08 rebased, commit message rewritten
* PATCH 06: Old PATCH 09 rebased, assertion added, commit message
  rewritten
* PATCH 07: Old PATCH 10 rebased, commit message rewritten
* PATCH 08: Old PATCH 11 rebased, qemu_opt_get() factored out, commit
  message tweaked
* PATCH 09: New, factored out of old PATCH 12
* PATCH 10: New, to complete PATCH 03-09
* PATCH 11: New, to make these loops cope with holes
* PATCH 12: New, split off old PATCH 06, with macros spliced in
* PATCH 13: New, replacing parts of old PATCH 06
* PATCH 14: New, replacing parts of old PATCH 06
* PATCH 15: Old PATCH 12 basically redone
* PATCH 16: Old PATCH 13 rebased, superfluous local variable dropped,
  missing check-qom-proplist.c update added

Not included: old PATCH 12's change to make output_type_enum() fail on
"hole".  I think this is best done together with the patches that
punch holes, so it can be tested.

Old diffstat:
 68 files changed, 425 insertions(+), 396 deletions(-)
New diffstat:
 71 files changed, 410 insertions(+), 463 deletions(-)

Marc-Andr=C3=A9 Lureau (7):
  tpm: Clean up driver registration & lookup
  hmp: Use qapi_enum_parse() in hmp_migrate_set_capability()
  hmp: Use qapi_enum_parse() in hmp_migrate_set_parameter()
  block: Use qemu_enum_parse() in blkdebug_debug_breakpoint()
  quorum: Use qapi_enum_parse() in quorum_open()
  qapi: Change data type of the FOO_lookup generated for enum FOO
  qapi: drop the sentinel in enum array

Markus Armbruster (9):
  qapi: Update qapi-code-gen.txt examples to match current code
  qapi: Drop superfluous qapi_enum_parse() parameter max
  tpm: Clean up model registration & lookup
  crypto: Use qapi_enum_parse() in qcrypto_block_luks_name_lookup()
  qapi: Use qapi_enum_parse() in input_type_enum()
  qapi: Avoid unnecessary use of enum lookup table's sentinel
  qapi: Generate FOO_str() macro for QAPI enum FOO
  qapi: Mechanically convert FOO_lookup[...] to FOO_str(...)
  qapi: Convert indirect uses of FOO_lookup[...] to qapi_enum_lookup()

 backends/hostmem.c                  |   4 +-
 block.c                             |   4 +-
 block/backup.c                      |   2 +-
 block/blkdebug.c                    |  27 ++---
 block/file-posix.c                  |  20 ++--
 block/file-win32.c                  |   5 +-
 block/gluster.c                     |  11 +-
 block/iscsi.c                       |   2 +-
 block/nfs.c                         |   2 +-
 block/parallels.c                   |  17 +--
 block/qcow2.c                       |  15 +--
 block/qed.c                         |   2 +-
 block/quorum.c                      |  27 ++---
 block/rbd.c                         |   2 +-
 block/sheepdog.c                    |   2 +-
 blockdev.c                          |   8 +-
 blockjob.c                          |   6 +-
 chardev/char.c                      |   4 +-
 crypto/block-luks.c                 |  38 +++----
 crypto/block.c                      |   4 +-
 crypto/cipher-afalg.c               |   2 +-
 crypto/cipher-builtin.c             |   8 +-
 crypto/cipher-gcrypt.c              |   4 +-
 crypto/cipher-nettle.c              |   8 +-
 crypto/hmac-gcrypt.c                |   2 +-
 crypto/hmac-glib.c                  |   2 +-
 crypto/hmac-nettle.c                |   2 +-
 crypto/pbkdf-gcrypt.c               |   2 +-
 crypto/pbkdf-nettle.c               |   2 +-
 crypto/secret.c                     |   2 +-
 crypto/tlscreds.c                   |   2 +-
 docs/devel/qapi-code-gen.txt        |  50 ++++++--
 hmp.c                               | 220 ++++++++++++++++++------------=
------
 hw/block/fdc.c                      |   6 +-
 hw/char/escc.c                      |   2 +-
 hw/core/qdev-properties.c           |  17 +--
 hw/input/virtio-input-hid.c         |   4 +-
 include/hw/qdev-core.h              |   2 +-
 include/qapi/util.h                 |  10 +-
 include/qapi/visitor.h              |   2 +-
 include/qom/object.h                |   4 +-
 include/sysemu/tpm_backend.h        |   4 +-
 migration/colo-failover.c           |   4 +-
 migration/colo.c                    |  14 +--
 migration/global_state.c            |   6 +-
 migration/migration.c               |   1 -
 monitor.c                           |  20 ++--
 net/filter.c                        |   2 +-
 net/net.c                           |   4 +-
 qapi/qapi-util.c                    |  16 ++-
 qapi/qapi-visit-core.c              |  34 +++---
 qapi/qmp-dispatch.c                 |   2 +-
 qemu-img.c                          |   6 +-
 qemu-nbd.c                          |   4 +-
 qom/object.c                        |  16 +--
 scripts/qapi-event.py               |   1 +
 scripts/qapi-types.py               |   4 +
 scripts/qapi-visit.py               |   2 +-
 scripts/qapi.py                     |  16 ++-
 tests/check-qom-proplist.c          |  14 ++-
 tests/test-qapi-util.c              |  18 +--
 tests/test-qobject-input-visitor.c  |   8 +-
 tests/test-qobject-output-visitor.c |   2 +-
 tests/test-string-input-visitor.c   |   4 +-
 tests/test-string-output-visitor.c  |   4 +-
 tpm.c                               |  81 +++----------
 ui/input-legacy.c                   |   6 +-
 ui/input.c                          |  12 +-
 ui/vnc.c                            |   6 +-
 util/keyval.c                       |   1 -
 vl.c                                |   6 +-
 71 files changed, 410 insertions(+), 463 deletions(-)

--=20
2.7.5
