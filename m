Received: from eggs.gnu.org ([2001:4830:134:3::10]:35079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL8JS-0003HU-8i
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL8JR-0001dE-4n
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:03:10 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gL8JD-0000sP-6h
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:03:08 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so1103076otm.13
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:02:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a05885c2-ae1e-ffa3-78d1-d43af3293be7@acm.org>
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-4-minyard@acm.org>
	<CAFEAcA9hp0VzN484uugfc4kzh3pSDMn3PU+ozfc_XPT5P-QsBw@mail.gmail.com>
	<25d95354-e536-dff6-0936-7e8d951108a5@mvista.com>
	<CAFEAcA9D4=KgmGqJbUceD_bxO11CBTDH7G3-54kn25nfi1XPJA@mail.gmail.com>
	<a05885c2-ae1e-ffa3-78d1-d43af3293be7@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 15:02:32 +0000
Message-ID: <CAFEAcA-9hgF_FRHYDFaNiH=6VBC6ZcLn03m-GWBaNfvYGTQw=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] i2c: Add vmstate handling to the smbus
 eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 9 November 2018 at 14:56, Corey Minyard <minyard@acm.org> wrote:
> On 11/8/18 12:03 PM, Peter Maydell wrote:
>>
>> On 8 November 2018 at 17:58, Corey Minyard <cminyard@mvista.com> wrote:
>>>
>>> On 11/8/18 8:08 AM, Peter Maydell wrote:
>>>>
>>>> This doesn't do anything for migration of the actual data contents.
>>>> The current users of this device (hw/arm/aspeed.c and the
>>>> smbus_eeprom_init() function) doesn't do anything
>>>> to migrate the contents. For that matter, "user of the device
>>>> passes a pointer to a random lump of memory via a device property"
>>>> is a bit funky as an interface. The device should allocate its
>>>> own memory and migrate it, and the user should just pass the
>>>> initial required contents (default being "zero-initialize",
>>>> which is what everybody except the mips_fulong2e, mips_malta
>>>> and sam460ex want).
>>>
>>> I debated on this, and it depends on what the eeprom is used for.  If
>>> it's a DRAM eeprom, it shouldn't need to be transferred.
>>
>> It's guest-visible data; the guest can write it and read it back.
>> So it needs to be migrated. Otherwise behaviour after migration
>> will not be the same as if the guest had never migrated.
>
>
>
> I looked at adding it, but I ran into an issue.  The value is a
>
> DEFINE_PROP_PTR("data", SMBusEEPROMDevice, data)
>
> and that means the data has to be void *, but to transfer it it must be a
> uint8_t *.
> The pointer property seems to be a cheap hack, I'm not sure what it will
> take
> to fix it.

The data provided by the caller is only the initialization
data. So I think the device should create its own memory
to copy that init data into, and migrate that ram, not
wherever the initialization data lives. (Currently
this "copy the data into our own ram" happens in the
smbus_eeprom_init() wrapper, but we should do it in the
device realize function instead.)

Also there seem to be unresolved questions about what happens
on reset -- should the EEPROM revert back to the initial
contents? We don't do that at the moment, but this breaks
the usual QEMU pattern that reset is as if you'd just
completely restarted QEMU.

thanks
-- PMM
