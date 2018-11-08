Received: from eggs.gnu.org ([2001:4830:134:3::10]:59541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKmsR-0005V3-Ur
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKmsO-0000uZ-5o
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKmsN-0000qI-Qv
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so21857549wrv.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 08:09:42 -0800 (PST)
References: <20181106110548.4209-1-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <af576b19-511c-f9e7-cc42-166d63ab6d39@redhat.com>
Date: Thu, 8 Nov 2018 17:09:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181106110548.4209-1-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/16] gdbstub: support for the
 multiprocess extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 6/11/18 12:05, Luc Michel wrote:
> changes since v3:
>    - patch 1    cpu_cluster.h: remove QEMU_ from the multiple includes
>                 guard #ifdef/#define [Alistair]
> 
>    - patch 1    cpu_cluster.c: include osdep.h first [Alistair]
> 
>    - patch 1    use uint64_t for cluster ID for prosperity :) [Philippe]

Actually my comment about 32-bit had the opposite meaning, I suppose 
having 256 kind of cpu cores in the same SoC is probably enough for a 
long time IMHO.

> 
>    - patch 1    auto-assign a cluster ID to newly created clusters [Philippe]
> 
>    - patch 2    fix mid-code variable declaration [Alistair]
> 
>    - patch 3    add a comment in gdb_get_cpu_pid() when retrieving CPU
>                 parent canonical path [Alistair]
> 
>    - patch 14   fix a typo in the commit message [Alistair]
> 
> changes since v2:
>    - patch 1    introducing the cpu-cluster type. I didn't opt for an
>                 Interface, but I can add one if you think it's necessary.
>                 For now this class inherits from Device and has a
>                 cluster-id property, used by the GDB stub to compute a
>                 PID.
> 
>    - patch 2    removed GDB group related code as it has been replaced
>                 with CPU clusters
> 
>    - patch 2/8  moved GDBProcess target_xml field introduction into patch
>                 8 [Philippe]
> 
>    - patch 3    gdb_get_cpu_pid() now search for CPU being a child of a
>                 cpu-cluster object. Use the cluster-id to compute the PID.
> 
>    - patch 4    gdb_get_process() does not rely on s->processes array
>                 indices anymore as PIDs can now be sparse. Instead, iterate
>                 over the array to find the process.
> 
>    - patch 3/4  removed Reviewed-by tags because of substantial changes.
> 
>    - patch 4/7  read_thread_id() hardening [Philippe]
> 
>    - patch 12   safer vAttach packet parsing [Phillipe]
> 
>    - patch 16   put APUs and RPUs in different clusters instead of GDB
>                 groups
> 
> changes since v1:
>    - rename qemu_get_thread_id() to gdb_fmt_thread_id() [Philippe]
>    - check qemu_strtoul() return value for 'D' packets [Philippe]
> 
> 
> This series adds support for the multiprocess extension of the GDB
> remote protocol in the QEMU GDB stub.
> 
> This extension is useful to split QEMU emulated CPUs in different
> processes from the point of view of the GDB client. It adds the
> possibility to debug different kind of processors (e.g. an AArch64 and
> an ARMv7 CPU) at the same time (it is not possible otherwise since GDB
> expects an SMP view at the thread granularity.
> 
> CPUs are grouped using specially named QOM containers. CPUs that are
> children of such a container are grouped under the same GDB process.
> 
> The last patch groups the CPUs of different model in the zynqmp machines
> into separate processes.
> 
> To test this patchset, you can use the following commands:
> 
> (Note that this requires a recent enough GDB, I think GDB 7.2 is OK.
> Also, it must be compiled to support both ARM and AArch64 architectures)
> 
> Run QEMU: (-smp 6 in xlnx-zcu102 enables both cortex-a53 and cortex-r5
> CPUs)
> 
> qemu-system-aarch64 -M xlnx-zcu102 -gdb tcp::1234 -S -smp 6
> 
> Run the following commands in GDB:
> 
> target extended :1234
> add-inferior
> inferior 2
> attach 2
> info threads
> 
> I want to thanks the Xilinx's QEMU team who sponsored this work for
> their collaboration and their prototype implementation.
> 
> Luc Michel (16):
>    hw/cpu: introduce CPU clusters
>    gdbstub: introduce GDB processes
>    gdbstub: add multiprocess support to '?' packets
>    gdbstub: add multiprocess support to 'H' and 'T' packets
>    gdbstub: add multiprocess support to vCont packets
>    gdbstub: add multiprocess support to 'sC' packets
>    gdbstub: add multiprocess support to (f|s)ThreadInfo and
>      ThreadExtraInfo
>    gdbstub: add multiprocess support to Xfer:features:read:
>    gdbstub: add multiprocess support to gdb_vm_state_change()
>    gdbstub: add multiprocess support to 'D' packets
>    gdbstub: add support for extended mode packet
>    gdbstub: add support for vAttach packets
>    gdbstub: processes initialization on new peer connection
>    gdbstub: gdb_set_stop_cpu: ignore request when process is not attached
>    gdbstub: add multiprocess extension support
>    arm/xlnx-zynqmp: put APUs and RPUs in separate CPU clusters
> 
>   include/hw/arm/xlnx-zynqmp.h |   3 +
>   include/hw/cpu/cluster.h     |  38 +++
>   gdbstub.c                    | 632 ++++++++++++++++++++++++++++++-----
>   hw/arm/xlnx-zynqmp.c         |  21 +-
>   hw/cpu/cluster.c             |  59 ++++
>   hw/cpu/Makefile.objs         |   2 +-
>   6 files changed, 674 insertions(+), 81 deletions(-)
>   create mode 100644 include/hw/cpu/cluster.h
>   create mode 100644 hw/cpu/cluster.c
> 
