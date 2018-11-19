Received: from eggs.gnu.org ([2001:4830:134:3::10]:59963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gOmmN-0001B8-Q2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gOmfg-0007RC-LI
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:45:13 -0500
Date: Mon, 19 Nov 2018 17:44:55 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181119164455.GB7447@toto>
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-8-luc.michel@greensocs.com>
	<20181116100407.GQ7447@toto>
	<d4fc764e-f23f-0154-f6f5-29b509422b7b@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d4fc764e-f23f-0154-f6f5-29b509422b7b@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/16] gdbstub: add multiprocess support
 to (f|s)ThreadInfo and ThreadExtraInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Nov 19, 2018 at 11:12:45AM +0100, Luc Michel wrote:
>=20
>=20
> On 11/16/18 11:04 AM, Edgar E. Iglesias wrote:
> > On Thu, Nov 15, 2018 at 10:41:58AM +0100, Luc Michel wrote:
> >> Change the thread info related packets handling to support multiproces=
s
> >> extension.
> >>
> >> Add the CPUs class name in the extra info to help differentiate
> >> them in multiprocess mode.
> >>
> >> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> >> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >> ---
> >>  gdbstub.c | 35 +++++++++++++++++++++++++----------
> >>  1 file changed, 25 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/gdbstub.c b/gdbstub.c
> >> index d19b0137e8..292dee8914 100644
> >> --- a/gdbstub.c
> >> +++ b/gdbstub.c
> >> @@ -1260,11 +1260,10 @@ out:
> >>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >>  {
> >>      CPUState *cpu;
> >>      CPUClass *cc;
> >>      const char *p;
> >> -    uint32_t thread;
> >>      uint32_t pid, tid;
> >>      int ch, reg_size, type, res;
> >>      uint8_t mem_buf[MAX_PACKET_LENGTH];
> >>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> >>      char thread_id[16];
> >> @@ -1556,30 +1555,46 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
> >>              snprintf(buf, sizeof(buf), "QC%s",
> >>                       gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thre=
ad_id)));
> >>              put_packet(s, buf);
> >>              break;
> >>          } else if (strcmp(p,"fThreadInfo") =3D=3D 0) {
> >> -            s->query_cpu =3D first_cpu;
> >> +            s->query_cpu =3D gdb_first_cpu(s);
> >>              goto report_cpuinfo;
> >>          } else if (strcmp(p,"sThreadInfo") =3D=3D 0) {
> >>          report_cpuinfo:
> >>              if (s->query_cpu) {
> >> -                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->qu=
ery_cpu));
> >> +                snprintf(buf, sizeof(buf), "m%s",
> >> +                         gdb_fmt_thread_id(s, s->query_cpu,
> >> +                                       thread_id, sizeof(thread_id)))=
;
> >>                  put_packet(s, buf);
> >> -                s->query_cpu =3D CPU_NEXT(s->query_cpu);
> >> +                s->query_cpu =3D gdb_next_cpu(s, s->query_cpu);
> >>              } else
> >>                  put_packet(s, "l");
> >>              break;
> >>          } else if (strncmp(p,"ThreadExtraInfo,", 16) =3D=3D 0) {
> >> -            thread =3D strtoull(p+16, (char **)&p, 16);
> >> -            cpu =3D find_cpu(thread);
> >> +            if (read_thread_id(p + 16, &p, &pid, &tid) =3D=3D GDB_REA=
D_THREAD_ERR) {
> >> +                put_packet(s, "E22");
> >> +                break;
> >> +            }
> >> +            cpu =3D gdb_get_cpu(s, pid, tid);
> >>              if (cpu !=3D NULL) {
> >>                  cpu_synchronize_state(cpu);
> >> -                /* memtohex() doubles the required space */
> >> -                len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
> >> -                               "CPU#%d [%s]", cpu->cpu_index,
> >> -                               cpu->halted ? "halted " : "running");
> >> +
> >> +                if (s->multiprocess && (s->process_num > 1)) {
> >> +                    /* Print the CPU model in multiprocess mode */
> >> +                    ObjectClass *oc =3D object_get_class(OBJECT(cpu))=
;
> >> +                    const char *cpu_model =3D object_class_get_name(o=
c);
> >> +                    len =3D snprintf((char *)mem_buf, sizeof(buf) / 2=
,
> >> +                                   "CPU#%d %s [%s]", cpu->cpu_index,
> >> +                                   cpu_model,
> >> +                                   cpu->halted ? "halted " : "running=
");
> >=20
> >=20
> >=20
> > I wonder if we could also print a friendly name here deducted from QOM?
> > In some of our use-cases we have an array of MicroBlazes that all live
> > in different HW subsystems and are named differently (e.g CSU, PMU, PMC=
,
> > PSM etc).
> >=20
> > Instead of just seeing a list of MicroBlaze cores it may be more useful
> > to see the actual core name of some sort, e.g:
> >=20
> > Instead of:
> > CPU#0 MicroBlaze [running]
> > CPU#1 MicroBlaze [running]
> > CPU#2 MicroBlaze [running]
> > CPU#3 MicroBlaze [running]
> >=20
> > Perhaps something like:
> > CPU#0 MicroBlaze PMU [running]
> > CPU#1 MicroBlaze PMC-PPU0 [running]
> > CPU#2 MicroBlaze PMC-PPU1 [running]
> > CPU#3 MicroBlaze PSM [running]
> >=20
> > Any thoughts on that?
> I wanted to avoid the ThreadExtraInfo packet to become too much cluttered=
.
>=20
> Here are some tests adding the component part of the CPU canonical name:
>=20
> (gdb) info threads
>   Id   Target Id         Frame
>   1.1  Thread 1.1 (CPU#0 cortex-a53-arm-cpu apu-cpu[0] [running])
> 0x0000000000000000 in ?? ()
>   1.2  Thread 1.2 (CPU#1 cortex-a53-arm-cpu apu-cpu[1] [halted ])
> 0x0000000000000000 in ?? ()
>   1.3  Thread 1.3 (CPU#2 cortex-a53-arm-cpu apu-cpu[2] [halted ])
> 0x0000000000000000 in ?? ()
>   1.4  Thread 1.4 (CPU#3 cortex-a53-arm-cpu apu-cpu[3] [halted ])
> 0x0000000000000000 in ?? ()
> * 2.1  Thread 2.5 (CPU#4 cortex-r5f-arm-cpu rpu-cpu[0] [halted ])
> 0xffff0000 in ?? ()
>   2.2  Thread 2.6 (CPU#5 cortex-r5f-arm-cpu rpu-cpu[1] [halted ])
> 0xffff0000 in ?? ()
>=20
> The model name takes quite some room. The interesting info are `arm` and
> `cortex-xxx`, but AFAIK there is no way of extracting that for a CPU
> generically.
>=20
> In this case, having the component part of the canonical name is ok
> because self-explanatory. However we could encounter cases where the
> parent name would be necessary to discriminate the CPUs, something like:
>   cluster[0]/cpu[0]
>             /cpu[1]
>   cluster[1]/cpu[0]
>             /cpu[1]
>   ...
>=20
> The "safest" way would be to have the whole path:
>=20
> (gdb) info threads
>   Id   Target Id         Frame
>   1.1  Thread 1.1 (CPU#0 cortex-a53-arm-cpu
> /machine/soc/apu-cluster/apu-cpu[0] [running]) 0x0000000000000000 in ?? (=
)
>   1.2  Thread 1.2 (CPU#1 cortex-a53-arm-cpu
> /machine/soc/apu-cluster/apu-cpu[1] [halted ]) 0x0000000000000000 in ?? (=
)
>   1.3  Thread 1.3 (CPU#2 cortex-a53-arm-cpu
> /machine/soc/apu-cluster/apu-cpu[2] [halted ]) 0x0000000000000000 in ?? (=
)
>   1.4  Thread 1.4 (CPU#3 cortex-a53-arm-cpu
> /machine/soc/apu-cluster/apu-cpu[3] [halted ]) 0x0000000000000000 in ?? (=
)
> * 2.1  Thread 2.5 (CPU#4 cortex-r5f-arm-cpu
> /machine/soc/rpu-cluster/rpu-cpu[0] [halted ]) 0xffff0000 in ?? ()
>   2.2  Thread 2.6 (CPU#5 cortex-r5f-arm-cpu
> /machine/soc/rpu-cluster/rpu-cpu[1] [halted ]) 0xffff0000 in ?? ()
>=20
> But that becomes really cluttered... We could also remove the CPU model
> completely.
>=20
> What are your thoughts?

Thanks Luc,

Not sure...

(CPU#0 cortex-a53-arm-cpu apu-cpu[0] [running])

Looks a little long but I think still the better option here. Would be inte=
resting to hear others opinion.

Also, would it make sense to remove the CPU#X alltogether here?
It's not of much use in GDB since we controll things by process and thread =
anyway...

Cheers,
Edgar



>=20
> Thanks,
> Luc
>=20
> >=20
> > Thanks,
> > Edgar
> >=20
> >> +                } else {
> >> +                    /* memtohex() doubles the required space */
> >> +                    len =3D snprintf((char *)mem_buf, sizeof(buf) / 2=
,
> >> +                                   "CPU#%d [%s]", cpu->cpu_index,
> >> +                                   cpu->halted ? "halted " : "running=
");
> >> +                }
> >>                  trace_gdbstub_op_extra_info((char *)mem_buf);
> >>                  memtohex(buf, mem_buf, len);
> >>                  put_packet(s, buf);
> >>              }
> >>              break;
> >> --=20
> >> 2.19.1
> >>
