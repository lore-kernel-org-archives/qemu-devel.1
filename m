Received: from eggs.gnu.org ([2001:4830:134:3::10]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cq0kg-00005A-Kp
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cq0kb-0006Si-N3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cq0kb-0006S8-EY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:05:45 -0400
References: <20170320115951.25345-1-lersek@redhat.com>
	<20170320115951.25345-3-lersek@redhat.com>
	<20170320161539-mutt-send-email-mst@kernel.org>
	<783bd4f6-faf9-1562-99f6-36556ed3d0cb@redhat.com>
	<3b0262b6-1f63-a962-edcb-dfed64eca2b1@redhat.com>
	<20170320182413-mutt-send-email-mst@kernel.org>
	<aa20535f-2e33-6f82-cdc8-aceef0d6031a@redhat.com>
	<20170320185352-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1dfc751f-d161-de4f-f4f7-64c41aeea01e@redhat.com>
Date: Mon, 20 Mar 2017 18:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170320185352-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/acpi/vmgenid: prevent more than one
 vmgenid device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

On 03/20/17 17:57, Michael S. Tsirkin wrote:
> On Mon, Mar 20, 2017 at 05:39:18PM +0100, Laszlo Ersek wrote:
>> On 03/20/17 17:26, Michael S. Tsirkin wrote:
>>> On Mon, Mar 20, 2017 at 05:22:16PM +0100, Laszlo Ersek wrote:
>>>> On 03/20/17 16:13, Laszlo Ersek wrote:
>>>>> On 03/20/17 15:16, Michael S. Tsirkin wrote:
>>>>>> On Mon, Mar 20, 2017 at 12:59:51PM +0100, Laszlo Ersek wrote:
>>>>>>> Multiple instances make no sense.
>>>>>>>
>>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>>> Cc: Ben Warren <ben@skyportsystems.com>
>>>>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>>>>
>>>>>> find_vmgenid_dev would be a better place for this.
>>>>>> This is where the single instance assumption comes from ATM.
>>>>>
>>>>> object_resolve_path_type() -- used internally in find_vmgenid_dev() --
>>>>> returns NULL in either of two cases: there is no such device, or there
>>>>> are multiple devices. You can tell them apart by looking at the last
>>>>> parameter (called "ambiguous"), but find_vmgenid_dev() doesn't use that
>>>>> parameter.
>>>>>
>>>>> By the time we are in the vmgenid_realize() function, at least one
>>>>> vmgenid device is guaranteed to exist (the one which we are realizing).
>>>>> Therefore, this patch could be simplified as:
>>>>>
>>>>> if (find_vmgenid_dev() == NULL) {
>>>>>   error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
>>>>>   return;
>>>>> }
>>>>>
>>>>> I found that confusing, and wanted to spell out "ambiguous" with the
>>>>> assert(). If you prefer the above simpler (but harder to understand)
>>>>> check, I can do that too.
>>>>
>>>> Also, find_vmgenid_dev() only captures the single instance assumption,
>>>> it does not dictate the assumption. The assumption comes from the spec.
>>>
>>> I don't see this assumption anywhere in spec. What do you have in mind?
>>
>> It has language like
>>
>> "1. Put the generation ID in an 8-byte aligned buffer in guest RAM [...]"
>>
>> "2. Expose a device somewhere in the ACPI namespace [...]"
>>
>> "5. When the generation ID changes, execute an ACPI Notify operation on
>> the generation ID device [...]"
>>
>> "After the identifier has been made persistent in the configuration [...]"
>>
>> The spec defines a system-wide feature, and in all contexts it implies
>> there is only one of those things. The multiple device case is undefined
>> by omission, if you will.
> 
> I see.
> 
>>>> With the above in mind, what do you say about this patch? Do you want me
>>>> to call find_vmgenid_dev() in the realize function (which will require a
>>>> comment about object_resolve_path_type's behavior), or are you okay with
>>>> the patch as-is? (The asserts make it clear IMO.)
>>>>
>>>> Thanks
>>>> Laszlo
>>>
>>> I prefer calling find_vmgenid_dev, and adding a comment
>>> near find_vmgenid_dev.
>>
>> Near the function definition in "include/hw/acpi/vmgenid.h", or the call
>> site in the realize function?
>>
>> Thanks
>> Laszlo
> 
> I'd put it near the function itself.

Thanks -- meanwhile I figured I'd put a comment at both locations, just
to be sure. I'm about to post v2.

Thanks!
Laszlo
