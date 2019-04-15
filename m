Received: from eggs.gnu.org ([209.51.188.92]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXr-0000aU-Je
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXq-0001RO-NF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:51 -0400
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 15 Apr 2019 15:59:43 +0800
Message-Id: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 0/2] vl.c: make current_machine as
 non-global variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, like.xu@intel.com

This patch makes the remaining dozen or so uses of the global
current_machine outside vl.c use qdev_get_machine() instead,
and then make current_machine local to vl.c instead of global.

With type assertion in qdev_get_machine(), it will be hard to
misuse this function if machine hasn't been created yet.
For obj-common cases, qdev_get_machine_uncheck() is applied
without semantic change.

---
Changes in v3:
    - add TYPE_MACHINE assertion for qdev_get_machine() usage
    - apply qdev_get_machine_uncheck() for obj-common usage
Changes in v2:
    - make the variable current_machine "static" (Thomas Huth)

Like Xu (2):
  vl.c: refactor current_machine as non-global variable
  core/qdev: refactor qdev_get_machine() with type assertion

 accel/kvm/kvm-all.c    |  6 ++++--
 device-hotplug.c       |  3 ++-
 device_tree.c          |  3 ++-
 exec.c                 |  6 ++++--
 hw/core/qdev.c         | 16 +++++++++++++---
 hw/ppc/spapr_rtas.c    |  3 ++-
 include/hw/boards.h    |  1 -
 include/hw/qdev-core.h |  1 +
 migration/savevm.c     |  9 ++++++---
 qmp.c                  |  3 ++-
 qom/cpu.c              |  5 +++--
 target/i386/kvm.c      |  3 ++-
 target/ppc/kvm.c       |  3 ++-
 vl.c                   |  4 ++--
 14 files changed, 45 insertions(+), 21 deletions(-)

-- 
1.8.3.1
