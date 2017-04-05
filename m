Received: from eggs.gnu.org ([2001:4830:134:3::10]:52173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cvgLA-0000YQ-4g
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cvgL5-0007mB-Ry
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cvgL5-0007jz-J5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:30:51 -0400
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-20-ehabkost@redhat.com>
	<a68c146f-7afa-235b-480b-25676a6bc519@redhat.com>
	<20170404193510.GA15929@thinpad.lan.raisama.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2fd26554-9dd7-91dc-5bc0-cf9b317f9916@redhat.com>
Date: Wed, 5 Apr 2017 10:30:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170404193510.GA15929@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 19/19] virtio-mmio: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>

On 04/04/17 21:35, Eduardo Habkost wrote:
> On Mon, Apr 03, 2017 at 05:50:13PM +0200, Laszlo Ersek wrote:
>> On 04/01/17 02:46, Eduardo Habkost wrote:
>>> virtio-mmio needs to be wired and mapped by other device or board
>>> code, and won't work with -device. Remove the user_creatable flag
>>> from the device class.
>>>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  hw/virtio/virtio-mmio.c | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>>> index b595512a3d..5807aa87fe 100644
>>> --- a/hw/virtio/virtio-mmio.c
>>> +++ b/hw/virtio/virtio-mmio.c
>>> @@ -450,11 +450,6 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
>>>      dc->reset = virtio_mmio_reset;
>>>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>>      dc->props = virtio_mmio_properties;
>>> -    /*
>>> -     * FIXME: Set only for compatibility on q35 machine-type.
>>> -     * Probably never meant to be user-creatable
>>> -     */
>>> -    dc->user_creatable = true;
>>>  }
>>>  
>>>  static const TypeInfo virtio_mmio_info = {
>>>
>>
>> Possible addition to the commit message: a reference to commit
>> 587078f0ed63 ("hw/arm/virt: explain device-to-transport mapping in
>> create_virtio_devices()", 2015-02-05).
> 
> I'm confused by the comments there: it says "Unfortunately, we
> can't counteract the kernel change by reversing the loop; it
> would break existing command lines". But, which comment-lines it
> would break,

Reversing the order in which the platform code generates the virtio-mmio
transports would break guest kernel command lines that identify the root
filesystem by virtio device name, such as /dev/vda1 vs. /dev/vdb1.

And, a QEMU command line can actually contain the guest kernel command
line; consider -kernel / -initrd / -append. In that sense, if you break
the guest kernel command line, you break the QEMU command line as well.

> if "-device virtio-mmio" was never supported?

The relevant "-device" options on the qemu command line are not "-device
virtio-mmio"; they are "-device virtio-blk-device". QEMU first
auto-generates the virtio-mmio transports, then assigns those virtio
block devices to the transports. The comment documents the interplay between
- order of virtio mmio transport creation (QEMU),
- order of assigning virtio block devices to transports (QEMU),
- order of naming disks based on transport address (guest kernel).

Anyway, it's not important to include a reference to commit 587078f0ed63.

Thanks
Laszlo

> 
>>
>> That's another example showing that board code has to participate in
>> virtio-mmio transport placement.
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks!
> 
