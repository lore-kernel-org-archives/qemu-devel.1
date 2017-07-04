Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSKOC-0001lu-PB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSKO9-0004Hc-K2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:45:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49514
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSKO9-0004HI-DU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:44:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v649iTKX037682
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 05:44:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bg1rnymrn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 05:44:56 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 05:44:55 -0400
References: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<650c9114-67bf-1f5b-7155-7bb1c7813b21@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 11:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <650c9114-67bf-1f5b-7155-7bb1c7813b21@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <8676f1e4-3d93-51d7-6d6c-7d819c0420c1@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.vnet.ibm.com

On 07/04/2017 11:35 AM, David Hildenbrand wrote:
>> +
>>  static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>>  {
>> -    CpuDefinitionInfoList **cpu_list = opaque;
>> +    struct CpuDefinitionInfoListData *cpu_list_data = opaque;
>> +    CpuDefinitionInfoList **cpu_list = &cpu_list_data->list;
>>      CpuDefinitionInfoList *entry;
>>      CpuDefinitionInfo *info;
>>      char *name = g_strdup(object_class_get_name(klass));
>> @@ -300,7 +331,19 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>>      info->migration_safe = scc->is_migration_safe;
>>      info->q_static = scc->is_static;
>>      info->q_typename = g_strdup(object_class_get_name(klass));
>> -
> 
> Wonder if we should add the following:
> 
> /* the host model can never be used under TCG */
> if (scc->kvm_required && !kvm_enabled())) {
>     info->has_unavailable_features = true;
>     list_add_feat("type", &info->unavailable_features);
> } else if (cpu_list_data->model ...
> 
>> +    /* check for unavailable features */
>> +    if (cpu_list_data->model) {
>> +        Object *obj;
>> +        S390CPU *sc;
>> +        obj = object_new(object_class_get_name(klass));
>> +        sc = S390_CPU(obj);
> 
> So we can drop the check here (if we have a host/max_model definition
> under KVM, then all models have sc->model set). But the current code
> should also work (it simply will not indicate runability information for
> the "host" model under TCG, as sc->model will be NULL).
> 
>> +        if (sc->model) {
>> +            info->has_unavailable_features = true;
>> +            check_unavailable_features(cpu_list_data->model, sc->model,
>> +                                       &info->unavailable_features);
>> +        }
>> +        object_unref(obj);
>> +    }
>>  
> Looks good to me and produced the expected result under TCG.
> 
> Feel free to add my
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks. Viktor I can pick this version or wait for a v4. What do you prefer?
