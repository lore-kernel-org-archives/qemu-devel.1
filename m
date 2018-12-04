Received: from eggs.gnu.org ([2001:4830:134:3::10]:47361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBYx-000481-QF
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBYs-0006hr-OE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:20:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBYs-0006hm-Gj
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C177430832C8
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 14:20:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:04 +0400
Message-Id: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 00/19] Generalize machine
 compatibility properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

During "[PATCH v2 05/10] qom/globals: generalize
object_property_set_globals()" review, Eduardo suggested to rework the
GlobalProperty handling, so that -global is limited to QDev only and
we avoid mixing the machine compats and the user-provided -global
properties (instead of generalizing -global to various object kinds,
like I proposed in v2).

"qdev: do not mix compat props with global props" patch decouples a
bit user-provided -global from machine compat properties. This allows
to get rid of "user_provided" and "errp" fields in following patches.

Instead of explcitely calling object_apply_global_props() in the
various object post_init, I opted for creating a new TYPE_COMPAT_PROPS
interface. The interface approach gives a lot more flexibility on
which objects can have compat props. This requires some interface
improvments in "qom: teach interfaces to implement post-init".

A new compat property "x-use-canonical-path-for-ramblock-id" is added
to hostmem for legacy canonical path names, set to true for -file and
-memfd with qemu < 4.0.

(this series was initially titled "[PATCH v2 00/10] hostmem: use
object "id" for memory region name with >=3D 3.1", but its focus is more
in refactoring the global and compatilibity properties handling now)

v5:
- replace the SET_COMPAT macros, use normal function instead
  (suggested by Eduardo)
- replace the TYPE_COMPAT_PROPS interface approach for explicit
  object_apply_compat_props(), solving post-init ordering issues.
- get back to coupling compat properties with machine, in qdev
  (although there is still some discussion how to improve this, it
   can be changed later)
- mark the "arm: replace instance_post_init()" as RFC, since it is not
  longer required for this series
- change machines version from 3.2 to 4.0
- add some r-b tags

v4:
- fix accel/machine compat props apply order inversion
- split "qdev: do not mix compat props with global props": replace
  using current_machine by new compat_props global, introduce
  SET_COMPAT() macro, use GPtrArray.
- add a comment about "qdev-props: call object_apply_global_props()"
  error reporting
- add "arm: replace instance_post_init()", to solve the post-init
  ordering issue
- add "hw/arm/virt: add virt-3.2 machine type" for completeness
- commit message improvements
- rebased, add r-b tags

v3:
- GlobalProperties improvements/cleanups
- drop generalizing the -global idea
- "replace" the set_globals flag with a TYPE_COMPAT_PROPS interface
- update hw/i386 machine version to 3.2
- add "qom: make interface types abstract" interface cleanup

v2:
- replace "qom/user-creatable: add a few helper macros" patch for a
  more optimized "qom: make user_creatable_complete() specific to
  UserCreatable"
- rename register_global_list() to register_global_properties()
- call object_property_set_globals() after post-init
- add and use a ObjectClass.set_globals flag, instead of dynamically
  check object class in object_property_set_globals()
- use object "id" in >=3D 3.1 instead of canonical path, add compat
  property "x-use-canonical-path-for-ramblock-id" in base hostmem
  class.

Marc-Andr=C3=A9 Lureau (19):
  tests: qdev_prop_check_globals() doesn't return "all_used"
  qom: make interface types abstract
  qom: make user_creatable_complete() specific to UserCreatable
  accel: register global_props like machine globals
  qdev: move qdev_prop_register_global_list() to tests
  qom: remove unimplemented class_finalize
  hw: apply accel compat properties without touching globals
  hw: apply machine compat properties without touching globals
  hw: remove SET_MACHINE_COMPAT
  qdev: make a separate helper function to apply compat properties
  qdev: all globals are now user-provided
  qdev-props: convert global_props to GPtrArray
  qdev-props: remove errp from GlobalProperty
  qdev-props: call object_apply_global_props()
  qom: add object_class_get_class_data()
  RFC: arm: replace instance_post_init()
  hw/i386: add pc-i440fx-4.0 & pc-q35-4.0
  hw/arm/virt: add virt-4.0 machine type
  hostmem: use object id for memory region name with >=3D 4.0

 include/hw/acpi/acpi_dev_interface.h |   6 +-
 include/hw/arm/linux-boot-if.h       |   5 +-
 include/hw/boards.h                  |  19 +-
 include/hw/compat.h                  |  11 +
 include/hw/fw-path-provider.h        |   4 +-
 include/hw/hotplug.h                 |   6 +-
 include/hw/i386/pc.h                 |   3 +
 include/hw/intc/intc.h               |   4 +-
 include/hw/ipmi/ipmi.h               |   4 +-
 include/hw/isa/isa.h                 |   4 -
 include/hw/mem/memory-device.h       |   4 +-
 include/hw/nmi.h                     |   4 +-
 include/hw/qdev-core.h               |  21 +-
 include/hw/qdev-properties.h         |  30 --
 include/hw/stream.h                  |   4 +-
 include/hw/timer/m48t59.h            |   4 +-
 include/qom/object.h                 |  19 +-
 include/qom/object_interfaces.h      |  10 +-
 include/sysemu/accel.h               |   4 +-
 include/sysemu/hostmem.h             |   3 +-
 include/sysemu/tpm.h                 |   4 +-
 target/arm/cpu.h                     |   2 +
 target/arm/idau.h                    |   4 +-
 accel/accel.c                        |   7 +-
 backends/hostmem-file.c              |   8 +-
 backends/hostmem-memfd.c             |   2 +-
 backends/hostmem-ram.c               |   9 +-
 backends/hostmem.c                   |  36 ++
 hw/arm/virt.c                        |  70 ++-
 hw/core/machine.c                    |  30 +-
 hw/core/qdev-properties.c            |  73 +---
 hw/core/qdev.c                       |  15 +
 hw/i386/pc_piix.c                    | 607 ++++++++++++++++-----------
 hw/i386/pc_q35.c                     |  88 +++-
 hw/misc/ivshmem.c                    |   2 +-
 hw/ppc/spapr.c                       | 209 +++++----
 hw/s390x/s390-virtio-ccw.c           | 220 +++++-----
 hw/virtio/virtio-rng.c               |   2 +-
 hw/xen/xen-common.c                  |   9 +-
 qom/cpu.c                            |   1 -
 qom/object.c                         |  54 ++-
 qom/object_interfaces.c              |  14 +-
 target/arm/cpu.c                     |  15 +-
 target/arm/cpu64.c                   |  11 +-
 target/i386/cpu.c                    |   1 -
 target/sparc/cpu.c                   |   1 -
 tests/check-qom-interface.c          |   4 +-
 tests/test-qdev-global-props.c       |  79 +---
 vl.c                                 |   4 -
 49 files changed, 963 insertions(+), 787 deletions(-)

--=20
2.20.0.rc1
