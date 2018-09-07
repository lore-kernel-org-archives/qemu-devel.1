Received: from eggs.gnu.org ([2001:4830:134:3::10]:54803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQ8u-0002aU-D2
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQ8t-0005Sj-D4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:26:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
	<20180901124639.19735-6-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28394c9a-fa7f-7687-77a6-22c2682792a4@amsat.org>
Date: Fri, 7 Sep 2018 20:25:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180901124639.19735-6-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/15] gdbstub: add multiprocess
 support to 'sC' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 9/1/18 9:46 AM, Luc Michel wrote:
> Change the sC packet handling to support the multiprocess extension.
> Instead of returning the first thread, we return the first thread of the
> current process.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 2cb9cb6d97..c15250ce65 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1531,13 +1531,18 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>              type = strtoul(p, (char **)&p, 16);
>              sstep_flags = type;
>              put_packet(s, "OK");
>              break;
>          } else if (strcmp(p,"C") == 0) {
> -            /* "Current thread" remains vague in the spec, so always return
> -             *  the first CPU (gdb returns the first thread). */
> -            put_packet(s, "QC1");
> +            /* "Current thread" remains vague in the spec, so always return the
> +             * first thread of the current process (gdb returns the first
> +             * thread).
> +             */
> +            cpu = get_first_cpu_in_process(s, gdb_get_cpu_process(s, s->g_cpu));
> +            snprintf(buf, sizeof(buf), "QC%s",
> +                     get_thread_id(s, cpu, thread_id, sizeof(thread_id)));
> +            put_packet(s, buf);
>              break;
>          } else if (strcmp(p,"fThreadInfo") == 0) {
>              s->query_cpu = first_cpu;
>              goto report_cpuinfo;
>          } else if (strcmp(p,"sThreadInfo") == 0) {
> 
