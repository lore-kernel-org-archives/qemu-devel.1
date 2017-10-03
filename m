Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzO8G-0006U5-Se
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzO8B-0002iQ-1G
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzO8A-0002i0-Og
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:25:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7D9381E1E
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 14:25:05 +0000 (UTC)
Date: Tue, 3 Oct 2017 11:25:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003142501.GI17385@localhost.localdomain>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507032886-199950-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 03, 2017 at 02:14:46PM +0200, Igor Mammedov wrote:
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

I'm unsure about the name.  We already have a declarative way to
register machine types (DEFINE_MACHINE), maybe use "DEFINE_*" for
consistency?

Also, this function won't work if t isn't a static variable, will
it?  The "STATIC" part looks redundant.

In other words, how about "DEFINE_TYPE" and "DEFINE_TYPES"?


> +static void do_qemu_init_ ## t(void)                                        \
> +{                                                                           \
> +    type_register_static_array(t, nr);                                      \

qemu/module.h doesn't include qom/object.h.  I think this should
go to either qom/object.h or a new header file.

> +}                                                                           \
> +type_init(do_qemu_init_ ## t)
> +
> +#define REGISTER_STATIC_TYPE(t)                                             \
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

This new function is probably less controversial than the new
module.h-based code.  Maybe worth moving to a separate patch so
it can be merged earlier?

(If I were you, I would just use type_register_static_array()
inside the existing *_cpu_register_types() functions by now, so
this won't block the whole series, and worry about
REGISTER_STATIC_TYPE*/DEFINE_TYPE* later.)


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

Why the assert()?  type_register_static() is already guaranteed
to never return NULL.

This will break if compiled with -DNDEBUG: assert() won't even
evaluate the expression if NDEBUG is defined.

> +    }
> +}
> +
>  static TypeImpl *type_get_by_name(const char *name)
>  {
>      if (name == NULL) {
> -- 
> 2.7.4
> 

-- 
Eduardo
