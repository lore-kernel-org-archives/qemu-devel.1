Received: from eggs.gnu.org ([2001:4830:134:3::10]:49471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePmet-0007kk-Oe
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePmep-0001w5-RT
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:51:56 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:46247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePmep-0001uE-LM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:51:55 -0500
Received: by mail-oi0-x22f.google.com with SMTP id t81so5787002oih.13
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 01:51:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215101135.447d9316.cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
	<CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
	<cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
	<20171215101135.447d9316.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 09:51:32 +0000
Message-ID: <CAFEAcA_VaKua1qjyeX2Ve=JrSUJQbBqMQOJQZ7e3y92+gtxkMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 00/46] First batch of s390x
 patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 15 December 2017 at 09:11, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 15 Dec 2017 09:35:10 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> On 12/14/2017 08:05 PM, Peter Maydell wrote:
>> > (ram_addr_t can be a 32-bit type).
>
> This a 32 bit host, isn't it? I don't have regular access to one...

Yes. Win32 cross compiler also gives this error.

>>
>> gcc seems to be extra clever, even a cast does not work.
>> Something like this seems to work.
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 80e753a5ef..9abb8de9f9 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -172,9 +172,10 @@ static void s390_memory_init(ram_addr_t mem_size)
>>      name = g_strdup_printf("s390.ram");
>>      while (mem_size) {
>>          MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +       unsigned long long size = mem_size;
>>
>>          /* KVM does not allow memslots >= 8 TB */
>> -        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
>> +        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
>>          memory_region_allocate_system_memory(ram, NULL, name, chunk);
>>          memory_region_add_subregion(sysmem, offset, ram);
>>          mem_size -= chunk;
>>
>
> Will see how I can test this and then merge it.

I would suggest uint64_t rather than unsigned long long.

thanks
-- PMM
