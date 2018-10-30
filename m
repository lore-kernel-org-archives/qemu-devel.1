Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHVZv-00037Q-Hm
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHVZq-0006I9-0J
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gHVZm-0005zY-BB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:05:04 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 19:04:43 +0400
Message-Id: <20181030150453.9344-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/10] hostmem: use object "id" for memory
 region name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The migration code expects the RAM block name to match between the
source and destination.  However the backend type may change, so it is
possible (so far) to migrate from a hostmem-file to a hostmem-memfd
for example.

However, hostmem backends use inconsistent RAM naming, which can cause
a name mismatch. hostmem-file and hostmem-memfd use the whole object
path as memory name, while -ram use only the object "id".

This series adds global property support for objects others than
TYPE_DEVICE (only TYPE_USER_CREATABLE for now), and a new compat
property "x-use-canonical-path-for-ramblock-id" to hostmem for legacy
canonical path names, set to true for -file and -memfd with qemu < 3.1.

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

Marc-Andr=C3=A9 Lureau (10):
  qom: make user_creatable_complete() specific to UserCreatable
  accel: register global_props like machine globals
  qdev: move qdev_prop_register_global_list() to tests
  qom/globals: move qdev globals to qom
  qom/globals: generalize object_property_set_globals()
  qom/object: set globals when initializing object
  qom/object: add set_globals flags
  tests: add user-creatable test to test-qdev-global-props
  hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
  hostmem: use object id for memory region name with >=3D 3.1

 include/hw/compat.h                           |  11 +-
 include/hw/i386/pc.h                          |   2 +-
 include/hw/qdev-core.h                        |  20 ---
 include/hw/qdev-properties.h                  |  34 +---
 include/qom/globals.h                         |  32 ++++
 include/qom/object.h                          |   1 +
 include/qom/object_interfaces.h               |   4 +-
 include/sysemu/hostmem.h                      |   3 +-
 accel/accel.c                                 |   9 +-
 backends/hostmem-file.c                       |   8 +-
 backends/hostmem-memfd.c                      |   2 +-
 backends/hostmem-ram.c                        |   9 +-
 backends/hostmem.c                            |  30 ++++
 hw/core/machine.c                             |   2 +-
 hw/core/qdev-properties.c                     |  97 -----------
 hw/core/qdev.c                                |   7 +-
 hw/i386/pc_piix.c                             |  15 +-
 hw/i386/pc_q35.c                              |  13 +-
 hw/misc/ivshmem.c                             |   2 +-
 hw/virtio/virtio-rng.c                        |   2 +-
 qom/cpu.c                                     |   2 +-
 qom/globals.c                                 |  76 +++++++++
 qom/object.c                                  |  17 +-
 qom/object_interfaces.c                       |  21 ++-
 target/i386/cpu.c                             |   2 +-
 target/sparc/cpu.c                            |   2 +-
 ...dev-global-props.c =3D> test-global-props.c} | 150 +++++++++++++++---
 vl.c                                          |   6 +-
 qom/Makefile.objs                             |   2 +-
 tests/Makefile.include                        |   4 +-
 30 files changed, 362 insertions(+), 223 deletions(-)
 create mode 100644 include/qom/globals.h
 create mode 100644 qom/globals.c
 rename tests/{test-qdev-global-props.c =3D> test-global-props.c} (71%)

--=20
2.19.0.271.gfe8321ec05
