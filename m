Received: from eggs.gnu.org ([2001:4830:134:3::10]:32827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gL8DN-0006jO-2K
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gL8D9-0002aT-Vc
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:56:51 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gL8D9-0002Z0-N7
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:56:39 -0500
Received: by mail-ot1-x343.google.com with SMTP id n46so1816046otb.9
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 06:56:38 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-4-minyard@acm.org>
	<CAFEAcA9hp0VzN484uugfc4kzh3pSDMn3PU+ozfc_XPT5P-QsBw@mail.gmail.com>
	<25d95354-e536-dff6-0936-7e8d951108a5@mvista.com>
	<CAFEAcA9D4=KgmGqJbUceD_bxO11CBTDH7G3-54kn25nfi1XPJA@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <a05885c2-ae1e-ffa3-78d1-d43af3293be7@acm.org>
Date: Fri, 9 Nov 2018 08:56:33 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9D4=KgmGqJbUceD_bxO11CBTDH7G3-54kn25nfi1XPJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
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
To: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/8/18 12:03 PM, Peter Maydell wrote:
> On 8 November 2018 at 17:58, Corey Minyard <cminyard@mvista.com> wrote:
>> On 11/8/18 8:08 AM, Peter Maydell wrote:
>>> This doesn't do anything for migration of the actual data contents.
>>> The current users of this device (hw/arm/aspeed.c and the
>>> smbus_eeprom_init() function) doesn't do anything
>>> to migrate the contents. For that matter, "user of the device
>>> passes a pointer to a random lump of memory via a device property"
>>> is a bit funky as an interface. The device should allocate its
>>> own memory and migrate it, and the user should just pass the
>>> initial required contents (default being "zero-initialize",
>>> which is what everybody except the mips_fulong2e, mips_malta
>>> and sam460ex want).
>> I debated on this, and it depends on what the eeprom is used for.  If
>> it's a DRAM eeprom, it shouldn't need to be transferred.
> It's guest-visible data; the guest can write it and read it back.
> So it needs to be migrated. Otherwise behaviour after migration
> will not be the same as if the guest had never migrated.


I looked at adding it, but I ran into an issue.  The value is a

DEFINE_PROP_PTR("data", SMBusEEPROMDevice, data)

and that means the data has to be void *, but to transfer it it must be 
a uint8_t *.
The pointer property seems to be a cheap hack, I'm not sure what it will 
take
to fix it.

I was hoping this would be easy.  I guess transferring the eeprom is not
that important, the state of pm_smbus is a lot more critical.  But it would
be nice to fix it since I am messing with that code.

Thanks for your help.

-corey

>>> Does this also break migration from an old QEMU to a new one?
>>> (For Aspeed that's probably ok, but we should flag it up in the
>>> commit message if so. x86 uses need care...)
>>>
>> There is no transfer before, so I don't see why it would break anything.
>> Am I missing something?
> I forget what the behaviour is where the source QEMU didn't
> have a vmstate at all but the destination QEMU does expect
> one. David can remind me...
>
> thanks
> - PMM
