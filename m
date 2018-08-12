Received: from eggs.gnu.org ([2001:4830:134:3::10]:47270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fovjq-0002yX-4z
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 15:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fovjm-0000u3-1m
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 15:09:18 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fovjl-0000tn-Pw
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 15:09:13 -0400
Received: by mail-wm0-f47.google.com with SMTP id t25-v6so6708900wmi.3
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 12:09:13 -0700 (PDT)
References: <20180720081948.23644-1-remy.noel@blade-group.com>
	<20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
	<20180807145701.GK2556@work-vm>
	<CAFEAcA9mgyCzR7-ANw0YvKdzz-0H50vETrr_sw5bH5D_2PUeNg@mail.gmail.com>
	<20180807150935.GL2556@work-vm>
	<3d89d87f-857d-ebb1-1fe7-710a52ea381d@blade-group.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7592b8a-ccf3-7d68-9fce-30a80fa58bce@redhat.com>
Date: Sun, 12 Aug 2018 12:19:03 +0200
MIME-Version: 1.0
In-Reply-To: <3d89d87f-857d-ebb1-1fe7-710a52ea381d@blade-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Remy NOEL <remy.noel@blade-group.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11/08/2018 21:07, Remy NOEL wrote:
> On 08/07/2018 05:09 PM, Dr. David Alan Gilbert wrote:
> 
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> On 7 August 2018 at 15:57, Dr. David Alan Gilbert
>>> <dgilbert@redhat.com> wrote:
>>>> * Gerd Hoffmann (kraxel@redhat.com) wrote:
>>>>> On Fri, Jul 20, 2018 at 10:19:48AM +0200, remy.noel@blade-group.com
>>>>> wrote:
>>>>>> From: "Remy Noel" <remy.noel@blade-group.com>
>>>>>>
>>>>>> When removing a secondary-vga device and then adding it back (or
>>>>>> adding
>>>>>> an other one), qemu aborts with:
>>>>>>      "RAMBlock "0000:00:02.0/vga.vram" already registered, abort!".
>>>>>>
>>>>>> It is caused by the vram staying registered, preventing vga
>>>>>> replugging.
>>>>> David?  Does that look ok?
>>>>>
>>>>> This balances the
>>>>>
>>>>>       vmstate_register_ram(&s->vram, s->global_vmstate ?  NULL :
>>>>> DEVICE(obj));
>>>>>
>>>>> call in vga_common_init().  I'm wondering whenever the manual
>>>>> cleanup is
>>>>> actually needed in case owner is not NULL?
>>>> I can't see anyone who is calling unregister_ram or the functions it
>>>> calls as part of generic device cleanup, so I think it IS needed
>>>> to manually do it.
>>>>
>>>> Which is a bit worrying since we have vastly more register's than
>>>> unregister's.
>>> Paolo suggested in an email last month that vmstate_unregister_ram()
>>> should simply not exist, because it doesn't actually do anything useful:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg01125.html
>>>
>>> (ie it was added in the first place because we'd ended up with
>>> two identically named ramblocks, but that only happened because
>>> a reference-counting bug meant we hadn't deleted the first one
>>> properly before creating the second.)
>>>
>>> So I think that the bug reported in this thread is similar:
>>> the problem is not that we're not calling vmstate_unregister_ram(),
>>> but that when the first instance of secondary-vga is removed
>>> it is not correctly destroying the ramblock.
>> Ah yes that makes more sense; I remember there was another similar bug
>> where a device screwed up and didn't delete it's RAM causing similar
>> problems.
>>
>> Dave
> Thanks for the feedback, after closer inspection, the secondary-vga
> refcount does, indeed, never reach 0.
> 
> I noticed the bug was not present in v2.12.0 and had been visible since
> 93abfc88bd649de1933588bfc7175605331b3ea9
> (https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07547.html).
> 
> This patch causes the secondary-vga object to be referenced by its
> subregions (mrs) which are themselves referenced by its mmio region
> which is referenced by the device causing a reference loop.
> We should probably break this loop upon exit, however, i am not sure
> whether we should deletes the subregions or delete the mmio properly.

I'll take a look...

Paolo
