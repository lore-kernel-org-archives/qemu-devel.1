Received: from eggs.gnu.org ([2001:4830:134:3::10]:37573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gSfEo-0003dI-Ow
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gSfEl-000160-Di
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:37:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gSfEl-00015I-2A
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:37:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CBBB308FBA4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:37:26 +0000 (UTC)
References: <20181129185754.7009-1-ehabkost@redhat.com>
	<874lbzneoy.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c3dc6fe2-b999-26ed-aee1-3cba6654740b@redhat.com>
Date: Fri, 30 Nov 2018 10:37:24 +0100
MIME-Version: 1.0
In-Reply-To: <874lbzneoy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: Validate host-nodes before
 setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 30.11.18 09:37, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
>> host_memory_backend_set_host_nodes() was not validating
>> host-nodes before writing to backend->host_nodes, making QEMU
>> write beyond the end of the bitmap.
>>
>> Fix the crash and add a simple regression test for the fix.
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  backends/hostmem.c                   | 13 +++++++---
>>  tests/acceptance/host-nodes-limit.py | 36 ++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>  create mode 100644 tests/acceptance/host-nodes-limit.py
>>
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 1a89342039..ef199d32fd 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -103,11 +103,18 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
>>  {
>>  #ifdef CONFIG_NUMA
>>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
>> -    uint16List *l = NULL;
>> +    uint16List *l, *host_nodes = NULL;
>>  
>> -    visit_type_uint16List(v, name, &l, errp);
>> +    visit_type_uint16List(v, name, &host_nodes, errp);
>> +
>> +    for (l = host_nodes; l; l = l->next) {
>> +        if (l->value >= MAX_NODES) {
>> +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
>> +            return;
>> +        }
>> +    }
>>  
>> -    while (l) {
>> +    for (l = host_nodes; l; l = l->next) {
>>          bitmap_set(backend->host_nodes, l->value, 1);
>>          l = l->next;
>>      }
> 
> Pre-existing: leaks the list created by visit_type_uint16List(), or am I
> confused?
> 

I think you're right.

-- 

Thanks,

David / dhildenb
