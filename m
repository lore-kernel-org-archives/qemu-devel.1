Received: from eggs.gnu.org ([2001:4830:134:3::10]:59263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gL2Hn-0000MC-E8
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gL2Hl-0002NL-RO
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:37:03 -0500
References: <20181106110548.4209-1-luc.michel@greensocs.com>
	<af576b19-511c-f9e7-cc42-166d63ab6d39@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <49f7bcc1-b615-6889-0d13-b42b4f6686fc@greensocs.com>
Date: Fri, 9 Nov 2018 09:36:44 +0100
MIME-Version: 1.0
In-Reply-To: <af576b19-511c-f9e7-cc42-166d63ab6d39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 11/8/18 5:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/11/18 12:05, Luc Michel wrote:
>> changes since v3:
>> =C2=A0=C2=A0 - patch 1=C2=A0=C2=A0=C2=A0 cpu_cluster.h: remove QEMU_ f=
rom the multiple includes
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 guard #ifdef/#define [Alistair]
>>
>> =C2=A0=C2=A0 - patch 1=C2=A0=C2=A0=C2=A0 cpu_cluster.c: include osdep.=
h first [Alistair]
>>
>> =C2=A0=C2=A0 - patch 1=C2=A0=C2=A0=C2=A0 use uint64_t for cluster ID f=
or prosperity :) [Philippe]
>=20
> Actually my comment about 32-bit had the opposite meaning, I suppose
> having 256 kind of cpu cores in the same SoC is probably enough for a
> long time IMHO.
Oops sorry about that :) I thought you were referring to an old quote
from a guy at Redmond about 640KiB of RAM ;)

A case I was thinking about that would require more than 8- or 16-bit ID
is if for whatever reason we need to model a SoC with sparse
(non-continuous) cluster IDs.

Anyway, I can put back the uint32_t for the next re-roll, I think it's a
good compromise.

Thanks.

Luc

>=20
>>
>> =C2=A0=C2=A0 - patch 1=C2=A0=C2=A0=C2=A0 auto-assign a cluster ID to n=
ewly created clusters
>> [Philippe]
>>
>> =C2=A0=C2=A0 - patch 2=C2=A0=C2=A0=C2=A0 fix mid-code variable declara=
tion [Alistair]
>>
>> =C2=A0=C2=A0 - patch 3=C2=A0=C2=A0=C2=A0 add a comment in gdb_get_cpu_=
pid() when retrieving CPU
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 parent canonical path [Alistair]
>>
>> =C2=A0=C2=A0 - patch 14=C2=A0=C2=A0 fix a typo in the commit message [=
Alistair]
>>
>> changes since v2:
>> =C2=A0=C2=A0 - patch 1=C2=A0=C2=A0=C2=A0 introducing the cpu-cluster t=
ype. I didn't opt for an
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Interface, but I can add one if you think it's necessa=
ry.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 For now this class inherits from Device and has a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cluster-id property, used by the GDB stub to compute a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 PID.
>>
>> =C2=A0=C2=A0 - patch 2=C2=A0=C2=A0=C2=A0 removed GDB group related cod=
e as it has been replaced
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 with CPU clusters
>>
>> =C2=A0=C2=A0 - patch 2/8=C2=A0 moved GDBProcess target_xml field intro=
duction into patch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 8 [Philippe]
>>
>> =C2=A0=C2=A0 - patch 3=C2=A0=C2=A0=C2=A0 gdb_get_cpu_pid() now search =
for CPU being a child of a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cpu-cluster object. Use the cluster-id to compute the
>> PID.
>>
>> =C2=A0=C2=A0 - patch 4=C2=A0=C2=A0=C2=A0 gdb_get_process() does not re=
ly on s->processes array
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 indices anymore as PIDs can now be sparse. Instead,
>> iterate
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 over the array to find the process.
>>
>> =C2=A0=C2=A0 - patch 3/4=C2=A0 removed Reviewed-by tags because of sub=
stantial changes.
>>
>> =C2=A0=C2=A0 - patch 4/7=C2=A0 read_thread_id() hardening [Philippe]
>>
>> =C2=A0=C2=A0 - patch 12=C2=A0=C2=A0 safer vAttach packet parsing [Phil=
lipe]
>>
>> =C2=A0=C2=A0 - patch 16=C2=A0=C2=A0 put APUs and RPUs in different clu=
sters instead of GDB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 groups
>>
>> changes since v1:
>> =C2=A0=C2=A0 - rename qemu_get_thread_id() to gdb_fmt_thread_id() [Phi=
lippe]
>> =C2=A0=C2=A0 - check qemu_strtoul() return value for 'D' packets [Phil=
ippe]
>>
>>
>> This series adds support for the multiprocess extension of the GDB
>> remote protocol in the QEMU GDB stub.
>>
>> This extension is useful to split QEMU emulated CPUs in different
>> processes from the point of view of the GDB client. It adds the
>> possibility to debug different kind of processors (e.g. an AArch64 and
>> an ARMv7 CPU) at the same time (it is not possible otherwise since GDB
>> expects an SMP view at the thread granularity.
>>
>> CPUs are grouped using specially named QOM containers. CPUs that are
>> children of such a container are grouped under the same GDB process.
>>
>> The last patch groups the CPUs of different model in the zynqmp machin=
es
>> into separate processes.
>>
>> To test this patchset, you can use the following commands:
>>
>> (Note that this requires a recent enough GDB, I think GDB 7.2 is OK.
>> Also, it must be compiled to support both ARM and AArch64 architecture=
s)
>>
>> Run QEMU: (-smp 6 in xlnx-zcu102 enables both cortex-a53 and cortex-r5
>> CPUs)
>>
>> qemu-system-aarch64 -M xlnx-zcu102 -gdb tcp::1234 -S -smp 6
>>
>> Run the following commands in GDB:
>>
>> target extended :1234
>> add-inferior
>> inferior 2
>> attach 2
>> info threads
>>
>> I want to thanks the Xilinx's QEMU team who sponsored this work for
>> their collaboration and their prototype implementation.
>>
>> Luc Michel (16):
>> =C2=A0=C2=A0 hw/cpu: introduce CPU clusters
>> =C2=A0=C2=A0 gdbstub: introduce GDB processes
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to '?' packets
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to 'H' and 'T' packets
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to vCont packets
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to 'sC' packets
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to (f|s)ThreadInfo and
>> =C2=A0=C2=A0=C2=A0=C2=A0 ThreadExtraInfo
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to Xfer:features:read:
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to gdb_vm_state_change(=
)
>> =C2=A0=C2=A0 gdbstub: add multiprocess support to 'D' packets
>> =C2=A0=C2=A0 gdbstub: add support for extended mode packet
>> =C2=A0=C2=A0 gdbstub: add support for vAttach packets
>> =C2=A0=C2=A0 gdbstub: processes initialization on new peer connection
>> =C2=A0=C2=A0 gdbstub: gdb_set_stop_cpu: ignore request when process is=
 not attached
>> =C2=A0=C2=A0 gdbstub: add multiprocess extension support
>> =C2=A0=C2=A0 arm/xlnx-zynqmp: put APUs and RPUs in separate CPU cluste=
rs
>>
>> =C2=A0 include/hw/arm/xlnx-zynqmp.h |=C2=A0=C2=A0 3 +
>> =C2=A0 include/hw/cpu/cluster.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 38 +++
>> =C2=A0 gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 632 ++++++=
++++++++++++++++++++++++-----
>> =C2=A0 hw/arm/xlnx-zynqmp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 21 +-
>> =C2=A0 hw/cpu/cluster.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 59 ++++
>> =C2=A0 hw/cpu/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 6 files changed, 674 insertions(+), 81 deletions(-)
>> =C2=A0 create mode 100644 include/hw/cpu/cluster.h
>> =C2=A0 create mode 100644 hw/cpu/cluster.c
>>
