Received: from eggs.gnu.org ([2001:4830:134:3::10]:60844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs7yL-0003FU-CP
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs7yK-0002ye-IE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:49:29 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs7yK-0002yI-BM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:49:28 -0400
Received: by mail-oi0-x243.google.com with SMTP id 8-v6so32525697oip.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:49:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <df1b1627-47e4-bffd-e73c-ffa3eb037b2a@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-4-contrib@steffen-goertz.de>
	<CAFEAcA-vtLpt-ScYpYPFqtQAnECuVqCW-DhKqVgoh6mAG=KfQw@mail.gmail.com>
	<df1b1627-47e4-bffd-e73c-ffa3eb037b2a@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 15:49:07 +0100
Message-ID: <CAFEAcA-n87TbE_a2zgnWAgTk1=P5=1j-f+xS7yKJ7jMZkNtx1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] arm: Add chip variant property to
 nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 21 August 2018 at 11:03, Steffen G=C3=B6rtz <mail@steffen-goertz.de> wro=
te:
> Hi Peter,
>
> object_property_set_bool(soc, true, "realized", &error_abort);>>
>>> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>>> -            NRF51_SOC(soc)->flash_size);
>>> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0=
x00);
>>
>> Hmm. Using 0x00 here doesn't seem ideal.
>
> i agree. The actual sizes for RAM/ROM are calculated in the SOC at the mo=
ment.
> I do not really know what impact max_sz has here. I could set the it to t=
he
> maximum code size defined in the memory map of the NRF51 series. Another =
way would be
> to lift the calculation of the ROM size from the SOC to the Board. What w=
ould you propose?

I think we need to specify a value somehow, otherwise we
won't be able to load raw images (which I think are the only
ones where we enforce the limit value). You could just use
the largest possible size, I suppose.

>>> +#define PAGE_SIZE       1024
>>
>> Page size isn't really an obvious concept for M profile.
>
> Flash pages are referred to here, not MMU pages. This constant is moved a=
nd renamed to NRF51_PAGE_SIZE in the upcoming revision. Would you suggest a=
nother name or can with stick with this?

I guess NRF51_FLASH_PAGE_SIZE would be a little clearer ?

thanks
-- PMM
