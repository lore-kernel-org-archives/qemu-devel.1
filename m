Received: from eggs.gnu.org ([2001:4830:134:3::10]:46260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahDy-0007Sj-Pc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahDx-0000UH-RO
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:34 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed,  4 Jul 2018 14:49:17 +0200
Message-Id: <20180704124923.32483-1-drjones@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu topology
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, imammedo@redhat.com, eric.auger@redhat.com, wei@redhat.com

This series provides support for booting mach-virt machines with
non-flat cpu topology, i.e. enabling the extended options of the
'-smp' command line parameter (sockets,cores,threads). Both DT and
ACPI description generators are added. We only apply the new feature
to 3.1 and later machine types, as the change is guest visible, even
when no command line change is made. This is because the basic
'-smp <N>' parameter makes the assumption that <N> refers to the
number of sockets, but when no topology description is provided,
Linux will use the MPIDR to guess. Neither the MPIDR exposed to
the guest when running with KVM nor TCG currently provides socket
information, leaving Linux to assume all processing elements are
cores in the same socket. For example, before this series '-smp 4'
would show up in the guest as

 CPU(s):                4
 On-line CPU(s) list:   0-3
 Thread(s) per core:    1
 Core(s) per socket:    4
 Socket(s):             1

and after it shows up as

 CPU(s):                4
 On-line CPU(s) list:   0-3
 Thread(s) per core:    1
 Core(s) per socket:    1
 Socket(s):             4

It's not expected that this should be a problem, but it's worth
considering. The only way to avoid the silent change is for QEMU to
provide boards a way to override the default '-smp' parsing function.
Otherwise, if a user wants to avoid a guest visible change, but still
use a 3.1 or later mach-virt machine type, then they must ensure the
command line specifies a single socket, e.g. '-smp sockets=1,cores=4'

Thanks,
drew


Andrew Jones (6):
  hw/arm/virt: Add virt-3.1 machine type
  device_tree: add qemu_fdt_add_path
  hw/arm/virt: DT: add cpu-map
  hw/arm/virt-acpi-build: distinguish possible and present cpus
  virt-acpi-build: add PPTT table
  hw/arm/virt: cpu topology: don't allow threads

 device_tree.c                | 24 +++++++++++++
 hw/acpi/aml-build.c          | 50 ++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c     | 25 ++++++++++---
 hw/arm/virt.c                | 69 +++++++++++++++++++++++++++++++++---
 include/hw/acpi/aml-build.h  |  2 ++
 include/hw/arm/virt.h        |  1 +
 include/sysemu/device_tree.h |  1 +
 7 files changed, 162 insertions(+), 10 deletions(-)

-- 
2.17.1
