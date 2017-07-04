Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dSKEn-0002Gb-3d
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dSKEj-0008Bw-57
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dSKEi-0008BX-Us
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:35:13 -0400
References: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <650c9114-67bf-1f5b-7155-7bb1c7813b21@redhat.com>
Date: Tue, 4 Jul 2017 11:35:09 +0200
MIME-Version: 1.0
In-Reply-To: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390: return unavailable features via
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

> +
>  static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>  {
> -    CpuDefinitionInfoList **cpu_list = opaque;
> +    struct CpuDefinitionInfoListData *cpu_list_data = opaque;
> +    CpuDefinitionInfoList **cpu_list = &cpu_list_data->list;
>      CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>      char *name = g_strdup(object_class_get_name(klass));
> @@ -300,7 +331,19 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>      info->migration_safe = scc->is_migration_safe;
>      info->q_static = scc->is_static;
>      info->q_typename = g_strdup(object_class_get_name(klass));
> -

Wonder if we should add the following:

/* the host model can never be used under TCG */
if (scc->kvm_required && !kvm_enabled())) {
    info->has_unavailable_features = true;
    list_add_feat("type", &info->unavailable_features);
} else if (cpu_list_data->model ...

> +    /* check for unavailable features */
> +    if (cpu_list_data->model) {
> +        Object *obj;
> +        S390CPU *sc;
> +        obj = object_new(object_class_get_name(klass));
> +        sc = S390_CPU(obj);

So we can drop the check here (if we have a host/max_model definition
under KVM, then all models have sc->model set). But the current code
should also work (it simply will not indicate runability information for
the "host" model under TCG, as sc->model will be NULL).

> +        if (sc->model) {
> +            info->has_unavailable_features = true;
> +            check_unavailable_features(cpu_list_data->model, sc->model,
> +                                       &info->unavailable_features);
> +        }
> +        object_unref(obj);
> +    }
>  
Looks good to me and produced the expected result under TCG.

Feel free to add my

Reviewed-by: David Hildenbrand <david@redhat.com>

with or without the modification.

-- 

Thanks,

David
