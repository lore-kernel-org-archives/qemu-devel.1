Received: from eggs.gnu.org ([2001:4830:134:3::10]:39318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gOeoJ-0003a1-Td
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gOeku-00076X-H1
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:18:12 -0500
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-5-luc.michel@greensocs.com>
	<20181116095145.GN7447@toto>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <797bdbb4-ac82-d011-b2fc-3d4fdbef4950@greensocs.com>
Date: Mon, 19 Nov 2018 09:17:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181116095145.GN7447@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/16] gdbstub: add multiprocess support
 to 'H' and 'T' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>



On 11/16/18 10:51 AM, Edgar E. Iglesias wrote:
> On Thu, Nov 15, 2018 at 10:41:55AM +0100, Luc Michel wrote:
>> Add a couple of helper functions to cope with GDB threads and processe=
s.
>>
>> The gdb_get_process() function looks for a process given a pid.
>>
>> The gdb_get_cpu() function returns the CPU corresponding to the (pid,
>> tid) pair given as parameters.
>>
>> The read_thread_id() function parses the thread-id sent by the peer.
>> This function supports the multiprocess extension thread-id syntax.  T=
he
>> return value specifies if the parsing failed, or if a special case was
>> encountered (all processes or all threads).
>>
>> Use them in 'H' and 'T' packets handling to support the multiprocess
>> extension.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>=20
> Hi Luc,
>=20
>=20
>=20
>> ---
>>  gdbstub.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++------=
-
>>  1 file changed, 134 insertions(+), 18 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 4fbc05dfe3..fa2b7077b2 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -680,10 +680,73 @@ out:
>>  #else
>>      return s->processes[0].pid;
>>  #endif
>>  }
>> =20
>> +static GDBProcess *gdb_get_process(const GDBState *s, uint32_t pid)
>> +{
>> +    int i;
>> +
>> +    if (!pid) {
>> +        /* 0 means any process, we take the first one */
>> +        return &s->processes[0];
>> +    }
>> +
>> +    for (i =3D 0; i < s->process_num; i++) {
>> +        if (s->processes[i].pid =3D=3D pid) {
>> +            return &s->processes[i];
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static GDBProcess *gdb_get_cpu_process(const GDBState *s, CPUState *c=
pu)
>> +{
>> +    return gdb_get_process(s, gdb_get_cpu_pid(s, cpu));
>> +}
>> +
>> +static CPUState *find_cpu(uint32_t thread_id)
>> +{
>> +    CPUState *cpu;
>> +
>> +    CPU_FOREACH(cpu) {
>> +        if (cpu_gdb_index(cpu) =3D=3D thread_id) {
>> +            return cpu;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_=
t tid)
>> +{
>> +    GDBProcess *process;
>> +    CPUState *cpu =3D find_cpu(tid);
>> +
>> +    if (!tid) {
>> +        /* 0 means any thread, we take the first one */
>> +        tid =3D 1;
>> +    }
>> +
>> +    if (cpu =3D=3D NULL) {
>> +        return NULL;
>> +    }
>=20
> Not sure about this. If tid is zero, you fix up the wildcard by setting=
 tid to one.
> Shouldn't you also retry find_cpu(tid) in that case?
>=20
> Otherwise, tid doesn't seem to be used after the wildcard fixup.
Thanks for catching this. It's a refactoring mistake. It will be fixed
in the next re-roll.

--=20
Luc

>=20
> Other than that, I think this looks good:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>=20
>=20
>=20
>> +
>> +    process =3D gdb_get_cpu_process(s, cpu);
>> +
>> +    if (process->pid !=3D pid) {
>> +        return NULL;
>> +    }
>> +
>> +    if (!process->attached) {
>> +        return NULL;
>> +    }
>> +
>> +    return cpu;
>> +}
>> +
>>  static const char *get_feature_xml(const char *p, const char **newp,
>>                                     CPUClass *cc)
>>  {
>>      size_t len;
>>      int i;
>> @@ -936,23 +999,10 @@ static void gdb_set_cpu_pc(GDBState *s, target_u=
long pc)
>> =20
>>      cpu_synchronize_state(cpu);
>>      cpu_set_pc(cpu, pc);
>>  }
>> =20
>> -static CPUState *find_cpu(uint32_t thread_id)
>> -{
>> -    CPUState *cpu;
>> -
>> -    CPU_FOREACH(cpu) {
>> -        if (cpu_gdb_index(cpu) =3D=3D thread_id) {
>> -            return cpu;
>> -        }
>> -    }
>> -
>> -    return NULL;
>> -}
>> -
>>  static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
>>                             char *buf, size_t buf_size)
>>  {
>>      if (s->multiprocess) {
>>          snprintf(buf, buf_size, "p%02x.%02x",
>> @@ -962,10 +1012,64 @@ static char *gdb_fmt_thread_id(const GDBState *=
s, CPUState *cpu,
>>      }
>> =20
>>      return buf;
>>  }
>> =20
>> +typedef enum GDBThreadIdKind {
>> +    GDB_ONE_THREAD =3D 0,
>> +    GDB_ALL_THREADS,     /* One process, all threads */
>> +    GDB_ALL_PROCESSES,
>> +    GDB_READ_THREAD_ERR
>> +} GDBThreadIdKind;
>> +
>> +static GDBThreadIdKind read_thread_id(const char *buf, const char **e=
nd_buf,
>> +                                      uint32_t *pid, uint32_t *tid)
>> +{
>> +    unsigned long p, t;
>> +    int ret;
>> +
>> +    if (*buf =3D=3D 'p') {
>> +        buf++;
>> +        ret =3D qemu_strtoul(buf, &buf, 16, &p);
>> +
>> +        if (ret) {
>> +            return GDB_READ_THREAD_ERR;
>> +        }
>> +
>> +        /* Skip '.' */
>> +        buf++;
>> +    } else {
>> +        p =3D 1;
>> +    }
>> +
>> +    ret =3D qemu_strtoul(buf, &buf, 16, &t);
>> +
>> +    if (ret) {
>> +        return GDB_READ_THREAD_ERR;
>> +    }
>> +
>> +    *end_buf =3D buf;
>> +
>> +    if (p =3D=3D -1) {
>> +        return GDB_ALL_PROCESSES;
>> +    }
>> +
>> +    if (pid) {
>> +        *pid =3D p;
>> +    }
>> +
>> +    if (t =3D=3D -1) {
>> +        return GDB_ALL_THREADS;
>> +    }
>> +
>> +    if (tid) {
>> +        *tid =3D t;
>> +    }
>> +
>> +    return GDB_ONE_THREAD;
>> +}
>> +
>>  static int is_query_packet(const char *p, const char *query, char sep=
arator)
>>  {
>>      unsigned int query_len =3D strlen(query);
>> =20
>>      return strncmp(p, query, query_len) =3D=3D 0 &&
>> @@ -1070,16 +1174,18 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>>  {
>>      CPUState *cpu;
>>      CPUClass *cc;
>>      const char *p;
>>      uint32_t thread;
>> +    uint32_t pid, tid;
>>      int ch, reg_size, type, res;
>>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>>      char thread_id[16];
>>      uint8_t *registers;
>>      target_ulong addr, len;
>> +    GDBThreadIdKind thread_kind;
>> =20
>>      trace_gdbstub_io_command(line_buf);
>> =20
>>      p =3D line_buf;
>>      ch =3D *p++;
>> @@ -1283,16 +1389,22 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>>          else
>>              put_packet(s, "E22");
>>          break;
>>      case 'H':
>>          type =3D *p++;
>> -        thread =3D strtoull(p, (char **)&p, 16);
>> -        if (thread =3D=3D -1 || thread =3D=3D 0) {
>> +
>> +        thread_kind =3D read_thread_id(p, &p, &pid, &tid);
>> +        if (thread_kind =3D=3D GDB_READ_THREAD_ERR) {
>> +            put_packet(s, "E22");
>> +            break;
>> +        }
>> +
>> +        if (thread_kind !=3D GDB_ONE_THREAD) {
>>              put_packet(s, "OK");
>>              break;
>>          }
>> -        cpu =3D find_cpu(thread);
>> +        cpu =3D gdb_get_cpu(s, pid, tid);
>>          if (cpu =3D=3D NULL) {
>>              put_packet(s, "E22");
>>              break;
>>          }
>>          switch (type) {
>> @@ -1308,12 +1420,16 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>>               put_packet(s, "E22");
>>               break;
>>          }
>>          break;
>>      case 'T':
>> -        thread =3D strtoull(p, (char **)&p, 16);
>> -        cpu =3D find_cpu(thread);
>> +        thread_kind =3D read_thread_id(p, &p, &pid, &tid);
>> +        if (thread_kind =3D=3D GDB_READ_THREAD_ERR) {
>> +            put_packet(s, "E22");
>> +            break;
>> +        }
>> +        cpu =3D gdb_get_cpu(s, pid, tid);
>> =20
>>          if (cpu !=3D NULL) {
>>              put_packet(s, "OK");
>>          } else {
>>              put_packet(s, "E22");
>> --=20
>> 2.19.1
>>
