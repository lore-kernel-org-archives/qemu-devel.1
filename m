Received: from eggs.gnu.org ([2001:4830:134:3::10]:57256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruqw-0005fa-VN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruqt-0005um-NO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:16:42 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eruqt-0005tm-Ds
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:16:39 -0500
Received: by mail-pl0-x241.google.com with SMTP id k8-v6so6587134pli.8
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 16:16:38 -0800 (PST)
References: <20180301130939.15875-1-aik@ozlabs.ru>
	<20180301130939.15875-2-aik@ozlabs.ru>
	<3986fcf2-844d-bc49-d297-960f788c3941@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a0332035-49f2-2ae2-b8aa-d46a193025bf@ozlabs.ru>
Date: Sat, 3 Mar 2018 11:16:31 +1100
MIME-Version: 1.0
In-Reply-To: <3986fcf2-844d-bc49-d297-960f788c3941@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 1/2] qmp: Merge ObjectPropertyInfo
 and DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 03/03/18 00:37, Eric Blake wrote:
> On 03/01/2018 07:09 AM, Alexey Kardashevskiy wrote:
>> ObjectPropertyInfo is more generic and only missing @description.
>> This adds a description to ObjectPropertyInfo and removes
>> DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
>> elsewhere.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   qapi-schema.json | 23 +++++------------------
>>   qdev-monitor.c   |  6 +++---
>>   qmp.c            | 20 ++++++++++----------
>>   3 files changed, 18 insertions(+), 31 deletions(-)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 0262b9f..87327e5 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1266,10 +1266,12 @@
>>   #        3) A link type in the form 'link<subtype>' where subtype is a
>> qdev
>>   #           device type name.  Link properties form the device model
>> graph.
>>   #
>> +# @description: if specified, the description of the property.
> 
> Missing a '(since 2.12)' tag.
> 
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'ObjectPropertyInfo',
>> -  'data': { 'name': 'str', 'type': 'str' } }
>> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
>>   +++ b/qmp.c
>> @@ -463,12 +463,12 @@ ObjectTypeInfoList *qmp_qom_list_types(bool
>> has_implements,
>>    *
>>    * The caller must free the return value.
>>    */
>> -static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
>> -                                                     const char *name,
>> -                                                     const char
>> *default_type,
>> -                                                     const char
>> *description)
>> +static ObjObjectPropertyInfoectPropertyInfo *make_device_property_info(ObjectClass *klass,
>> +                                                  const char *name,
>> +                                                  const char *default_type,
>> +                                                  const char *description)
> 
> Why the indentation change?


Oh. Leftover from DevicePropertyInfo->(non-existng) OOMPropertyInfo. I'll
repost.


> 
>> @@ -508,14 +508,14 @@ static DevicePropertyInfo
>> *make_device_property_info(ObjectClass *klass,
>>       return info;
>>   }
>>   -DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
>> -                                                   Error **errp)
>> +ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>> +                                                Error **errp)
> 
> and again
> 
> Otherwise looks okay
> 


-- 
Alexey
