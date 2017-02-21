Received: from eggs.gnu.org ([2001:4830:134:3::10]:34132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgCzf-0006mC-U8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgCzc-0004MR-IT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:08:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgCzc-0004MH-9R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:08:44 -0500
References: <88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
	<20170220201923.GM2372@work-vm>
	<d51d4a21-5558-d4e5-5b7e-08f729fc1a5e@redhat.com>
	<0488d90c-f73c-916c-f84c-a1ffd2bad592@redhat.com>
	<20170221034053-mutt-send-email-mst@kernel.org>
	<5676cac1-b161-0500-e7ed-e93c273cc178@redhat.com>
	<20170221161048-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9f52e1a6-9ed0-5736-6641-100c332899ab@redhat.com>
Date: Tue, 21 Feb 2017 17:08:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170221161048-mutt-send-email-mst@kernel.org>
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

On 02/21/17 15:14, Michael S. Tsirkin wrote:
> On Tue, Feb 21, 2017 at 10:58:05AM +0100, Laszlo Ersek wrote:
>> On 02/21/17 02:43, Michael S. Tsirkin wrote:
>>> On Mon, Feb 20, 2017 at 09:55:40PM +0100, Laszlo Ersek wrote:
>>>> On 02/20/17 21:45, Eric Blake wrote:
>>>>> On 02/20/2017 02:19 PM, Dr. David Alan Gilbert wrote:
>>>>>> * Eric Blake (eblake@redhat.com) wrote:
>>>>>>> On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
>>>>>>>> * Laszlo Ersek (lersek@redhat.com) wrote:
>>>>>>>>> CC Dave
>>>>>>>>
>>>>>>>> This isn't an area I really understand; but if I'm
>>>>>>>> reading this right then 
>>>>>>>>    vmgenid is stored in fw_cfg?
>>>>>>>>    fw_cfg isn't migrated
>>>>>>>>
>>>>>>>> So why should any changes to it get migrated, except if it's already
>>>>>>>> been read by the guest (and if the guest reads it again aftwards what's
>>>>>>>> it expected to read?)
>>>>>>>
>>>>>>> Why are we expecting it to change on migration?  You want a new value
>>>>>>
>>>>>> I'm not; I was asking why a change made prior to migration would be
>>>>>> preserved across migration.
>>>>>
>>>>> Okay, so you're asking what happens if the source requests the vmgenid
>>>>> device, and sets an id, but the destination of the migration does not
>>>>> request anything
>>>>
>>>> This should never happen, as it means different QEMU command lines on
>>>> source vs. target hosts. (Different as in "incorrectly different".)
>>>>
>>>> Dave writes, "a change made prior to migration". Change made to what?
>>>>
>>>> - the GUID cannot be changed via the monitor once QEMU has been started.
>>>> We dropped the monitor command for that, due to lack of a good use case,
>>>> and due to lifecycle complexities. We have figured out a way to make it
>>>> safe, but until there's a really convincing use case, we shouldn't add
>>>> that complexity.
>>>
>>> True but we might in the future, and it seems prudent to make
>>> migration stream future-proof for that.
>>
>> It is already.
>>
>> The monitor command, if we add it, can be implemented incrementally. I
>> described it as "approach (iii)" elsewhere in the thread. This is a more
>> detailed recap:
>>
>> - introduce a new device property (internal only), such as
>>   "x-enable-set-vmgenid". Make it reflect whether a given machine type
>>   supports the monitor command.
> 
> This is the part we can avoid at no real cost just
> by making sure the guid is migrated.
> 
> 
>> - change the /etc/vmgenid_guid fw_cfg blob from callback-less to one
>>   with a selection callback
>>
>> - add a new boolean latch to the vmgenid device, called
>>   "guid_blob_selected" or something similar
>>
>> - the reset handler sets the latch to FALSE
>>   (NB: the reset handler already sets /etc/vmgenid_addr to zero)
>>
>> - the select callback for /etc/vmgenid_guid sets the latch to TRUE
>>
>> - the latch is added to the migration stream as a subsection *if*
>>   x-enable-set-vmgenid is TRUE
>>
>> - the set-vmgenid monitor command checks all three of:
>>   x-enable-set-vmgenid, the latch, and the contents of
>>   /etc/vmgenid_addr:
>>
>>   - if x-enable-set-vmgenid is FALSE, the monitor command returns
>>     QERR_UNSUPPORTED (this is a generic error class, with an
>>     "unsupported" error message). Otherwise,
>>
>>   - if the latch is TRUE *and* /etc/vmgenid_addr is zero, then the
>>     guest firmware has executed (or started executing) ALLOCATE for
>>     /etc/vmgenid_guid, but it has not executed WRITE_POINTER yet.
>>     In this case updating the VMGENID from the monitor is unsafe
>>     (we cannot guarantee informing the guest successfully), so in this
>>     case the monitor command fails with ERROR_CLASS_DEVICE_NOT_ACTIVE.
>>     The caller should simply try a bit later. (By which time the
>>     firmware will likely have programmed /etc/vmgenid_addr.)
> 
> This makes no sense to me. Just update it in qemu memory
> and write when guest asks for it.

I designed the above (sorry if "designed" is a word too pompous for
this) quite explicitly to address your concern as to what would happen
if someone tried to massage the GUID via the monitor while the firmware
was between ALLOCATE and WRITE_POINTER.

Also, we don't know when the guest "asks" for the GUID (in guest RAM).
It just evaluates ADDR (maybe always, maybe only once, at guest driver
startup), and then it just looks at RAM whenever it wants to.

This is why this idea seeks to track the guest's state -- if the guest
is before ALLOCATE, it's okay to update the fw_cfg blob, if it is
between ALLOCATE and WRITE_POINTER, reject the monitor command
(temporarily), and if the guest is after WRITE_POINTER, update the RAM
and inject the SCI.

We cannot see *exactly* when the guest has just finished writing the
address. We have only select callbacks for fw_cfg items, not write
callbacks. And a select callback is no good for the address blob,
because it would be invoked *before* the guest writes the address.

We discussed these facts several days (weeks?) and several iterations
ago. The longer term remedy we came up was the above design. The shorter
term remedy was to drop the "set" monitor command, because we couldn't
figure out a management layer use case for that monitor command.

If you now (at v8) insist to future proof the design for a potential
"set" monitor command, that's exactly the same as if you were requiring
Ben to implement the monitor command right now. Except this is worse,
because we dropped the monitor command in v6 (from v5), and you didn't
protest.

> 
> 
>>     Libvirt can recognize this error specifically, because it is not the
>>     generic error class. ERROR_CLASS_DEVICE_NOT_ACTIVE stands for
>>     "EAGAIN", practically, in this case.
>>
>>   - Otherwise -- meaning latch is FALSE *or* /etc/vmgenid_addr is
>>     nonzero, that is, the guest has either not run ALLOCATE since
>>     reset, *or* it has, but it has also run WRITE_POINTER):
>>
>>     - refresh the GUID within the fw_cfg blob for /etc/vmgenid_guid
>>       in-place -- the guest will see this whenever it runs ALLOCATE for
>>       /etc/vmgenid_guid, *AND*
>>
>>     - if /etc/vmgenid_addr is not zero, then update the guest (that is,
>>       RAM write + SCI)
>>
>> Thanks
>> Laszlo
> 
> Seems way more painful than it has to be. Just migrate the guid
> and then management can write it at any time.

Yes, management would be able to do that, but we won't know when to
expose it to the guest. (Because, again, we don't exactly know when the
guest looks at the GUID in RAM, and if the address is not configured
yet, we cannot put the GUID anywhere in RAM.)

Do you intend to block v8 over this?

Thanks
Laszlo

> 
> 
>>>
>>>> - the address of the GUID is changed (the firmware programs it from
>>>> "zero" to an actual address, in a writeable fw_cfg file), and that piece
>>>> of info is explicitly migrated, as part of the vmgenid device's vmsd.
>>>>
>>>> Thanks
>>>> Laszlo
>>>>
>>>>
>>>>> - how does the guest on the destination see the same id
>>>>> as was in place on the source at the time migration started.
>>>>>
>>>>>>
>>>>>>
>>>>>>> when you load state from disk (you don't know how many times the same
>>>>>>> state has been loaded previously, so each load is effectively forking
>>>>>>> the VM and you want a different value), but for a single live migration,
>>>>>>> you aren't forking the VM and don't need a new generation ID.
>>>>>>>
>>>>>>> I guess it all boils down to what command line you're using: if libvirt
>>>>>>> is driving a live migration, it will request the same UUID in the
>>>>>>> command line of the destination as what is on the source; while if
>>>>>>> libvirt is loading from a [managed]save to restore state from a file, it
>>>>>>> will either request a new UUID directly or request auto to let qemu
>>>>>>> generate the new id.
>>>>>>
>>>>>> Hmm now I've lost it a bit; I thought we would preserve the value
>>>>>> transmitted from the source, not the value on the command line of the destination.
>>>>>
>>>>> I guess I'm trying to figure out whether libvirt MUST read the current
>>>>> id and explicitly tell the destination of migration to reuse that id, or
>>>>> if libvirt can omit the id on migration and everything just works
>>>>> because the id was migrated from the source.
>>>>>
