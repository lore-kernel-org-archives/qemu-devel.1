Received: from eggs.gnu.org ([2001:4830:134:3::10]:54920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gI0GA-0005ys-Po
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gI0G9-00081c-TP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:50:50 -0400
References: <20181026081653.24602-1-luc.michel@greensocs.com>
	<20181026081653.24602-15-luc.michel@greensocs.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <794aaf4d-b3a4-692a-8f41-e74f5b0d4936@gmail.com>
Date: Wed, 31 Oct 2018 16:50:22 -0700
MIME-Version: 1.0
In-Reply-To: <20181026081653.24602-15-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 14/16] gdbstub: gdb_set_stop_cpu: ignore
 request when process is not attached
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



On 10/26/18 1:16 AM, Luc Michel wrote:
> When gdb_set_stop_cpu() is called with a CPU associated to a process
> currently not attached by the GDB client, return without modifying the
> stop CPU. Otherwise, GDB get confused if it receives packets with a

s/get/gets/g

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> thread-id it does not know about.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>   gdbstub.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index b3461eff9e..09480df2bf 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1784,10 +1784,19 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>       return RS_IDLE;
>   }
>   
>   void gdb_set_stop_cpu(CPUState *cpu)
>   {
> +    GDBProcess *p = gdb_get_cpu_process(gdbserver_state, cpu);
> +
> +    if (!p->attached) {
> +        /* Having a stop CPU corresponding to a process that is not attached
> +         * confuses GDB. So we ignore the request.
> +         */
> +        return;
> +    }
> +
>       gdbserver_state->c_cpu = cpu;
>       gdbserver_state->g_cpu = cpu;
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> 
