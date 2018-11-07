Received: from eggs.gnu.org ([2001:4830:134:3::10]:36870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN5F-00042Y-6q
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN5C-00065x-I9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:37:20 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:38 +0400
Message-Id: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 00/14] Generalize machine
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
-memfd with qemu < 3.2.

(this series was initially titled "[PATCH v2 00/10] hostmem: use
object "id" for memory region name with >=3D 3.1", but its focus is more
in refactoring the global and compatilibity properties handling now)

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

Marc-Andr=C3=A9 Lureau (14):
  tests: qdev_prop_check_globals() doesn't return "all_used"
  qom: make interface types abstract
  qom: make user_creatable_complete() specific to UserCreatable
  accel: register global_props like machine globals
  qdev: move qdev_prop_register_global_list() to tests
  qdev: do not mix compat props with global props
  qdev: all globals are now user-provided
  qdev-props: convert global_props to GArray
  qdev-props: remove errp from GlobalProperty
  qdev-props: call object_apply_global_props()
  qom: teach interfaces to implement post-init
  machine: add compat-props interface
  hw/i386: add pc-i440fx-3.2 & pc-q35-3.2
  hostmem: use object id for memory region name with >=3D 3.1

 include/hw/acpi/acpi_dev_interface.h |  6 +--
 include/hw/arm/linux-boot-if.h       |  5 +-
 include/hw/boards.h                  |  3 +-
 include/hw/compat.h                  | 11 ++++
 include/hw/fw-path-provider.h        |  4 +-
 include/hw/hotplug.h                 |  6 +--
 include/hw/i386/pc.h                 |  3 ++
 include/hw/intc/intc.h               |  4 +-
 include/hw/ipmi/ipmi.h               |  4 +-
 include/hw/isa/isa.h                 |  4 --
 include/hw/mem/memory-device.h       |  4 +-
 include/hw/nmi.h                     |  4 +-
 include/hw/qdev-core.h               |  9 ----
 include/hw/qdev-properties.h         | 30 -----------
 include/hw/stream.h                  |  4 +-
 include/hw/timer/m48t59.h            |  4 +-
 include/qom/object.h                 |  2 +
 include/qom/object_interfaces.h      | 10 ++--
 include/sysemu/accel.h               |  4 +-
 include/sysemu/hostmem.h             |  3 +-
 include/sysemu/tpm.h                 |  4 +-
 target/arm/idau.h                    |  4 +-
 accel/accel.c                        |  7 +--
 backends/hostmem-file.c              |  8 +--
 backends/hostmem-memfd.c             |  2 +-
 backends/hostmem-ram.c               |  9 ++--
 backends/hostmem.c                   | 31 +++++++++++
 hw/core/compat-props.c               | 43 +++++++++++++++
 hw/core/machine.c                    | 18 -------
 hw/core/qdev-properties.c            | 73 ++++++-------------------
 hw/core/qdev.c                       |  4 ++
 hw/i386/pc_piix.c                    | 21 ++++++--
 hw/i386/pc_q35.c                     | 19 ++++++-
 hw/misc/ivshmem.c                    |  2 +-
 hw/virtio/virtio-rng.c               |  2 +-
 hw/xen/xen-common.c                  |  9 +++-
 qom/cpu.c                            |  1 -
 qom/object.c                         | 49 +++++++++++++++--
 qom/object_interfaces.c              | 14 ++---
 stubs/machine.c                      |  4 ++
 target/i386/cpu.c                    |  1 -
 target/sparc/cpu.c                   |  1 -
 tests/check-qom-interface.c          | 27 ++++++++--
 tests/test-qdev-global-props.c       | 80 ++++++++--------------------
 vl.c                                 |  4 --
 MAINTAINERS                          |  1 +
 hw/core/Makefile.objs                |  1 +
 stubs/Makefile.objs                  |  1 +
 tests/Makefile.include               |  1 +
 49 files changed, 283 insertions(+), 282 deletions(-)
 create mode 100644 hw/core/compat-props.c
 create mode 100644 stubs/machine.c

--=20
2.19.1.708.g4ede3d42df
