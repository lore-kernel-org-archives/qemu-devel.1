Received: from eggs.gnu.org ([2001:4830:134:3::10]:34837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNGM-00026L-R5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNGJ-0004Ui-Jq
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:29:30 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNGJ-0004Tt-Et
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:29:27 -0400
Received: by mail-qk0-x243.google.com with SMTP id b124so3272870qke.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:29:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b559ae7-4fe5-6ba2-5bb1-98d9e7c68c6f@amsat.org>
Date: Tue, 3 Oct 2017 10:29:22 -0300
MIME-Version: 1.0
In-Reply-To: <1507032886-199950-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org

Hi Igor,

On 10/03/2017 09:14 AM, Igor Mammedov wrote:
> it will help to remove code duplication in places
> that currently open code registration of static
> type[s] and remove necessity to declare function
> for type_init() to call, when only static types
> need to be registered.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> I'm going to use it for CPU types in followup patches
> 
> CC: ehabkost@redhat.com
> ---
>  include/qemu/module.h | 10 ++++++++++
>  include/qom/object.h  | 10 ++++++++++
>  qom/object.c          |  9 +++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 56dd218..60dd632 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -52,6 +52,16 @@ typedef enum {
>  #define type_init(function) module_init(function, MODULE_INIT_QOM)
>  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
>  
> +#define REGISTER_STATIC_TYPES(t, nr)                                        \

ok

> +static void do_qemu_init_ ## t(void)                                        \
> +{                                                                           \
> +    type_register_static_array(t, nr);                                      \
> +}                                                                           \
> +type_init(do_qemu_init_ ## t)
> +
> +#define REGISTER_STATIC_TYPE(t)                                             \

eh why not...

What's your plan for your "generalize parsing of cpu_model (2)" series?
re-post the whole? If you just change this macro you can keep my R-b for it.

> +    REGISTER_STATIC_TYPES(t, 1)
> +
>  #define block_module_load_one(lib) module_load_one("block-", lib)
>  
>  void register_module_init(void (*fn)(void), module_init_type type);
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f3e5cff..17fcadd 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
>  Type type_register(const TypeInfo *info);
>  
>  /**
> + * type_register_static_array:
> + * @infos: The array of the new type #TypeInfo structures.
> + * @nr_infos: number of entries in @infos
> + *
> + * @infos and all of the strings it points to should exist for the life time
> + * that the type is registered.
> + */
> +void type_register_static_array(const TypeInfo *infos, int nr_infos);
> +
> +/**
>   * object_class_dynamic_cast_assert:
>   * @klass: The #ObjectClass to attempt to cast.
>   * @typename: The QOM typename of the class to cast to.
> diff --git a/qom/object.c b/qom/object.c
> index 3e18537..40b1729 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *info)
>      return type_register(info);
>  }
>  
> +void type_register_static_array(const TypeInfo *infos, int nr_infos)
> +{
> +    int i;
> +
> +    for (i = 0; i < nr_infos; i++) {
> +        assert(type_register_static(&infos[i]));
> +    }
> +}

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  static TypeImpl *type_get_by_name(const char *name)
>  {
>      if (name == NULL) {
> 
