Received: from eggs.gnu.org ([2001:4830:134:3::10]:50322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cjMFR-0000XX-MH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cjMFN-0007BJ-O9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:38:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cjMFN-0007BD-FS
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:38:01 -0500
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-6-git-send-email-mst@redhat.com>
	<87a894m72h.fsf@dusky.pond.sub.org>
	<15694a65-6ac4-9387-1cc2-89d5bb8660b9@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1987f7ea-6d16-c5c4-2ddb-cec3e18bd9f8@redhat.com>
Date: Thu, 2 Mar 2017 09:37:57 +0100
MIME-Version: 1.0
In-Reply-To: <15694a65-6ac4-9387-1cc2-89d5bb8660b9@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 05/15] qmp/hmp: add query-vm-generation-id
 and 'info vm-generation-id' commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/02/17 09:25, Laszlo Ersek wrote:
> On 03/02/17 09:11, Markus Armbruster wrote:
>> Crash bug, I'm afraid...
>>
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>
>>> From: Igor Mammedov <imammedo@redhat.com>
>>>
>>> Add commands to query Virtual Machine Generation ID counter.
>>>
>>> QMP command example:
>>>     { "execute": "query-vm-generation-id" }
>>>
>>> HMP command example:
>>>     info vm-generation-id
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  qapi-schema.json     | 20 ++++++++++++++++++++
>>>  hmp.h                |  1 +
>>>  hmp.c                |  9 +++++++++
>>>  hw/acpi/vmgenid.c    | 16 ++++++++++++++++
>>>  stubs/vmgenid.c      |  9 +++++++++
>>>  hmp-commands-info.hx | 14 ++++++++++++++
>>>  stubs/Makefile.objs  |  1 +
>>>  7 files changed, 70 insertions(+)
>>>  create mode 100644 stubs/vmgenid.c
>>>
>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>> index d6186d4..84692da 100644
>>> --- a/qapi-schema.json
>>> +++ b/qapi-schema.json
>>> @@ -6188,3 +6188,23 @@
>>>  #
>>>  ##
>>>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
>>> +
>>> +##
>>> +# @GuidInfo:
>>> +#
>>> +# GUID information.
>>> +#
>>> +# @guid: the globally unique identifier
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
>>> +
>>> +##
>>> +# @query-vm-generation-id:
>>> +#
>>> +# Show Virtual Machine Generation ID
>>> +#
>>> +# Since 2.9
>>> +##
>>> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> [...]
>>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>>> index c8465df..744f284 100644
>>> --- a/hw/acpi/vmgenid.c
>>> +++ b/hw/acpi/vmgenid.c
>>> @@ -240,3 +240,19 @@ static void vmgenid_register_types(void)
>>>  }
>>>  
>>>  type_init(vmgenid_register_types)
>>> +
>>> +GuidInfo *qmp_query_vm_generation_id(Error **errp)
>>> +{
>>> +    GuidInfo *info;
>>> +    VmGenIdState *vms;
>>> +    Object *obj = find_vmgenid_dev();
>>> +
>>> +    if (!obj) {
>>> +        return NULL;
>>> +    }
>>> +    vms = VMGENID(obj);
>>> +
>>> +    info = g_malloc0(sizeof(*info));
>>> +    info->guid = qemu_uuid_unparse_strdup(&vms->guid);
>>> +    return info;
>>> +}
>>
>> This either returns a GuidInfo or NULL.
>>
>> If it returns NULL, the generated qmp_marshal_output_GuidInfo() will
>> crash like this:
>>
>> #0  0x00007fffdb4c7765 in raise () at /lib64/libc.so.6
>> #1  0x00007fffdb4c936a in abort () at /lib64/libc.so.6
>> #2  0x00007fffdb4bff97 in __assert_fail_base () at /lib64/libc.so.6
>> #3  0x00007fffdb4c0042 in  () at /lib64/libc.so.6
>> #4  0x0000555555c800a0 in visit_start_struct (v=
>>     0x555557727000, name=0x555555cf29e8 "unused", obj=0x7fffffffc7c8, size=8, errp=0x7fffffffc790) at /work/armbru/qemu/qapi/qapi-visit-core.c:49
>> #5  0x0000555555c5d398 in visit_type_GuidInfo (v=
>>     0x555557727000, name=0x555555cf29e8 "unused", obj=0x7fffffffc7c8, errp=0x7fffffffc7d8) at qapi-visit.c:6038
>> #6  0x0000555555922fc0 in qmp_marshal_output_GuidInfo (ret_in=0x0, ret_out=0x7fffffffc870, errp=0x7fffffffc820) at qmp-marshal.c:5148
>> #7  0x0000555555923123 in qmp_marshal_query_vm_generation_id (args=0x555557a67500, ret=0x7fffffffc870, errp=0x7fffffffc868) at qmp-marshal.c:5186
>> #8  0x0000555555c83a73 in do_qmp_dispatch (request=0x555556ab3200, errp=0x7fffffffc8c0) at /work/armbru/qemu/qapi/qmp-dispatch.c:97
>> #9  0x0000555555c83ba3 in qmp_dispatch (request=0x555556ab3200)
>>     at /work/armbru/qemu/qapi/qmp-dispatch.c:124
>> #10 0x00005555557bb671 in handle_qmp_command (parser=
>>     0x5555568776b0, tokens=0x555556858520) at /work/armbru/qemu/monitor.c:3789
>> #11 0x0000555555c8af2f in json_message_process_token (lexer=0x5555568776b8, input=0x5555568582e0, type=JSON_RCURLY, x=48, y=1)
>>     at /work/armbru/qemu/qobject/json-streamer.c:105
>>
>> Sorry for not having reviewed this earlier.  On the other hand, how come
>> this survived testing?
> 
> We primarily focused on testing the functionality, not the failure /
> corner cases, I think. (There are at least two other known startup
> scenarios that are not handled correctly just yet, although they don't
> crash -- multiple vmgenid devices, and vmgenid on machtypes without
> writeable fw_cfg.)
> 
> Also, in my testing I only called the monitor command via HMP (from
> virsh), and AFAICS that one doesn't crash even if the device is missing.
> Nonetheless, qmp_query_vm_generation_id() should set an error when it
> returns NULL, yes.
> 
> I think Ben wants to post a followup series with those fixes mentioned
> above, in time for 2.9, perhaps this crash can be addressed in there
> too. Ben?

Regarding your other email ("New QMP command without a test -> automatic
NAK"), Ben did write a small test suite for this feature:

[Qemu-devel] [PATCH v8 7/8] tests: Add unit tests for the VM Generation
                            ID feature

and it contains a test called "/vmgenid/vmgenid/query-monitor".

That patch is not part of the pull request because the functional tests
in the same suite only pass if you have an updated SeaBIOS blob in the
tree as well. While the SeaBIOS patches have been committed, the update
for the blob bundled with QEMU is still in progress. Thus the patch with
the tests is being delayed.

So, it wasn't negligence, we simply missed this failure case because we
were so focused on the long-awaited functionality. We didn't miss other
failure cases that were a bit closer to the functionality.

BTW, now that I look at said "/vmgenid/vmgenid/query-monitor" test case,
it also doesn't seem to catch this error -- the monitor command is
apparently not called without the device present. So yeah, review
focused specifically on QMP / QAPI bits is always welcome.

Thanks
Laszlo
