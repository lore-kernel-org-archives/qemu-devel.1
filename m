Received: from eggs.gnu.org ([2001:4830:134:3::10]:51719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwqAu-00044F-1d
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwqAp-0004kE-0O
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:45:24 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:50835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dwqAo-0004ji-OB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:45:18 -0400
Received: by mail-wr0-x229.google.com with SMTP id w12so13271042wrc.7
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:45:18 -0700 (PDT)
References: <20170919150313.10833-1-richard.henderson@linaro.org>
	<20170919150313.10833-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170919150313.10833-9-richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 14:45:16 +0100
Message-ID: <87y3p1tvyr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] disas: Remove
 monitor_disas_is_physical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Even though there is only one monitor, and thus no race on this
> global data object, there is also no point in having it.  We can
> just as well record the decision in the read_memory_function that
> we select.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  disas.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/disas.c b/disas.c
> index b4e4fc409e..c3606b3986 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -513,19 +513,11 @@ const char *lookup_symbol(target_ulong orig_addr)
>
>  #include "monitor/monitor.h"
>
> -static int monitor_disas_is_physical;
> -
>  static int
> -monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
> -                     struct disassemble_info *info)
> +physical_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
> +                      struct disassemble_info *info)
>  {
> -    CPUDebug *s = container_of(info, CPUDebug, info);
> -
> -    if (monitor_disas_is_physical) {
> -        cpu_physical_memory_read(memaddr, myaddr, length);
> -    } else {
> -        cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
> -    }
> +    cpu_physical_memory_read(memaddr, myaddr, length);
>      return 0;
>  }
>
> @@ -540,8 +532,8 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
>      INIT_DISASSEMBLE_INFO(s.info, (FILE *)mon, monitor_fprintf);
>
>      s.cpu = cpu;
> -    monitor_disas_is_physical = is_physical;
> -    s.info.read_memory_func = monitor_read_memory;
> +    s.info.read_memory_func
> +        = (is_physical ? physical_read_memory : target_read_memory);
>      s.info.print_address_func = generic_print_address;
>      s.info.buffer_vma = pc;
>      s.info.cap_arch = -1;


--
Alex Bennée
