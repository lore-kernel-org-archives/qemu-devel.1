Received: from eggs.gnu.org ([2001:4830:134:3::10]:36259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cRe4Z-0006Xn-Tu
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cRe4V-0004r0-EK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:01:40 -0500
References: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
	<CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
	<20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <a43107f4-629f-2328-cd87-efa592868730@sysgo.com>
Date: Thu, 12 Jan 2017 13:01:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pflash_cfi01: fix per device sector length
 in CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, dgilbert@redhat.com

Am 12.01.2017 um 12:36 schrieb Andrew Jones:
> On Thu, Jan 12, 2017 at 10:42:41AM +0000, Peter Maydell wrote:
>> On 12 January 2017 at 10:35, David Engraf <david.engraf@sysgo.com> wrote:
>>> The CFI entry for sector length must be set to sector length per device.
>>> This is important for boards using multiple devices like the ARM Vexpress
>>> board (width = 4, device-width = 2).
>>>
>>> Linux and u-boots calculate the size ratio by dividing both values:
>>>
>>> size_ratio = info->portwidth / info->chipwidth;
>>>
>>> After that the sector length will be multiplied by the size_ratio, thus the
>>> CFI entry for sector length is doubled. When Linux or u-boot send a sector
>>> erase, they expect to erase the doubled sector length, but QEMU only erases
>>> the board specified sector length.
>>>
>>> This patch fixes the sector length in the CFI table to match the length per
>>> device, equal to blocks_per_device.
>>
>> Thanks for the patch. I haven't checked against the pflash spec yet,
>> but this looks like it's probably the right thing.
>>
>> The only two machines which use a setup with multiple devices (ie
>> which specify device_width to the pflash_cfi01) are vexpress and virt.
>> For all other machines this patch leaves the behaviour unchanged.
>>
>> Q: do we need to have some kind of nasty hack so that pre-2.9 virt
>> still gets the old broken values in the CFI table, for version and
>> migration compatibility? Ccing Drew for an opinion...
>>
>
> I'm pretty sure we need the nasty hack, but I'm also Ccing David for
> his opinion.

I can update the patch if you give me some more information about the 
hack. Some ifdef for older versions?

Best regards
- David
