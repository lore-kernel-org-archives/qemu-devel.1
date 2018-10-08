Received: from eggs.gnu.org ([2001:4830:134:3::10]:58154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Ucn-0002eA-7A
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Ucm-00030C-BM
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:27:01 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Ucm-0002zd-4L
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:27:00 -0400
Received: by mail-ot1-x344.google.com with SMTP id i12-v6so19451954otl.1
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 05:27:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0ed94c1e-4c58-d1ac-6ceb-c851cc089cec@redhat.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
	<0ed94c1e-4c58-d1ac-6ceb-c851cc089cec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 13:26:38 +0100
Message-ID: <CAFEAcA-SRO6Jod2TyRuEiBH+2G12hKKEiYPfBVaVvTvvMvcHgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 06/12] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>

On 6 October 2018 at 00:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=
 wrote:
> Hi Edgar,
>
> On 03/10/2018 17:07, Edgar E. Iglesias wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>
>> Add support for selecting the Memory Region that the GEM
>> will do DMA to.

>> @@ -1500,6 +1506,13 @@ static void gem_realize(DeviceState *dev, Error *=
*errp)
>>      CadenceGEMState *s =3D CADENCE_GEM(dev);
>>      int i;
>>
>> +    if (s->dma_mr) {
>> +        s->dma_as =3D g_malloc0(sizeof(AddressSpace));
>> +        address_space_init(s->dma_as, s->dma_mr, NULL);
>> +    } else {
>> +        s->dma_as =3D &address_space_memory;
>> +    }
>
> This is not the first time I see this if() block.
>
> Should we consider refactor it?

Given that there are only three users of the device in the tree,
I think the nicest cleanup would be to make those callers pass
in a suitable MemoryRegion (which could just be the system memory
MR), and make the "dma" property of the device mandatory to set.
We can do that as followup, though.

thanks
-- PMM
