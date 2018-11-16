Received: from eggs.gnu.org ([2001:4830:134:3::10]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb9N-0000r7-9U
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb9M-000635-HJ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:14:57 -0500
Date: Fri, 16 Nov 2018 11:14:18 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181116101418.GX7447@toto>
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-15-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181115094207.22846-15-luc.michel@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v6 14/16] gdbstub: gdb_set_stop_cpu: ignore
 request when process is not attached
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

On Thu, Nov 15, 2018 at 10:42:05AM +0100, Luc Michel wrote:
> When gdb_set_stop_cpu() is called with a CPU associated to a process
> currently not attached by the GDB client, return without modifying the
> stop CPU. Otherwise, GDB gets confused if it receives packets with a
> thread-id it does not know about.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  gdbstub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 59eed3b878..89819a6a72 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1787,10 +1787,19 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      return RS_IDLE;
>  }
>  
>  void gdb_set_stop_cpu(CPUState *cpu)
>  {
> +    GDBProcess *p = gdb_get_cpu_process(gdbserver_state, cpu);
> +
> +    if (!p->attached) {
> +        /* Having a stop CPU corresponding to a process that is not attached
> +         * confuses GDB. So we ignore the request.
> +         */
> +        return;
> +    }
> +
>      gdbserver_state->c_cpu = cpu;
>      gdbserver_state->g_cpu = cpu;
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -- 
> 2.19.1
> 
