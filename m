Received: from eggs.gnu.org ([2001:4830:134:3::10]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpT-0002R9-Ad
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpQ-0005nc-LL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:35 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Mon,  1 Oct 2018 13:56:49 +0200
Message-Id: <20181001115704.701-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/15] gdbstub: support for the multiprocess
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com

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

Luc Michel (15):
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
  arm/xlnx-zynqmp: put APUs and RPUs in separate GDB groups

 include/exec/gdbstub.h |   8 +
 gdbstub.c              | 594 +++++++++++++++++++++++++++++++++++------
 hw/arm/xlnx-zynqmp.c   |   7 +-
 3 files changed, 531 insertions(+), 78 deletions(-)

--
2.19.0
