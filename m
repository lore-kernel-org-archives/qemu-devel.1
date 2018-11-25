Received: from eggs.gnu.org ([2001:4830:134:3::10]:44379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Vt-0000Xh-0R
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Vo-0003Cy-QQ
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:00:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gR1Vo-0003C6-KK
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:00:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so16176960wmc.5
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 13:00:16 -0800 (PST)
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-13-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ea8b9cf8-7112-2bca-46a8-17c60f517542@redhat.com>
Date: Sun, 25 Nov 2018 22:00:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181123091729.29921-13-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 12/16] gdbstub: add support for vAttach
 packets
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
> Add support for the vAttach packets. In multiprocess mode, GDB sends
> them to attach to additional processes.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  gdbstub.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 5cc643b9e0..69471ea914 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1342,10 +1342,45 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
> 
