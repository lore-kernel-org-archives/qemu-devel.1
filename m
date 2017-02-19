Received: from eggs.gnu.org ([2001:4830:134:3::10]:54629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIcF-00048V-NX
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 22:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIcE-0000Sv-TK
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 22:56:51 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIcE-0000Sh-Ok
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 22:56:50 -0500
Received: by mail-qk0-x243.google.com with SMTP id s186so4441743qkb.1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 19:56:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
	<20170217082704.23270-3-skiver.cloud.yzy@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad911bcd-c535-6b2a-a29b-f8ed1146168c@amsat.org>
Date: Sun, 19 Feb 2017 00:56:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170217082704.23270-3-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/i386/monitor.c: check return
 value of mon_get_cpu before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>, qemu-devel@nongnu.org
Cc: Ziyue Yang <yzylivezh@hotmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

On 02/17/2017 05:27 AM, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
>
> This patch eliminates the segfault caused by accessing CPU that doesn't
> exist in hmp command "info lapic", which can be reproduced by
>
> $ qemu-system-x86_64 -nographic -M none -serial none -monitor stdio
>
> and then type "info lapic" into qemu monitor.
>
> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/i386/monitor.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 468aa073bc..7b96c74a24 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -624,8 +624,11 @@ const MonitorDef *target_monitor_defs(void)
>
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
>  {
> -    x86_cpu_dump_local_apic_state(mon_get_cpu(), (FILE *)mon, monitor_fprintf,
> -                                  CPU_DUMP_FPU);
> +    CPUState *cs = mon_get_cpu();
> +    if (cs) {
> +        x86_cpu_dump_local_apic_state(cs, (FILE *)mon, monitor_fprintf,
> +                                      CPU_DUMP_FPU);
> +    }
>  }
>
>  void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
>
