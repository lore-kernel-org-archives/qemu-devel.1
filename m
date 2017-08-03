Received: from eggs.gnu.org ([2001:4830:134:3::10]:45307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddG4A-0003IP-DU
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddG49-0007VR-7W
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:21:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170802103259.25940-1-lvivier@redhat.com>
	<CAAdtpL4fDx3JLm7+=TcJTZXwq_zuwup4=zkGH8QMLJ1ES=kqHw@mail.gmail.com>
	<de5b3384-086b-bf7f-944f-94d10e185a7d@redhat.com>
	<20170802212933.GG3108@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f0af521-5ff7-2d17-4bc7-c18f871444cf@amsat.org>
Date: Thu, 3 Aug 2017 10:21:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170802212933.GG3108@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 08/02/2017 06:29 PM, Eduardo Habkost wrote:
> On Wed, Aug 02, 2017 at 03:50:36PM +0200, Laurent Vivier wrote:
>> On 02/08/2017 15:42, Philippe Mathieu-Daudé wrote:
>>> Hi Laurent,
>>>
>>> On Wed, Aug 2, 2017 at 7:32 AM, Laurent Vivier <lvivier@redhat.com> wrote:
>>>> With pseries machine type a negative core-id is not managed properly:
>>>> -1 gives an inaccurate error message ("core -1 already populated"),
>>>> -2 crashes QEMU (core dump)
>>>>
>>>> As it seems a negative value is invalid for any architecture,
>>>> instead of checking this in spapr_core_pre_plug() I think it's better
>>>> to check this in the generic part, core_prop_set_core_id()
>>>
>>> Why is this property signed? If there is not reason to use it negative,
>>> is it possible to use object_property_add(.."uint"..)?
>>
>> You should be right:
>>
>> { 'struct': 'NumaNodeOptions',
>>    'data': {
>>     '*nodeid': 'uint16',
>>     '*cpus':   ['uint16'],
>>     '*mem':    'size',
>>     '*memdev': 'str' }}
>>
>> but
>>
>> { 'struct': 'CpuInstanceProperties',
>>    'data': { '*node-id': 'int',
>>              '*socket-id': 'int',
>>              '*core-id': 'int',
>>              '*thread-id': 'int'
>>    }
>> }
>>
>> But I'm not sure it's a good idea to change the API now.
> 
> Property parsing is not affected by the QAPI schema at all, so
> touching the schema wouldn't fix the bug.
> 
> The same applies to the 'type' argument to object_property_add():
> it is ignored everywhere.
> 
> However, the property setter can simply use a visitor for unsigned values, and
> it will reject negative values automatically, e.g.:
> 
>    diff --git a/hw/cpu/core.c b/hw/cpu/core.c
>    index 2bf960d..b5af2bf 100644
>    --- a/hw/cpu/core.c
>    +++ b/hw/cpu/core.c
>    @@ -25,9 +25,9 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
>     {
>         CPUCore *core = CPU_CORE(obj);
>         Error *local_err = NULL;
>    -    int64_t value;
>    +    uint32_t value;
>     
>    -    visit_type_int(v, name, &value, &local_err);
>    +    visit_type_uint32(v, name, &value, &local_err);
>         if (local_err) {
>             error_propagate(errp, local_err);
>             return;
> 
> 
>    $ ./ppc64-softmmu/qemu-system-ppc64 -device POWER8_v2.0-spapr-cpu-core,core-id=-2
>    qemu-system-ppc64: -device POWER8_v2.0-spapr-cpu-core,core-id=-2: Parameter 'core-id' expects uint32_t
> 
> 
> I would suggest changing the CPUCore struct fields to uint32_t or
> uint64_t, but it would be more intrusive and we're past hard
> freeze.  Your patch looks good for 2.10.

Laurent with a /* TODO ... */  you can add:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> I'm queueing it on machine-next.
> 
