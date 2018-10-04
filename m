Received: from eggs.gnu.org ([2001:4830:134:3::10]:56910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g87dw-0002OZ-8A
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g87dv-0001Vn-Df
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:42:32 -0400
MIME-Version: 1.0
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-13-luc.michel@greensocs.com>
In-Reply-To: <20181001115704.701-13-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Oct 2018 10:42:02 -0700
Message-ID: <CAKmqyKPt2EL+BZNey3YOm5TsCK0B01v4wWZtcaR93p3yVJfkig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 12/15] gdbstub: processes initialization
 on new peer connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Mon, Oct 1, 2018 at 5:07 AM Luc Michel <luc.michel@greensocs.com> wrote:
>
> When a new connection is established, we set the first process to be
> attached, and the others detached. The first CPU of the first process
> is selected as the current CPU.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  gdbstub.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index b6de821025..c27a3edf1d 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2221,13 +2221,14 @@ static bool gdb_accept(void)
>          close(fd);
>          return false;
>      }
>
>      s = g_malloc0(sizeof(GDBState));
> -    s->c_cpu = first_cpu;
> -    s->g_cpu = first_cpu;
>      create_unique_process(s);
> +    s->processes[0].attached = true;
> +    s->c_cpu = gdb_first_cpu(s);
> +    s->g_cpu = s->c_cpu;
>      s->fd = fd;
>      gdb_has_xml = false;
>
>      gdbserver_state = s;
>      return true;
> @@ -2309,12 +2310,23 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>
>  static void gdb_chr_event(void *opaque, int event)
>  {
> +    int i;
> +    GDBState *s = (GDBState *) opaque;
> +
>      switch (event) {
>      case CHR_EVENT_OPENED:
> +        /* Start with first process attached, others detached */
> +        for (i = 0; i < s->process_num; i++) {
> +            s->processes[i].attached = !i;
> +        }
> +
> +        s->c_cpu = gdb_first_cpu(s);
> +        s->g_cpu = s->c_cpu;
> +
>          vm_stop(RUN_STATE_PAUSED);
>          gdb_has_xml = false;
>          break;
>      default:
>          break;
> @@ -2474,19 +2486,17 @@ int gdbserver_start(const char *device)
>          mon_chr = s->mon_chr;
>          cleanup_processes(s);
>          memset(s, 0, sizeof(GDBState));
>          s->mon_chr = mon_chr;
>      }
> -    s->c_cpu = first_cpu;
> -    s->g_cpu = first_cpu;
>
>      create_processes(s);
>
>      if (chr) {
>          qemu_chr_fe_init(&s->chr, chr, &error_abort);
>          qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
> -                                 gdb_chr_event, NULL, NULL, NULL, true);
> +                                 gdb_chr_event, NULL, s, NULL, true);
>      }
>      s->state = chr ? RS_IDLE : RS_INACTIVE;
>      s->mon_chr = mon_chr;
>      s->current_syscall_cb = NULL;
>
> --
> 2.19.0
>
>
