Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gNCaE-0004Gf-Dl
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gNCa9-0007nH-AY
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:01:02 -0500
References: <20181110081147.4027-1-luc.michel@greensocs.com>
	<20181110081147.4027-4-luc.michel@greensocs.com>
	<20181113110636.GH1148@toto>
	<a67ef945-2466-155c-0f16-0a1b3b74c9fc@greensocs.com>
	<20181114102723.GC7447@toto>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <c19bf072-701e-823d-52e5-dc11b946319f@greensocs.com>
Date: Thu, 15 Nov 2018 09:00:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181114102723.GC7447@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 03/16] gdbstub: add
 multiprocess support to '?' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org



On 11/14/18 11:27 AM, Edgar E. Iglesias wrote:
> On Wed, Nov 14, 2018 at 09:43:27AM +0100, Luc Michel wrote:
>> Hi Edgar,
>>
>> On 11/13/18 12:06 PM, Edgar E. Iglesias wrote:
>>> On Sat, Nov 10, 2018 at 09:11:34AM +0100, Luc Michel wrote:
>>>> The gdb_get_cpu_pid() function does the PID lookup for the given CPU=
. It
>>>> checks if the CPU is a direct child of a CPU cluster. If it is, the
>>>> returned PID is the cluster ID plus one (cluster IDs start at 0, GDB
>>>> PIDs at 1). When the CPU is not a child of such a container, the PID=
 of
>>>> the first process is returned.
>>>>
>>>> The gdb_fmt_thread_id() function generates the string to be used to =
identify
>>>> a given thread, in a response packet for the peer. This function
>>>> supports generating thread IDs when multiprocess mode is enabled (in=
 the
>>>> form `p<pid>.<tid>').
>>>>
>>>> Use them in the reply to a '?' request.
>>>>
>>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>>>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>>>
>>>
>>> This is also theoretical but:
>>> When looking at this, it seems like you could have lazily created
>>> the s->processes array entries (if you find a cluster but the
>>> no valid entry in s->processes). Then we could perhaps eliminate the
>>> scan of all objects at startup and also support CPU/Cluster hotplug.
>> Yes you are right, this could be an improvement to this series to add
>> cluster hotplug support (CPU hotplug is actually supported). It's a
>> little bit tricky though since we would have to maintain the
>> s->processes array and properly signal to GDB when a process dies.
>=20
> Hi Luc,
>=20
> IMO, support for hotplugging could be added incrementally with follow-u=
p work.
> I wonder if the GDB stub would handle it today, without your patches?
Yes as of today, CPU hotplugging works fine with the GDB stub / GDB
client. I took extra care in this patch series so that it continues to
work correctly (both for system mode, and user mode where 1 QEMU CPU =3D=3D
1 guest thread). The only thing that would need extra care is cluster
hotplugging, which can be added incrementally with follow-up work.

Thanks,
Luc


>=20
> Cheers,
> Edgar
>=20
>=20
>>
>> Cheers,
>> Luc
>>
>>>
>>> Anyway, this looks good to me!
>>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>>
>>> Cheers,
>>> Edgar
>>>
>>>
>>>> ---
>>>>  gdbstub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+--
>>>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/gdbstub.c b/gdbstub.c
>>>> index 0d70b89598..d26bad4b67 100644
>>>> --- a/gdbstub.c
>>>> +++ b/gdbstub.c
>>>> @@ -638,10 +638,52 @@ static int memtox(char *buf, const char *mem, =
int len)
>>>>          }
>>>>      }
>>>>      return p - buf;
>>>>  }
>>>> =20
>>>> +static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
>>>> +{
>>>> +#ifndef CONFIG_USER_ONLY
>>>> +    gchar *path, *name;
>>>> +    Object *obj;
>>>> +    CPUClusterState *cluster;
>>>> +    uint32_t ret;
>>>> +
>>>> +    path =3D object_get_canonical_path(OBJECT(cpu));
>>>> +    name =3D object_get_canonical_path_component(OBJECT(cpu));
>>>> +
>>>> +    if (path =3D=3D NULL) {
>>>> +        ret =3D s->processes[0].pid;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Retrieve the CPU parent path by removing the last '/' and th=
e CPU name
>>>> +     * from the CPU canonical path. */
>>>> +    path[strlen(path) - strlen(name) - 1] =3D '\0';
>>>> +
>>>> +    obj =3D object_resolve_path_type(path, TYPE_CPU_CLUSTER, NULL);
>>>> +
>>>> +    if (obj =3D=3D NULL) {
>>>> +        ret =3D s->processes[0].pid;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    cluster =3D CPU_CLUSTER(obj);
>>>> +    ret =3D cluster->cluster_id + 1;
>>>> +
>>>> +out:
>>>> +    g_free(name);
>>>> +    g_free(path);
>>>> +
>>>> +    return ret;
>>>> +
>>>> +#else
>>>> +    return s->processes[0].pid;
>>>> +#endif
>>>> +}
>>>> +
>>>>  static const char *get_feature_xml(const char *p, const char **newp=
,
>>>>                                     CPUClass *cc)
>>>>  {
>>>>      size_t len;
>>>>      int i;
>>>> @@ -907,10 +949,23 @@ static CPUState *find_cpu(uint32_t thread_id)
>>>>      }
>>>> =20
>>>>      return NULL;
>>>>  }
>>>> =20
>>>> +static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
>>>> +                           char *buf, size_t buf_size)
>>>> +{
>>>> +    if (s->multiprocess) {
>>>> +        snprintf(buf, buf_size, "p%02x.%02x",
>>>> +                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
>>>> +    } else {
>>>> +        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
>>>> +    }
>>>> +
>>>> +    return buf;
>>>> +}
>>>> +
>>>>  static int is_query_packet(const char *p, const char *query, char s=
eparator)
>>>>  {
>>>>      unsigned int query_len =3D strlen(query);
>>>> =20
>>>>      return strncmp(p, query, query_len) =3D=3D 0 &&
>>>> @@ -1018,22 +1073,23 @@ static int gdb_handle_packet(GDBState *s, co=
nst char *line_buf)
>>>>      const char *p;
>>>>      uint32_t thread;
>>>>      int ch, reg_size, type, res;
>>>>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>>>>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>>>> +    char thread_id[16];
>>>>      uint8_t *registers;
>>>>      target_ulong addr, len;
>>>> =20
>>>>      trace_gdbstub_io_command(line_buf);
>>>> =20
>>>>      p =3D line_buf;
>>>>      ch =3D *p++;
>>>>      switch(ch) {
>>>>      case '?':
>>>>          /* TODO: Make this return the correct value for user-mode. =
 */
>>>> -        snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_=
TRAP,
>>>> -                 cpu_gdb_index(s->c_cpu));
>>>> +        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TR=
AP,
>>>> +                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(t=
hread_id)));
>>>>          put_packet(s, buf);
>>>>          /* Remove all the breakpoints when this query is issued,
>>>>           * because gdb is doing and initial connect and the state
>>>>           * should be cleaned up.
>>>>           */
>>>> --=20
>>>> 2.19.1
>>>>
>>>>
