Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gUsl9-0005cY-Bh
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gUsl5-0004F4-1C
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:28:03 -0500
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-4-luc.michel@greensocs.com>
	<970cc3ab-f93b-75c2-f3f0-86a1ddc75ca7@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ef9e6b39-6d3e-230b-6116-3a2cb9a5e1a6@greensocs.com>
Date: Thu, 6 Dec 2018 13:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <970cc3ab-f93b-75c2-f3f0-86a1ddc75ca7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 03/16] gdbstub: add multiprocess support
 to '?' packets
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

On 11/25/18 10:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Luc,
>=20
> On 23/11/18 10:17, Luc Michel wrote:
>> The gdb_get_cpu_pid() function does the PID lookup for the given CPU. =
It
>> checks if the CPU is a direct child of a CPU cluster. If it is, the
>> returned PID is the cluster ID plus one (cluster IDs start at 0, GDB
>> PIDs at 1). When the CPU is not a child of such a container, the PID o=
f
>> the first process is returned.
>>
>> The gdb_fmt_thread_id() function generates the string to be used to id=
entify
>> a given thread, in a response packet for the peer. This function
>> supports generating thread IDs when multiprocess mode is enabled (in t=
he
>> form `p<pid>.<tid>').
>>
>> Use them in the reply to a '?' request.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> ---
>>  gdbstub.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++-=
-
>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 26f5a7449a..4fbc05dfe3 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -638,10 +638,52 @@ static int memtox(char *buf, const char *mem, in=
t len)
>>          }
>>      }
>>      return p - buf;
>>  }
>> =20
>> +static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
>> +{
>> +#ifndef CONFIG_USER_ONLY
>> +    gchar *path, *name;
>=20
> Setting ...
>=20
>        gchar *path, *name =3D NULL;
>=20
>> +    Object *obj;
>> +    CPUClusterState *cluster;
>> +    uint32_t ret;
>> +
>> +    path =3D object_get_canonical_path(OBJECT(cpu));
>> +    name =3D object_get_canonical_path_component(OBJECT(cpu));
>=20
> ... we might move this line ...
>=20
>> +
>> +    if (path =3D=3D NULL) {
>> +        ret =3D s->processes[0].pid;
>> +        goto out;
>> +    }
>=20
> ... hereOK I'll change that.
>=20
>        name =3D object_get_canonical_path_component(OBJECT(cpu));
>=20
>> +
>> +    /*
>> +     * Retrieve the CPU parent path by removing the last '/' and the =
CPU name
>> +     * from the CPU canonical path. */
>> +    path[strlen(path) - strlen(name) - 1] =3D '\0';
>=20
> Can we get there with path !=3D NULL && name =3D=3D NULL?
I think the only way we could end up in this case is if cpu =3D=3D
object_get_root(), which does not make much sense. I can add an
assert(name !=3D NULL) here to enforce that.

>=20
>> +
>> +    obj =3D object_resolve_path_type(path, TYPE_CPU_CLUSTER, NULL);
>> +
>> +    if (obj =3D=3D NULL) {
>> +        ret =3D s->processes[0].pid;
>> +        goto out;
>> +    }
>> +
>> +    cluster =3D CPU_CLUSTER(obj);
>> +    ret =3D cluster->cluster_id + 1;
>> +
>> +out:
>> +    g_free(name);
>> +    g_free(path);
>> +
>> +    return ret;
>> +
>> +#else
>=20
> [*]
>=20
>> +    return s->processes[0].pid;
>> +#endif
>> +}
>> +
>>  static const char *get_feature_xml(const char *p, const char **newp,
>>                                     CPUClass *cc)
>>  {
>>      size_t len;
>>      int i;
>> @@ -907,10 +949,23 @@ static CPUState *find_cpu(uint32_t thread_id)
>>      }
>> =20
>>      return NULL;
>>  }
>> =20
>> +static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
>> +                           char *buf, size_t buf_size)
>> +{
>> +    if (s->multiprocess) {
>> +        snprintf(buf, buf_size, "p%02x.%02x",
>> +                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
>> +    } else {
>> +        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
>> +    }
>> +
>> +    return buf;
>> +}
>> +
>>  static int is_query_packet(const char *p, const char *query, char sep=
arator)
>>  {
>>      unsigned int query_len =3D strlen(query);
>> =20
>>      return strncmp(p, query, query_len) =3D=3D 0 &&
>> @@ -1018,22 +1073,23 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>>      const char *p;
>>      uint32_t thread;
>>      int ch, reg_size, type, res;
>>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>> +    char thread_id[16];
>>      uint8_t *registers;
>>      target_ulong addr, len;
>> =20
>>      trace_gdbstub_io_command(line_buf);
>> =20
>>      p =3D line_buf;
>>      ch =3D *p++;
>>      switch(ch) {
>>      case '?':
>>          /* TODO: Make this return the correct value for user-mode.  *=
/
>=20
> Is this comment still relevant?
>=20
> If so, wouldn't it be better placed in [*]?
git blame shows that at the time when this comment was added
(1fddef4b1ba from 2005), the Stop Reply packet was like this:

+        /* TODO: Make this return the correct value for user-mode.  */
         snprintf(buf, sizeof(buf), "S%02x", SIGTRAP);

Which is the form that contains only a signal number. So this comment
must refer to this hard-coded signal, so I think it is still valid :-)

However, you are right pointing out that the PID used in user-mode
should probably be the one of the QEMU process running the guest binary
(as it is done for TIDs I believe). I'll add a comment at [*] to point
that out.

Thanks.

--=20
Luc

>=20
>> -        snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TR=
AP,
>> -                 cpu_gdb_index(s->c_cpu));
>> +        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP=
,
>> +                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thr=
ead_id)));
>>          put_packet(s, buf);
>>          /* Remove all the breakpoints when this query is issued,
>>           * because gdb is doing and initial connect and the state
>>           * should be cleaned up.
>>           */
>>
