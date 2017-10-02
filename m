Received: from eggs.gnu.org ([2001:4830:134:3::10]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1CX-0001Oj-En
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1CR-0000LE-GB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:05 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:56418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1CR-0000Ky-Bd
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:55:59 -0400
Received: by mail-qt0-x244.google.com with SMTP id e19so3438555qta.13
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 06:55:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd0cab5c-1e22-167b-60f9-7b12669f3417@amsat.org>
Date: Mon, 2 Oct 2017 10:55:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170928165414.7339-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 8/9] disas: Remove
 monitor_disas_is_physical
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 09/28/2017 01:54 PM, Richard Henderson wrote:
> Even though there is only one monitor, and thus no race on this
> global data object, there is also no point in having it.  We can
> just as well record the decision in the read_memory_function that
> we select.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/disas.c b/disas.c
> index 0d212f2ac5..194c523885 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -513,19 +513,11 @@ const char *lookup_symbol(target_ulong orig_addr)
>   
>   #include "monitor/monitor.h"
>   
> -static int monitor_disas_is_physical;
> -
>   static int
> -monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
> +physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
>                        struct disassemble_info *info)
>   {
> -    CPUDebug *s = container_of(info, CPUDebug, info);
> -
> -    if (monitor_disas_is_physical) {
> -        cpu_physical_memory_read(memaddr, myaddr, length);
> -    } else {
> -        cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
> -    }
> +    cpu_physical_memory_read(memaddr, myaddr, length);
>       return 0;
>   }
>   
> @@ -540,8 +532,8 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
>       INIT_DISASSEMBLE_INFO(s.info, (FILE *)mon, monitor_fprintf);
>   
>       s.cpu = cpu;
> -    monitor_disas_is_physical = is_physical;
> -    s.info.read_memory_func = monitor_read_memory;
> +    s.info.read_memory_func
> +        = (is_physical ? physical_read_memory : target_read_memory);
>       s.info.print_address_func = generic_print_address;
>       s.info.buffer_vma = pc;
>       s.info.cap_arch = -1;
> 
