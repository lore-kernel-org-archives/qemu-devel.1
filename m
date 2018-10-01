Received: from eggs.gnu.org ([2001:4830:134:3::10]:49902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71K9-0003Pj-UN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71K4-00050I-Td
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:45:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g71K4-000508-MJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:45:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so3996594wmt.2
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 09:45:28 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-12-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <285be5d2-8bb1-8fc4-9a8e-03078f59dd73@redhat.com>
Date: Mon, 1 Oct 2018 18:45:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-12-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/15] gdbstub: add support for vAttach
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi Luc,

On 01/10/2018 13:57, Luc Michel wrote:
> Add support for the vAttach packets. In multiprocess mode, GDB sends
> them to attach to additional processes.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  gdbstub.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index d372972dd3..b6de821025 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1326,10 +1326,42 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>                      break;
>                  }
>                  goto unknown_command;
>              }
>              break;
> +        } else if (strncmp(p, "Attach", 6) == 0) {

Shouldn't this be strncmp("Attach;", 7)?

> +            unsigned long pid;
> +
> +            p += 7;
> +
> +            qemu_strtoul(p, &p, 16, &pid);

You should check for EINVAL/ERANGE here.

Rest of the patch is OK.

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
