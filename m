Received: from eggs.gnu.org ([2001:4830:134:3::10]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciJxx-0007bE-65
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciJxs-00041V-9O
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:59:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ciJxs-00040m-47
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:59:40 -0500
References: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
	<20170223122025.10420-4-cornelia.huck@de.ibm.com>
	<4fe97bb7-d6f0-7b58-916f-94dc0ae81616@redhat.com>
	<20170227125138.18c3f43c.cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c0652d8e-399a-411f-b338-e80674ae27c4@redhat.com>
Date: Mon, 27 Feb 2017 12:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170227125138.18c3f43c.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] s390x/ipl: Load network boot image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, Farhan Ali <alifm@linux.vnet.ibm.com>, agraf@suse.de

On 27.02.2017 12:51, Cornelia Huck wrote:
> On Sat, 25 Feb 2017 07:18:29 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 23.02.2017 13:20, Cornelia Huck wrote:
>>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>>
>>> Load the network boot image into guest RAM when the boot
>>> device selected is a network device. Use some of the reserved
>>> space in IplBlockCcw to store the start address of the netboot
>>> image.
>>>
>>> A user could also use 'chreipl'(diag 308/5) to change the boot device.
>>> So every time we update the IPLB, we need to verify if the selected
>>> boot device is a network device so we can appropriately load the
>>> network boot image.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> ---
>>>  hw/s390x/ipl.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  hw/s390x/ipl.h |  4 ++-
>>>  2 files changed, 92 insertions(+), 1 deletion(-)
[...]
>>> +    if (ipl->netboot) {
>>> +        if (load_netboot_image(&err) < 0) {
>>> +            error_report_err(err);
>>> +            vm_stop(RUN_STATE_INTERNAL_ERROR);
>>> +        }
>>> +        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;
>>
>> Not sure whether it matters, but in case of early errors during
>> load_netboot_image(), ipl->start_addr could be used uninitialized here.
>> Maybe you should move the "ipl->start_addr = KERN_IMAGE_START;" there at
>> the beginning of the function, to make it also the default value for the
>> other error cases?
> 
> ipl->start_addr has already been set to some value in the realize
> function (either the kernel entry address, or the bios address).
> 
> But that should not matter with the vm_stop() on error anyway, no?

Likely not. It's just a little bit strange to see that the program flow
continues after the error in this function here ... maybe it would have
been clearer to put a "return" right after the "vm_stop()"? Anyway, it
likely does not really matter here, so never mind.

 Thomas
