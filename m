Received: from eggs.gnu.org ([2001:4830:134:3::10]:60829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotKs-0008KR-2a
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotKn-0000gS-8x
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:30:50 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotKn-0000gL-24
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:30:45 -0400
Received: by mail-qt0-x244.google.com with SMTP id 7so475352qtz.3
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 08:30:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9123c18-9e8a-0be2-f28e-b2fdc47832e5@amsat.org>
Date: Mon, 4 Sep 2017 12:30:40 -0300
MIME-Version: 1.0
In-Reply-To: <1504533662-198084-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qom: cpus: split cpu_generic_init() on
 feature parsing and cpu creation parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09/04/2017 11:00 AM, Igor Mammedov wrote:
> it would allow to reuse feature parsing part in various machines
> that have CPU features instead of re-implementing the same feature
> parsing each time.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   include/qom/cpu.h | 21 +++++++++++++++++++++
>   qom/cpu.c         | 46 ++++++++++++++++++++++++++++++----------------
>   2 files changed, 51 insertions(+), 16 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index b7ac949..a92a7d2 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -633,6 +633,27 @@ void cpu_reset(CPUState *cpu);
>   ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
>   
>   /**
> + * cpu_create:
> + * @typename: The CPU type.
> + *
> + * Instantiates a CPU and realizes the CPU.
> + *
> + * Returns: A #CPUState or %NULL if an error occurred.
> + */
> +CPUState *cpu_create(const char *typename);
> +
> +/**
> + * cpu_parse_features:
> + * @typename: The CPU base type or CPU type.
> + * @cpu_model: The model string including optional parameters.
> + *
> + * processes optional parameters and registers them as global properties
> + *
> + * Returns: type of CPU to create or %NULL if an error occurred.
> + */
> +const char *cpu_parse_features(const char *typename, const char *cpu_model);
> +
> +/**
>    * cpu_generic_init:
>    * @typename: The CPU base type.
>    * @cpu_model: The model string including optional parameters.
> diff --git a/qom/cpu.c b/qom/cpu.c
> index deb8880..d715890 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -53,13 +53,26 @@ bool cpu_exists(int64_t id)
>       return !!cpu_by_arch_id(id);
>   }
>   
> -CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
> +CPUState *cpu_create(const char *typename)
> +{
> +    Error *err = NULL;
> +    CPUState *cpu = CPU(object_new(typename));
> +    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
> +    if (err != NULL) {
> +        error_report_err(err);
> +        object_unref(OBJECT(cpu));
> +        return NULL;
> +    }
> +    return cpu;
> +}
> +
> +const char *cpu_parse_features(const char *typename, const char *cpu_model)
>   {
> -    CPUState *cpu = NULL;
>       ObjectClass *oc;
>       CPUClass *cc;
>       Error *err = NULL;
>       gchar **model_pieces;
> +    const char *cpu_type;
>   
>       model_pieces = g_strsplit(cpu_model, ",", 2);
>   
> @@ -69,27 +82,28 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
>           return NULL;
>       }
>   
> +    cpu_type = object_class_get_name(oc);
>       cc = CPU_CLASS(oc);
> -    /* TODO: all callers of cpu_generic_init() need to be converted to
> -     * call parse_features() only once, before calling cpu_generic_init().
> -     */
> -    cc->parse_features(object_class_get_name(oc), model_pieces[1], &err);
> +    cc->parse_features(cpu_type, model_pieces[1], &err);
>       g_strfreev(model_pieces);
>       if (err != NULL) {
> -        goto out;
> -    }
> -
> -    cpu = CPU(object_new(object_class_get_name(oc)));
> -    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
> -
> -out:
> -    if (err != NULL) {
>           error_report_err(err);
> -        object_unref(OBJECT(cpu));
>           return NULL;
>       }
> +    return cpu_type;
> +}
>   
> -    return cpu;
> +CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
> +{
> +    /* TODO: all callers of cpu_generic_init() need to be converted to
> +     * call cpu_parse_features() only once, before calling cpu_generic_init().
> +     */
> +    const char *cpu_type = cpu_parse_features(typename, cpu_model);
> +
> +    if (cpu_type) {
> +        return cpu_create(cpu_type);
> +    }
> +    return NULL;
>   }
>   
>   bool cpu_paging_enabled(const CPUState *cpu)
> 
