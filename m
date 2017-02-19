Received: from eggs.gnu.org ([2001:4830:134:3::10]:54512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIbC-0003LH-0R
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 22:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIb8-00004w-Uf
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 22:55:46 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIb8-0008WP-QQ
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 22:55:42 -0500
Received: by mail-qt0-x242.google.com with SMTP id w20so10417281qtb.1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 19:55:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
	<20170217082704.23270-2-skiver.cloud.yzy@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c9a78b3-bd37-d263-b7c2-d7a2db92c0a8@amsat.org>
Date: Sun, 19 Feb 2017 00:55:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170217082704.23270-2-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor.c: make mon_get_cpu return
 NULL when there is no CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Cc: qemu-devel@nongnu.org, Ziyue Yang <yzylivezh@hotmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

On 02/17/2017 05:27 AM, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
>
> Currently mon_get_cpu always dereferences first_cpu without checking
> whether it's a valid pointer. This commit adds check before dereferencing,
> and reports "No CPU" info if there isn't any CPU then returns NULL.
>
> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  monitor.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 3cd72a9bab..6b25cf7a2b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1026,6 +1026,10 @@ int monitor_set_cpu(int cpu_index)
>  CPUState *mon_get_cpu(void)
>  {
>      if (!cur_mon->mon_cpu) {
> +        if (!first_cpu) {
> +            monitor_printf(cur_mon, "No CPU available on this machine\n");
> +            return NULL;
> +        }
>          monitor_set_cpu(first_cpu->cpu_index);
>      }
>      cpu_synchronize_state(cur_mon->mon_cpu);
> @@ -2495,11 +2499,11 @@ static int default_fmt_size = 4;
>  static int is_valid_option(const char *c, const char *typestr)
>  {
>      char option[3];
> -
> +
>      option[0] = '-';
>      option[1] = *c;
>      option[2] = '\0';
> -
> +
>      typestr = strstr(typestr, option);
>      return (typestr != NULL);
>  }
> @@ -2864,7 +2868,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      p++;
>                      if(c != *p) {
>                          if(!is_valid_option(p, typestr)) {
> -
> +
>                              monitor_printf(mon, "%s: unsupported option -%c\n",
>                                             cmd->name, *p);
>                              goto fail;
>
