Received: from eggs.gnu.org ([2001:4830:134:3::10]:53879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07tJ-00081m-3H
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07tF-0004Ko-QT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:49 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07tF-0004KP-Ig
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:45 -0400
Received: by mail-qk0-x242.google.com with SMTP id w63so8608702qkd.2
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:16:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-23-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1fc71085-5d06-b8e8-fef4-93e64c0db27d@amsat.org>
Date: Thu, 5 Oct 2017 12:16:34 -0300
MIME-Version: 1.0
In-Reply-To: <1507211474-188400-23-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 22/40] sh4: simplify
 superh_cpu_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

On 10/05/2017 10:50 AM, Igor Mammedov wrote:
> currently for sh4 cpu_model argument for '-cpu' option
> could be either 'cpu model' name or cpu_typename.
> 
> however typically '-cpu' takes 'cpu model' name and
> cpu type for sh4 target isn't advertised publicly
> ('-cpu help' prints only 'cpu model' names) so we
> shouldn't care about this use case (it's more of a bug).
> 
> 1. Drop '-cpu cpu_typename' to align with the rest of
>    targets.
> 2. Compose searched for typename from cpu model and use
>    it with object_class_by_name() directly instead of
>    over-complicated
>        object_class_get_list()
>        g_slist_find_custom() + superh_cpu_name_compare()
> 
> With #1 droped, #2 could be used for both lookups which
> simplifies superh_cpu_class_by_name() quite a bit.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2:
>   - there is no need to NULL-initialize 'oc' in superh_cpu_class_by_name()
>     also drop extra ';' (Philippe Mathieu-Daudé)
> 
> CC: aurelien@aurel32.net
> ---
>  target/sh4/cpu.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 72f1dec..e715560 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -120,36 +120,26 @@ void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      g_slist_free(list);
>  }
>  
> -static gint superh_cpu_name_compare(gconstpointer a, gconstpointer b)
> -{
> -    const SuperHCPUClass *scc = SUPERH_CPU_CLASS(a);
> -    const char *name = b;
> -
> -    return strcasecmp(scc->name, name);
> -}
> -
>  static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> -    GSList *list, *item;
> +    char *s, *typename = NULL;
>  
> -    if (strcasecmp(cpu_model, "any") == 0) {
> -        return object_class_by_name(TYPE_SH7750R_CPU);
> +    s = g_ascii_strdown(cpu_model, -1);
> +    if (strcmp(s, "any") == 0) {
> +        oc = object_class_by_name(TYPE_SH7750R_CPU);
> +        goto out;
>      }
>  
> -    oc = object_class_by_name(cpu_model);
> -    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_SUPERH_CPU) != NULL
> -        && !object_class_is_abstract(oc)) {
> -        return oc;
> +    typename = g_strdup_printf(SUPERH_CPU_TYPE_NAME("%s"), s);
> +    oc = object_class_by_name(typename);
> +    if (oc != NULL && object_class_is_abstract(oc)) {
> +        oc = NULL;
>      }
>  
> -    oc = NULL;
> -    list = object_class_get_list(TYPE_SUPERH_CPU, false);
> -    item = g_slist_find_custom(list, cpu_model, superh_cpu_name_compare);
> -    if (item != NULL) {
> -        oc = item->data;
> -    }
> -    g_slist_free(list);
> +out:
> +    g_free(s);
> +    g_free(typename);
>      return oc;
>  }
>  
> 
