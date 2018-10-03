Received: from eggs.gnu.org ([2001:4830:134:3::10]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7goI-0006ro-B2
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7goB-0001NH-Jr
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:03:26 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7go2-0001Go-LG
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:03:14 -0400
Received: by mail-wm1-f48.google.com with SMTP id z204-v6so4735339wmc.5
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:03:08 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-13-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d34ae93a-da1b-02ec-f55c-6a68865a4345@redhat.com>
Date: Wed, 3 Oct 2018 15:02:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] vl: list user creatable
 properties when 'help' is argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/09/2018 09:59, Marc-André Lureau wrote:
> Iterate over the writable class properties, sort and print them out
> with the description if available.
> 
> Ex: qemu -object memory-backend-file,help
> memory-backend-file.align=int
> memory-backend-file.discard-data=bool
> memory-backend-file.dump=bool - Set to 'off' to exclude from core dump
> memory-backend-file.host-nodes=int - Binds memory to the list of NUMA host nodes
> memory-backend-file.mem-path=string
> memory-backend-file.merge=bool - Mark memory as mergeable
> memory-backend-file.pmem=bool
> memory-backend-file.policy=HostMemPolicy - Set the NUMA policy
> memory-backend-file.prealloc=bool - Preallocate memory
> memory-backend-file.share=bool - Mark the memory as private to QEMU or shared
> memory-backend-file.size=int - Size of the memory region (ex: 500M)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/object_interfaces.c |  6 +++---
>  vl.c                    | 40 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 72b97a8bed..941fd63afd 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -141,14 +141,14 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>  
>  int user_creatable_add_opts_foreach(void *opaque, QemuOpts *opts, Error **errp)
>  {
> -    bool (*type_predicate)(const char *) = opaque;
> +    bool (*type_opt_predicate)(const char *, QemuOpts *) = opaque;
>      Object *obj = NULL;
>      Error *err = NULL;
>      const char *type;
>  
>      type = qemu_opt_get(opts, "qom-type");
> -    if (type && type_predicate &&
> -        !type_predicate(type)) {
> +    if (type && type_opt_predicate &&
> +        !type_opt_predicate(type, opts)) {
>          return 0;
>      }
>  
> diff --git a/vl.c b/vl.c
> index 71765a2982..880676ecc1 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2729,8 +2729,10 @@ static int machine_set_property(void *opaque,
>   * cannot be created here, as it depends on the chardev
>   * already existing.
>   */
> -static bool object_create_initial(const char *type)
> +static bool object_create_initial(const char *type, QemuOpts *opts)
>  {
> +    ObjectClass *klass;
> +
>      if (is_help_option(type)) {
>          GSList *l, *list;
>  
> @@ -2744,6 +2746,38 @@ static bool object_create_initial(const char *type)
>          exit(0);
>      }
>  
> +    klass = object_class_by_name(type);
> +    if (klass && qemu_opt_has_help_opt(opts)) {
> +        ObjectPropertyIterator iter;
> +        ObjectProperty *prop;
> +        GPtrArray *array = g_ptr_array_new();
> +        int i;
> +
> +        object_class_property_iter_init(&iter, klass);
> +        while ((prop = object_property_iter_next(&iter))) {
> +            GString *str;
> +
> +            if (!prop->set) {
> +                continue;
> +            }
> +
> +            str = g_string_new(NULL);
> +            g_string_append_printf(str, "%s.%s=%s", type,
> +                                   prop->name, prop->type);
> +            if (prop->description) {
> +                g_string_append_printf(str, " - %s", prop->description);
> +            }
> +            g_ptr_array_add(array, g_string_free(str, false));
> +        }
> +        g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp);
> +        for (i = 0; i < array->len; i++) {
> +            printf("%s\n", (char *)array->pdata[i]);
> +        }
> +        g_ptr_array_set_free_func(array, g_free);
> +        g_ptr_array_free(array, true);
> +        exit(0);
> +    }
> +
>      if (g_str_equal(type, "rng-egd") ||
>          g_str_has_prefix(type, "pr-manager-")) {
>          return false;
> @@ -2790,9 +2824,9 @@ static bool object_create_initial(const char *type)
>   * The remainder of object creation happens after the
>   * creation of chardev, fsdev, net clients and device data types.
>   */
> -static bool object_create_delayed(const char *type)
> +static bool object_create_delayed(const char *type, QemuOpts *opts)
>  {
> -    return !object_create_initial(type);
> +    return !object_create_initial(type, opts);
>  }
>  
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
