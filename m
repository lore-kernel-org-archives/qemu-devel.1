Received: from eggs.gnu.org ([2001:4830:134:3::10]:47037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb6W-0006uz-Nj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb6W-0004ed-2T
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:12:00 -0500
Date: Fri, 16 Nov 2018 11:11:26 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181116101126.GV7447@toto>
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-13-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181115094207.22846-13-luc.michel@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/16] gdbstub: add support for vAttach
 packets
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

On Thu, Nov 15, 2018 at 10:42:03AM +0100, Luc Michel wrote:
> Add support for the vAttach packets. In multiprocess mode, GDB sends
> them to attach to additional processes.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  gdbstub.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index ada53ac559..0427d1c4f0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1340,10 +1340,45 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>                      break;
>                  }
>                  goto unknown_command;
>              }
>              break;
> +        } else if (strncmp(p, "Attach;", 7) == 0) {
> +            unsigned long pid;
> +
> +            p += 7;
> +
> +            if (qemu_strtoul(p, &p, 16, &pid)) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +
> +            process = gdb_get_process(s, pid);
> +
> +            if (process == NULL) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +
> +            cpu = get_first_cpu_in_process(s, process);
> +
> +            if (cpu == NULL) {
> +                /* Refuse to attach an empty process */
> +                put_packet(s, "E22");
> +                break;
> +            }
> +
> +            process->attached = true;
> +
> +            s->g_cpu = cpu;
> +            s->c_cpu = cpu;
> +
> +            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
> +                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
> +
> +            put_packet(s, buf);
> +            break;
>          } else {
>              goto unknown_command;
>          }
>      case 'k':
>          /* Kill the target */
> -- 
> 2.19.1
> 
