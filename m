Received: from eggs.gnu.org ([2001:4830:134:3::10]:57455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1N-00081P-TH
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1H-0005Wi-3u
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:05 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri,  7 Dec 2018 10:01:18 +0100
Message-Id: <20181207090135.7651-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/16] gdbstub: support for the multiprocess
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

changes since v7:
  - patch 1    Add documentation about cpu-cluster [Eduardo, Peter]

  - patch 1    Remove the cluster-id auto-assign mechanism [Eduardo]

  - patch 2    Replace create_unique_process() with
               create_default_process() that is now called even if some
               clusters are found. This default process is used for
               CPUs that are not in a cluster [Eduardo, Peter]

  - patch 3    Refactor and harden gdb_get_cpu_pid() [Philippe]

  - patch 16   Go back to cluster-id manual assignment [Eduardo]

changes since v6:
  - patch 4    Fix a refactoring issue in gdb_get_cpu [Edgar]

  - patch 5    Renamed gdb_first_cpu/gdb_next_cpu to
               gdb_first_attached_cpu/gdb_next_attached_cpu [Edgar]

  - patch 7    Added the CPU name and removed the CPU index in the
               ThreadInfo packet in multiprocess mode [Edgar]

changes since v5:
  - patch 1    Rebased on top of master

  - patch 2    Cluster ID handling hardening to ensure uint32_t overflow
               won't cause PID 0 to be used [Edgar]

  - patch 2    Fix the GDB process ordering function to avoid uint32_t
               overflow when comparing two cluster_ids [Edgar]

changes since v4:
  - patch 1    add cpu_cluster.[ch] files into MAINTAINERS Machine core
               section (thanks Eduardo!) [Philippe, Eduardo]

  - patch 1    revert to uint32_t for cluster IDs [Philippe]

  - patch 1    fixed a coding style issue [patchew]

changes since v3:
  - patch 1    cpu_cluster.h: remove QEMU_ from the multiple includes
               guard #ifdef/#define [Alistair]

  - patch 1    cpu_cluster.c: include osdep.h first [Alistair]

  - patch 1    use uint64_t for cluster ID for prosperity :) [Philippe]

  - patch 1    auto-assign a cluster ID to newly created clusters [Philip=
pe]

  - patch 2    fix mid-code variable declaration [Alistair]

  - patch 3    add a comment in gdb_get_cpu_pid() when retrieving CPU
               parent canonical path [Alistair]

  - patch 14   fix a typo in the commit message [Alistair]

changes since v2:
  - patch 1    introducing the cpu-cluster type. I didn't opt for an
               Interface, but I can add one if you think it's necessary.
               For now this class inherits from Device and has a
               cluster-id property, used by the GDB stub to compute a
               PID.

  - patch 2    removed GDB group related code as it has been replaced
               with CPU clusters

  - patch 2/8  moved GDBProcess target_xml field introduction into patch
               8 [Philippe]

  - patch 3    gdb_get_cpu_pid() now search for CPU being a child of a
               cpu-cluster object. Use the cluster-id to compute the PID.

  - patch 4    gdb_get_process() does not rely on s->processes array
               indices anymore as PIDs can now be sparse. Instead, iterat=
e
               over the array to find the process.

  - patch 3/4  removed Reviewed-by tags because of substantial changes.

  - patch 4/7  read_thread_id() hardening [Philippe]

  - patch 12   safer vAttach packet parsing [Phillipe]

  - patch 16   put APUs and RPUs in different clusters instead of GDB
               groups

changes since v1:
  - rename qemu_get_thread_id() to gdb_fmt_thread_id() [Philippe]
  - check qemu_strtoul() return value for 'D' packets [Philippe]


This series adds support for the multiprocess extension of the GDB
remote protocol in the QEMU GDB stub.

This extension is useful to split QEMU emulated CPUs in different
processes from the point of view of the GDB client. It adds the
possibility to debug different kind of processors (e.g. an AArch64 and
an ARMv7 CPU) at the same time (it is not possible otherwise since GDB
expects an SMP view at the thread granularity.

CPUs are grouped using specially named QOM containers. CPUs that are
children of such a container are grouped under the same GDB process.

The last patch groups the CPUs of different model in the zynqmp machines
into separate processes.

To test this patchset, you can use the following commands:

(Note that this requires a recent enough GDB, I think GDB 7.2 is OK.
Also, it must be compiled to support both ARM and AArch64 architectures)

Run QEMU: (-smp 6 in xlnx-zcu102 enables both cortex-a53 and cortex-r5
CPUs)

qemu-system-aarch64 -M xlnx-zcu102 -gdb tcp::1234 -S -smp 6

Run the following commands in GDB:

target extended :1234
add-inferior
inferior 2
attach 2
info threads

I want to thanks the Xilinx's QEMU team who sponsored this work for
their collaboration and their prototype implementation.


Luc Michel (16):
  hw/cpu: introduce CPU clusters
  gdbstub: introduce GDB processes
  gdbstub: add multiprocess support to '?' packets
  gdbstub: add multiprocess support to 'H' and 'T' packets
  gdbstub: add multiprocess support to vCont packets
  gdbstub: add multiprocess support to 'sC' packets
  gdbstub: add multiprocess support to (f|s)ThreadInfo and
    ThreadExtraInfo
  gdbstub: add multiprocess support to Xfer:features:read:
  gdbstub: add multiprocess support to gdb_vm_state_change()
  gdbstub: add multiprocess support to 'D' packets
  gdbstub: add support for extended mode packet
  gdbstub: add support for vAttach packets
  gdbstub: processes initialization on new peer connection
  gdbstub: gdb_set_stop_cpu: ignore request when process is not attached
  gdbstub: add multiprocess extension support
  arm/xlnx-zynqmp: put APUs and RPUs in separate CPU clusters

 include/hw/arm/xlnx-zynqmp.h |   3 +
 include/hw/cpu/cluster.h     |  58 +++
 gdbstub.c                    | 662 +++++++++++++++++++++++++++++++----
 hw/arm/xlnx-zynqmp.c         |  23 +-
 hw/cpu/cluster.c             |  50 +++
 MAINTAINERS                  |   2 +
 hw/cpu/Makefile.objs         |   2 +-
 7 files changed, 719 insertions(+), 81 deletions(-)
 create mode 100644 include/hw/cpu/cluster.h
 create mode 100644 hw/cpu/cluster.c

--=20
2.19.2
