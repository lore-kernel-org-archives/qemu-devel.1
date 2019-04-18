Received: from eggs.gnu.org ([209.51.188.92]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6Oi-0006Hw-66
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6Oh-0007CF-8C
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:44:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH6Oh-0007Bl-2Q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:44:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so2778091wrw.13
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:44:11 -0700 (PDT)
References: <20190418040103.15314-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ffb2830-56e0-2d9f-ea4e-71543fa06ece@redhat.com>
Date: Thu, 18 Apr 2019 14:44:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190418040103.15314-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hppa: Delete unused hppa_cpu_list()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Eduardo,

On 4/18/19 6:01 AM, Eduardo Habkost wrote:
> hppa_cpu_list() is dead code and is never called.  Delete it.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/hppa/cpu.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 00bf444620..b3b1826209 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -110,28 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  }
>  
> -static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
> -{
> -    ObjectClass *oc = data;
> -    CPUListState *s = user_data;
> -
> -    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
> -}
> -
> -void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)

You forgot to remove the declaration in "target/hppa/cpu.h".

With this header updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -{
> -    CPUListState s = {
> -        .file = f,
> -        .cpu_fprintf = cpu_fprintf,
> -    };
> -    GSList *list;
> -
> -    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
> -    (*cpu_fprintf)(f, "Available CPUs:\n");
> -    g_slist_foreach(list, hppa_cpu_list_entry, &s);
> -    g_slist_free(list);
> -}
> -
>  static void hppa_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
> 
