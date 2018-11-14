Received: from eggs.gnu.org ([2001:4830:134:3::10]:51312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gMsCD-0004OZ-DO
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gMsCC-0000tq-0i
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:14:53 -0500
References: <20181110081147.4027-1-luc.michel@greensocs.com>
	<20181110081147.4027-3-luc.michel@greensocs.com>
	<20181113105216.GG1148@toto>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <2785510b-5db5-7ded-2404-7d5653a98764@greensocs.com>
Date: Wed, 14 Nov 2018 11:14:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181113105216.GG1148@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 02/16] gdbstub: introduce GDB
 processes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi Edgar,

On 11/13/18 11:52 AM, Edgar E. Iglesias wrote:
> On Sat, Nov 10, 2018 at 09:11:33AM +0100, Luc Michel wrote:
>> Add a structure GDBProcess that represent processes from the GDB
>> semantic point of view.
>>
>> CPUs can be split into different processes, by grouping them under
>> different cpu-cluster objects.  Each occurrence of a cpu-cluster objec=
t
>> implies the existence of the corresponding process in the GDB stub. Th=
e
>> GDB process ID is derived from the corresponding cluster ID as follows=
:
>>
>>   GDB PID =3D cluster ID + 1
>>
>> This is because PIDs -1 and 0 are reserved in GDB and cannot be used b=
y
>> processes.
>>
>> When no such container are found, all the CPUs are put in a unique GDB
>> process (create_unique_process()). This is also the case when compiled
>> in user mode, where multi-processes do not make much sense for now.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  gdbstub.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index c4e4f9f082..0d70b89598 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -27,10 +27,11 @@
>>  #include "monitor/monitor.h"
>>  #include "chardev/char.h"
>>  #include "chardev/char-fe.h"
>>  #include "sysemu/sysemu.h"
>>  #include "exec/gdbstub.h"
>> +#include "hw/cpu/cluster.h"
>>  #endif
>> =20
>>  #define MAX_PACKET_LENGTH 4096
>> =20
>>  #include "qemu/sockets.h"
>> @@ -294,10 +295,15 @@ typedef struct GDBRegisterState {
>>      gdb_reg_cb set_reg;
>>      const char *xml;
>>      struct GDBRegisterState *next;
>>  } GDBRegisterState;
>> =20
>> +typedef struct GDBProcess {
>> +    uint32_t pid;
>> +    bool attached;
>> +} GDBProcess;
>> +
>>  enum RSState {
>>      RS_INACTIVE,
>>      RS_IDLE,
>>      RS_GETLINE,
>>      RS_GETLINE_ESC,
>> @@ -322,10 +328,13 @@ typedef struct GDBState {
>>      int running_state;
>>  #else
>>      CharBackend chr;
>>      Chardev *mon_chr;
>>  #endif
>> +    bool multiprocess;
>> +    GDBProcess *processes;
>> +    int process_num;
>>      char syscall_buf[256];
>>      gdb_syscall_complete_cb current_syscall_cb;
>>  } GDBState;
>> =20
>>  /* By default use no IRQs and no timers while single stepping so as t=
o
>> @@ -1749,10 +1758,24 @@ void gdb_exit(CPUArchState *env, int code)
>>  #ifndef CONFIG_USER_ONLY
>>    qemu_chr_fe_deinit(&s->chr, true);
>>  #endif
>>  }
>> =20
>> +/*
>> + * Create a unique process containing all the CPUs.
>> + */
>> +static void create_unique_process(GDBState *s)
>> +{
>> +    GDBProcess *process;
>> +
>> +    s->processes =3D g_malloc0(sizeof(GDBProcess));
>> +    s->process_num =3D 1;
>> +    process =3D &s->processes[0];
>> +
>> +    process->pid =3D 1;
>> +}
>> +
>>  #ifdef CONFIG_USER_ONLY
>>  int
>>  gdb_handlesig(CPUState *cpu, int sig)
>>  {
>>      GDBState *s;
>> @@ -1846,10 +1869,11 @@ static bool gdb_accept(void)
>>      }
>> =20
>>      s =3D g_malloc0(sizeof(GDBState));
>>      s->c_cpu =3D first_cpu;
>>      s->g_cpu =3D first_cpu;
>> +    create_unique_process(s);
>>      s->fd =3D fd;
>>      gdb_has_xml =3D false;
>> =20
>>      gdbserver_state =3D s;
>>      return true;
>> @@ -2002,10 +2026,58 @@ static const TypeInfo char_gdb_type_info =3D {
>>      .name =3D TYPE_CHARDEV_GDB,
>>      .parent =3D TYPE_CHARDEV,
>>      .class_init =3D char_gdb_class_init,
>>  };
>> =20
>> +static int find_cpu_clusters(Object *child, void *opaque)
>> +{
>> +    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
>> +        GDBState *s =3D (GDBState *) opaque;
>> +        CPUClusterState *cluster =3D CPU_CLUSTER(child);
>> +        GDBProcess *process;
>> +
>> +        s->processes =3D g_renew(GDBProcess, s->processes, ++s->proce=
ss_num);
>> +
>> +        process =3D &s->processes[s->process_num - 1];
>> +
>> +        /* GDB process IDs -1 and 0 are reserved */
>> +        process->pid =3D cluster->cluster_id + 1;
>=20
> This may be theoretical but since both pid and cluster_id are uint32_t
> you may end up with 0 here.
>=20
> You may want to limit cluster_id's to something like the range 0 - INT3=
2_MAX.
That would be an efficient solution to workaround this problem. However
it seems a bit artificial to limit the cluster_id range in the "generic"
CPU_CLUSTER class, just for the GDB stub code to work correctly.

Another solution could be to add a `gdb_pid' property to the CPU_CLUSTER
type, that would automatically be set to `cpu_cluster + 1' during
realization (and customized by the platform if needed). That way, value
0 could be explicitly forbidden in the CPU_CLUSTER API. However, Peter
was not a big fan of having explicit GDB stuff in the platform.

If somebody comes with a good compromise, I can change this. Otherwise
if we want to be extra safe, maybe we can simply assert that cluster_id
UINT32_MAX is not used in GDB stub.

(snip)
>> +static int pid_order(const void *a, const void *b)
>> +{
>> +    GDBProcess *pa =3D (GDBProcess *) a;
>> +    GDBProcess *pb =3D (GDBProcess *) b;
>> +
>> +    return pa->pid - pb->pid;
>=20
> Similarly here, is this safe?
> e.g:
> pa->pid =3D 1
> pb->pid =3D 0x80000002
To make it safe, I think we can do explicit comparisons:

if (pa->pid < pb->pid) {
    return -1;
} else if (pa->pid > pb->pid) {
    return 1;
} else {
    return 0;
}


Thanks,
Luc

>=20
>=20
> Otherwise:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>=20
>=20
>=20
>> +}
>> +
>> +static void create_processes(GDBState *s)
>> +{
>> +    object_child_foreach(object_get_root(), find_cpu_clusters, s);
>> +
>> +    if (!s->processes) {
>> +        /* No CPU cluster specified by the machine */
>> +        create_unique_process(s);
>> +    } else {
>> +        /* Sort by PID */
>> +        qsort(s->processes, s->process_num, sizeof(s->processes[0]), =
pid_order);
>> +    }
>> +}
>> +
>> +static void cleanup_processes(GDBState *s)
>> +{
>> +    g_free(s->processes);
>> +    s->process_num =3D 0;
>> +    s->processes =3D NULL;
>> +}
>> +
>>  int gdbserver_start(const char *device)
>>  {
>>      trace_gdbstub_op_start(device);
>> =20
>>      GDBState *s;
>> @@ -2058,15 +2130,19 @@ int gdbserver_start(const char *device)
>>                                     NULL, &error_abort);
>>          monitor_init(mon_chr, 0);
>>      } else {
>>          qemu_chr_fe_deinit(&s->chr, true);
>>          mon_chr =3D s->mon_chr;
>> +        cleanup_processes(s);
>>          memset(s, 0, sizeof(GDBState));
>>          s->mon_chr =3D mon_chr;
>>      }
>>      s->c_cpu =3D first_cpu;
>>      s->g_cpu =3D first_cpu;
>> +
>> +    create_processes(s);
>> +
>>      if (chr) {
>>          qemu_chr_fe_init(&s->chr, chr, &error_abort);
>>          qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_ch=
r_receive,
>>                                   gdb_chr_event, NULL, NULL, NULL, tru=
e);
>>      }
>> --=20
>> 2.19.1
>>
>>
