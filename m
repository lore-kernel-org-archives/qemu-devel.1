Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLAyd-0007lt-Hk
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLAyc-0006QF-Hh
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:53:51 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gLAyc-0006PE-5q
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:53:50 -0500
Received: by mail-oi1-x242.google.com with SMTP id 192-v6so2180928oii.6
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 09:53:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94a4be73-e870-d82c-0ace-4be17bf95413@mvista.com>
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-4-minyard@acm.org>
	<CAFEAcA9hp0VzN484uugfc4kzh3pSDMn3PU+ozfc_XPT5P-QsBw@mail.gmail.com>
	<25d95354-e536-dff6-0936-7e8d951108a5@mvista.com>
	<CAFEAcA9D4=KgmGqJbUceD_bxO11CBTDH7G3-54kn25nfi1XPJA@mail.gmail.com>
	<a05885c2-ae1e-ffa3-78d1-d43af3293be7@acm.org>
	<CAFEAcA-9hgF_FRHYDFaNiH=6VBC6ZcLn03m-GWBaNfvYGTQw=A@mail.gmail.com>
	<94a4be73-e870-d82c-0ace-4be17bf95413@mvista.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 17:53:28 +0000
Message-ID: <CAFEAcA9=UK2P7J_8yvvf38Jvyr-v96uvjVEY-oBcOS-VF5DFZg@mail.gmail.com>
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
To: Corey Minyard <cminyard@mvista.com>
Cc: Corey Minyard <minyard@acm.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 9 November 2018 at 17:19, Corey Minyard <cminyard@mvista.com> wrote:
> On 11/9/18 9:02 AM, Peter Maydell wrote:
>> The data provided by the caller is only the initialization
>> data. So I think the device should create its own memory
>> to copy that init data into, and migrate that ram, not
>> wherever the initialization data lives. (Currently
>> this "copy the data into our own ram" happens in the
>> smbus_eeprom_init() wrapper, but we should do it in the
>> device realize function instead.)
>
>
> That's what I would like, but should I get rid of the "DEFINE_PROP_PTR"?
> I don't know the value of creating a properly like this, since the user
> can't set it and can't see it.  Plus the comments in the code say that
> it should be gotten rid of at some point.
>
> But if I store off the initialization data and keep the actual data in
> a separate memory created by the realize function, that should work
> find.

Well, you still have to pass the init data to the device
somehow, so I think a pointer property is not a terrible
way to do that.

>> Also there seem to be unresolved questions about what happens
>> on reset -- should the EEPROM revert back to the initial
>> contents? We don't do that at the moment, but this breaks
>> the usual QEMU pattern that reset is as if you'd just
>> completely restarted QEMU.
>
>
> I would consider this part of the hardware, like data on a disk drive,
> so it seem better to leave it alone after a reset.  But it's not quite
> the same.  So I'm not sure.

That would require us to support backing it properly with a block
device, like the pflash flash devices, I think. (This would
be the long term way to be able to dump the pointer property,
in favour of a block backend property.)

thanks
-- PMM
