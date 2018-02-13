Received: from eggs.gnu.org ([2001:4830:134:3::10]:37571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1eldEa-0007dR-Dt
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1eldEW-0003su-9F
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:15:08 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru>
	<20180213144310.GH5083@localhost.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <e67351ee-f944-4307-dd52-44f4e08612d9@virtuozzo.com>
Date: Tue, 13 Feb 2018 19:14:57 +0300
MIME-Version: 1.0
In-Reply-To: <20180213144310.GH5083@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, dgilbert@redhat.com, Denis Lunev <den@virtuozzo.com>



On 13.02.2018 17:43, Kevin Wolf wrote:
> Am 13.02.2018 um 15:30 hat Roman Kagan geschrieben:
>> On Tue, Feb 13, 2018 at 11:50:24AM +0100, Kevin Wolf wrote:
>>> Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
>>>> Then you could just use the regular migrate QMP commands for loading
>>>> and saving snapshots.
>>>
>>> Yes, you could. I think for a proper implementation you would want to do
>>> better, though. Live migration provides just a stream, but that's not
>>> really well suited for snapshots. When a RAM page is dirtied, you just
>>> want to overwrite the old version of it in a snapshot [...]
>>
>> This means the point in time where the guest state is snapshotted is not
>> when the command is issued, but any unpredictable amount of time later.
>>
>> I'm not sure this is what a user expects.
> 
> I don't think it's necessarily a big problem as long as you set the
> expectations right, but good point anyway.
> 
>> A better approach for the save part appears to be to stop the vcpus,
>> dump the device state, resume the vcpus, and save the memory contents
>> in the background, prioritizing the old copies of the pages that
>> change.
> 
> So basically you would let the guest fault whenever it writes to a page
> that is not saved yet, and then save it first before you make the page
> writable again? Essentially blockdev-backup, except for RAM.
> 
>> No multiple copies of the same page would have to be saved so the
>> stream format would be fine.  For the load part the usual inmigrate
>> should work.
> 
> This is true.
> 
> I think it will require changes to the qcow2 driver, though. Currently,
> you write the VM state into the active layer and then take the disk
> snapshot so that the VM state is automatically snapshotted as well.
> Afterwards, the VM state is discarded again in the active layer.
> 
> If you want to take the snapshot at the point in time when the command
> was issued, you first need to create a qcow2 snapshot to save the disk
> state, but then continue to write the VM state into that snapshot, even
> though it's not the active layer.
> 
> In fact I think this would be more elegant than writing the VM state
> into the active layer and then discarding it again, but inactive
> snapshots haven't been writable so far, so that will require some
> changes.
> 
> I'm sure that Denis has already some thoughts on this, though.
Yes, I stick to the scheme when you write a snapshot as it is now but 
instead of ram writing I just preallocate the space for ram and save the 
actual file offsets of the clusters forming the space, then I resume 
vcpus and write the ram using those cluster offsets with respect to vcpu 
pagefaults.

> 
> Kevin
> 

-- 
Best,
Denis
