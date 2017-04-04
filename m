Received: from eggs.gnu.org ([2001:4830:134:3::10]:35833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cvQ3q-0002X6-Gq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cvQ3m-0007iC-Cr
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:07:58 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cvQ3m-0007he-9K
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:07:54 -0400
Received: by mail-vk0-f50.google.com with SMTP id z204so178927798vkd.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 08:07:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <58E3ADA3.2040305@windriver.com>
References: <58DEB834.6060405@windriver.com>
	<20170403191158.GI3539@stefanha-x1.localdomain>
	<CABdb737NXTBJGvk+nuyFTccK_-g=N=PHO+ZRd1qSZcTgai=feQ@mail.gmail.com>
	<58E3ADA3.2040305@windriver.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 4 Apr 2017 17:07:52 +0200
Message-ID: <CABdb73636afMA97hXZo9sP1Rg1zw0Z+Obbjse8F-DFOrs5+PKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] hitting intermittent issue with live migration
 from qemu-kvm-ev 2.3.0 to qemu-kvm-ev 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Apr 4, 2017 at 4:28 PM, Chris Friesen
<chris.friesen@windriver.com> wrote:
> On 04/04/2017 07:56 AM, Ladi Prosek wrote:
>>
>> On Mon, Apr 3, 2017 at 9:11 PM, Stefan Hajnoczi <stefanha@gmail.com>
>> wrote:
>>>
>>> On Fri, Mar 31, 2017 at 02:12:36PM -0600, Chris Friesen wrote:
>
>
>>>> Initially we have a bunch of guests running on compute-2 (which is
>>>> running
>>>> qemu-kvm-ev 2.3.0).  We then started live-migrating them one at a time
>>>> to
>>>> compute-0 (which is running qemu-kvm-ev 2.6.0).  Three of them migrated
>>>> successfully.  The fourth (which was essentially identical in
>>>> configuration
>>>> to the first three) failed, as per the following logs in
>>>> /var/log/libvirt/qemu/instance-0000000e.log:
>>>>
>>>>
>>>> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx
>>>> 0x47b
>>>> - used_idx 0x47c
>>>> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for
>>>> instance
>>>> 0x0 of device '0000:00:07.0/virtio-balloon'
>>>> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed:
>>>> Operation
>>>> not permitted
>>>> 2017-03-29 06:38:37.896+0000: shutting down
>>>>
>>>>
>>>> Does anyone know of an existing bug report covering this issue?  (I took
>>>> a
>>>> look and didn't see anything obviously related.)
>>>
>>>
>>> This is the virtio-balloon device.  If you remove the device the live
>>> migration should work reliably.
>>>
>>> Alternatively, you can temporarily rmmod virtio_balloon inside the guest
>>> for live migration.  After migration you can modprobe virtio_balloon
>>> again.
>>>
>>> last_avail_idx 0x47b with used_idx 0x47c is an invalid device state.
>>> I've diffed qemu-kvm-ev 2.6.0-27.1 hw/virtio/virtio-balloon.c against
>>> qemu.git/master and do not see an obvious bug.  I also compared
>>> qemu-kvm-ev 2.3.0-31 with qemu-kvm-ev 2.6.0-27.1.
>>
>>
>> The device likely got into the invalid state as part of a previous
>> migration to an unfixed QEMU. I second Stefan's suggestion to
>> temporarily remove the device or unload the driver.
>
>
> I'll give that a try (been busy with a separate issue).
>
> If I have a guest already running, can I unilaterally hot-remove the device
> from the host side or does the guest need to be involved as well?  (I'm just
> trying to figure out how to deal with existing guests.)

Hot-remove should be fine.

> Thanks,
> Chris
