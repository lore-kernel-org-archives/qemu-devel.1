Received: from eggs.gnu.org ([2001:4830:134:3::10]:45907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Xj-0001yZ-Fw
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Xf-0004IE-7J
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:02:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gR1Xd-0004H5-6u
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:02:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so16282932wmf.5
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 13:02:08 -0800 (PST)
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-14-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <775700ee-1c92-34e4-0a19-1fc2ec466d86@redhat.com>
Date: Sun, 25 Nov 2018 22:02:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181123091729.29921-14-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 13/16] gdbstub: processes initialization
 on new peer connection
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

On 23/11/18 10:17, Luc Michel wrote:
> When a new connection is established, we set the first process to be
> attached, and the others detached. The first CPU of the first process
> is selected as the current CPU.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  gdbstub.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 69471ea914..6518324d46 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2249,13 +2249,14 @@ static bool gdb_accept(void)
>          close(fd);
>          return false;
>      }
>  
>      s = g_malloc0(sizeof(GDBState));
> -    s->c_cpu = first_cpu;
> -    s->g_cpu = first_cpu;
>      create_unique_process(s);
> +    s->processes[0].attached = true;
> +    s->c_cpu = gdb_first_attached_cpu(s);
> +    s->g_cpu = s->c_cpu;
>      s->fd = fd;
>      gdb_has_xml = false;
>  
>      gdbserver_state = s;
>      return true;
> @@ -2337,12 +2338,23 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
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
> +        s->c_cpu = gdb_first_attached_cpu(s);
> +        s->g_cpu = s->c_cpu;
> +
>          vm_stop(RUN_STATE_PAUSED);
>          gdb_has_xml = false;
>          break;
>      default:
>          break;
> @@ -2528,19 +2540,17 @@ int gdbserver_start(const char *device)
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
> 
