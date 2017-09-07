Received: from eggs.gnu.org ([2001:4830:134:3::10]:34776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq32A-0001Js-Tu
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq326-00032q-AS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq326-00031c-4W
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:04:14 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-16-david@redhat.com>
	<20170907172222.6307d887.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e5f9a8e9-a9ca-1b77-f937-8033ad270cfa@redhat.com>
Date: Thu, 7 Sep 2017 22:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170907172222.6307d887.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/19] s390x: print CPU definitions in
 sorted order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>


>> +    CPUListState *s = user_data;
>> +    const S390CPUClass *scc = S390_CPU_CLASS((ObjectClass *)data);
>> +    char *name = g_strdup(object_class_get_name((ObjectClass *)data));
>>  
>>      /* strip off the -s390-cpu */
>>      g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
>> -    (*info->print)(info->f, "s390 %-15s %-35s %s\n", name, scc->desc,
>> -                   details);
>> +    (*s->cpu_fprintf)(s->file, "s390 %-15s %-35s (%smigration-safe)\n", name,
>> +                      scc->desc, scc->is_static ? "static, " : "");
> 
> Hm, that now prints 's390 host' as 'migration safe'...

Very good point, will fix, thanks!

> 
>>      g_free(name);
>>  }
>>  
>> +static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
>> +{
>> +    const S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *)a);
>> +    const S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *)b);
>> +    const char *name_a = object_class_get_name((ObjectClass *)a);
>> +    const char *name_b = object_class_get_name((ObjectClass *)b);
>> +
>> +    /* move qemu and host to the top of the list, qemu first, host second */
>> +    if (name_a[0] == 'q') {
>> +        return -1;
>> +    } else if (name_b[0] == 'q') {
>> +        return 1;
>> +    } else if (name_a[0] == 'h') {
>> +        return -1;
>> +    } else if (name_b[0] == 'h') {
>> +        return 1;
>> +    }
> 
> Are we sure that there will never be models starting with q or h? But
> we can worry about that later.

Could be but unlikely. In the worst case sorting would be wrong, I think
we can live with that :)


-- 

Thanks,

David
