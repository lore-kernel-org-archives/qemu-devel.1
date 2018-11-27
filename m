Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfE-0002E4-D2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfB-0003sG-8s
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfB-0003pm-1b
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 435763002E06
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 09:28:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:33 +0400
Message-Id: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 00/28] Generalize machine
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
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

Edgar E. Iglesias (1):
  net: cadence_gem: Remove incorrect assert()

Eric Auger (1):
  MAINTAINERS: Add an ARM SMMU section

Greg Kurz (1):
  9p: fix QEMU crash when renaming files

Marc-Andr=C3=A9 Lureau (20):
  tests: qdev_prop_check_globals() doesn't return "all_used"
  qom: make interface types abstract
  qom: make user_creatable_complete() specific to UserCreatable
  accel: register global_props like machine globals
  qdev: move qdev_prop_register_global_list() to tests
  qom: remove unimplemented class_finalize
  hw: apply accel compat properties without touching globals
  hw: apply machine compat properties without touching globals
  hw: remove SET_MACHINE_COMPAT
  qdev: all globals are now user-provided
  qdev-props: convert global_props to GPtrArray
  qdev-props: remove errp from GlobalProperty
  qdev-props: call object_apply_global_props()
  qom: teach interfaces to implement post-init
  qom: add object_class_get_class_data()
  arm: replace instance_post_init()
  machine: add compat-props interface
  hw/i386: add pc-i440fx-3.2 & pc-q35-3.2
  hw/arm/virt: add virt-3.2 machine type
  hostmem: use object id for memory region name with >=3D 3.1

Max Filippov (4):
  target/xtensa: gdbstub fix register counting
  target/xtensa: drop num_[core_]regs from dc232b/dc233c configs
  target/xtensa: xtfpga: provide default memory sizes
  MAINTAINERS: add missing xtensa patterns

Thomas Huth (1):
  MAINTAINERS: Assign some more files in the hw/arm/ directory

--=20
2.20.0.rc1
