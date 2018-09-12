Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gI-000796-Q3
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gF-0007aj-KG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04gF-0007aF-ER
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:39 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:55:22 +0400
Message-Id: <20180912125531.32131-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/9] hostmem-ram: use whole path for region
 name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The migration code expects the RAM block name to match between the
source and destination.  However the backend type may change, so it is
possible (so far) to migrate from a hostmem-file to a hostmem-memfd
for example.

However, hostmem backends use inconsistent RAM naming, which can cause
a name mismatch. hostmem-file and hostmem-memfd use the whole object
path as memory name, while -ram use only the "component" (or basename)
of the path.

This series adds global/compat property support for objects others
than TYPE_DEVICE (only TYPE_USER_CREATABLE for now), and a new compat
property "x-component-name" to hostmem-ram. Machines >=3D 3.1 will use
the whole path for the -ram memory name (like -file and -memfd).

Marc-Andr=C3=A9 Lureau (9):
  qom/user-creatable: add a few helper macros
  accel: register global_props like machine globals
  qdev: move qdev_prop_register_global_list() to tests
  qom/globals: move qdev globals to qom
  qom/globals: generalize object_property_set_globals()
  qom/object: set globals when initializing object
  tests: add user-creatable test to test-qdev-global-props
  hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
  hostmem-ram: use whole path for memory region name with >=3D 3.1

 include/hw/compat.h                           |   6 +-
 include/hw/i386/pc.h                          |   5 +-
 include/hw/qdev-core.h                        |  20 ---
 include/hw/qdev-properties.h                  |  34 +---
 include/qom/globals.h                         |  32 ++++
 include/qom/object_interfaces.h               |   4 +
 accel/accel.c                                 |   9 +-
 backends/hostmem-ram.c                        |  47 +++++-
 hw/core/machine.c                             |   2 +-
 hw/core/qdev-properties.c                     |  97 -----------
 hw/core/qdev.c                                |   6 -
 hw/i386/pc_piix.c                             |  15 +-
 hw/i386/pc_q35.c                              |  13 +-
 qom/cpu.c                                     |   2 +-
 qom/globals.c                                 |  81 ++++++++++
 qom/object.c                                  |   6 +-
 qom/object_interfaces.c                       |   9 +-
 target/i386/cpu.c                             |   2 +-
 target/sparc/cpu.c                            |   2 +-
 ...dev-global-props.c =3D> test-global-props.c} | 150 +++++++++++++++---
 vl.c                                          |   8 +-
 qom/Makefile.objs                             |   2 +-
 tests/Makefile.include                        |   4 +-
 23 files changed, 350 insertions(+), 206 deletions(-)
 create mode 100644 include/qom/globals.h
 create mode 100644 qom/globals.c
 rename tests/{test-qdev-global-props.c =3D> test-global-props.c} (71%)

--=20
2.19.0.rc1
