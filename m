Received: from eggs.gnu.org ([2001:4830:134:3::10]:39172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLlo-0005Et-WF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLlj-0004bn-NN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:13:20 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLlj-0004bZ-DX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:13:15 -0500
Received: by mail-wm0-x242.google.com with SMTP id i3so1254518wmi.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 15:13:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306164957.24275-1-pbonzini@redhat.com>
	<20180306164957.24275-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5572225-34e5-01af-5133-20dc6a59f24c@amsat.org>
Date: Tue, 6 Mar 2018 20:13:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180306164957.24275-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qom: introduce
 object_class_get_list_sorted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 03/06/2018 01:49 PM, Paolo Bonzini wrote:
> Unify half a dozen copies of very similar code (the only difference being
> whether comparisons were case-sensitive) and use it also in Tricore,
> which did not do any sorting of CPU model names.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qom/object.h    | 10 ++++++++++
>  qdev-monitor.c          |  9 +--------
>  qom/object.c            | 14 ++++++++++++++
>  target/alpha/cpu.c      | 15 +--------------
>  target/hppa/cpu.c       | 14 +-------------
>  target/lm32/cpu.c       | 15 +--------------
>  target/sh4/cpu.c        | 15 +--------------
>  target/tricore/helper.c |  2 +-
>  8 files changed, 30 insertions(+), 64 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 4f07090db0..12c0f58c8f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -913,6 +913,17 @@ void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
>  GSList *object_class_get_list(const char *implements_type,
>                                bool include_abstract);
>  
> +/**
> + * object_class_get_list_sorted:
> + * @implements_type: The type to filter for, including its derivatives.
> + * @include_abstract: Whether to include abstract classes.
> + *
> + * Returns: A singly-linked list of the classes in alphabetical
> + * case-insensitive order.
> + */
> +GSList *object_class_get_list_sorted(const char *implements_type,
> +                              bool include_abstract);
> +
>  /**
>   * object_ref:
>   * @obj: the object
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index b7e3291f8b..61e0300991 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -122,12 +122,6 @@ static void qdev_print_devinfo(DeviceClass *dc)
>      error_printf("\n");
>  }
>  
> -static gint devinfo_cmp(gconstpointer a, gconstpointer b)
> -{
> -    return strcasecmp(object_class_get_name((ObjectClass *)a),
> -                      object_class_get_name((ObjectClass *)b));
> -}
> -
>  static void qdev_print_devinfos(bool show_no_user)
>  {
>      static const char *cat_name[DEVICE_CATEGORY_MAX + 1] = {
> @@ -146,8 +140,7 @@ static void qdev_print_devinfos(bool show_no_user)
>      int i;
>      bool cat_printed;
>  
> -    list = g_slist_sort(object_class_get_list(TYPE_DEVICE, false),
> -                        devinfo_cmp);
> +    list = object_class_get_list_sorted(TYPE_DEVICE, false);
>  
>      for (i = 0; i <= DEVICE_CATEGORY_MAX; i++) {
>          cat_printed = false;
> diff --git a/qom/object.c b/qom/object.c
> index 755ad03819..6088f55943 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -891,6 +891,19 @@ GSList *object_class_get_list(const char *implements_type,
>      return list;
>  }
>  
> +static gint object_class_cmp(gconstpointer a, gconstpointer b)
> +{
> +    return strcasecmp(object_class_get_name((ObjectClass *)a),
> +                      object_class_get_name((ObjectClass *)b));
> +}
> +
> +GSList *object_class_get_list_sorted(const char *implements_type,
> +                                     bool include_abstract)
> +{
> +    return g_slist_sort(object_class_get_list(implements_type, include_abstract),
> +                        object_class_cmp);
> +}
> +
>  void object_ref(Object *obj)
>  {
>      if (!obj) {
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 55675ce419..b08078e7fc 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -71,18 +71,6 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
>      acc->parent_realize(dev, errp);
>  }
>  
> -/* Sort alphabetically by type name. */
> -static gint alpha_cpu_list_compare(gconstpointer a, gconstpointer b)
> -{
> -    ObjectClass *class_a = (ObjectClass *)a;
> -    ObjectClass *class_b = (ObjectClass *)b;
> -    const char *name_a, *name_b;
> -
> -    name_a = object_class_get_name(class_a);
> -    name_b = object_class_get_name(class_b);
> -    return strcmp(name_a, name_b);
> -}
> -
>  static void alpha_cpu_list_entry(gpointer data, gpointer user_data)
>  {
>      ObjectClass *oc = data;
> @@ -100,8 +88,7 @@ void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      };
>      GSList *list;
>  
> -    list = object_class_get_list(TYPE_ALPHA_CPU, false);
> -    list = g_slist_sort(list, alpha_cpu_list_compare);
> +    list = object_class_get_list_sorted(TYPE_ALPHA_CPU, false);
>      (*cpu_fprintf)(f, "Available CPUs:\n");
>      g_slist_foreach(list, alpha_cpu_list_entry, &s);
>      g_slist_free(list);
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 969f628f0a..e5da8c3cab 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -110,18 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  }
>  
> -/* Sort hppabetically by type name. */
> -static gint hppa_cpu_list_compare(gconstpointer a, gconstpointer b)
> -{
> -    ObjectClass *class_a = (ObjectClass *)a;
> -    ObjectClass *class_b = (ObjectClass *)b;
> -    const char *name_a, *name_b;
> -
> -    name_a = object_class_get_name(class_a);
> -    name_b = object_class_get_name(class_b);
> -    return strcmp(name_a, name_b);
> -}
> -
>  static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
>  {
>      ObjectClass *oc = data;
> @@ -138,7 +126,7 @@ void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      };
>      GSList *list;
>  
> -    list = object_class_get_list(TYPE_HPPA_CPU, false);
> +    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
>      list = g_slist_sort(list, hppa_cpu_list_compare);
>      (*cpu_fprintf)(f, "Available CPUs:\n");
>      g_slist_foreach(list, hppa_cpu_list_entry, &s);
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index 96c2499d0b..0003152469 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -32,18 +32,6 @@ static void lm32_cpu_set_pc(CPUState *cs, vaddr value)
>      cpu->env.pc = value;
>  }
>  
> -/* Sort alphabetically by type name. */
> -static gint lm32_cpu_list_compare(gconstpointer a, gconstpointer b)
> -{
> -    ObjectClass *class_a = (ObjectClass *)a;
> -    ObjectClass *class_b = (ObjectClass *)b;
> -    const char *name_a, *name_b;
> -
> -    name_a = object_class_get_name(class_a);
> -    name_b = object_class_get_name(class_b);
> -    return strcmp(name_a, name_b);
> -}
> -
>  static void lm32_cpu_list_entry(gpointer data, gpointer user_data)
>  {
>      ObjectClass *oc = data;
> @@ -65,8 +53,7 @@ void lm32_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      };
>      GSList *list;
>  
> -    list = object_class_get_list(TYPE_LM32_CPU, false);
> -    list = g_slist_sort(list, lm32_cpu_list_compare);
> +    list = object_class_get_list_sorted(TYPE_LM32_CPU, false);
>      (*cpu_fprintf)(f, "Available CPUs:\n");
>      g_slist_foreach(list, lm32_cpu_list_entry, &s);
>      g_slist_free(list);
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 6302cfda3a..541ffc2d97 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -85,18 +85,6 @@ typedef struct SuperHCPUListState {
>      FILE *file;
>  } SuperHCPUListState;
>  
> -/* Sort alphabetically by type name. */
> -static gint superh_cpu_list_compare(gconstpointer a, gconstpointer b)
> -{
> -    ObjectClass *class_a = (ObjectClass *)a;
> -    ObjectClass *class_b = (ObjectClass *)b;
> -    const char *name_a, *name_b;
> -
> -    name_a = object_class_get_name(class_a);
> -    name_b = object_class_get_name(class_b);
> -    return strcmp(name_a, name_b);
> -}
> -
>  static void superh_cpu_list_entry(gpointer data, gpointer user_data)
>  {
>      SuperHCPUListState *s = user_data;
> @@ -114,8 +102,7 @@ void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      };
>      GSList *list;
>  
> -    list = object_class_get_list(TYPE_SUPERH_CPU, false);
> -    list = g_slist_sort(list, superh_cpu_list_compare);
> +    list = object_class_get_list_sorted(TYPE_SUPERH_CPU, false);
>      g_slist_foreach(list, superh_cpu_list_entry, &s);
>      g_slist_free(list);
>  }
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 45276d3782..dad7eea085 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -101,7 +101,7 @@ void tricore_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      };
>      GSList *list;
>  
> -    list = object_class_get_list(TYPE_TRICORE_CPU, false);
> +    list = object_class_get_list_sorted(TYPE_TRICORE_CPU, false);
>      (*cpu_fprintf)(f, "Available CPUs:\n");
>      g_slist_foreach(list, tricore_cpu_list_entry, &s);
>      g_slist_free(list);
> 
