Received: from eggs.gnu.org ([2001:4830:134:3::10]:46397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgDeJ-0005TU-PU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgDeG-0007Tj-IP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:50:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgDeG-0007TU-1J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:50:44 -0500
References: <918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
	<20170220201923.GM2372@work-vm>
	<d51d4a21-5558-d4e5-5b7e-08f729fc1a5e@redhat.com>
	<0488d90c-f73c-916c-f84c-a1ffd2bad592@redhat.com>
	<20170221034053-mutt-send-email-mst@kernel.org>
	<5676cac1-b161-0500-e7ed-e93c273cc178@redhat.com>
	<20170221161048-mutt-send-email-mst@kernel.org>
	<9f52e1a6-9ed0-5736-6641-100c332899ab@redhat.com>
	<20170221180947-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0e0537de-3f1f-016f-141c-0928f2fd0c39@redhat.com>
Date: Tue, 21 Feb 2017 17:50:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170221180947-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com

On 02/21/17 17:17, Michael S. Tsirkin wrote:
> On Tue, Feb 21, 2017 at 05:08:40PM +0100, Laszlo Ersek wrote:
>> On 02/21/17 15:14, Michael S. Tsirkin wrote:
>>> On Tue, Feb 21, 2017 at 10:58:05AM +0100, Laszlo Ersek wrote:
>>>> On 02/21/17 02:43, Michael S. Tsirkin wrote:
>>>>> On Mon, Feb 20, 2017 at 09:55:40PM +0100, Laszlo Ersek wrote:
>>>>>> On 02/20/17 21:45, Eric Blake wrote:
>>>>>>> On 02/20/2017 02:19 PM, Dr. David Alan Gilbert wrote:
>>>>>>>> * Eric Blake (eblake@redhat.com) wrote:
>>>>>>>>> On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
>>>>>>>>>> * Laszlo Ersek (lersek@redhat.com) wrote:
>>>>>>>>>>> CC Dave
>>>>>>>>>>
>>>>>>>>>> This isn't an area I really understand; but if I'm
>>>>>>>>>> reading this right then 
>>>>>>>>>>    vmgenid is stored in fw_cfg?
>>>>>>>>>>    fw_cfg isn't migrated
>>>>>>>>>>
>>>>>>>>>> So why should any changes to it get migrated, except if it's already
>>>>>>>>>> been read by the guest (and if the guest reads it again aftwards what's
>>>>>>>>>> it expected to read?)
>>>>>>>>>
>>>>>>>>> Why are we expecting it to change on migration?  You want a new value
>>>>>>>>
>>>>>>>> I'm not; I was asking why a change made prior to migration would be
>>>>>>>> preserved across migration.
>>>>>>>
>>>>>>> Okay, so you're asking what happens if the source requests the vmgenid
>>>>>>> device, and sets an id, but the destination of the migration does not
>>>>>>> request anything
>>>>>>
>>>>>> This should never happen, as it means different QEMU command lines on
>>>>>> source vs. target hosts. (Different as in "incorrectly different".)
>>>>>>
>>>>>> Dave writes, "a change made prior to migration". Change made to what?
>>>>>>
>>>>>> - the GUID cannot be changed via the monitor once QEMU has been started.
>>>>>> We dropped the monitor command for that, due to lack of a good use case,
>>>>>> and due to lifecycle complexities. We have figured out a way to make it
>>>>>> safe, but until there's a really convincing use case, we shouldn't add
>>>>>> that complexity.
>>>>>
>>>>> True but we might in the future, and it seems prudent to make
>>>>> migration stream future-proof for that.
>>>>
>>>> It is already.
>>>>
>>>> The monitor command, if we add it, can be implemented incrementally. I
>>>> described it as "approach (iii)" elsewhere in the thread. This is a more
>>>> detailed recap:
>>>>
>>>> - introduce a new device property (internal only), such as
>>>>   "x-enable-set-vmgenid". Make it reflect whether a given machine type
>>>>   supports the monitor command.
>>>
>>> This is the part we can avoid at no real cost just
>>> by making sure the guid is migrated.
>>>
>>>
>>>> - change the /etc/vmgenid_guid fw_cfg blob from callback-less to one
>>>>   with a selection callback
>>>>
>>>> - add a new boolean latch to the vmgenid device, called
>>>>   "guid_blob_selected" or something similar
>>>>
>>>> - the reset handler sets the latch to FALSE
>>>>   (NB: the reset handler already sets /etc/vmgenid_addr to zero)
>>>>
>>>> - the select callback for /etc/vmgenid_guid sets the latch to TRUE
>>>>
>>>> - the latch is added to the migration stream as a subsection *if*
>>>>   x-enable-set-vmgenid is TRUE
>>>>
>>>> - the set-vmgenid monitor command checks all three of:
>>>>   x-enable-set-vmgenid, the latch, and the contents of
>>>>   /etc/vmgenid_addr:
>>>>
>>>>   - if x-enable-set-vmgenid is FALSE, the monitor command returns
>>>>     QERR_UNSUPPORTED (this is a generic error class, with an
>>>>     "unsupported" error message). Otherwise,
>>>>
>>>>   - if the latch is TRUE *and* /etc/vmgenid_addr is zero, then the
>>>>     guest firmware has executed (or started executing) ALLOCATE for
>>>>     /etc/vmgenid_guid, but it has not executed WRITE_POINTER yet.
>>>>     In this case updating the VMGENID from the monitor is unsafe
>>>>     (we cannot guarantee informing the guest successfully), so in this
>>>>     case the monitor command fails with ERROR_CLASS_DEVICE_NOT_ACTIVE.
>>>>     The caller should simply try a bit later. (By which time the
>>>>     firmware will likely have programmed /etc/vmgenid_addr.)
>>>
>>> This makes no sense to me. Just update it in qemu memory
>>> and write when guest asks for it.
>>
>> I designed the above (sorry if "designed" is a word too pompous for
>> this) quite explicitly to address your concern as to what would happen
>> if someone tried to massage the GUID via the monitor while the firmware
>> was between ALLOCATE and WRITE_POINTER.
>>
>> Also, we don't know when the guest "asks" for the GUID (in guest RAM).
>> It just evaluates ADDR (maybe always, maybe only once, at guest driver
>> startup), and then it just looks at RAM whenever it wants to.
>>
>> This is why this idea seeks to track the guest's state -- if the guest
>> is before ALLOCATE, it's okay to update the fw_cfg blob, if it is
>> between ALLOCATE and WRITE_POINTER, reject the monitor command
>> (temporarily), and if the guest is after WRITE_POINTER, update the RAM
>> and inject the SCI.
>>
>> We cannot see *exactly* when the guest has just finished writing the
>> address. We have only select callbacks for fw_cfg items, not write
>> callbacks. And a select callback is no good for the address blob,
>> because it would be invoked *before* the guest writes the address.
>>
>> We discussed these facts several days (weeks?) and several iterations
>> ago. The longer term remedy we came up was the above design. The shorter
>> term remedy was to drop the "set" monitor command, because we couldn't
>> figure out a management layer use case for that monitor command.
>>
>> If you now (at v8) insist to future proof the design for a potential
>> "set" monitor command, that's exactly the same as if you were requiring
>> Ben to implement the monitor command right now. Except this is worse,
>> because we dropped the monitor command in v6 (from v5), and you didn't
>> protest.
> 
> I'm merging this as-is

Thank you!

> but I think the concerns are overblown.
> We have many fields which devices DMA into guest memory
> and changing them is easy.
> 
> It should be a simple matter to update guid copy in
> fw cfg blob, and *if we have the address*, DMA there
> and send SCI.

I think this was more or less what Ben's v5 did, and (again, as far as I
recall) you were concerned about its safety:

msgid: <20170206201249-mutt-send-email-mst@kernel.org>
URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg427927.html

msgid: <20170206210237-mutt-send-email-mst@kernel.org>
URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg427935.html

Again, at that point I "invented" the above elaborate design *only* to
address your concern. If you are not concerned any longer (or, if you
had never had this exact concern, I just misunderstood you), then I'm
fine dropping all of the above -- I definitely don't strive to implement
(or request) the above out of my own initiative.

Please see item (5) in the following message:

msgid: <14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg428296.html

The design above is just "approach (iii)" expanded with more details,
from under said item (5). You didn't react there, and I thought you were
okay with the idea.

Then Ben went on to drop the "set" monitor command in v6, and you didn't
comment on that either -- so I assumed you were okay with that too.

> 
> Yes we don't know when does guest look at guid but that
> is simply up to guest. It needs to look at it at the
> right time.
> 
> So the implementation is really easy I think.

That's for the best!

> 
> The real problem is that we will have migrated guid
> and command line guid and which one wins if they conflict.
> And that is IMO something we need to figure out now and
> not later.

Neither Ben nor myself seem to know when the management layer would want
to call the "set" monitor command, and youor question is really hard to
answer without that knowledge.

(Under my proposal, the question does not really exist, because the GUID
set last on the source host needs not be migrated except as part of
guest RAM, and it's always the command line GUID on the target host that
takes precedence after migration and gets written into guest RAM.)

In other words, it is for libvirt / users / etc to say why they would
want to set GUID-A with the monitor command on the source host, *and*
then start up QEMU on the target host with GUID-B on the command line.

... Either way, I would let GUID-B take effect.

Thanks
Laszlo
