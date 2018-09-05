Received: from eggs.gnu.org ([2001:4830:134:3::10]:35483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fxdrZ-0002od-S5
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fxdjn-00089T-SY
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:45:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fxdjn-00087R-My
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:45:15 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so11573264itj.5
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 12:45:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxj5eJ8MvkNfvwMVMQaZ-E09yomP-amLZz=aPBH+AWK9g@mail.gmail.com>
References: <20180905082919.6986-1-marcandre.lureau@redhat.com>
	<87va7k9nvc.fsf@trasno.org>
	<CAMxuvaxj5eJ8MvkNfvwMVMQaZ-E09yomP-amLZz=aPBH+AWK9g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 5 Sep 2018 21:45:13 +0200
Message-ID: <CAMxuvaxFngPfeYt-RT2FoPhhsqkV2tTaT_O7rRsC91jVaSTnuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: size can be different from ptr_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Wed, Sep 5, 2018 at 7:51 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Hi
>
> On Wed, Sep 5, 2018 at 1:37 PM, Juan Quintela <quintela@redhat.com> wrote=
:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>> memory_region_init_ram*_ptr() take only the size of the MemoryRegion,
>>> and allocate a RAMBlock with the same size. However, it may be
>>> convenient to expose a smaller MemoryRegion (for ex: a few bytes) than
>>> the RAMBlock (which must be a multiple of TARGET_PAGE_SIZE).
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  include/exec/memory.h  |  8 ++++++--
>>>  exec.c                 |  3 +++
>>>  hw/display/g364fb.c    |  2 +-
>>>  hw/vfio/common.c       |  3 ++-
>>>  hw/virtio/vhost-user.c |  2 +-
>>>  memory.c               | 10 ++++++----
>>>  6 files changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index eb4f2fb249..03f257829b 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -700,6 +700,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *m=
r,
>>>   *        must be unique within any device
>>>   * @size: size of the region.
>>>   * @ptr: memory to be mapped; must contain at least @size bytes.
>>                                                        ^^^^^
>>
>> this comment gets wrong with your patches
>
> why? it must contain at least @size (And preferrably exactly @ptr_size)
>
>
>>
>>> + * @ptr_size: size of @ptr buffer
>>
>>> diff --git a/exec.c b/exec.c
>>> index 6826c8337d..fcea614e79 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -2361,6 +2361,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size=
, ram_addr_t max_size,
>>>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>>                                     MemoryRegion *mr, Error **errp)
>>>  {
>>> +    assert(size >=3D TARGET_PAGE_SIZE);
>>> +    assert(size % TARGET_PAGE_SIZE =3D=3D 0);
>>> +
>>>      return qemu_ram_alloc_internal(size, size, NULL, host, false,
>>>                                     false, mr, errp);
>>>  }
>>
>> ok with this bit.
>>
>> But how about to change instead to:
>>
>> void memory_region_init_ram_ptr(MemoryRegion *mr,
>>                                 Object *owner,
>>                                 const char *name,
>>                                 uint64_t size,
>>                                 void *ptr)
>> {
>>     uint64_t real_size =3D ROUND_UP_TARGET_PAGE_SIZE(size);
>>     memory_region_init(mr, owner, name, real_size);
>>     mr->ram =3D true;
>>     mr->terminates =3D true;
>>     mr->destructor =3D memory_region_destructor_ram;
>>     mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>
>>     /* qemu_ram_alloc_from_ptr cannot fail with ptr !=3D NULL.  */
>>     assert(ptr !=3D NULL);
>>     mr->ram_block =3D qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fata=
l);
>> }
>>
>> For a suitable ROUND_UP_TARGET_PAGE_SIZE() macro.  You get the idea.
>>
>> And memory_region_device_ram_ptr() don't even need a change.
>> We need to adjust the comments, but it looks like an easier patch to me,=
 no?
>
> That's a good suggestion, it puts a bit more responsability into
> caller side, put that's fair.
>
>>
>>> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
>>> index fbc2b2422d..f4f5643761 100644
>>> --- a/hw/display/g364fb.c
>>> +++ b/hw/display/g364fb.c
>>> @@ -475,7 +475,7 @@ static void g364fb_init(DeviceState *dev, G364State=
 *s)
>>>
>>>      memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ct=
rl", 0x180000);
>>>      memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
>>> -                               s->vram_size, s->vram);
>>> +                               s->vram_size, s->vram, s->vram_size);
>>
>> Having to change all the devices that use the function with exactly the
>> same parameter looks weird to me.
>>
>> What do you think?
>
> I'll update the patch, thanks

Actually the patch is a bit pointless, since qemu_ram_alloc_internal()
already HOST_PAGE_ALIGN(size). And host page is supposed to be larger
than target page. So, I can simply over-allocate the ram ptr/device
buffer in the TPM PPI patch.

thanks
