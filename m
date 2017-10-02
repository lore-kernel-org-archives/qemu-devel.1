Received: from eggs.gnu.org ([2001:4830:134:3::10]:59976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7RL-0008AN-8t
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7RH-0006Kv-6I
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:35:47 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:47055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7RH-0006KY-1Y
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:35:43 -0400
Received: by mail-qt0-x242.google.com with SMTP id 6so213097qtw.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:35:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-23-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <71226704-7e3b-25e7-3155-4a84ceba5c51@amsat.org>
Date: Mon, 2 Oct 2017 17:35:39 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-23-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/38] xtensa: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, jcmvbkbc@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> use new XTENSA_CPU_TYPE_NAME to compose CPU type name
> to bring xtensa in line with all other targets that
> will similar macro.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: jcmvbkbc@gmail.com
> ---
>   target/xtensa/cpu.h    | 4 ++++
>   target/xtensa/cpu.c    | 2 +-
>   target/xtensa/helper.c | 2 +-
>   3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 4803331..b17d7d9 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -469,11 +469,15 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>   #define cpu_signal_handler cpu_xtensa_signal_handler
>   #define cpu_list xtensa_cpu_list
>   
> +#define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
> +#define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
> +
>   #ifdef TARGET_WORDS_BIGENDIAN
>   #define XTENSA_DEFAULT_CPU_MODEL "fsf"
>   #else
>   #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
>   #endif
> +#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)

I see XTENSA_DEFAULT_CPU_MODEL is used in mc->desc, any idea to be able 
to use this instead?

#ifdef TARGET_WORDS_BIGENDIAN
# define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME("fsf")
#else
# define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME("dc232b")
#endif

>   
>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
>   
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index dcdc765..b5f7079 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -83,7 +83,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
>       ObjectClass *oc;
>       char *typename;
>   
> -    typename = g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
> +    typename = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
>       oc = object_class_by_name(typename);
>       g_free(typename);
>       if (oc == NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU) ||
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index e8fba20..216f198 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -76,7 +76,7 @@ void xtensa_register_core(XtensaConfigList *node)
>   
>       node->next = xtensa_cores;
>       xtensa_cores = node;
> -    type.name = g_strdup_printf("%s-" TYPE_XTENSA_CPU, node->config->name);
> +    type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
>       type_register(&type);
>       g_free((gpointer)type.name);
>   }
> 
