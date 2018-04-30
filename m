Received: from eggs.gnu.org ([2001:4830:134:3::10]:46840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5g7-0000oV-Sx
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5g2-0000FA-Qm
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:05:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD5g2-0000Er-JB
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:04:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so6160981wrf.5
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 03:04:58 -0700 (PDT)
References: <20180303002504.25142-1-aik@ozlabs.ru>
	<20180303002504.25142-2-aik@ozlabs.ru>
	<f3b6cbb3-4484-55cf-3529-ce1a9946904f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe645105-209e-6ba1-5661-d475cb74f3a8@redhat.com>
Date: Mon, 30 Apr 2018 12:04:55 +0200
MIME-Version: 1.0
In-Reply-To: <f3b6cbb3-4484-55cf-3529-ce1a9946904f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 1/2] qmp: Merge ObjectPropertyInfo
 and DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 18/04/2018 18:35, Eric Blake wrote:
> On 03/02/2018 06:25 PM, Alexey Kardashevskiy wrote:
>> ObjectPropertyInfo is more generic and only missing @description.
>> This adds a description to ObjectPropertyInfo and removes
>> DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
>> elsewhere.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v4:
>> * added (since 2.12) to the new field
> 
> And since it missed 2.12,

It is in 2.12:

commit 961c47bb8bacc9ae21c0760fa6e2594156299dd7
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Fri Mar 2 00:09:39 2018 +1100

    qmp: Add qom-list-properties to list QOM object properties
    
    There is already 'device-list-properties' which does most of the job,
    however it does not handle everything returned by qom-list-types such
    as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
    It does not handle abstract classes either.
    
    This adds a new qom-list-properties command which prints properties
    of a specific class and its instance. It is pretty much a simplified copy
    of the device-list-properties handler.
    
    Since it creates an object instance, device properties should appear
    in the output as they are copied to QOM properties at the instance_init
    hook.
    
    This adds a object_class_property_iter_init() helper to allow class
    properties enumeration uses it in the new QMP command to allow properties
    listing for abstract classes.
    
    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Message-Id: <20180301130939.15875-3-aik@ozlabs.ru>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

commit 35f63767dc77d85bebff6c6565aceaf74023776a
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Fri Mar 2 00:09:38 2018 +1100

    qmp: Merge ObjectPropertyInfo and DevicePropertyInfo
    
    ObjectPropertyInfo is more generic and only missing @description.
    This adds a description to ObjectPropertyInfo and removes
    DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
    elsewhere.
    
    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Message-Id: <20180301130939.15875-2-aik@ozlabs.ru>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

>> * removed wrong reindents
>> ---
>>  qapi-schema.json | 23 +++++------------------
>>  qdev-monitor.c   |  6 +++---
>>  qmp.c            | 14 +++++++-------
>>  3 files changed, 15 insertions(+), 28 deletions(-)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 0262b9f..5cdf89a 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1266,10 +1266,12 @@
>>  #        3) A link type in the form 'link<subtype>' where subtype is a qdev
>>  #           device type name.  Link properties form the device model graph.
>>  #
>> +# @description: if specified, the description of the property (since 2.12).
> 
> this should be tweaked to say since 2.13.
> 
> 
