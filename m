Received: from eggs.gnu.org ([2001:4830:134:3::10]:33371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNH9m-0002in-Al
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNH9l-0005DQ-D7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:49:30 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eNH9l-0005DE-7g
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:49:29 -0500
Received: by mail-oi0-x241.google.com with SMTP id j17so7033143oih.3
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 03:49:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHmME9qNnqYEbW_m8LG0E0HBKUE38YjUodbBihnSi2k0FrZJtw@mail.gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
	<20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
	<CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
	<CAFEAcA8O6YyS1tSzaydckFpsqpb8HXgW5PJe-VTWud_5YGdW5A@mail.gmail.com>
	<CAHmME9pE79krWx-zD=VGiScT4c=4TZ1wVxYFiF3m+8wsx9Fqeg@mail.gmail.com>
	<CAFEAcA9XoeXDCQCmRBehntWSo0WGRBsaMDmC8QCqgU1K8jAF_A@mail.gmail.com>
	<CAHmME9qSJSPjANce_cWN6nm=qJsncfczgk7PoPa0xkOHmZjLUA@mail.gmail.com>
	<CAFEAcA-bKPNwJpcny=1azScO8bzHsi0Ou+m3rYPq-=v52Gf26g@mail.gmail.com>
	<CAHmME9qNnqYEbW_m8LG0E0HBKUE38YjUodbBihnSi2k0FrZJtw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Dec 2017 11:49:07 +0000
Message-ID: <CAFEAcA-5F2GMx9UNoH=LJAa-m1DXg2HW8PJZ47kurjx5x3NhWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 18:31, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Oct 26, 2017 at 6:41 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Those are primarily about migration compatibility -- you should
>> be able to live migrate a guest from QEMU 2.6's virt-2.6 machine to
>> QEMU 2.7's virt-2.6 machine. That's a stricter requirement than
>> the compatibility we want to keep for non-versioned machines,
>> where generally we don't want to break command lines but are OK
>> to make changes if they don't break those existing uses.
>>
>> Command lines get baked into all sorts of scripts and so they're
>> effectively part of QEMU's "ABI". People don't like it when we
>> break their previously working flows :-)
>
> Fair enough. So in that case, secure=no means serials 1-4 are for
> kernel. With secure=yes, serials 1,3-5 are for kernel, with serial 2
> being for trustzone. Seems like that's the best of all worlds.

Now that the 2.11 release is mostly out of the way, I've been
working through some of my other todo list items so I've
come back to this thread.

My suggestion is that we should add a second non-secure UART
to the virt board, so if you're using secure=no then you
get serial 1 and 2, and for secure=yes serial 1 is the first
NS uart, serial 2 is the secure uart and serial 3 is the
2nd NS uart. (I don't really want to add a 4th uart unless
there's some good reason to -- maybe we would turn out to
want it for the secure side, for instance.)

I'll probably write a patch for this next week, unless you
want to do it.

thanks
-- PMM
