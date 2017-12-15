Received: from eggs.gnu.org ([2001:4830:134:3::10]:56145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePvYH-00050r-BJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePvYG-0002Bv-3s
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:21:45 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1ePvYF-0002Bf-VV
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:21:44 -0500
Received: by mail-qt0-x244.google.com with SMTP id a16so13394846qtj.3
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 11:21:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Chirj4y_YhK7Na_gf5504VNKUGZnfNTN6CHXN9gfZPA@mail.gmail.com>
References: <20171214151906.3250-1-andrew.smirnov@gmail.com>
	<CAFEAcA-Chirj4y_YhK7Na_gf5504VNKUGZnfNTN6CHXN9gfZPA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 15 Dec 2017 11:21:42 -0800
Message-ID: <CAHQ1cqGPq_PkxbnZHdZwKB8snqavyuWuHFjD9x_OdMSjzS3mRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/misc: Add code to emulate PFUZE3000 PMIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.orgn, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Dec 15, 2017 at 6:56 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 14 December 2017 at 15:19, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Add trivial code to emulate PFUZE3000 PMIC.
>>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.orgn
>> Cc: yurovsky@gmail.com
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>
>> Integrating this into a build system via "obj-y" might not be the best
>> way. Does this code need a dedicated CONFIG_ symbol?
>
> Yes, it ought to have a CONFIG_something symbol and be enabled
> via the whatever.mak for whatever guest architecture needs this
> device.
>
> Is there a board which needs this device? We usually
> only add devices together with whatever's using them.
>

It's a pretty popular PMIC used on majority on i.MX reference designs,
but I am not sure how many of those boards truly need it in QEMU. I
ended up having to implement this code for a custom i.MX7 board that
used one of PFUZE3000's output as a power supply for USB. I am not
sure if I'm ever going to submit patches for that mystery board
upstream. Looking at imx6qdl-sabresd.dtsi, in Linux source tree I
think this emulation code would also be needed for USB emulation on
i.MX6 SabreSD board, but I haven't verified it in practice.

Is this enough of a case to justify the patch's inclusion, or should I
go back and find a board QEMU supports that actually needs this
(either answer is perfectly fine with me)?

>> diff --git a/hw/misc/pfuze3000.c b/hw/misc/pfuze3000.c
>> new file mode 100644
>> index 0000000000..f414b7c0ba
>> --- /dev/null
>> +++ b/hw/misc/pfuze3000.c
>> @@ -0,0 +1,212 @@
>> +/*
>> + *
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 or
>> + * (at your option) version 3 of the License.
>
> The .h file is "v2 or later", but the .c file is "v2 or v3".
> Is that an intentional difference? Generally we go with "v2 or later".
>

Nope, just me not paying attention. Will change in v2.

>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>
>> +static void pfuze3000_reset(DeviceState *ds)
>> +{
>> +    PFuze3000State *s = PFUZE3000(ds);
>> +
>> +    s->reg = PFUZE100_INVAL;
>
> This function needs to reset all the device state
> (all the fields that the guest can modify).
>

Good point, will change in v2.

Thanks,
Andrey Smirnov
