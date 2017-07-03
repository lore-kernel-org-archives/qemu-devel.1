Received: from eggs.gnu.org ([2001:4830:134:3::10]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRxc3-0002SM-Pu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRxc0-0005D5-Jc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dRxbz-0005C8-Sf
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:25:44 -0400
References: <1499068251-6164-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <83e957bb-6064-e769-6ada-3846cbd77059@redhat.com>
Date: Mon, 3 Jul 2017 11:25:39 +0200
MIME-Version: 1.0
In-Reply-To: <1499068251-6164-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com


>  
> +static S390CPUModel *get_max_cpu_model(Error **errp);
> +
>  #ifndef CONFIG_USER_ONLY
> +static void list_add_feat(const char *name, void *opaque);

Wonder if we should declare all these prototypes at the beginning of the
file.

> +
> +static void check_unavailable_features(const S390CPUModel *max_model,
> +                                       const S390CPUModel *model,
> +                                       strList **unavailable)
> +{
> +    S390FeatBitmap missing;
> +
> +    /* check general model compatibility */
> +    if (max_model->def->gen < model->def->gen ||
> +        (max_model->def->gen == model->def->gen &&
> +         max_model->def->ec_ga < model->def->ec_ga)) {
> +        list_add_feat("type", unavailable);
> +    }
> +
> +    /* detect missing features if any to properly report them */
> +    bitmap_andnot(missing, model->features, max_model->features,
> +                  S390_FEAT_MAX);
> +    if (!bitmap_empty(missing, S390_FEAT_MAX)) {
> +        s390_feat_bitmap_to_ascii(missing,
> +                                  unavailable,
> +                                  list_add_feat);

This certainly fits into one line.

> +    }
> +}
> +
> +struct CpuDefinitionInfoListData {
> +    CpuDefinitionInfoList *list;
> +    Error **errp;
> +};
> +
>  static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>  {
> -    CpuDefinitionInfoList **cpu_list = opaque;
> +    struct CpuDefinitionInfoListData *cpu_list_data = opaque;
> +    CpuDefinitionInfoList **cpu_list = &cpu_list_data->list;
>      CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>      char *name = g_strdup(object_class_get_name(klass));
>      S390CPUClass *scc = S390_CPU_CLASS(klass);
> +    Object *obj;
> +    S390CPU *sc;
> +    S390CPUModel *scm;
>  
>      /* strip off the -s390-cpu */
>      g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
> @@ -300,21 +336,33 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>      info->migration_safe = scc->is_migration_safe;
>      info->q_static = scc->is_static;
>      info->q_typename = g_strdup(object_class_get_name(klass));
> -
> +    /* check for unavailable features */
> +    obj = object_new(object_class_get_name(klass));
> +    sc = S390_CPU(obj);
> +    scm = get_max_cpu_model(cpu_list_data->errp);

Hmmmm, if this function fails, we will create the same error multiple
times (as there is no way to stop this function from iterating). And we
will fail to create a cpu model list in case there is no host cpu model,
which is a change in behavior (as we will report an error).

Would it be better to simply get the max model in
arch_query_cpu_definitions() and pass it via CpuDefinitionInfoListData,
instead of the errp variable?

Then you could simply skip the checks and set
info->has_unavailable_features = false in case there is no max model
(get_max_cpu_model() returned NULL / an error). (same behavior as for now)

Errors from get_max_cpu_model() then should be ignored and not reported.



> +    if (scm && sc->model) {
> +        info->has_unavailable_features = true;
> +        check_unavailable_features(scm, sc->model, &info->unavailable_features);
> +    }
>  
>      entry = g_malloc0(sizeof(*entry));
>      entry->value = info;
>      entry->next = *cpu_list;
>      *cpu_list = entry;
> +    object_unref(obj);
>  }
>  
>  CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
>  {
> -    CpuDefinitionInfoList *list = NULL;
> +    struct CpuDefinitionInfoListData list_data = {
> +        .list = NULL,
> +        .errp = errp,
> +    };
>  
> -    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false, &list);
> +    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false,
> +                         &list_data);
>  
> -    return list;
> +    return list_data.list;
>  }
>  
>  static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
> 


-- 

Thanks,

David
