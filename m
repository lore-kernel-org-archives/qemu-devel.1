Received: from eggs.gnu.org ([209.51.188.92]:50211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU4c-0007m8-IZ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU4a-0001E5-M3
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:32:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ggU4a-000193-87
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:32:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Jan 2019 16:22:36 +0400
Message-Id: <20190107122304.22997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/28] Machine props patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3f=
b8:

  Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-=
request' into staging (2019-01-04 18:23:13 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/machine-props-pull-request

for you to fetch changes up to fa0cb34d2210cc749b9a70db99bb41c56ad20831:

  hostmem: use object id for memory region name with >=3D 4.0 (2019-01-07=
 16:18:42 +0400)

----------------------------------------------------------------
Generalize machine compatibility properties

During "[PATCH v2 05/10] qom/globals: generalize
object_property_set_globals()" review, Eduardo suggested to rework the
GlobalProperty handling, so that -global is limited to QDev only and
we avoid mixing the machine compats and the user-provided -global
properties (instead of generalizing -global to various object kinds,
like I proposed in v2).

"qdev: do not mix compat props with global props" patch decouples a
bit user-provided -global from machine compat properties. This allows
to get rid of "user_provided" and "errp" fields in following patches.

A new compat property "x-use-canonical-path-for-ramblock-id" is added
to hostmem for legacy canonical path names, set to true for -file and
-memfd with qemu < 4.0.

(this series was initially titled "[PATCH v2 00/10] hostmem: use
object "id" for memory region name with >=3D 3.1", but its focus is more
in refactoring the global and compatilibity properties handling now)

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (28):
  hw: apply accel compat properties without touching globals
  machines: replace COMPAT define with a static array
  hw: apply machine compat properties without touching globals
  machine: move compat properties out of globals
  hw: remove SET_MACHINE_COMPAT
  compat: replace PC_COMPAT_3_1 & HW_COMPAT_3_1 macros
  compat: replace PC_COMPAT_3_0 & HW_COMPAT_3_0 macros
  compat: replace PC_COMPAT_2_12 & HW_COMPAT_2_12 macros
  compat: replace PC_COMPAT_2_11 & HW_COMPAT_2_11 macros
  compat: replace PC_COMPAT_2_10 & HW_COMPAT_2_10 macros
  compat: replace PC_COMPAT_2_9 & HW_COMPAT_2_9 macros
  compat: replace PC_COMPAT_2_8 & HW_COMPAT_2_8 macros
  compat: replace PC_COMPAT_2_7 & HW_COMPAT_2_7 macros
  compat: replace PC_COMPAT_2_6 & HW_COMPAT_2_6 macros
  compat: replace PC_COMPAT_2_5 & HW_COMPAT_2_5 macros
  compat: replace PC_COMPAT_2_4 & HW_COMPAT_2_4 macros
  compat: replace PC_COMPAT_2_3 & HW_COMPAT_2_3 macros
  compat: replace PC_COMPAT_2_2 & HW_COMPAT_2_2 macros
  compat: replace PC_COMPAT_2_1 & HW_COMPAT_2_1 macros
  include: remove compat.h
  compat: remove remaining PC_COMPAT macros
  qdev: make a separate helper function to apply compat properties
  qdev: all globals are now user-provided
  qdev-props: convert global_props to GPtrArray
  qdev-props: remove errp from GlobalProperty
  qdev-props: call object_apply_global_props()
  arm: replace instance_post_init()
  hostmem: use object id for memory region name with >=3D 4.0

 include/hw/boards.h            |  59 ++-
 include/hw/compat.h            | 299 --------------
 include/hw/i386/pc.h           | 689 +++------------------------------
 include/hw/qdev-core.h         |  23 +-
 include/qom/object.h           |   3 +
 include/sysemu/accel.h         |   4 +-
 include/sysemu/hostmem.h       |   3 +-
 target/arm/cpu-qom.h           |   3 +
 target/arm/cpu.h               |   2 +
 accel/accel.c                  |  12 -
 backends/hostmem-file.c        |   8 +-
 backends/hostmem-memfd.c       |   2 +-
 backends/hostmem-ram.c         |   9 +-
 backends/hostmem.c             |  36 ++
 hw/arm/virt.c                  |  46 +--
 hw/core/machine.c              | 347 ++++++++++++++++-
 hw/core/qdev-properties.c      |  49 +--
 hw/core/qdev.c                 |  15 +
 hw/i386/pc.c                   | 674 ++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c              | 508 ++++++++++++------------
 hw/i386/pc_q35.c               |  36 +-
 hw/ppc/spapr.c                 | 207 +++++-----
 hw/s390x/s390-virtio-ccw.c     | 196 +++++-----
 hw/xen/xen-common.c            |  41 +-
 qom/cpu.c                      |   1 -
 qom/object.c                   |  35 ++
 target/arm/cpu.c               |  30 +-
 target/arm/cpu64.c             |  24 +-
 target/i386/cpu.c              |   1 -
 target/sparc/cpu.c             |   1 -
 tests/test-qdev-global-props.c |  57 +--
 vl.c                           |   4 -
 32 files changed, 1786 insertions(+), 1638 deletions(-)
 delete mode 100644 include/hw/compat.h

--=20
2.20.1.2.gb21ebb671b
